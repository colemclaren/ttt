ITEM.ID = 7820
ITEM.Name = "Empty Gift Package"
ITEM.Description = "Right click to insert an item into the gift package"
ITEM.Rarity = 0
ITEM.Active = true
ITEM.Price = 5000
ITEM.Collection = "Gift Collection"
ITEM.Image = "https://cdn.moat.gg/f/xWuj9CmSOsG96zDxCWWcAmfVz0bN.png"
ITEM.ItemCheck = 13
ITEM.Preview = false
ITEM.CrateShopOverride = "Gift"
ITEM.ItemUsed = function(pl, slot, item, cslot, citem)
	return MOAT_GIFTS.UseEmptyGift(pl, slot, item, cslot, citem)
end