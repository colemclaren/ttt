ITEM.ID = 7101
ITEM.Name = "Santa's Present"
ITEM.Description = "Every player will receive a Holiday Crate when this item is used"
ITEM.ShopDesc = "Every player will receive a Holiday Crate when this item is used!"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.NewItem = 1577779200
ITEM.Price = 50000
ITEM.Collection = "Santa's Collection"
ITEM.Image = "https://static.moat.gg/f/gift_usable64.png"
ITEM.ItemUsed = function(pl, slot, item)
	for k, v in pairs(player.GetAll()) do
		v:m_DropInventoryItem("Holiday Crate")
	end
end