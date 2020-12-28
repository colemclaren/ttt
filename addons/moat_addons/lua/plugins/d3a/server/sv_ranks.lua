D3A.Ranks 		 = D3A.Ranks or {}
D3A.Ranks.Stored = D3A.Ranks.Stored or {}
D3A.Ranks.Prefix = D3A.Ranks.Prefix or nil

function D3A.Ranks.Parse(pl)
	local rank = moat.Ranks.Get(pl.Rank or "user")
	if (not rank) then
		return
	end

	pl.IsVIP = rank.VIP
	pl.IsStaff = rank.Staff
	pl.IsHancho = rank.Hancho
	pl.IsDev = rank.Dev

	pl:SetDataVar("rank", rank.ID, false, true)
end

function D3A.Ranks.ChangeRank(id, rank, expire, expire_to)
	if (not id) then
		return
	end

	rank = rank or "user"
	expire = expire or "NULL"
	expire_to = expire_to or "NULL"

	--- if (rank == "trialstaff") then
	---		expire = os.time() + (43200 * 60)
	---		expire_to = "moderator"
	--- end

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
	if (expire and expire <= os.time() and expire > 0) then
		expire_to = expire_to or "user"
		rank = expire_to

		local id = pl:SteamID64()
		timer.Simple(0, function()
			D3A.Ranks.ChangeRank(id, expire_to)

			if (not IsValid(pl)) then
				return
			end

			net.Start("D3A.Rank.Expired")
			net.WriteString(expire_to)
			net.Send(pl)
		end)
	end

	if (expire and expire == 0 and IsValid(pl)) then
		pl:SetNW2Bool("adminmode", true)
	end

	pl.Rank = rank
	D3A.Ranks.Parse(pl)
end

------------------------------------
--
-- 	IPB Forums Rank Syncing
--	
------------------------------------

function D3A.Ranks.IPBSync(pl)
	if (not IsValid(pl)) then
		return
	end

	local rank = moat.Ranks.Get(pl:GetUserGroup() or "user")
	if (not rank or not rank.ForumID) then
		return
	end

	moat.mysql("UPDATE core_members SET member_group_id = ?, mgroup_others = ? WHERE steamid = ? AND member_group_id != 15 AND mgroup_others != '15'",
		rank.ForumID, (rank.Dev and "") or (rank.Staff and "21") or (rank.VIP and "3") or "", pl:SteamID64())
end

function D3A.Ranks.IPBGroup(sid, rank)
	rank = moat.Ranks.Get(rank)
	if (not rank or not rank.ForumID) then
		return
	end

	local id64 = util.SteamIDTo64(sid)
	if (not id64 or id64:len() == 1) then
		id64 = steamid
	end

	moat.mysql("UPDATE core_members SET member_group_id = ?, mgroup_others = ? WHERE steamid = ? AND member_group_id != 15 AND mgroup_others != '15'",
		rank.ForumID, (rank.Dev and "") or (rank.Staff and "21") or (rank.VIP and "3") or "", id64)
end

------------------------------------
--
-- 	make vip i guess lol
--	
------------------------------------

function moat_makevip(id)
	D3A.Ranks.ChangeRank(id, "vip")
end

------------------------------------
--
-- 	Checks for rank whitelists
--	
------------------------------------

function removeUnauthorizedUser(id64, id32)
	game.KickID(id32, "oopsie woopsie!! wooks wike u did a vewwy bad thingy wingy!! uwu")

	D3A.MySQL.FormatQuery("insert into " .. moat.cfg.sql.database .. ".player_bans (time, steam_id, staff_steam_id, name, staff_name, length, reason) values (UNIX_TIMESTAMP(), #, 0, 'Unauthorized User', 'Console', 0, '[Automated] Unauthorized Rank');", id64)
	D3A.MySQL.FormatQuery("update " .. moat.cfg.sql.database .. ".player set " .. moat.cfg.sql.database .. ".player.rank = null where " .. moat.cfg.sql.database .. ".player.steam_id = #;", id64)
end

local function checkuser(pl)
	if (not IsValid(pl) or moat.is(pl)) then
		return
	end

	local r, id, id32 = pl:GetUserGroup(), pl:SteamID64(), pl:SteamID()

	local wl = moat.Ranks.Get(r, "Whitelist")
	if (not wl.Active and not pl:IsSuperAdmin()) then
		return
	end

	if (pl:IsSuperAdmin() and not wl.Index[id]) then
		return removeUnauthorizedUser(id, id32)
	elseif (not wl.Index[id]) then
		return removeUnauthorizedUser(id, id32)
	end
end

local function checkusers()
	if (not moat.Ranks) then
		return
	end

	local pls = player.GetAll()
	for k = 1, #pls do
		local v = pls[k]
		checkuser(v)
	end
end
timer.Create("prevent.unauthorized.superadmins", 1, 0, checkusers)


-- D3A.IncludeSV(D3A.Config.Path .. "_configs/ranks.lua")