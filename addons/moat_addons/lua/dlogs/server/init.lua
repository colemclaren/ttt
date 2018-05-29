-- Building error reporting
-- dlogs:Error(debug.getinfo(1).source, debug.getinfo(1).currentline, "connection error")
function dlogs:Error(file, line, strg)
    self.Print("ERROR - " .. file .. " (" .. line .. ") - " .. strg)
end

-- Including Net Messages
util.AddNetworkString("dlogs.Askdlogs")
util.AddNetworkString("dlogs.Senddlogs")
util.AddNetworkString("dlogs.Refreshdlogs")
util.AddNetworkString("dlogs.Ded")
util.AddNetworkString("dlogs.SendLang")
dlogs.DamageTable = dlogs.DamageTable or {}
dlogs.OldTables = dlogs.OldTables or {}
dlogs.ShootTables = dlogs.ShootTables or {}
dlogs.Roles = dlogs.Roles or {}
dlogs.SceneRounds = dlogs.SceneRounds or {}

net.Receive("dlogs.SendLang", function(_, ply)
    ply.DMGLogLang = net.ReadString()
end)

local Player = FindMetaTable("Player")

function Player:GetdlogsID()
    return self.dlogsID or -1
end

function Player:SetdlogsID(id)
    self.dlogsID = id
end

function Player:AddTodlogsRoles(spawned)
	local id = self:MoatID()

	dlogs.Roles[#dlogs.Roles][id] = {
        role = (spawned and 4) or (self:IsSpec() and 5) or self:GetRole(),
        steamid64 = self:SteamID64(),
        nick = self:Nick()
	}

    self:SetdlogsID(id)
end

function dlogs:TTTBeginRound()
    self.Time = 0

    if not timer.Exists("dlogs_Timer") then
        timer.Create("dlogs_Timer", 1, 0, function()
            self.Time = self.Time + 1
        end)
    end

    if IsValid(self:GetSyncEnt()) then
        local rounds = self:GetSyncEnt():GetPlayedRounds()
        self:GetSyncEnt():SetPlayedRounds(rounds + 1)

        if self.add_old then
            self.OldTables[rounds] = table.Copy(self.DamageTable)
        else
            self.add_old = true
        end

        self.ShootTables[rounds + 1] = {}
        self.Roles[rounds + 1] = {}

        for k, v in ipairs(player.GetAll()) do
            v:AddTodlogsRoles(rounds + 1)
        end

        self.CurrentRound = rounds + 1
    end

    table.Empty(self.DamageTable)
end

hook.Add("TTTBeginRound", "TTTBeginRound_dlogs", function()
    dlogs:TTTBeginRound()
end)

/*
hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_dlogs", function(ply)
    if GetRoundState() == ROUND_ACTIVE then
        local steamid64 = ply:SteamID64()
        local found = false

        for k, v in pairs(dlogs.Roles[#dlogs.Roles]) do
            if v.steamid64 == steamid64 then
                found = true
                ply:SetdlogsID(k)
                break
            end
        end

        if not found then
            ply:AddTodlogsRoles(true)
        end
    end
end)
*/

-- rip from TTT
-- this one will return a string
function dlogs:WeaponFromDmg(dmg)
    local inf = dmg:GetInflictor()
    local wep = nil

    if IsValid(inf) then
        if inf:IsWeapon() or inf.Projectile then
            wep = inf
        elseif dmg:IsDamageType(DMG_BLAST) then
            wep = "DMG_BLAST"
        elseif dmg:IsDamageType(DMG_DIRECT) or dmg:IsDamageType(DMG_BURN) then
            wep = "DMG_BURN"
        elseif dmg:IsDamageType(DMG_CRUSH) then
            wep = "DMG_CRUSH"
        elseif dmg:IsDamageType(DMG_SLASH) then
            wep = "DMG_SLASH"
        elseif dmg:IsDamageType(DMG_CLUB) then
            wep = "DMG_CLUB"
        elseif dmg:IsDamageType(DMG_SHOCK) then
            wep = "DMG_SHOCK"
        elseif dmg:IsDamageType(DMG_ENERGYBEAM) then
            wep = "DMG_ENERGYBEAM"
        elseif dmg:IsDamageType(DMG_SONIC) then
            wep = "DMG_SONIC"
        elseif dmg:IsDamageType(DMG_PHYSGUN) then
            wep = "DMG_PHYSGUN"
        elseif inf:IsPlayer() then
            wep = inf:GetActiveWeapon()

            if not IsValid(wep) then
                wep = IsValid(inf.dying_wep) and inf.dying_wep
            end
        end
    end

    if type(wep) ~= "string" then
        return IsValid(wep) and wep:GetClass()
    else
        return wep
    end
end

function dlogs:Senddlogs(ply, round)
    if self.MySQL_Error and not ply.dlogs.MySQL_Error then
        dlogs:Error(debug.getinfo(1).source, debug.getinfo(1).currentline, "mysql connection error")
        ply.dlogs.MySQL_Error = true
    end

    local damage_send = {}
    local roles = self.Roles[round]
    local current = false

    if round == -1 then
        if not self.last_round_map then return end

        if not dlogs.PreviousMap then
            if dlogs.Config.Use_MySQL then
                local query = self.database:query("SELECT damagelog FROM damagelog_oldlogs_v3 WHERE date = " .. self.last_round_map)

                query.onSuccess = function(q)
                    local data = q:getData()

                    if data and data[1] then
                        local encoded = data[1]["damagelog"]
                        local decoded = util.JSONToTable(encoded)

                        if not decoded then
                            decoded = {
                                Roles = {},
                                ShootTables = {},
                                DamageTable = {}
                            }
                        end

                        self:TransferLogs(decoded.DamageTable, ply, round, decoded.Roles)
                        dlogs.PreviousMap = decoded
                    end
                end

                query:start()
            else
                local query = sql.QueryValue("SELECT damagelog FROM damagelog_oldlogs_v3 WHERE date = " .. self.last_round_map)
                if not query then return end
                local decoded = util.JSONToTable(query)

                if not decoded then
                    decoded = {
                        Roles = {},
                        ShootTables = {},
                        DamageTable = {}
                    }
                end

                self:TransferLogs(decoded.DamageTable, ply, round, decoded.Roles)
                dlogs.PreviousMap = decoded
            end
        else
            self:TransferLogs(dlogs.PreviousMap.DamageTable, ply, round, dlogs.PreviousMap.Roles)
        end
    else
        if round == self:GetSyncEnt():GetPlayedRounds() then
            if not ply:CanUsedlogs() then return end
            damage_send = self.DamageTable
            current = true
        else
            damage_send = self.OldTables[round]
        end

        self:TransferLogs(damage_send, ply, round, roles, current)
    end
end

function dlogs:TransferLogs(damage_send, ply, round, roles, current)
    local count = #damage_send
    net.Start("dlogs.Senddlogs")
    net.WriteTable(roles or {})
    net.WriteUInt(count, 32)

    for k, v in ipairs(damage_send) do
        net.WriteTable(v)
    end

    net.Send(ply)
end

net.Receive("dlogs.Askdlogs", function(_, ply)
    local roundnumber = net.ReadInt(32)

    --Because -1 is the last round from previous map
    if (roundnumber and roundnumber > -2) then
        dlogs:Senddlogs(ply, roundnumber)
    else
        dlogs:Error(debug.getinfo(1).source, debug.getinfo(1).currentline, "Roundnumber invalid or negative")
    end
end)

hook.Add("PlayerDeath", "dlogs_PlayerDeathLastLogs", function(ply)
    if GetRoundState() ~= ROUND_ACTIVE then return end
    local found_dmg = {}
    local count = #dlogs.DamageTable

    for i = count, 1, -1 do
        local line = dlogs.DamageTable[i]
        if not dlogs.Time or line.time < dlogs.Time - 10 then break end
        table.insert(found_dmg, line)
    end

    ply.DeathDmgLog = {
        logs = table.Reverse(found_dmg),
        roles = dlogs.Roles[#dlogs.Roles]
    }
end)