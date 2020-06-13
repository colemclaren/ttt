ITEM.Name = "TNT Token"
ITEM.ID = 4812
ITEM.Description = "Hot-potato style minigame! Be the last alive to win the best prizes"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/tnt_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "TNT-Tag Round", {"self"})
end