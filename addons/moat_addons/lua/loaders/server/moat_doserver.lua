util.AddNetworkString("moat.dot.init")
util.AddNetworkString("moat.dot.adjust")
util.AddNetworkString("moat.dot.end")


local pl = FindMetaTable("Player")

function pl:ApplyDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    local id = dmgtype .. self:EntIndex() .. att:EntIndex()
    local wep = att:GetActiveWeapon()

    timer.Create(id, delay, reps, function()
        if (not self:IsValid() or self:IsSpec() or not self:IsActive() or GetRoundState() ~= ROUND_ACTIVE) then
            timer.Remove(id)

            return
        end

        if (onhit) then
            onhit(self, att)
        end

        if (dmg and dmg > 0) then
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(dmg)
            dmginfo:SetAttacker(att)
            dmginfo:SetInflictor(wep)
            self:TakeDamageInfo(dmginfo)
        end
        
        if (timer.RepsLeft(id) < 1 and onend) then
            onend(self, att)
        end
    end)

    if (onstart) then
        onstart(self, att)
    end
end

function pl:IncreaseDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    local id = dmgtype .. self:EntIndex() .. att:EntIndex()
    local newreps = timer.RepsLeft(id) + reps
    local wep = att:GetActiveWeapon()

    net.Start("moat.dot.adjust")
    net.WriteString(id)
    net.WriteUInt(newreps * deay, 16)
    net.Send(self)

    timer.Adjust(id, delay, newreps, function()
        if (not self:IsValid() or self:IsSpec() or not self:IsActive() or GetRoundState() ~= ROUND_ACTIVE) then
            timer.Remove(id)

            return
        end

        if (onhit) then
            onhit(self, att)
        end

        if (dmg and dmg > 0) then
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(dmg)
            dmginfo:SetAttacker(att)
            dmginfo:SetInflictor(wep)
            self:TakeDamageInfo(dmginfo)
        end
        
        if (timer.RepsLeft(id) < 1 and onend) then
            onend(self, att)
        end
    end)
end

function pl:ApplyDOT(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    if (timer.Exists(dmgtype .. self:EntIndex() .. att:EntIndex())) then
        self:IncreaseDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    else
        self:ApplyDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    end
end


local max_kills = 5
local pl_kills = {}

hook.Add("PlayerDeath", "AutoBanRDM", function(vic, inf, att)
    if (MOAT_MINIGAME_OCCURING) then return end
    if (inf.Avoidable or not IsValid(att) or not att:IsPlayer() or att == vic) then return end
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
	local roles = {[ROLE_DETECTIVE] = 1, [ROLE_INNOCENT] = 1, [ROLE_TRAITOR] = 2}
	local attr = roles[att:GetRole()]
	local vicr = roles[vic:GetRole()]

    if ((attr and vicr and attr == vicr) or (att:GetRole() == vic:GetRole())) then
        if (not pl_kills[att:SteamID()]) then
			if (att:GetNWInt("MOAT_STATS_LVL", 1) >= 10) then
				pl_kills[att:SteamID()] = 15
			else
				pl_kills[att:SteamID()] = 5
			end
		end

        pl_kills[att:SteamID()] = pl_kills[att:SteamID()] - 1
        if (pl_kills[att:SteamID()] == 3) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 3 more teammates!")]])
        elseif (pl_kills[att:SteamID()] == 2) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 2 more teammates!")]])
        elseif (pl_kills[att:SteamID()] == 1) then
            att:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color(255, 100, 100), "WARNING: You will be banned from the server if you kill 1 more teammates!")]])
        elseif (pl_kills[att:SteamID()] <= 0) then
            RunConsoleCommand("mga", "ban", att:SteamID(), "240", "minutes", "[Automated] Too Many Teammate Kills!")
        end
    end
end)


/*
local max = GetConVarNumber("maxplayers")
local cur_max = 0
local playersjoined = {}
local math_Clamp = math.Clamp
local function setmax(num)
    RunConsoleCommand("sv_visiblemaxplayers", num)
end

local function raise_cur()
    cur_max = math_Clamp(cur_max + 1, 0, max)
end

local function lower_cur()
    cur_max = math_Clamp(cur_max - 1, 0, max)
end

setmax(max)

hook.Add("CheckPassword","PlayerList",function(sid)
    raise_cur()
    playersjoined[sid] = true
    print("cp", "cp", "cp", "cp", "cp")
    print("cp", "cp", "cp", "cp", "cp")
    print("cp", "cp", "cp", "cp", "cp")
    print("cp", "cp", "cp", "cp", "cp")
    print("cp", "cp", "cp", "cp", "cp")
    print("cp", "cp", "cp", "cp", "cp")

    if cur_max >= max then
        setmax(max-1)
    end
end)

hook.Add("PlayerAuthed","PlayerList",function(ply)
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")
    print("pa", "pa", "pa", "pa", "pa")

    if not playersjoined[ply:SteamID64()] then
        raise_cur()
        if cur_max >= max then
            setmax(max-1)
        end
    end
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect","PlayerList",function()
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    print("pd", "pd", "pd", "pd", "pd")
    lower_cur()
    setmax(max)
end)
*/