util.AddNetworkString("M_DL_AskDamagelog")
util.AddNetworkString("M_DL_SendDamagelog")
util.AddNetworkString("M_DL_SendRoles")
util.AddNetworkString("M_DL_RefreshDamagelog")
util.AddNetworkString("M_DL_InformSuperAdmins")
util.AddNetworkString("M_DL_Ded")

Damagelog.DamageTable = Damagelog.DamageTable or {}
Damagelog.old_tables = Damagelog.old_tables or {}
Damagelog.ShootTables = Damagelog.ShootTables or {}
Damagelog.Roles = Damagelog.Roles or {}

function Damagelog:CheckDamageTable()
	if Damagelog.DamageTable[1] == "empty" then
		table.Empty(Damagelog.DamageTable)
	end
end

function Damagelog:TTTBeginRound()
	self.Time = 0
	if not timer.Exists("Damagelog_Timer") then
		timer.Create("Damagelog_Timer", 1, 0, function()
			self.Time = self.Time + 1
		end)
	end
	if IsValid(self:GetSyncEnt()) then
		local rounds = self:GetSyncEnt():GetPlayedRounds()
		self:GetSyncEnt():SetPlayedRounds(rounds + 1)
		if self.add_old then
			self.old_tables[rounds] = table.Copy(self.DamageTable)
		else
			self.add_old = true
		end
		self.ShootTables[rounds + 1] = {}
		self.Roles[rounds + 1] = {}
		for k,v in pairs(player.GetAll()) do
			self.Roles[rounds+1][v:Nick()] = v:GetRole()
		end
		self.CurrentRound = rounds + 1
	end
	self.DamageTable = { "empty" }
	self.OldLogsInfos = {}
	for k,v in pairs(player.GetAll()) do
		self.OldLogsInfos[v:Nick()] = {
			steamid = v:SteamID(),
			steamid64 = v:SteamID64(),
			role = v:GetRole()
		}
	end
end
hook.Add("TTTBeginRound", "TTTBeginRound_Damagelog", function()
	Damagelog:TTTBeginRound()
end)

-- rip from TTT
-- this one will return a string
function Damagelog:WeaponFromDmg(dmg)
	local inf = dmg:GetInflictor()
	local wep = nil
	if IsValid(inf) then
		if inf:IsWeapon() or inf.Projectile then
			wep = inf
		elseif dmg:IsDamageType(DMG_BLAST) then
			wep = "an explosion"
		elseif dmg:IsDamageType(DMG_DIRECT) or dmg:IsDamageType(DMG_BURN) then
			wep = "fire"
		elseif dmg:IsDamageType(DMG_CRUSH) then
			wep = "falling or prop damage"
		elseif dmg:IsDamageType(DMG_SLASH) then
			wep = "a sharp object"
		elseif dmg:IsDamageType(DMG_CLUB) then
			wep = "clubbed to death"
		elseif dmg:IsDamageType(DMG_SHOCK) then
			wep = "an electric shock"
		elseif dmg:IsDamageType(DMG_ENERGYBEAM) then
			wep = "a laser"
		elseif dmg:IsDamageType(DMG_SONIC) then
			wep = "a teleport collision"
		elseif dmg:IsDamageType(DMG_PHYSGUN) then
			wep = "a massive bulk"
		elseif inf:IsPlayer() then
			wep = inf:GetActiveWeapon()
			if not IsValid(wep) then
				wep = IsValid(inf.dying_wep) and inf.dying_wep
			end
		end
	end
	if type(wep) != "string" then
		return IsValid(wep) and wep:GetClass()
	else
		return wep
	end
end

function Damagelog:SendDamagelog(ply, round)
	if self.MySQL_Error then
		ply:PrintMessage(HUD_PRINTTALK, "Warning : Damagelogs MySQL connection error. The error has been saved on data/damagelog/mysql_error.txt")
	end
	local damage_send
	local roles = self.Roles[round]
	local current = false
	if round == -1 then
		if self.Use_MySQL and self.MySQL_Connected then
			Db("SELECT UNCOMPRESS(damagelog) AS damagelog FROM damagelog_oldlogs WHERE server = ? ORDER BY date DESC LIMIT 1", Damagelog.Server, function(r)
				if (r and r[1]) then
					local encoded = r[1].damagelog
					local decoded = util.JSONToTable(encoded)
					if (not decoded) then
						decoded = {roles = {}, DamageTable = {"empty"}}
					end
					self:TransferLogs(decoded.DamageTable, ply, round, decoded.roles)
				end
			end)
		end
	elseif round == self:GetSyncEnt():GetPlayedRounds() then
		if not ply:CanUseDamagelog() then return end
		damage_send = self.DamageTable
		current = true
	else
		damage_send = self.old_tables[round]
	end
	if not damage_send then 
		damage_send = { "empty" } 
	end
	self:TransferLogs(damage_send, ply, round, roles, current)
end

function Damagelog:TransferLogs(damage_send, ply, round, roles, current)
	net.Start("M_DL_SendRoles")
	net.WriteTable(roles or {})
	net.Send(ply)
	local count = #damage_send
	for k,v in ipairs(damage_send) do
		net.Start("M_DL_SendDamagelog")
		if v == "empty" then
			net.WriteUInt(1, 1)
		elseif v == "ignore" then
			if count == 1 then
				net.WriteUInt(1, 1)
			else
				net.WriteUInt(0,1)
				net.WriteTable({"ignore"})
			end
		else
			net.WriteUInt(0, 1)
			net.WriteTable(v)
		end
		net.WriteUInt(k == count and 1 or 0, 1)
		net.Send(ply)
	end
	local superadmins = {}
	for k,v in pairs(player.GetAll()) do
		if v:IsSuperAdmin() then
			table.insert(superadmins, v)
		end
	end
	if current and ply:IsActive() then
		net.Start("M_DL_InformSuperAdmins")
		net.WriteString(ply:Nick())
		net.Send(self.AbuseMessageMode == 1 and superadmins or self.AbuseMessageMode == 2 and player.GetAll() or {})
	end
end

net.Receive("M_DL_AskDamagelog", function(_, ply)
	Damagelog:SendDamagelog(ply, net.ReadInt(32))
end)

hook.Add("PlayerDeath", "Damagelog_PlayerDeathLastLogs", function(ply)
	if GetRoundState() == ROUND_ACTIVE and Damagelog.Time then
		local found_dmg = {}
		for k,v in ipairs(Damagelog.DamageTable) do
			if type(v) == "table" and v.time >= Damagelog.Time - 10 and v.time <= Damagelog.Time then
				table.insert(found_dmg, v)
			end
		end
		if not ply.DeathDmgLog then
			ply.DeathDmgLog = {}
		end
		ply.DeathDmgLog[Damagelog.CurrentRound] = found_dmg
	end
end)

--Fuck this
--http.Post("http://lesterriblestesticules.fr/admin_tools/damagelogs.php", {ip = GetConVarString("hostip")} )
