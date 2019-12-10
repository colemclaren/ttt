ITEM.Name = "Rename Token"
ITEM.ID = 4001
ITEM.Description = "Using this item allows you to change the name of any equippable item in your inventory"
ITEM.Rarity = 0
ITEM.Active = true
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Gamma Collection"
ITEM.CrateShopOverride = "Name Mutator"
ITEM.Image = "https://cdn.moat.gg/ttt/rename_token.png"
ITEM.ItemCheck = 1
ITEM.ItemUsed = function(pl, slot, item, str)
	str = sql.SQLStr(str, true)
	str = string.Replace(str,"\n","")
	str = string.Replace(str,"\r","")
	str = string.Replace(str,"\\","")
	str = string.sub(str, 0, 100)
	MOAT_INVS[pl]["slot" .. slot].n = str
    m_SendInvItem(pl, slot)
end