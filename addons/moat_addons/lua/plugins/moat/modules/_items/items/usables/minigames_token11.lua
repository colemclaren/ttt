ITEM.Name = "Team Deathmatch Token"
ITEM.ID = 4811
ITEM.Description = "You have two teams, but only use one loadout. Fair game, first team to reach the winning kill limit wins, with the highest damage player getting the top prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/tdm_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Team Deathmatch", {"self"})
end