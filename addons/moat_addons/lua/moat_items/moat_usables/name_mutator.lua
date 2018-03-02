ITEM.Name = "Name Mutator"
ITEM.ID = 4001
ITEM.Description = "Using this item allows you to change the name of any equippable item in your inventory"
ITEM.Rarity = 8
ITEM.Collection = "Gamma Collection"
ITEM.Image = "moat_inv/name_mutator64.png"
ITEM.ItemCheck = 1
ITEM.ItemUsed = function(pl, slot, item, str)
	str = sql.SQLStr(str, true)
	MOAT_INVS[pl]["slot" .. slot].n = str
    m_SendInvItem(pl, slot)
end