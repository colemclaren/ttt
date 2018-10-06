ITEM.Name = "High-End Stat Mutator"
ITEM.ID = 4008
ITEM.Description = "Using this item allows you to re-roll the stats of any High-End item"
ITEM.Rarity = 5
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/oNRjVxjAGwfijs04tAPfL7Z7QJ8H.png"
ITEM.ItemCheck = 8
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end