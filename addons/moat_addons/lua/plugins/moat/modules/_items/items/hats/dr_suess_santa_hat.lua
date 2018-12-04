ITEM.ID = 8535
ITEM.Rarity = 7
ITEM.Name = "Suess Santa Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_xmasfestive01.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.798)+ (a:Right() * -0.191)+ (a:Up() * 2.377)

	return m, p, a
end