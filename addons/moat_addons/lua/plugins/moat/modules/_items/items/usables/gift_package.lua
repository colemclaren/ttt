ITEM.ID = 7821
ITEM.Name = "Gift Package"
ITEM.Description = "I wonder what's inside?"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.Collection = "Gift Collection"
ITEM.Image = "https://i.moat.gg/nzP37.png"
ITEM.Preview = false
ITEM.CrateShopOverride = "Gift"
ITEM.ItemUsed = function(pl, slot, item)
	local ply_inv = MOAT_INVS[pl]
	if (not ply_inv) then return end
	local i = ply_inv["slot" .. slot]
	if (not i) then return end
	if (not i.g) then return end

	pl:m_AddInventoryItem(i.g)
end