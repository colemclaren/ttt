function mi:CreateSlotFiles(num, lids)
	for i = 1, num do
		local str = ""
		self:SaveSlotItem(i, str)
		if (lids and lids[i]) then self:SaveSlotItemL(i, str) end
	end

	for i = 1, 10 do
		self:SaveSlotItem(-i, "")
	end
end

function mi.ShouldCreateSlots()
	local amt = net.ReadUInt(16)
	if (not amt) then
		mi:CreateSlotFiles(mi.Config.DefaultSlots)
		return
	end

	local lids = {}
	for i = 1, net.ReadUInt(16) do
		lids[net.ReadUInt(16)] = true
	end

	mi:CreateSlotFiles(amt, lids)
end
net.Receive("mi.CreateSlots", mi.ShouldCreateSlots)



function mi.UpdateSlots()
	local tbl = {}
	for i = 1, net.ReadUInt(16) do
		tbl[net.ReadUInt(16)] = net.ReadUInt(32)
	end

	for k, v in pairs(tbl) do
		mi:SaveSlotItem(k, v)
	end

	mi:HandleSlotLocks()
end
net.Receive("mi.UpdateSlots", mi.UpdateSlots)