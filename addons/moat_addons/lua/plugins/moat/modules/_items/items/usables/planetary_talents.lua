ITEM.Name = "Planetary Talent Mutator"
ITEM.ID = 4005
ITEM.Description = "Using this item allows you to re-roll the talents of any Planetary item. This will reset the item's LVL and XP"
ITEM.Rarity = 9
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/MUCFa2rOqAr4RR4VbrmFRsuYpC1U.png"
ITEM.ItemCheck = 5
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end