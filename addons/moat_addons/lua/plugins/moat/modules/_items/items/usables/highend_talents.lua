ITEM.Name = "High-End Talent Mutator"
ITEM.ID = 4004
ITEM.Description = "Using this item allows you to re-roll the talents of any High-End item. This will reset the item's LVL and XP"
ITEM.Rarity = 5
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/laq7NyppkCcWxYkzys56kFEpGaKh.png"
ITEM.ItemCheck = 4
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end