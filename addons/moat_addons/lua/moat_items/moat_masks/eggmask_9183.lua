ITEM.Name = 'Egg Of Golden Achievement'
ITEM.ID = 9183
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_golden_achievement.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.3)
	pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * 0.003173828125) +  (ang:Up() * 3.6561584472656)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end