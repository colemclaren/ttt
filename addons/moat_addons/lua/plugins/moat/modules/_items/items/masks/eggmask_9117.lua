ITEM.Name = 'The Amber Egg'
ITEM.ID = 9117
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/the_amber_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -3.130859375) + (ang:Right() * 0.0819091796875) +  (ang:Up() * -0.20054626464844)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end