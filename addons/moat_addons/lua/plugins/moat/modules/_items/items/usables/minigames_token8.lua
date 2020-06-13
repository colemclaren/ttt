ITEM.Name = "One Token"
ITEM.ID = 4808
ITEM.Description = "Everybody has a one bullet gun, gain an extra bullet by taking somebody's life. You have 3 lives and the last man standing wins"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/one_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "One in the Chamber", {"self"})
end