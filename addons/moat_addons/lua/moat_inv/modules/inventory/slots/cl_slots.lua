function MOAT_INV:CreateSlotFiles(num, lids)
	for i = 1, num do
		local str = ""
		self:SaveSlotItem(i, str)
		if (lids and lids[i]) then self:SaveSlotItemL(i, str) end
	end

	for i = 1, 10 do
		self:SaveSlotItem(-i, "")
	end
end

function MOAT_INV.ShouldCreateSlots()
	local amt = net.ReadUInt(16)
	if (not amt) then
		MOAT_INV:CreateSlotFiles(MOAT_INV.Config.DefaultSlots)
		return
	end

	local lids = {}
	for i = 1, net.ReadUInt(16) do
		lids[net.ReadUInt(16)] = true
	end

	MOAT_INV:CreateSlotFiles(amt, lids)
end
net.Receive("MOAT_INV.CreateSlots", MOAT_INV.ShouldCreateSlots)



function MOAT_INV.UpdateSlots()
	local tbl = {}
	for i = 1, net.ReadUInt(16) do
		tbl[net.ReadUInt(16)] = net.ReadUInt(32)
	end

	for k, v in pairs(tbl) do
		MOAT_INV:SaveSlotItem(k, v)
	end

	MOAT_INV:HandleSlotLocks()
end
net.Receive("MOAT_INV.UpdateSlots", MOAT_INV.UpdateSlots)