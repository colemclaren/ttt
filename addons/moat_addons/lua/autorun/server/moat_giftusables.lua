MOAT_GIFTS = MOAT_GIFTS or {}

function MOAT_GIFTS.UseEmptyGift(pl, slot, item, cslot, citem)
	local ply_inv = MOAT_INVS[pl]
	if (not ply_inv) then return end
	
	local i = ply_inv["slot" .. slot]
	local d = ply_inv["slot" .. cslot]

	if (not i or not d) then return end
	if (not d.c) then return end
	
	i.g = table.Copy(d)
	i.u = 7821

	m_RemoveInventoryItem(pl, cslot, d.c, 1)
    m_SendInvItem(pl, slot)

    return true
end

function MOAT_GIFTS.SendGift(item)


end


util.AddNetworkString "MOAT_GET_PLAYER_INFO"
util.AddNetworkString "MOAT_GET_PLAYER_INFO_FAILED"

net.Receive("MOAT_GET_PLAYER_INFO", function(_, pl)
	if (pl.LastPlayerInfo and pl.LastPlayerInfo > CurTime()) then return end
	local id = net.ReadString()
	local q = MOATSQL:query("SELECT name, rank, last_join, playtime FROM player WHERE steam_id = '" .. MOATSQL:escape(id) .. "';")
	function q:onSuccess(d)
		if (not d or #d <= 0) then
			if (not IsValid(pl)) then return end
			net.Start "MOAT_GET_PLAYER_INFO_FAILED"
			net.Send(pl)
			return
		end
		
		local q2 = MOATSQL:query("SELECT stats_tbl FROM moat_stats WHERE steamid = '" .. MOATSQL:escape(util.SteamIDFrom64(id)) .. "';")
		function q2:onSuccess(data)
			if (data and #data > 0) then
				if (not IsValid(pl)) then return end

				local tbl = {
					name = d[1].name,
					sid = id,
					lvl = tostring(util.JSONToTable(data[1].stats_tbl).l or "???"),
					rank = tostring(d[1].rank or "User"),
					playtime = tonumber(d[1].playtime),
					last_online = tonumber(os.time() - d[1].last_join)
				}

				net.Start "MOAT_GET_PLAYER_INFO"
				net.WriteTable(tbl)
				net.Send(pl)

			else
				if (not IsValid(pl)) then return end
				net.Start "MOAT_GET_PLAYER_INFO_FAILED"
				net.Send(pl)
			end
		end

		function q2:onError()
			if (not IsValid(pl)) then return end
			net.Start "MOAT_GET_PLAYER_INFO_FAILED"
			net.Send(pl)
		end

		q2:start()
	end

	function q:onError()
		if (not IsValid(pl)) then return end
		net.Start "MOAT_GET_PLAYER_INFO_FAILED"
		net.Send(pl)
	end
	q:start()

	pl.LastPlayerInfo = CurTime() + 1
end)

util.AddNetworkString "MOAT_SEND_GIFT"

net.Receive("MOAT_SEND_GIFT", function(_, pl)
	local class = net.ReadString()
	local slot = net.ReadString()
	local sid = net.ReadString()
	local anon = net.ReadBool()

	local ply_inv = MOAT_INVS[pl]
	if (not ply_inv) then return end
	local i = ply_inv["slot" .. slot]
	if (not i) then return end
	if (i.u ~= 7821) then return end
	local j = util.TableToJSON(i)
	if (not j) then return end
	
	moat_add_saved_item(sid, j)
	pl:SendLua([[chat.AddText(Material("icon16/heart.png"), Color(255, 0, 255), "Successfully sent gift package! The player will receive the gift the next time they login! <3")]])
	m_RemoveInventoryItem(pl, slot, class, 1)
end)