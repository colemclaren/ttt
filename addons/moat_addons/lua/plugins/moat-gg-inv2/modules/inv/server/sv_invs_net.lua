util.AddNetworkString "Moat.SendSlots"
util.AddNetworkString "Moat.SendInvItem"
util.AddNetworkString "Moat.Swap"
util.AddNetworkString "Moat.DataInfo"
util.AddNetworkString "Moat.ItemInfo"
util.AddNetworkString "Moat.Purge"
util.AddNetworkString "Moat.AddInvItem"
util.AddNetworkString "Moat.NewItem"
util.AddNetworkString "Moat.SendCredits"
util.AddNetworkString "Moat.RemInvItem"
util.AddNetworkString "Moat.InvCat"
util.AddNetworkString "Moat.UpdateEXP"
util.AddNetworkString "Moat.LoadData"

local interval = engine.TickInterval() * 10
local max_per_interval = 30000 * interval * 0.8

function mi.WriteWeaponForPlayer(wep, ply)
	local written = net.BytesWritten()
	wep:WriteToNet()

	return net.BytesWritten() - written
end

function mi.SendExtraInfo(ply, sending, cb)
	if (not IsValid(ply)) then
		cb(false)

		return
	end

	local overflow = false

	net.Start "Moat.DataInfo"

		for j = #sending.t, 1, -1 do
			net.WriteBool(true)
			net.WriteBool(false) -- talent

			local send = sending.t[j]
			net.WriteLong(send[1])
			net.WriteTable(send[2])

			table.remove(sending.t, j)

			if (net.BytesWritten() >= max_per_interval) then
				overflow = true

				break
			end
		end

		if (not overflow) then
			for j = #sending.i, 1, -1 do
				net.WriteBool(true)
				net.WriteBool(true) -- item
				
				local send = sending.i[j]
				net.WriteLong(send[1])
				net.WriteTable(send[2])

				table.remove(sending.i, j)

				if (net.BytesWritten() >= max_per_interval) then
					overflow = true

					break
				end
			end
		end
		net.WriteBool(false)

	net.Send(ply)

	if (overflow) then
		timer.Simple(interval, function()
			mi.SendExtraInfo(ply, sending, cb)
		end)
	else
		return cb()
	end
end

function mi.SendWeapons(ply, weps, cb, i)
	if (not weps[i]) then
		return cb()
	end

	if (not weps[i].c) then
		i = i + 1

		return mi.SendWeapons(ply, weps, cb, i)
	end

	ply.ItemCache = ply.ItemCache or {}

	net.Start "Moat.ItemInfo"

		while (true) do
			if (net.BytesWritten() >= max_per_interval or not weps[i]) then
				break
			end
	
			local wep = weps[i]
			if (wep.c and not ply.ItemCache[wep.c]) then
				net.WriteBool(true)
				wep:WriteToNet()

				ply.ItemCache[wep.c] = true
			end

			i = i + 1
		end
		net.WriteBool(false)

	net.Send(ply)


	if (weps[i]) then
		timer.Tick(function()
			mi.SendWeapons(ply, weps, cb, i)
		end)
	else
		return cb()
	end
end

function mi.WriteWeaponsToPlayer(plys, weps, rcb)
	if (type(plys) ~= "table") then
		plys = {plys}
	end
	
	for i = 1, #plys do
		local ply = plys[i]
		local cb = function()
			return rcb(ply)
		end

		local needed, sending = ply.MG_InfoSent or {
			t = {},
			i = {}
		}, {
			t = {},
			i = {}
		}

		ply.MG_InfoSent = needed

		for _, wep in ipairs(weps) do
			if (wep.u and not needed.i[wep.u]) then
				needed.i[wep.u] = m_GetItemFromEnum(wep.u)

				table.insert(sending.i, {wep.u, needed.i[wep.u]})
			end

			if (wep.t) then
				for _, talent in pairs(wep.t.real_data or wep.t) do
					if (not needed.t[talent.e]) then
						needed.t[talent.e] = m_GetTalentFromEnum(talent.e)

						table.insert(sending.t, {talent.e, needed.t[talent.e]})
					end
				end
			end
		end
		
		mi.SendExtraInfo(ply, sending, function()
			mi.SendWeapons(ply, weps, cb, 1)
		end)
	end
end

function mi.SendWeaponInvItems(ply, datas, is_loadout, cb)
	return BreakableMessage {
		datas = datas,
		startfn = function(i)
			net.Start "Moat.SendInvItem"
			net.WriteBool(is_loadout)
			net.WriteLong(i)
		end,
		writefn = function(i, wep)
			net.WriteUInt(wep.c, 32)
		end,
		endfn = function()
			net.Send(ply)
		end,
		checkfn = function(d)
			return d.c
		end,
		callback = cb
	}
end

function mi.LoadInventoryForPlayer(ply, cb)
	local queue = ply.m_SentInventoryQueue
	if (queue == true) then
		if (cb) then
			return cb()
		end

		return
	elseif (queue) then
		table.insert(queue, cb)
	end
	ply.m_SentInventoryQueue = {cb}

	ply:LoadInventory(function(_, inv)
		local inv_tbl = {
			ply = ply,
			ply_steamid = ply:SteamID64(),
			credits = {
				c = 0
			} -- TODO: readd
		}

		for i = 1, 10 do
			inv_tbl["l_slot" .. i] = mi:Blank()
		end

		local n = 0
		for uid, wep in pairs(inv) do
			if (wep.slotid and wep.slotid < 0) then
				inv_tbl["l_slot" .. math.abs(wep.slotid)] = wep

				continue
			end

			n = n + 1
			inv_tbl["slot" .. n] = wep
		end

		setmetatable(inv_tbl, {
			__newindex = function(self, k, v)
				rawset(self, k, v)
			end
		})

		ply.InventorySlots = n
		ply.Inventory = inv_tbl
		MOAT_INVS[ply] = inv_tbl

		local callbacks = ply.m_SentInventoryQueue
		ply.m_SentInventoryQueue = true

		for _, fn in pairs(callbacks) do
			fn()
		end
	end)

	-- SQL:Query("UPDATE core_members SET last_activity = UNIX_TIMESTAMP() WHERE steamid = ?;", ply:SteamID64())
end

function mi.SendInventoryToPlayer(ply)
	if (ply.Sending) then
		return
	end

	ply.Sending = true

	return mi.LoadInventoryForPlayer(ply, function()
		local ply_inv = MOAT_INVS[ply]

		local loadout = {}
		for i = 1, 10 do
			loadout[i] = ply_inv["l_slot" .. i]
		end

		PrintTable(loadout)

		return mi.WriteWeaponsToPlayer(ply, loadout, function()
			return mi.SendWeaponInvItems(ply, loadout, true, function()
				local inv = {}

				for i = 1, ply.InventorySlots do
					inv[i] = ply_inv["slot" .. i]
				end

				return mi.WriteWeaponsToPlayer(ply, inv, function()
					return mi.SendWeaponInvItems(ply, inv, false, function()
						net.Start "Moat.Purge"
						net.Send(ply)

						MsgC(Color(0, 255, 0), "Inventory sent to " .. ply:Nick() .. "\n")
						ply.Sending = false
					end)
				end)
			end)
		end)
	end)
end

util.AddNetworkString "mi.CreateSlots"
util.AddNetworkString "mi.UpdateSlots"

function mi:PlayerCreateSlots(pl, tbl)
	net.Start "mi.CreateSlots"
	if (not tbl) then net.Send(pl) return end

	net.WriteUInt(tbl.n, 16)
	net.WriteUInt(tbl.ln, 16)

	for i = 1, tbl.ln do
		net.WriteUInt(tbl.l[i], 16)
	end

	net.Send(pl)
end

function mi:SendUpdatedSlots(pl, cb)
	return self:SQLQuery("SELECT id, slotid, locked FROM moat_inv.items WHERE ownerid = ?;", pl, function(d)
		if (not IsValid(pl)) then
			return
		end

		if (not d or not d[1]) then
			return cb()
		end

		local slots, exist, n = {}, {}, 0
		for k, v in ipairs(d) do
			if (not v.slotid) then
				continue
			end

			n = n + 1
			slots[n] = {
				slot = v.slotid,
				item = v.id,
				lock = (not not v.locked)
			}

			exist[tostring(v.slotid)] = true
		end

		for i = 1, pl:GetSlots() do
			if (not exist[tostring(i)]) then
				n = n + 1
				slots[n] = {
					slot = i,
					item = 0,
					lock = false
				}

				exist[tostring(i)] = true
			end
		end

		for i = 1, 10 do
			if (not exist[tostring(-i)]) then
				n = n + 1
				slots[n] = {
					slot = -i,
					item = 0,
					lock = false
				}

				exist[tostring(-i)] = true
			end
		end

		if (n == 0) then
			return cb()
		end

		MsgC(Color(0, 255, 0), "Updating slots for " .. pl:Nick() .. "\n")
		return net.WriteArray(slots, 
			function(i)
				net.Start "mi.UpdateSlots"
				net.WriteShort(i)
			end,
			function(i)
				net.WriteInt(i.slot, 16)
				net.WriteLong(i.item)
				net.WriteBool(i.lock)
			end,
			function()
				net.Send(pl)
			end,
			function()
				return cb()
			end)
	end)
end

function mi.LoadData(pl)
	pl:LoadData(function()
		mi.SendInventoryToPlayer(pl)
	end)
end

hook.Add("PlayerInitialSpawn", "mi.LoadData", mi.LoadData)
net.Receive("Moat.LoadData", function(_, pl)
	mi.LoadData(pl)
end)