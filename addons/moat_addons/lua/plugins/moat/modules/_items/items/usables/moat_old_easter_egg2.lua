ITEM.ID = 8981
ITEM.Name = "Easter Egg of Past"
ITEM.Description = "A usable capable of summoning 2017's easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Easter 2018 Collection"
ITEM.Image = "https://cdn.moat.gg/f/qPk8bO1ovDg8UWhJlE80k48xcQ19.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end