ITEM.Name = "Cock Token"
ITEM.ID = 4803
ITEM.Description = "Expoding chickens will spawn on everybody. Be the last alive to win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/cock_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Apache Round", {"self"})
end