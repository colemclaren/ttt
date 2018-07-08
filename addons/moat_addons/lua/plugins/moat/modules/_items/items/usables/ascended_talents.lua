ITEM.Name = "Ascended Talent Mutator"
ITEM.ID = 4003
ITEM.Description = "Using this item allows you to re-roll the talents of any Ascended item. This will reset the item's LVL and XP"
ITEM.Rarity = 6
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://moat.gg/assets/img/ascended_talent64.png"
ITEM.ItemCheck = 3
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end