D3A.Ranks 		 = D3A.Ranks or {}
D3A.Ranks.Stored = D3A.Ranks.Stored or {}
D3A.Ranks.Prefix = D3A.Ranks.Prefix or nil

function D3A.Ranks.Register(name, weight, flags, global, color)
	color = color or Color(255, 255, 255)
	global = global or false
	flags = flags or ""
	weight = weight or 0
	-- It should have a name, of all things
	
	local flagstab = {}
	for i=1, #flags do
		flagstab[flags[i]:lower()] = true
	end
	
	local basename = string.Replace(name:lower(), " ", "")
	D3A.Ranks.Stored[basename] = {Name = name, Weight = weight, FlagsString = flags, Flags = flagstab, Global = global}
	
	for k, v in ipairs(player.GetAll()) do
		local r = v:GetDataVar("rank")
		if (r and r[1] == basename) then
			D3A.Ranks.Parse(v)
		end
	end
end

function D3A.Ranks.CheckWeight(tm1, tm2)
	if (type(tm1) == "Player") then tm1 = tm1.Rank end
	if (type(tm1) == "Entity" and not tm1:IsPlayer()) then return true end
	if (type(tm2) == "Player") then tm2 = tm2.Rank end
	if (istable(tm1) and tm1.rcon) then tm1 = tm1:GetUserGroup() end
	if (istable(tm2) and tm2.rcon) then tm2 = tm2:GetUserGroup() end
	
	if (!D3A.Ranks.Stored[tm1] or !D3A.Ranks.Stored[tm2]) then return true end
	
	return D3A.Ranks.Stored[tm1].Flags["*"] or (D3A.Ranks.Stored[tm1].Weight >= D3A.Ranks.Stored[tm2].Weight)
end

function D3A.Ranks.Parse(pl)
	local tm = D3A.Ranks.Stored[pl.Rank]
	if (not tm) then return end

	pl:SetDataVar("rank", {Name = tm.Name, Weight = tm.Weight, Flags = tm.Flags, FlagsString = tm.FlagsString}, false, true)
	pl.IsStaff = (tm.Weight and tm.Weight >= 15)
	pl.IsVIP = (tm.Weight and tm.Weight >= 5)
end

function D3A.Ranks.ChangeRank(id, rank, expire, expire_to)
	if (not id) then return end
	rank = rank or "user"
	expire = expire or "NULL"
	expire_to = expire_to or "NULL"

	if (rank == "trialstaff") then
		expire = os.time() + (43200 * 60)
		expire_to = "moderator"
	end

	D3A.MySQL.FormatQuery("UPDATE player SET rank = #, rank_changed = UNIX_TIMESTAMP(), rank_expire = #, rank_expire_to = # WHERE steam_id = #;", rank, expire, expire_to, id)
	D3A.Ranks.IPBGroup(id, rank)

	local pl = player.GetBySteamID64(id)
	if (pl) then
		pl.Rank = rank
		D3A.Ranks.Parse(pl)
	end
end

util.AddNetworkString "D3A.Rank.Expired"
function D3A.Ranks.LoadRank(pl, rank, expire, expire_to)
	if (expire and expire <= os.time()) then
		expire_to = expire_to or "user"
		rank = expire_to
		
		local id = pl:SteamID64()
		timer.Simple(0, function()
			D3A.Ranks.ChangeRank(id, expire_to)
			
			if (not IsValid(pl)) then return end

			net.Start("D3A.Rank.Expired")
			net.WriteString(expire_to)
			net.Send(pl)
		end)
	end

	pl.Rank = rank
	D3A.Ranks.Parse(pl)
end

local ipb_id_to_group = {
	[12] = "senioradmin",
	[11] = "admin",
	[10] = "moderator",
	[9] = "trialstaff",
	[8] = "credibleclub",
	[23] = "vip",
	[3] = "user"
}

function D3A.Ranks.IPBSync(pl)
	if (pl:GetUserGroup() ~= "vip") then return end
	local sid = pl:SteamID64()

	D3A.MySQL.Query("UPDATE core_members SET member_group_id=23, mgroup_others=3 WHERE steamid='" .. sid .. "'")
end

function D3A.Ranks.IPBGroup(sid, rank)
	local gid = 0
	for k, v in pairs(ipb_id_to_group) do
		if (v == rank) then
			gid = k
			break 
		end
	end
	if (gid == 0) then return end

	if (gid == 3) then
		D3A.MySQL.Query("UPDATE core_members SET member_group_id=3 WHERE steamid='" .. sid .. "'")
		return
	end

	if (gid == 23) then
		D3A.MySQL.Query("UPDATE core_members SET member_group_id=23, mgroup_others=3 WHERE steamid='" .. sid .. "'")
		return
	end

	D3A.MySQL.Query("UPDATE core_members SET member_group_id=" .. gid .. ", mgroup_others=21 WHERE steamid='" .. sid .. "'")
end

function moat_makevip(id)
	D3A.Ranks.ChangeRank(id, "vip")
end


function removeUnauthorizedUser(id64, id32)
	game.KickID(id32, "oopsie woopsie!! wooks wike u did a vewwy bad thingy wingy!! uwu")

	D3A.MySQL.FormatQuery("insert into forum.player_bans (time, steam_id, staff_steam_id, name, staff_name, length, reason) values (UNIX_TIMESTAMP(), #, 0, 'Unauthorized User', 'Console', 0, '[Automated] Unauthorized Rank');", id64)
	D3A.MySQL.FormatQuery("update forum.player set forum.player.rank = null where forum.player.steam_id = #;", id64)
end

local function checkuser(pl)
	if (not IsValid(pl)) then return end
	local r, id, id32 = pl:GetUserGroup(), pl:SteamID64(), pl:SteamID()
	if (not id or (not pl:IsSuperAdmin() and not MOAT_RANKS[r].check)) then return end

	if (((r == "communitylead" or pl:IsSuperAdmin()) and not COMMUNITY_LEADS[id]) or
		((r == "techlead") and (not COMMUNITY_LEADS[id] or not TECH_LEADS[id])) or
		((r == "operationslead") and (not OPERATION_LEADS[id] or not HEAD_ADMINS[id])) or
		((r == "headadmin") and (not HEAD_ADMINS[id]))) then

		removeUnauthorizedUser(id, id32)
		return
	end
end

local function checkusers()
	if (not MOAT_RANKS) then return end
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		checkuser(v)
	end
end
timer.Create("prevent.unauthorized.superadmins", 1, 0, checkusers)


D3A.IncludeSV(D3A.Config.Path .. "_configs/ranks.lua")