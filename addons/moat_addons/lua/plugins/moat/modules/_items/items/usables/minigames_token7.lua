ITEM.Name = "Lava Token"
ITEM.ID = 4807
ITEM.Description = "The floor is lava! Be the last alive to win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/lava_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "The Floor is Lava", {"self"})
end