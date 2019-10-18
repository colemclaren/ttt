ITEM.Name = "Ascended Stat Mutator"
ITEM.ID = 4006
ITEM.Description = "Using this item allows you to re-roll the stats of any Ascended item"
ITEM.Rarity = 6
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/6ebf091ece6172a692c640204464d839.png"
ITEM.ItemCheck = 7
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end