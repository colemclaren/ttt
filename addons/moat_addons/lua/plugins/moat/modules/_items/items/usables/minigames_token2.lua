ITEM.Name = "Boss Token"
ITEM.ID = 4802
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/boss_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Deathclaw Round", {"self"})
end