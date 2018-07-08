ITEM.Name = "High-End Stat Mutator"
ITEM.ID = 4008
ITEM.Description = "Using this item allows you to re-roll the stats of any High-End item"
ITEM.Rarity = 5
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://moat.gg/assets/img/highend_stat64.png"
ITEM.ItemCheck = 8
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end