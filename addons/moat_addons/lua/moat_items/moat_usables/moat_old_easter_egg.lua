ITEM.ID = 8980
ITEM.Name = "Easter Egg Memories"
ITEM.Description = "A usable capable of summoning 2017's easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Easter 2018 Collection"
ITEM.Image = "https://i.moat.gg/3XeiQ.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end