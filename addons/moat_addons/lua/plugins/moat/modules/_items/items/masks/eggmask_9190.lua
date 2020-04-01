ITEM.Name = 'Gooey Egg'
ITEM.ID = 9190
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/gooey_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.310546875) + (ang:Right() * 0.044525146484375) +  (ang:Up() * 7.1444625854492)
	
	return mdl, pos, ang
end