ITEM.Name = 'Sand Shark Egg'
ITEM.ID = 9182
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/sand_shark_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.725)
	pos = pos + (ang:Forward() * -2.2077026367188) + (ang:Right() * 0.097442626953125) +  (ang:Up() * 1.2389678955078)
	ang:RotateAroundAxis(ang:Right(), 102.5)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end