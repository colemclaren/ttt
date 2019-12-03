ITEM.Name = "Cosmic Talent Mutator"
ITEM.ID = 4002
ITEM.Description = "Using this item allows you to re-roll the talents of any Cosmic item. This will reset the item's LVL and XP"
ITEM.Rarity = 7
ITEM.Active = true
ITEM.NewItem = 1575878400
ITEM.Price = 400000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://cdn.moat.gg/f/cosmic_talent64.png"
ITEM.ItemCheck = 2
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end