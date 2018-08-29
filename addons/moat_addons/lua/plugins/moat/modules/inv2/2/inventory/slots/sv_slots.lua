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
	self:SQLQuery("select id, slotid from mg_items where ownerid = ?", pl, function(d)
		if (not IsValid(pl)) then return end
		if (not d or not d[1]) then cb() return end

		local num, tbl = 0, {}
		for i = 1, #d do
			if (not d[i].slotid or d[i].slotid < 0) then continue end
			tbl[d[i].slotid] = d[i].id
			num = num + 1
		end

		if (num == 0) then cb() return end

		net.Start "mi.UpdateSlots"
			net.WriteUInt(num, 16)
			for k, v in pairs(tbl) do
				net.WriteUInt(k, 16)
				net.WriteUInt(v, 32)
			end
		net.Send(pl)

		cb()
	end)
end