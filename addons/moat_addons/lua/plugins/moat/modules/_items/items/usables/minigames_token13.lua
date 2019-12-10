ITEM.Name = "Zombie Token"
ITEM.ID = 4813
ITEM.Description = "Hide and kill the contagion to be the last survivor"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/zombie_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Contagion Round", {"self"})
end