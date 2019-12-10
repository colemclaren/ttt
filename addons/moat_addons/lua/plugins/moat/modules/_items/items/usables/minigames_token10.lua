ITEM.Name = "Stalker Token"
ITEM.ID = 4810
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/stalker_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Stalker Round", {"self"})
end