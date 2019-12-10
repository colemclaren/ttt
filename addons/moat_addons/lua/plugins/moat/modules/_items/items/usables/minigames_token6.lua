ITEM.Name = "Knife Token"
ITEM.ID = 4806
ITEM.Description = "Each player starts with the same weapon. Kill to advance wepaons"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/knife_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Gun Game", {"self"})
end