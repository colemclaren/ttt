ITEM.Name = "Seek Token"
ITEM.ID = 4809
ITEM.Description = "Classic prop hunt! Randomly be a prop or a hunter, only one team can win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/seek_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Prop Hunt", {"self"})
end