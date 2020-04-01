ITEM.Name = 'Cannonical Egg'
ITEM.ID = 9173
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cannonical_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -4.3116989135742) + (ang:Right() * 0.001953125) +  (ang:Up() * 1.3859100341797)
	ang:RotateAroundAxis(ang:Right(), -36.900001525879)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end