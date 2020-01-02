if (true) then return end

--[[-------------------------------------------------------------------------
core mysql stuff
---------------------------------------------------------------------------]]

require "mysqloo"

MOAT_EVENT = MOAT_EVENT or {}
MOAT_EVENT.SQL = MOAT_EVENT.SQL or {
	Config = {
		database = "old_moat_ttt",
		host = "gamedb.moat.gg",
		port = 3306,
		user = "footsies",
		pass = "clkmTQF6bF@3V0NYjtUMoC6sF&17B$"
	}
}

function MOAT_EVENT.Print(str)
	MsgC(Color(255, 0, 0), "Events | ", Color(255, 255, 255), str .. "\n")
end

function MOAT_EVENT.SQL.CheckTable()
	MOAT_EVENT.SQL.Query([[
		CREATE TABLE IF NOT EXISTS moat_event (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
		name TEXT NOT NULL,
		steamid VARCHAR(30) NOT NULL,
		complete INTEGER NOT NULL,
		weps TEXT NOT NULL)
	]])
end
/*
function MOAT_EVENT.SQL.Connect()
	if (MOAT_EVENT.SQL.DBHandle) then
		MOAT_EVENT.Print "Using pre-established MySQL link."
		return
	end

	local db = mysqloo.connect(MOAT_EVENT.SQL.Config.host, MOAT_EVENT.SQL.Config.user, MOAT_EVENT.SQL.Config.pass, MOAT_EVENT.SQL.Config.database, MOAT_EVENT.SQL.Config.port)
	
	db.onConnectionFailed = function(msg, err)
		MOAT_EVENT.Print("MySQL connection failed: " .. tostring(err))
	end
	
	db.onConnected = function()
		MOAT_EVENT.Print("MySQL connection established at " .. os.date())
		
		MOAT_EVENT.SQL.DBHandle = db

		MOAT_EVENT.SQL.CheckTable()

		db.onConnected = function() MOAT_EVENT.Print("MySQL connection re-established at " .. os.date()) end
	end
	
	db:connect()
	db:wait()
	
	MOAT_EVENT.SQL.DBHandle = db
end*/

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
	
	local vicrole = vic:GetRole()
	local attrole = att:GetRole()

	if (vicrole == ROLE_TRAITOR and attrole == ROLE_TRAITOR) then return false end
	if ((vicrole == ROLE_DETECTIVE or vicrole == ROLE_INNOCENT) and attrole ~= ROLE_TRAITOR) then return false end

	return true
end

-- weapon ids
MOAT_EVENT.Weapons = {
    [1]   =   "weapon_zm_sledge",
    [2]   =   "weapon_ttt_m590",
    [3]   =   "weapon_zm_shotgun",
    [4]   =   "weapon_zm_revolver",
    [5]   =   "weapon_zm_mac10",
    [6]   =   "weapon_xm8b",
    [7]   =   "weapon_ttt_sg552",
    [8]   =   "weapon_ttt_ump45",
    [9]   =   "weapon_ttt_famas",
    [10]  =   "weapon_ttt_aug",
    [11]  =   "weapon_ttt_ak47",
    [12]  =   "weapon_ttt_galil",
    [13]  =   "weapon_ttt_mr96",
    [14]  =   "weapon_zm_pistol",
    [15]  =   "weapon_ttt_m16",
    [16]  =   "weapon_ttt_dual_elites",
    [17]  =   "weapon_ttt_msbs",
    [18]  =   "weapon_ttt_shotgun",
    [19]  =   "weapon_ttt_p90",
    [20]  =   "weapon_ttt_mp5",
    [21]  =   "weapon_zm_rifle",
    [22]  =   "weapon_thompson",
    [23]  =   "weapon_flakgun",
    [24]  =   "weapon_ttt_glock"
}

MOAT_EVENT.WeaponsID = {
    ["weapon_zm_sledge"] = 1,
    ["weapon_ttt_m590"] = 2,
    ["weapon_zm_shotgun"] = 3,
    ["weapon_zm_revolver"] = 4,
    ["weapon_zm_mac10"] = 5,
    ["weapon_xm8b"] = 6,
    ["weapon_ttt_sg552"] = 7,
    ["weapon_ttt_ump45"] = 8,
    ["weapon_ttt_famas"] = 9,
    ["weapon_ttt_aug"] = 10,
    ["weapon_ttt_ak47"] = 11,
    ["weapon_ttt_galil"] = 12,
    ["weapon_ttt_mr96"] = 13,
    ["weapon_zm_pistol"] = 14,
    ["weapon_ttt_m16"] = 15,
    ["weapon_ttt_dual_elites"] = 16,
    ["weapon_ttt_msbs"] = 17,
    ["weapon_ttt_shotgun"] = 18,
    ["weapon_ttt_p90"] = 19,
    ["weapon_ttt_mp5"] = 20,
    ["weapon_zm_rifle"] = 21,
    ["weapon_thompson"] = 22,
    ["weapon_flakgun"] = 23,
    ["weapon_ttt_glock"] = 24
}

MOAT_EVENT.WeaponsChallenges = {
    ["weapon_zm_sledge"] = {150, 75, 75, 50, 100, 25, 20, 300},
    ["weapon_ttt_m590"] = {150, 75, 75, 50, 100, 25, 21, 400},
    ["weapon_zm_shotgun"] = {150, 75, 75, 50, 100, 30, 23, 400},
    ["weapon_zm_revolver"] = {100, 75, 65, 50, 75, 26, 20, 300},
    ["weapon_zm_mac10"] = {200, 125, 100, 75, 125, 34, 24, 500},
    ["weapon_xm8b"] = {150, 125, 125, 100, 100, 35, 25, 500},
    ["weapon_ttt_sg552"] = {150, 100, 75, 75, 100, 32, 20, 450},
    ["weapon_ttt_ump45"] = {200, 125, 125, 100, 125, 38, 27, 550},
    ["weapon_ttt_famas"] = {150, 125, 125, 100, 115, 33, 23, 450},
    ["weapon_ttt_aug"] = {150, 100, 75, 75, 100, 25, 18, 400},
    ["weapon_ttt_ak47"] = {200, 150, 150, 125, 125, 40, 27, 500},
    ["weapon_ttt_galil"] = {200, 150, 150, 125, 125, 35, 25, 500},
    ["weapon_ttt_mr96"] = {150, 100, 75, 50, 100, 30, 20, 350},
    ["weapon_zm_pistol"] = {100, 50, 75, 50, 75, 24, 13, 300},
    ["weapon_ttt_m16"] = {200, 150, 150, 100, 125, 35, 25, 500},
    ["weapon_ttt_dual_elites"] = {100, 50, 75, 50, 75, 25, 14, 300},
    ["weapon_ttt_msbs"] = {150, 75, 75, 75, 100, 25, 20, 400},
    ["weapon_ttt_shotgun"] = {150, 75, 75, 50, 100, 30, 20, 500},
    ["weapon_ttt_p90"] = {200, 100, 100, 75, 125, 35, 23, 500},
    ["weapon_ttt_mp5"] = {200, 100, 125, 100, 125, 35, 23, 500},
    ["weapon_zm_rifle"] = {100, 65, 50, 50, 75, 20, 12, 300},
    ["weapon_thompson"] = {200, 100, 100, 100, 125, 35, 23, 500},
    ["weapon_flakgun"] = {100, 50, 50, 50, 75, 23, 12, 300},
    ["weapon_ttt_glock"] = {100, 75, 75, 75, 100, 30, 18, 350}
}

function MOAT_EVENT.WepToID(class)
	return MOAT_EVENT.WeaponsID[class] or nil
end

function MOAT_EVENT.SendData(pl, weps)
	pl.MOAT_EVENT = weps

	for i = 1, #weps do
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
	MOAT_EVENT.SQL.FormatQuery("SELECT name, steamid, complete FROM moat_event ORDER BY complete DESC LIMIT 15", function(d)
		if (not pl:IsValid()) then return end
		if (not d or #d < 1) then return end

		for i = 1, #d do
			net.Start("moat.events.top")
			net.WriteUInt(i, 6)
			net.WriteString(d[i].steamid)
			net.WriteString(d[i].name)
			net.WriteUInt(d[i].complete, 16)
			net.Send(pl)
		end
	end)
end

function MOAT_EVENT.CheckPlayer(pl)
	if (not pl:SteamID64()) then return end
	
	MOAT_EVENT.SQL.FormatQuery("SELECT weps FROM moat_event WHERE steamid = #", pl:SteamID64(), function(d)
		if (not pl:IsValid()) then return end

		if (not d or #d < 1) then
			MOAT_EVENT.NewPlayer(pl)
		else
			MOAT_EVENT.SendData(pl, util.JSONToTable(d[1].weps))
		end
	end)

	MOAT_EVENT.SendTop(pl)
end
hook.Add("PlayerInitialSpawn", "MOAT_EVENT.CheckPlayer", MOAT_EVENT.CheckPlayer)

function MOAT_EVENT.NewPlayer(pl)
	local tbl = {}

	for i = 1, #MOAT_EVENT.Weapons do
		tbl[i] = {0, 0, 0, 0, 0, 0, 0, 0}
	end

	MOAT_EVENT.SQL.FormatQuery("INSERT INTO moat_event (name, steamid, complete, weps) VALUES ('#', '#', 0, '#')", pl:Nick(), pl:SteamID64(), util.TableToJSON(tbl), function(d)
		if (not pl:IsValid()) then return end

		MOAT_EVENT.SendData(pl, tbl)
	end)
end

function MOAT_EVENT.SavePlayer(pl)
	if (not pl.MOAT_EVENT) then return end
	if (#pl.MOAT_EVENT < 1) then return end
	
	MOAT_EVENT.SQL.FormatQuery("UPDATE moat_event SET weps = '#' WHERE steamid = #", util.TableToJSON(pl.MOAT_EVENT), pl:SteamID64())
end

function MOAT_EVENT.OnChallenge(pl, class, id)
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
	if (att:IsValid() and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

	if (vic:IsValid() and att:IsValid() and att:IsPlayer() and vic ~= att and WasRightfulKill(att, vic) and inf:IsValid() and inf:IsWeapon() and inf.ClassName and MOAT_EVENT.WeaponsID[inf.ClassName]) then
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
	if (not pl:IsValid() or not pl:IsPlayer()) then return end
	local vic, inf, att, hit, dmg = pl, dmg:GetInflictor(), dmg:GetAttacker(), dmg:GetDamageCustom(), dmg:GetDamage()

	if (att:IsValid() and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

	if (not att:IsValid() or not att:IsPlayer()) then return end
	if (att == vic) then return end

	if (dmg >= vic:Health() and WasRightfulKill(att, vic) and inf:IsValid() and inf:IsWeapon() and inf.ClassName and MOAT_EVENT.WeaponsID[inf.ClassName]) then
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

hook.Add("EntityTakeDamage", "MOAT_EVENT.EntityTakeDamage", MOAT_EVENT.EntityTakeDamage)