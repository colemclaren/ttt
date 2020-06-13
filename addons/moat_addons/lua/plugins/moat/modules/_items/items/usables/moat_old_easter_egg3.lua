ITEM.ID = 8983
ITEM.Name = "Old Timey Easter Egg"
ITEM.Description = "A usable capable of summoning an easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Egg Hunt Collection"
ITEM.Image = "https://static.moat.gg/f/easter_eggold64.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end