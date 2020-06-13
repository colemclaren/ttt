ITEM.Name = "Planetary Stats Mutator"
ITEM.ID = 4009
ITEM.Description = "Using this item allows you to re-roll the stats of any Planetary item"
ITEM.Rarity = 9
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 600000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/planetary_stat64.png"
ITEM.ItemCheck = 9
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end