AddCSLuaFile()

------------------------------------
--
-- Run sum shit b4 main startup
--	
------------------------------------

function moat.print(...)
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end
	local msgt, msgc = {}, 3
	msgt[1] = Color(103, 152, 235)
	msgt[2] = "[MOAT.GG] "
	msgt[3] = Color(255, 105, 180)

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = args[i]
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end

function moat.error(...)
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end
	local msgt, msgc = {}, 3
	msgt[1] = Color(245, 54, 92)
	msgt[2] = "[ERRORS] Need to report a bug? We'd love to talk with you! <3<3<3"
	msgt[3] = [[[ERRORS] The best way to contact us is on our partnered Discord server. \ (•◡•) /]]
	msgt[4] = "[ERRORS] > https://moat.chat"
	msgt[5] = Color(249, 134, 157)
	msgt[6] = table.ToString(debug.getinfo(-1, "flLnSu"), "[WARNINGS]", true)

	MsgC(unpack(msgt))
	MsgC "\n"
end

function moat.spacer(n)
	for i = 1, n or 2 do
		moat.print "---------------------------------------------------------------------------------------"
	end
end

function moat.debug(...)
	if (not DEBUG) then return end
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end

	local fn = debug.getinfo(2)
	local msgt, msgc = {}, 8
	msgt[1] = Color(0, 255, 255)
	msgt[2] = "debug | "
	msgt[3] = Color(255, 0, 0)
	msgt[4] = SERVER and "SV" or "CL"
	msgt[5] = Color(0, 255, 255)
	msgt[6] = " | "
	msgt[7] = Color(255, 255, 0)
	msgt[8] = fn and fn.name or "unknown"

	if (not DEBUG_LOAD and (msgt[8] == "includesv" or msgt[8] == "includecl" or msgt[8] == "includepath")) then
		return
	end

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = Color(0, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = " | "
		msgc = msgc + 1
		msgt[msgc] = Color(255, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = args[i] or "nil"
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end

-- all cole accounts
local ismoat = {["STEAM_0:0:46558052"] = true, ["76561198053381832"] = true, ["STEAM_0:1:122211923"] = true, ["76561198204689575"] = true}
function moat.is(moat_check)
	if (type(moat_check) == "string") then
		return ismoat[moat_check]
	elseif (type(moat_check) == "Player") then
		return ismoat[moat_check:SteamID()]
	end
end

------------------------------------
--
-- Here is surface.CreateFont detoured super early
-- Fonts should go in system/constants/fonts
-- (u shouldnt use surface.createfont anywhere)
--	
------------------------------------

if (CLIENT) then
	if (not _SCF) then _SCF = surface.CreateFont end
	THE_FONTS = {}
	function surface.CreateFont(name, tbl)
		/*
		table.insert(THE_FONTS, {Name = name, Tbl = tbl})
		_SCF(name, tbl)
		*/
	end

	concommand.Add("dump_fonts", function()
		local fs = ""
		for i = 1, #THE_FONTS do
			local f = THE_FONTS[i]
			if (not f.Name or not f.Tbl) then continue end
			local s = "surface.CreateFont('" .. f.Name .. "', {"
			if (f.Tbl.font) then s = s .. "font = '" .. f.Tbl.font .. "'," end
			if (f.Tbl.extended) then s = s .. "extended = true," end
			if (f.Tbl.size) then s = s .. "size = " .. f.Tbl.size .. "," end
			if (f.Tbl.weight) then s = s .. "weight = " .. f.Tbl.weight .. "," end
			if (f.Tbl.blursize) then s = s .. "blursize = " .. f.Tbl.blursize .. "," end
			if (f.Tbl.scanlines) then s = s .. "scanlines = " .. f.Tbl.scanlines .. "," end
			if (f.Tbl.antialias != nil and f.Tbl.antialias == false) then s = s .. "antialias = false," end
			if (f.Tbl.underline) then s = s .. "underline = true," end
			if (f.Tbl.italic) then s = s .. "italic = true," end
			if (f.Tbl.strikeout) then s = s .. "strikeout = true," end
			if (f.Tbl.symbol) then s = s .. "symbol = true," end
			if (f.Tbl.rotary) then s = s .. "rotary = true," end
			if (f.Tbl.shadow) then s = s .. "shadow = true," end
			if (f.Tbl.additive) then s = s .. "additive = true," end
			if (f.Tbl.outline) then s = s .. "outline = true," end
			fs = fs .. string.TrimRight(s, ',') .. "})\n"
		end

		file.Write("fonts.txt", fs)
	end)
end



------------------------------------
--
-- Build the moat.Ranks metatable
--	
------------------------------------

local ranks, mt = setmetatable({
	UserInfo = {Count = 0, Cache = {}},
	BackwardsCompatibile = {},
	LocalPlayer = "user",
	Roster = setmetatable({}, {
		__call = function(s) return s end
	}), Count = 0
}, {
	__call = function(s, ...) return s.Get(...) end
}), {}
mt.__index = mt
mt.__newindex = mt

ranks.GetCache = {}
function ranks.Get(data, key)
	if (ranks.GetCache[data] != nil) then
		if (key and ranks.GetCache[data][key] != nil) then
			return ranks.GetCache[data][key]
		elseif (not key) then
			return ranks.GetCache[data]
		end
	end

	local ret = ranks.Roster[data] or (ranks.BackwardsCompatibile[data] and ranks.Roster[ranks.BackwardsCompatibile[data]])
	if (key and ret[key] != nil) then
		ret = ret[key]

		ranks.GetCache[data] = ranks.GetCache[data] or {}
		ranks.GetCache[data][key] = ret
		return ret
	end

	ranks.GetCache[data] = ret
	return ret
end

ranks.TableCache = {}
function ranks.Table(key)
	key = key or "String"

	if (ranks.TableCache[key] != nil) then
		return ranks.TableCache[key]
	end

	local ret, c = {}, 0
	for k, v in ipairs(ranks.Roster) do
		if (v[key]) then
			c = c + 1
			ret[c] = v[key]
		end
	end

	ranks.TableCache[key] = ret
	return ret
end

function ranks.Register(id, short, name)
	local str = name and short or short:Replace(" ", ""):lower()
	assert(id and str and ranks.Roster[id] == nil and ranks.BackwardsCompatibile[str] == nil,
		"Failed on ranks.Register call attempt!\n	id: " .. tostring(id)
			.. "\n	str: " .. tostring(short)
			.. "\n	name: " .. tostring(name)
		)

	ranks.BackwardsCompatibile[str] = id
	ranks.Count = ranks.Count + 1

	return setmetatable({
		ID = id,
		Name = name or short,
		String = str,
		Color = Color(255, 255, 255),
		FlagsString = "",
		Flags = {},
		Weight = 0,
		VIP = false,
		Staff = false,
		Hancho = false,
		Dev = false,
		ForumID = 0,
		Icon = false,
		Whitelist = {Active = false, Index = {}, UserInfo = {}}
	}, mt):Rank()
end

function ranks.AddUser(rankid, name, steamid64, steamid, discord, discordid, forumid, alts)
	assert(rankid and name and steamid64 and steamid and discord and discordid and forumid,
		"Missing some user info on ranks AddWhitelist call attempt!\n	rankid: " .. tostring(rankid)
			.. "\n	name: " .. tostring(name)
			.. "\n	steamid64: " .. tostring(steamid64)
			.. "\n	steamid: " .. tostring(steamid)
			.. "\n	discord: " .. tostring(discord)
			.. "\n	discordid: " .. tostring(discordid)
			.. "\n	forumid: " .. tostring(forumid)
		)

	local rank = ranks.Get(rankid)
	if (not rank) then
		return
	end

	ranks.Roster[rank.ID]:AddWhitelist(name, steamid64, steamid, discord, discordid, forumid, alts)
end

function ranks.CheckWhitelist(rankid, steamid64)
	local rank = ranks.Get(rankid)
	if (not rank) then
		return false
	end

	if (not rank.Whitelist.Active) then
		return true
	end

	return rank.Whitelist.Index[steamid64]
end

function ranks.CheckWeight(pl, targ)
	if (type(pl) == "Player" or (istable(pl) and pl.rcon)) then
		pl = pl:GetUserGroup()
	elseif (type(pl) == "Entity") then
		return true
	end

	targ = (type(targ) == "Player" or (istable(targ) and targ.rcon)) and targ:GetUserGroup() or targ
	return (not ranks.Get(pl) or not ranks.Get(targ)) or ranks.Get(pl, "Flags")["*"] or (ranks.Get(pl, "Weight") >= ranks.Get(targ, "Weight"))
end

function mt:Rank()
	ranks.BackwardsCompatibile[self.String] = self.ID
	ranks.Roster[self.ID] = self

	return self
end

function mt:SetName(name)
	self.Name = name

	return self:Rank()
end

function mt:ForumSync(gid)
	self.ForumID = gid

	return self:Rank()
end

function mt:SetIcon(img)
	self.Icon = img

	return self:Rank()
end

function mt:SetColor(r, g, b, a)
	if (istable(r)) then
		self.Color = Color(r[1] or r.r or 0, r[2] or r.g or 0, r[3] or r.b or 0, r[4] or r.a or 255)
	elseif (isnumber(r)) then
		self.Color = Color(r or 0, g or 0, b or 0, a or 255)
	else
		self.Color = r
	end

	return self:Rank()
end

function mt:SetWeight(num)
	self.Weight = num

	self.VIP = num > 1
	self.Staff = num > 30
	self.Hancho = num > 70
	self.Dev = num == 100

	return self:Rank()
end

function mt:SetFlags(flags)
	local t = {}
	for i = 1, #flags do
		t[flags[i]:lower()] = true
	end

	self.FlagsString = flags
	self.Flags = t

	return self:Rank()
end

function mt:AddWhitelist(name, steamid64, steamid, discord, discordid, forumid, alts)
	self.Whitelist.Index[steamid64] = true
	self.Whitelist.Active = true

	local userinfo = {
		Name = name,
		SteamID = steamid,
		SteamID64 = steamid64,
		DiscordTag = discord,
		DiscordID = discordid,
		ForumID = forumid,
		Alts = alts,
		Rank = self
	}

	if (self.Weight >= 100) then
		table.insert(Devs, userinfo)
	end

	ranks.UserInfo.Count = ranks.UserInfo.Count + 1
	ranks.UserInfo[ranks.UserInfo.Count] = userinfo

	if (not alts) then
		return self:Rank()
	end

	for k, v in pairs(alts) do
		self.Whitelist.Index[v] = true
	end

	return self:Rank()
end

moat.Ranks, Devs = ranks, {}



------------------------------------
--
-- Developer tools for whitelisted devs
--	
------------------------------------

moat.isdev, moat.isdev_cache = function(lookup, can_null)
	if (moat.isdev_cache[lookup] != nil) then
		return moat.isdev_cache[lookup]
	end

	if (lookup == nil) then
		error("moat.isdev called with nil lookup")
		return false
	end

	if (lookup == NULL and not can_null) then
		return true
	end

	if (IsValid(lookup) and not lookup:IsPlayer() and IsValid(lookup:GetOwner()) and lookup:GetOwner():IsPlayer()) then
		lookup = lookup:GetOwner()
	end

	lookup = (IsValid(lookup) and lookup:IsPlayer()) and lookup:SteamID64() or lookup
	for k, v in ipairs(Devs) do
		if (v.SteamID == lookup or v.SteamID64 == lookup) then
			moat.isdev_cache[lookup] = true
			return true
		end
	end

	moat.isdev_cache[lookup] = false
	return false
end, {}

if (SERVER) then
	concommand.Add("bots", function(pl, cmd, args)
		if (IsValid(pl) and not moat.isdev(pl)) then
			return
		end

		for i = 1, args[1] or 8 do
			game.ConsoleCommand("bot\n")
		end
	end)
end