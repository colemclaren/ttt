ITEM.Name = "Deathmatch Token"
ITEM.ID = 4805
ITEM.Description = "First player to reach the winning kill count gets the top prize! Everybody must compete in a free-for-all shootout with the same guns"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/ffa_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "FFA Round", {"self"})
end