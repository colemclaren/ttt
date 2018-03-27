ITEM.Name = 'Egg Of Scales'
ITEM.ID = 9184
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_scales.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.575)
	pos = pos + (ang:Forward() * -3.9340209960938) + (ang:Right() * 0.02142333984375) +  (ang:Up() * 2.0720672607422)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 180)
	
	return mdl, pos, ang
end