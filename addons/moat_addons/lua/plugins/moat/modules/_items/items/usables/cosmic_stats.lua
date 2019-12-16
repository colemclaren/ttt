ITEM.Name = "Cosmic Stats Mutator"
ITEM.ID = 4007
ITEM.Description = "Using this item allows you to re-roll the stats of any Cosmic item"
ITEM.Rarity = 7
ITEM.Active = true
ITEM.NewItem = 1575878400
ITEM.Price = 350000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/cosmic_stat64.png"
ITEM.ItemCheck = 6
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end