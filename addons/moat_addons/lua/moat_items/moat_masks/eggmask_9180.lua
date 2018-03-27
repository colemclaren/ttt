ITEM.Name = 'Sorcus Egg'
ITEM.ID = 9180
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/sorcus_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.61)
	pos = pos + (ang:Forward() * -2.7235717773438) + (ang:Right() * -0.86248779296875) +  (ang:Up() * 1.7162933349609)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end