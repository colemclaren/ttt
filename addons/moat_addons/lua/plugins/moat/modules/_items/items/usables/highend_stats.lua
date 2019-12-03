ITEM.Name = "High-End Stat Mutator"
ITEM.ID = 4008
ITEM.Description = "Using this item allows you to re-roll the stats of any High-End item"
ITEM.Rarity = 5
ITEM.Active = true
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/highend_stat64.png"
ITEM.ItemCheck = 8
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end