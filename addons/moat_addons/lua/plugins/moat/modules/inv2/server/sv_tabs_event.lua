--[[-------------------------------------------------------------------------
core mysql stuff
---------------------------------------------------------------------------]]

MOAT_EVENT = MOAT_EVENT or {}
MOAT_EVENT.SQL = MOAT_EVENT.SQL or {}

function MOAT_EVENT.Print(str)
	MsgC(Color(255, 0, 0), "Events | ", Color(255, 255, 255), str .. "\n")
end

function MOAT_EVENT.SQL.CheckTable()
	MOAT_EVENT.SQL.Query([[
		CREATE TABLE IF NOT EXISTS moat_event (
		`steamid` bigint unsigned not null unique,
		`name` varchar(32) not null,
		`complete` int unsigned NOT NULL,
		`weps` mediumtext default NULL,
		`createdat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		`updatedat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		PRIMARY KEY (`steamid`))
	]])
end

hook.Add("SQLConnected", "EventSQL", function(db)
	MOAT_EVENT.Print("MySQL connection established at " .. os.date())
	MOAT_EVENT.SQL.DBHandle = db
	MOAT_EVENT.SQL.CheckTable()
end)

hook.Add("SQLConnectionFailed", "EventSQL", function(db, err)
	MOAT_EVENT.Print("MySQL connection failed: " .. tostring(err))
end)

function MOAT_EVENT.SQL.Escape(txt)
	return MOAT_EVENT.SQL.DBHandle:escape(tostring(txt or ""))
end

function MOAT_EVENT.SQL.Query(query, callback, ret)
	if (!query) then
		MOAT_EVENT.Print "No query given."
		return
	end
	
	local db = MOAT_EVENT.SQL.DBHandle
	local q = db:query(query)
	local d, r
	
	q.onData = function(self, dat)
		d = d or {}
		table.insert(d, dat)
	end
	
	q.onSuccess = function()
		if (callback) then r = callback(d) end
	end
	
	q.onError = function(q, err, query)
		if (db:status() == 2) then
			MOAT_EVENT.Print "MySQL connection lost during query. Reconnecting."

			db:connect()

			timer.Simple(1, function()
				MOAT_EVENT.SQL.Query(query, callback, ret)
			end)
			
			//r = MOAT_EVENT.SQL.Query(query, callback, ret)
		else
			MOAT_EVENT.Print("MySQL error: " .. err)
			MOAT_EVENT.Print(" | Query: " .. query)
		end
	end
	
	q:start()
	
	--if (ret) then q:wait() end
	
	return r
end

function MOAT_EVENT.SQL.FormatQuery(str, ...)
	local args, arg, succ = {...}, 0

	if (args and #args > 0 and isfunction(args[#args])) then
		succ = args[#args]
		args[#args] = nil
	end
	str = str:gsub("#", function() arg = arg + 1 return MOAT_EVENT.SQL.Escape(args[arg]) end)

	MOAT_EVENT.SQL.Query(str, succ)
end

function MOAT_EVENT.SQL.QueryRet(query, callback)
	callback = callback or function(data) return data end
	
	return MOAT_EVENT.SQL.Query(query, callback, true)
end

--=hook.Add("Initialize", "MOAT_EVENT.SQL.Connect", MOAT_EVENT.SQL.Connect)

--[[-------------------------------------------------------------------------
still mysql stuff, but not the core lol
---------------------------------------------------------------------------]]

util.AddNetworkString("moat.events.send")
util.AddNetworkString("moat.events.update")
util.AddNetworkString("moat.events.complete")
util.AddNetworkString("moat.events.top")

local function WasRightfulKill(att, vic)
	if (GetRoundState() ~= ROUND_ACTIVE) then return false end
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return false end
	
	local vicrole = vic:GetBasicRole()
	local attrole = att:GetBasicRole()

	if (vicrole == ROLE_TRAITOR and attrole == ROLE_TRAITOR) then return false end
	if ((vicrole == ROLE_DETECTIVE or vicrole == ROLE_INNOCENT) and (attrole == ROLE_DETECTIVE or attrole == ROLE_INNOCENT)) then return false end

	return true
end

-- weapon ids
MOAT_EVENT.Weapons = {}
MOAT_EVENT.WeaponsID = {
	["weapon_zm_sledge"] = 1,
	["weapon_ttt_m590"] = 2,
	["weapon_zm_shotgun"] = 3,
	["weapon_zm_revolver"] = 4,
	["weapon_zm_mac10"] = 5,
	["weapon_xm8b"] = 6,
	["weapon_ttt_sg552"] = 7,
	["weapon_ttt_mp5"] = 8,
	["weapon_ttt_ump45"] = 9,
	["weapon_ttt_famas"] = 10,
	["weapon_spas12pvp"] = 11,
	["weapon_ttt_vss"] = 12,
	["weapon_ttt_p228"] = 13,
	["weapon_ttt_scorpion"] = 14,
	["weapon_ttt_aug"] = 15,
	["weapon_ttt_ak47"] = 16,
	["weapon_ttt_tmp"] = 17,
	["weapon_ttt_galil"] = 18,
	["weapon_ttt_mr96"] = 19,
	["weapon_ttt_m1014"] = 20,
	["weapon_zm_pistol"] = 21,
	["weapon_ttt_m16"] = 22,
	["weapon_ttt_dual_elites"] = 23,
	["weapon_doubleb"] = 24,
	["weapon_ttt_cz75"] = 25,
	["weapon_ttt_m03a3"] = 26,
	["weapon_ttt_msbs"] = 27,
	["weapon_ttt_shotgun"] = 28,
	["weapon_ttt_p90"] = 29,
	["weapon_ttt_mp5k"] = 30,
	["weapon_ttt_mac11"] = 31,
	["weapon_zm_rifle"] = 32,
	["weapon_ttt_peacekeeper"] = 33,
	["weapon_supershotty"] = 34,
	["weapon_thompson"] = 35,
	["weapon_flakgun"] = 36,
	["weapon_ttt_glock"] = 37,
	["weapon_ttt_te_sr25"] = 38,
	["weapon_ttt_te_1911"] = 39,
	["weapon_ttt_te_ak47"] = 40,
	["weapon_ttt_te_benelli"] = 41,
	["weapon_ttt_te_cf05"] = 42,
	["weapon_ttt_te_deagle"] = 43,
	["weapon_ttt_te_fal"] = 44,
	["weapon_ttt_te_famas"] = 45,
	["weapon_ttt_te_g36c"] = 46,
	["weapon_ttt_te_glock"] = 47,
	["weapon_ttt_te_m4a1"] = 48,
	["weapon_ttt_te_m9"] = 49,
	["weapon_ttt_te_m14"] = 50,
	["weapon_ttt_te_m24"] = 51,
	["weapon_ttt_te_mac"] = 52,
	["weapon_ttt_te_mp5"] = 53,
	["weapon_ttt_te_ots33"] = 54,
	["weapon_ttt_te_sako"] = 55,
	["weapon_ttt_te_sg550"] = 56,
	["weapon_ttt_te_sterling"] = 57,
	["weapon_ttt_te_vollmer"] = 58
}

for k, v in pairs(MOAT_EVENT.WeaponsID) do
	MOAT_EVENT.Weapons[v] = k
end

MOAT_EVENT.WeaponsChallenges = {
	["weapon_zm_sledge"] = {150, 75, 75, 50, 100, 25, 20, 300},
	["weapon_ttt_m590"] = {150, 75, 75, 50, 100, 25, 21, 400},
	["weapon_zm_shotgun"] = {150, 75, 75, 50, 100, 40, 25, 400},
	["weapon_zm_revolver"] = {100, 75, 65, 50, 75, 26, 20, 300},
	["weapon_zm_mac10"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_xm8b"] = {150, 125, 125, 100, 100, 35, 25, 500},
	["weapon_ttt_sg552"] = {150, 100, 75, 75, 100, 32, 20, 450},
	["weapon_ttt_mp5"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_ump45"] = {200, 125, 125, 100, 125, 38, 27, 500},
	["weapon_ttt_famas"] = {150, 125, 125, 100, 115, 33, 23, 450},
	["weapon_spas12pvp"] = {150, 75, 75, 50, 100, 35, 20, 500},
	["weapon_ttt_vss"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_p228"] = {100, 50, 50, 50, 75, 27, 14, 300},
	["weapon_ttt_scorpion"] = {200, 125, 100, 75, 125, 32, 26, 500},
	["weapon_ttt_aug"] = {150, 100, 75, 75, 100, 25, 18, 400},
	["weapon_ttt_ak47"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_tmp"] = {150, 75, 75, 75, 100, 32, 17, 350},
	["weapon_ttt_galil"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_mr96"] = {150, 100, 75, 50, 100, 30, 20, 350},
	["weapon_ttt_m1014"] = {150, 75, 75, 50, 100, 28, 25, 400},
	["weapon_zm_pistol"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_m16"] = {200, 150, 150, 100, 125, 35, 25, 500},
	["weapon_ttt_dual_elites"] = {100, 50, 75, 50, 75, 25, 14, 300},
	["weapon_doubleb"] = {100, 50, 75, 50, 100, 20, 11, 300},
	["weapon_ttt_cz75"] = {100, 75, 75, 75, 100, 30, 20, 350},
	["weapon_ttt_m03a3"] = {150, 75, 75, 75, 100, 23, 18, 400},
	["weapon_ttt_msbs"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_shotgun"] = {150, 75, 75, 50, 100, 35, 22, 500},
	["weapon_ttt_p90"] = {200, 100, 100, 75, 125, 35, 23, 500},
	["weapon_ttt_mp5k"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_mac11"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_zm_rifle"] = {100, 65, 50, 50, 75, 20, 12, 300},
	["weapon_ttt_peacekeeper"] = {200, 150, 150, 125, 120, 35, 24, 500},
	["weapon_supershotty"] = {150, 75, 75, 50, 100, 35, 21, 500},
	["weapon_thompson"] = {200, 100, 100, 100, 125, 35, 23, 500},
	["weapon_flakgun"] = {100, 50, 50, 50, 75, 23, 12, 300},
	["weapon_ttt_glock"] = {100, 75, 75, 75, 100, 30, 18, 350},
	["weapon_ttt_te_sr25"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_te_1911"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_ak47"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_te_benelli"] = {150, 75, 75, 50, 100, 40, 25, 400},
	["weapon_ttt_te_cf05"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_te_deagle"] = {100, 75, 65, 50, 75, 26, 20, 300},
	["weapon_ttt_te_fal"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_te_famas"] = {150, 125, 125, 100, 115, 33, 23, 450},
	["weapon_ttt_te_g36c"] = {200, 150, 150, 100, 125, 35, 25, 500},
	["weapon_ttt_te_glock"] = {100, 75, 75, 75, 100, 30, 18, 350},
	["weapon_ttt_te_m4a1"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_te_m9"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_m14"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_te_m24"] = {100, 65, 50, 50, 75, 20, 12, 300},
	["weapon_ttt_te_mac"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_ttt_te_mp5"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_te_ots33"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_sako"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_te_sg550"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_te_sterling"] = {150, 75, 75, 75, 100, 32, 17, 350},
	["weapon_ttt_te_vollmer"] = {150, 75, 75, 50, 100, 25, 20, 300}
}

function MOAT_EVENT.WeaponClass(class)
	if (class == "weapon_ttt_an94") then
		class = "weapon_ttt_peacekeeper"
	elseif (class == "weapon_ttt_te_m9s") then
		class = "weapon_ttt_te_m9"
	elseif (class == "weapon_ttt_te_sterlings") then
		class = "weapon_ttt_te_sterling"
	end

	return class
end

function MOAT_EVENT.WepToID(class)
	class = MOAT_EVENT.WeaponClass(class)

	return MOAT_EVENT.WeaponsID[class]
end

function MOAT_EVENT.SendData(pl, weps)
	for i = 1, #MOAT_EVENT.Weapons do
		if (not weps[i]) then
			weps[i] = {0, 0, 0, 0, 0, 0, 0, 0}
		end

		net.Start("moat.events.send")
		net.WriteUInt(i, 6)
		net.WriteUInt(weps[i][1], 8)
		net.WriteUInt(weps[i][2], 8)
		net.WriteUInt(weps[i][3], 8)
		net.WriteUInt(weps[i][4], 8)
		net.WriteUInt(weps[i][5], 8)
		net.WriteUInt(weps[i][6], 8)
		net.WriteUInt(weps[i][7], 8)
		net.WriteUInt(weps[i][8], 10)
		net.Send(pl)
	end

	pl.MOAT_EVENT = weps
end

function MOAT_EVENT.SendSpecData(pl, wep_id, num)
	local ti = pl.MOAT_EVENT[wep_id][num]

	net.Start("moat.events.update")
	net.WriteUInt(wep_id, 6)
	net.WriteUInt(num, 4)
	net.WriteUInt(ti, 10)
	net.Send(pl)
end

MOAT_EVENT.WeaponRewards = {
	"Novice",
	"Amateur",
	"Apprentice",
	"Professional",
	"Master",
	"Expert",
	"Legend",
	"God"
}

function MOAT_EVENT.GiveReward(pl, wep, id)
	pl:m_DropInventoryItem(MOAT_EVENT.WeaponRewards[id], MOAT_EVENT.Weapons[wep])
	MOAT_EVENT.SQL.FormatQuery("UPDATE moat_event SET complete = complete + 1 WHERE steamid = #", pl:SteamID64())

	net.Start("moat.events.complete")
	net.WriteUInt(wep, 6)
	net.WriteUInt(id, 4)
	net.Send(pl)
end

function MOAT_EVENT.UpdateData(pl, wep, id)
	pl.MOAT_EVENT[wep][id] = pl.MOAT_EVENT[wep][id] + 1

	if (pl.MOAT_EVENT[wep][id] >= MOAT_EVENT.WeaponsChallenges[MOAT_EVENT.Weapons[wep]][id]) then
		MOAT_EVENT.GiveReward(pl, wep, id)
	end

	MOAT_EVENT.SendSpecData(pl, wep, id)
	MOAT_EVENT.SavePlayer(pl)
end

function MOAT_EVENT.SendTop(pl)
	MOAT_EVENT.SQL.FormatQuery("SELECT CAST(steamid AS CHAR) AS steamid, name, complete FROM moat_event ORDER BY complete DESC LIMIT 100", function(d)
		if (not IsValid(pl)) then return end
		if (not d or #d < 1) then return end

		net.Start("moat.events.top")
		net.WriteUInt(#d, 7)
		for i = 1, #d do
			net.WriteString(d[i].steamid)
			net.WriteString(d[i].name)
			net.WriteUInt(d[i].complete, 16)
		end
		net.Send(pl)
	end)
end

net.Receive("moat.events.top", function(_, pl)
	if (pl.RequestedEventsTop) then
		return
	end

	MOAT_EVENT.SendTop(pl)
	pl.RequestedEventsTop = true
end)

function MOAT_EVENT.CheckPlayer(pl)
	if (not pl:SteamID64()) then return end

	MOAT_EVENT.SQL.FormatQuery("SELECT weps FROM moat_event WHERE steamid = #", pl:SteamID64(), function(d)
		if (not IsValid(pl)) then return end

		if (not d or #d < 1) then
			MOAT_EVENT.NewPlayer(pl)
		else
			MOAT_EVENT.SendData(pl, util.JSONToTable(d[1].weps))
		end
	end)
end
hook.Add("PlayerInitialSpawn", "MOAT_EVENT.CheckPlayer", MOAT_EVENT.CheckPlayer)

function MOAT_EVENT.NewPlayer(pl)
	local tbl = {}

	for i = 1, #MOAT_EVENT.Weapons do
		tbl[i] = {0, 0, 0, 0, 0, 0, 0, 0}
	end

	MOAT_EVENT.SQL.FormatQuery("INSERT INTO moat_event (name, steamid, complete, weps) VALUES ('#', '#', 0, '#')", pl:Nick(), pl:SteamID64(), util.TableToJSON(tbl), function(d)
		if (not IsValid(pl)) then return end

		MOAT_EVENT.SendData(pl, tbl)
	end)
end

function MOAT_EVENT.SavePlayer(pl)
	if (not pl.MOAT_EVENT) then return end
	if (#pl.MOAT_EVENT < 1) then return end

	MOAT_EVENT.SQL.FormatQuery("UPDATE moat_event SET weps = '#' WHERE steamid = #", util.TableToJSON(pl.MOAT_EVENT), pl:SteamID64())
end

function MOAT_EVENT.OnChallenge(pl, class, id)
	class = MOAT_EVENT.WeaponClass(class)

	local wep_id = MOAT_EVENT.WepToID(class)
	local cur = pl.MOAT_EVENT[wep_id]
	local tbl = MOAT_EVENT.WeaponsChallenges[class]

	if (cur[1] < tbl[1]) then
		return id == 1
	elseif (cur[2] < tbl[2]) then
		return id == 2
	elseif (cur[3] < tbl[3]) then
		return id == 3
	elseif (cur[4] < tbl[4]) then
		return id == 4
	elseif (cur[5] < tbl[5]) then
		return id == 5
	elseif (cur[6] < tbl[6]) then
		return id == 6
	elseif (cur[7] < tbl[7]) then
		return id == 7
	elseif (cur[8] < tbl[8]) then
		return id == 8
	end
	
	return false
end

function MOAT_EVENT.PlayerDeathEvent(vic, inf, att)
	if (IsValid(att) and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

	if (IsValid(vic) and IsValid(att) and att:IsPlayer() and vic ~= att and WasRightfulKill(att, vic) and IsValid(inf) and inf:IsWeapon() and inf.ClassName and MOAT_EVENT.WepToID(inf.ClassName)) then
		if (not att.MOAT_EVENT) then return end

		local wep_id = MOAT_EVENT.WepToID(inf.ClassName)
		if (not wep_id) then return end
		
		if (MOAT_EVENT.OnChallenge(att, inf.ClassName, 1)) then
			MOAT_EVENT.UpdateData(att, wep_id, 1)
		elseif (inf.Weapon.ItemStats and inf.Weapon.ItemStats.item and inf.Weapon.ItemStats.item.Rarity and inf.Weapon.ItemStats.item.Rarity == 2 and MOAT_EVENT.OnChallenge(att, inf.ClassName, 3)) then
			MOAT_EVENT.UpdateData(att, wep_id, 3)
		elseif (att:Crouching() and MOAT_EVENT.OnChallenge(att, inf.ClassName, 5)) then
			MOAT_EVENT.UpdateData(att, wep_id, 5)
		elseif (MOAT_EVENT.OnChallenge(att, inf.ClassName, 6) and inf.Weapon.ItemStats and inf.Weapon.ItemStats.item and inf.Weapon.ItemStats.item.Rarity and inf.Weapon.ItemStats.item.Rarity == 5) then
			if (att.EventDoubleKill) then
				if (att.EventDoubleKill >= CurTime() - 10) then
					MOAT_EVENT.UpdateData(att, wep_id, 6)
					att.EventDoubleKill = nil
				else
					att.EventDoubleKill = CurTime()
				end
			else
				att.EventDoubleKill = CurTime()
			end
		elseif (MOAT_EVENT.OnChallenge(att, inf.ClassName, 7) and inf.Weapon.ItemStats and inf.Weapon.ItemStats.item and inf.Weapon.ItemStats.item.Rarity and inf.Weapon.ItemStats.item.Rarity == 5) then
			if (att.EventPentaKill) then
				att.EventPentaKill = att.EventPentaKill + 1

				if (att.EventPentaKill >= 5) then
					MOAT_EVENT.UpdateData(att, wep_id, 7)
					att.EventPentaKill = nil
				end
			else
				att.EventPentaKill = 1
			end
		elseif (MOAT_EVENT.OnChallenge(att, inf.ClassName, 8)) then
			MOAT_EVENT.UpdateData(att, wep_id, 8)
		end
	end
end

hook.Add("PlayerDeath", "MOAT_EVENT.PlayerDeathEvent", MOAT_EVENT.PlayerDeathEvent)

function MOAT_EVENT.ResetEventPentaKill()
	local plys = player.GetAll()

	for i = 1, #plys do
		plys[i].EventPentaKill = nil
	end
end

hook.Add("TTTBeginRound", "MOAT_EVENT.ResetEventPentaKill", MOAT_EVENT.ResetEventPentaKill)

function MOAT_EVENT.EntityTakeDamage(pl, dmg)
	if (not IsValid(pl) or not pl:IsPlayer()) then return end
	local vic, inf, att, hit, dmg = pl, dmg:GetInflictor(), dmg:GetAttacker(), dmg:GetDamageCustom(), dmg:GetDamage()

	if (IsValid(att) and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

	if (not IsValid(att) or not att:IsPlayer()) then return end
	if (att == vic) then return end

	if (dmg >= vic:Health() and WasRightfulKill(att, vic) and IsValid(inf) and inf:IsWeapon() and inf.ClassName and MOAT_EVENT.WepToID(inf.ClassName)) then
		if (not att.MOAT_EVENT) then return end

		local wep_id = MOAT_EVENT.WepToID(inf.ClassName)
		if (not wep_id) then return end

		if (MOAT_EVENT.OnChallenge(att, inf.ClassName, 2) and hit == HITGROUP_HEAD) then
			MOAT_EVENT.UpdateData(att, wep_id, 2)
		elseif (MOAT_EVENT.OnChallenge(att, inf.ClassName, 4) and hit == HITGROUP_HEAD and inf.Weapon.ItemStats and inf.Weapon.ItemStats.item and inf.Weapon.ItemStats.item.Rarity and inf.Weapon.ItemStats.item.Rarity == 3) then
			MOAT_EVENT.UpdateData(att, wep_id, 4)
		end
	end
end

-- hook.Add("EntityTakeDamage", "MOAT_EVENT.EntityTakeDamage", MOAT_EVENT.EntityTakeDamage)

hook.Add("ScalePlayerDamage", "MOAT_EVENT.ScalePlayerDamage", function(ply, hitgroup, dmginfo)
    local att, inf = dmginfo:GetAttacker(), dmginfo:GetInflictor()

	if (IsValid(att) and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

    if (hitgroup == HITGROUP_HEAD) then
        att.eventhead = ply
		att.eventwep = inf
	elseif (att.eventhead == ply) then
        att.eventhead = att
		att.eventwep = inf
    end
end)

 hook.Add("PlayerDeath", "MOAT_EVENT.PlayerDeath", function(ply, inf, att)
	if (IsValid(att) and att:IsPlayer() and ply ~= att and (att.lasthead and att.lasthead == ply) and WasRightfulKill(att, ply)) then
        inf = att.eventwep

		if (IsValid(inf) and inf:IsWeapon() and inf.ClassName and MOAT_EVENT.WepToID(inf.ClassName)) then
			if (not att.MOAT_EVENT) then return end
			
			local wep_id = MOAT_EVENT.WepToID(inf.ClassName)
			if (not wep_id) then return end

			if (MOAT_EVENT.OnChallenge(att, inf.ClassName, 2)) then
				MOAT_EVENT.UpdateData(att, wep_id, 2)
			elseif (MOAT_EVENT.OnChallenge(att, inf.ClassName, 4) and inf.Weapon.ItemStats and inf.Weapon.ItemStats.item and inf.Weapon.ItemStats.item.Rarity and inf.Weapon.ItemStats.item.Rarity == 3) then
				MOAT_EVENT.UpdateData(att, wep_id, 4)
			end
		end
	end
end)