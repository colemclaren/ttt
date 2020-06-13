ITEM.Name = "Apache Token"
ITEM.ID = 4801
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/apache_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Apache Round", {"self"})
end