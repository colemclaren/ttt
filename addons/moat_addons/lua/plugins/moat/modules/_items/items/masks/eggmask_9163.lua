ITEM.Name = 'Air Balloon Egg'
ITEM.ID = 9163
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/s.s_egg_-_the_mighty_dirigible.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.475)
	pos = pos + (ang:Forward() * -3.213623046875) + (ang:Right() * 0.0863037109375) +  (ang:Up() * -1.3739624023438)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end