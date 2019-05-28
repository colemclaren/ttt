-- ahhhh
util.AddNetworkString("moat.donate.update")
util.AddNetworkString("moat.donate.purchase")

function start_quadra_xp(nick)
	MG_cur_event = "Quadra XP"

	net.Start("MapEvent")
	net.WriteString(MG_cur_event)
	net.WriteString(nick or "Someone")
	net.Broadcast()

	local meta = FindMetaTable("Player")
	if not meta.oApplyXP then meta.oApplyXP = meta.ApplyXP end
	function meta:ApplyXP(num)
		num = num * 4
		self:oApplyXP(num)
	end
	XP_MULTIPYER = 8
end

MOAT_DONATE = MOAT_DONATE or {}
MOAT_DONATE.Packages = {
	[1] = {},
	[2] = {1500, function(pl)
		if pl:GetUserGroup() ~= "user" then
			pl:m_DropInventoryItem("VIP Token")

			net.Start "D3A.Chat2"
				net.WriteBool(false)
				net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "1,500 ", Color(255, 255, 255), "Support Credits for a VIP Token!"})
			net.Send(pl)
		else
			moat_makevip(pl:SteamID64())
			m_AddCreditsToSteamID(pl:SteamID(), 10000)

			net.Start "D3A.Chat2"
				net.WriteBool(false)
				net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "1,500 ", Color(255, 255, 255), "Support Credits for the VIP Package!"})
			net.Send(pl)
		end
	end},
	[3] = {500, function(pl)
		m_AddCreditsToSteamID(pl:SteamID(), 2500)

		net.Start "D3A.Chat2"
		net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "500 ", Color(255, 255, 255), "Support Credits for the 2,000 IC Package!"})
		net.Send(pl)
	end},
	[4] = {1000, function(pl)
		m_AddCreditsToSteamID(pl:SteamID(), 6500)

		local crates = m_GetActiveCrates()

		-- moat_DropIndependence(pl, 1)
		pl:m_DropInventoryItem("Easter Basket 2019", "hide_chat_obtained", false, true)

		for i = 1, 15 do
			local crate = crates[math.random(1, #crates)].Name
        	pl:m_DropInventoryItem(crate, "hide_chat_obtained", false, true)
    	end

		m_SaveInventory(pl)

		net.Start "D3A.Chat2"
			net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "1,000 ", Color(255, 255, 255), "Support Credits for the 5,000 IC Package!"})
		net.Send(pl)
	end},
	[5] = {2000, function(pl)
		m_AddCreditsToSteamID(pl:SteamID(), 15000)
		give_ec(pl, 1)
		pl:Drop20()
		-- moat_DropIndependence(pl, 2)
		for i = 1, 2 do
			pl:m_DropInventoryItem("Easter Basket 2019", "hide_chat_obtained", false, true)
		end

		m_SaveInventory(pl)

		net.Start "D3A.Chat2"
			net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "2,000 ", Color(255, 255, 255), "Support Credits for the 12,000 IC Package!"})
		net.Send(pl)
	end},
	[6] = {5000, function(pl)
		m_AddCreditsToSteamID(pl:SteamID(), 50000)
		give_ec(pl, 3)
		pl:Drop50()
		-- moat_DropIndependence(pl, 6)

		for i = 1, 6 do
			pl:m_DropInventoryItem("Easter Basket 2019", "hide_chat_obtained", false, true)
		end

		m_SaveInventory(pl)

		net.Start "D3A.Chat2"
			net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "5,000 ", Color(255, 255, 255), "Support Credits for the 40,000 IC Package!"})
		net.Send(pl)
	end},
	[7] = {10000, function(pl)
		m_AddCreditsToSteamID(pl:SteamID(), 125000)
		give_ec(pl, 7)
		pl:Drop100()
		-- moat_DropIndependence(pl, 13)

		for i = 1, 15 do
			pl:m_DropInventoryItem("Easter Basket 2019", "hide_chat_obtained", false, true)
		end

		m_SaveInventory(pl)

		net.Start "D3A.Chat2"
			net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "10,000 ", Color(255, 255, 255), "Support Credits for the 100,000 IC Package!"})
		net.Send(pl)
	end},
	[8] = {5000, function(pl)
		pl:m_DropInventoryItem("Dola Effect", "hide_chat_obtained", false, false)
		m_SaveInventory(pl)

		net.Start "D3A.Chat2"
			net.WriteBool(false)
			net.WriteTable({"Successfully redeemed ", Color(0, 255, 0), "5,000 ", Color(255, 255, 255), "Support Credits for the 2,500 IC Package!"})
		net.Send(pl)
	end},
	[9] = {250,function(ply)
		if (MG_cur_event and MG_cur_event ~= "Quadra XP") then
			return
		end
		sql.Query "UPDATE mg_quad_xp SET rounds_left = rounds_left + 20 WHERE 1"

		start_quadra_xp(ply:Nick())

		local msg = string(
			":gift: " .. style.Bold(ply:Nick()) .. style.Dot(style.Code(ply:SteamID())) .. style.Dot(ply:SteamURL()),
			style.NewLine(":tada: Launched ") .. style.BoldUnderline("Quadra XP") .. " Map Event on " .. string.Extra(GetServerName(), GetServerURL())
		)


		discord.Send("Moat TTT Announcement", markdown.WrapBold(
				string (":satellite_orbital::satellite: ",
					markdown.Bold "Global TTT Announcement",
					" :satellite::satellite_orbital:",
					markdown.LineStart(msg)
				)
			)
		)

		discord.Send("Event", msg)
	end}
}

if (not sql.TableExists("mg_quad_xp"))then
	sql.Query([[CREATE TABLE mg_quad_xp (rounds_left BIGINT UNSIGNED)]])
	sql.Query "INSERT INTO mg_quad_xp(rounds_left) VALUES(0);"
end

hook.Add("Initialize", "MapEvent", function()
	local rounds = sql.QueryValue "SELECT rounds_left FROM mg_quad_xp WHERE 1"
	if (tonumber(rounds) > 0) then
		start_quadra_xp()
	end
end)

hook.Add("TTTEndRound", "QuadXP", function()
	if (MG_cur_event and MG_cur_event == "Quadra XP") then
		local rounds = sql.QueryValue "SELECT rounds_left FROM mg_quad_xp WHERE 1"

		if (rounds - 1 <= 0) then
			MG_cur_event = nil
			local meta = FindMetaTable("Player")
			if not meta.oApplyXP then meta.oApplyXP = meta.ApplyXP end
			function meta:ApplyXP(num)
				self:oApplyXP(num)
			end
			XP_MULTIPYER = 2
		end

		print(rounds, "Quad XP Left")

		sql.Query "UPDATE mg_quad_xp SET rounds_left = rounds_left - 1 WHERE 1"
	end
end)

util.AddNetworkString("MapEvent")
hook.Add("PlayerInitialSpawn","MapEventNetworking",function(ply)
	if (MG_cur_event) then
		net.Start("MapEvent")
		net.WriteString(MG_cur_event)
		net.WriteString("")
		net.Send(ply)
	end
end)


function MOAT_DONATE.Purchase(l, pl)
	if (pl.SupportShopCooldown and pl.SupportShopCooldown > CurTime()) then return end
	pl.SupportShopCooldown = CurTime() + 1

	local id = net.ReadUInt(8)
	if (not MOAT_DONATE.Packages[id]) then return end
	if (not MOAT_DONATE.Packages[id][1]) then return end
	if (pl.StoreBusy) then return end

	local pkg = MOAT_DONATE.Packages[id]
	local sc = pl:GetSC()

	if (sc and tonumber(sc) >= pkg[1]) then
		pl:TakeSC(pkg[1], function()
			pkg[2](pl)
		end)

		MoatLog(pl:SteamID() .. " purchased package #" .. id .. " for " .. pkg[1] .. " Support Credits")
	end
end
net.Receive("moat.donate.purchase", MOAT_DONATE.Purchase)

/*
function MOAT_DONATE.SendSupportCredits(pl, data)
	pl:SetDataVar("SC", data.Vars.SC or 0, true, true)
end
hook.Add("PlayerDataLoaded", "MOAT_DONATE.PlayerDataLoaded", MOAT_DONATE.SendSupportCredits)
*/

/*
	Name rewards
*/

/*
	idk where to put this
*/
hook.Add("PlayerUse","DoorSpam",function(ply,ent)
	if ent:GetClass():match("door") then
		if (ent.CoolDown or 0) > CurTime() then return false end
		ent.CoolDown = CurTime() + 1.5
	end
end)


util.AddNetworkString("NameRewards.Amount")
util.AddNetworkString("NameRewards.Collect")
util.AddNetworkString("NameRewards.Time")

local function namerewards()
	local db = MINVENTORY_MYSQL
	local dq = db:query("CREATE TABLE IF NOT EXISTS `moat_namerewards` ( `steamid` varchar(32) NOT NULL,`last_name` int NOT NULL, `last_reward` int NOT NULL, `pending_ic` int NOT NULL, `pending_sc` int NOT NULL, PRIMARY KEY (`steamid`) ) ")

    function dq:onError(err)
        ServerLog("[mInventory] Error with creating table: " .. err)
    end

    dq:start()

	local function getplayer(ply,fun)
		local q = db:query("SELECT * FROM moat_namerewards WHERE steamid = '" .. ply:SteamID64() .. "';")
		function q:onSuccess(dat)
			if #dat < 1 then
				fun(false)
			else
				fun(dat[1])
			end
		end
		q:start()
	end

	local function nametag(ply)
		return ply:Nick():lower():match("moat%.gg")
	end

	local reward_ic = 500
	local reward_sc = 20

	hook.Add("TTTNameChangeKick","NameBullshit",function(ply)
		ply.spawn_nick = ply:Nick()
		ply:Kill()
		return true
	end)

	gameevent.Listen("player_changename")
	hook.Add("player_changename","NameRewards",function(a)
		local userid = a.userid
		local oldname = a.oldname
		local newname = a.newname
		local ply = Player(userid)
		if (not ply.HasMoatNameTag) and nametag(ply) then
			ply.HasMoatNameTag = true
			--print("New name tag, setting name")
			local time = os.time()
			local q = db:query("UPDATE moat_namerewards SET last_name = '" .. time .. "' WHERE steamid = '" .. ply:SteamID64() .. "';")
			q:start()
			net.Start("NameRewards.Time")
			net.WriteInt(time,32)
			net.Send(ply)
		end -- removing of name tag is checked when they join, before the reward
	end)

	hook.Add("PlayerInitialSpawn","NameRewards",function(ply)
		ply.HasMoatNameTag = nametag(ply) -- used for checking in name hook
		getplayer(ply,function(d)
			if not d then
				--print("Making new")
				local name = 0
				local time = os.time()
				if nametag(ply) then
					name = time
				end
				local q = db:query("INSERT INTO moat_namerewards (steamid, last_name, last_reward, pending_ic, pending_sc) VALUES ('" .. ply:SteamID64() .. "','" .. name .. "','" .. time .. "',0,0);")
				q:start()
				if name > 0 then
					net.Start("NameRewards.Time")
					net.WriteInt(name,32)
					net.Send(ply)
				end
			else
				local diff = 86400 -- 24 hours in seconds (os.time)
				local time = os.time()
				if d.last_name < 1 and nametag(ply) then
					d.last_name = time
					local q = db:query("UPDATE moat_namerewards SET last_name = '" .. time .. "' WHERE steamid = '" .. ply:SteamID64() .. "';")
					q:start()
					--print("Set name time since added")
				elseif not nametag(ply) and d.last_name > 1 then
					local q = db:query("UPDATE moat_namerewards SET last_name = '0' WHERE steamid = '" .. ply:SteamID64() .. "';")
					q:start()
					d.last_name = 0
					--print("Reset name time since removed")
				elseif ((time - d.last_name) > diff ) and ((time - d.last_reward) > diff ) and nametag(ply) then
					local q = db:query("UPDATE moat_namerewards SET pending_ic = '" .. d.pending_ic + reward_ic .. "',pending_sc = '" .. d.pending_sc + reward_sc .. "',last_reward = '" .. time .. "' WHERE steamid = '" .. ply:SteamID64() .. "';")
					q:start()
					ply.pendingname = {
						d.pending_ic + reward_ic,
						d.pending_sc + reward_sc
					}
					d.last_reward = time
					net.Start("NameRewards.Amount")
					net.WriteInt(d.pending_ic + reward_ic,32)
					net.WriteInt(d.pending_sc + reward_sc,32)
					net.Send(ply)
					--print("Rewarded ",ply," name rewards")
				elseif (d.pending_ic > 0) or d.pending_sc > 0 then
					ply.pendingname = {
						d.pending_ic,
						d.pending_sc
					}
					net.Start("NameRewards.Amount")
					net.WriteInt(d.pending_ic,32)
					net.WriteInt(d.pending_sc,32)
					net.Send(ply)
					--print("Player has pending rewards")
				elseif nametag(ply) then
					--print("Player has no rewards and is waiting for reward")
				else
					--print("Player can't receive rewards since no nametag")
				end
				if d.last_name > 0 then
					net.Start("NameRewards.Time")
					local t = d.last_name
					if d.last_reward > t then
						t = d.last_reward
					end
					net.WriteInt(t,32)
					net.Send(ply)
				end
			end
		end)
	end)

	net.Receive("NameRewards.Collect",function(l,ply)
		if (ply.namecooldownr) then return end
		ply.namecooldownr = true -- should only be rewarded once per session when they first join anyways
		if not ply.pendingname then return end
		local q = db:query("UPDATE moat_namerewards SET pending_ic = '0',pending_sc = '0' WHERE steamid = '" .. ply:SteamID64() .. "';")
		q:start()
		ply:m_GiveIC(ply.pendingname[1])
		ply:TakeSC(ply.pendingname[2] * -1)
		ply.pendingname = nil
		q:start()
		ply:SendLua("chat.AddText('You have collected your points! Thanks for supporting Moat Gaming <3')")
	end)

end

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        namerewards()
    end
end

hook.Add("InitPostEntity","namerewards",function()
    if not c() then 
        timer.Create("Checknamerewards",1,0,function()
            if c() then
                namerewards()
                timer.Destroy("Checknamerewards")
            end
        end)
    else
        namerewards()
    end

end)