ITEM.Name = 'Egg Of Duty'
ITEM.ID = 9181
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_duty.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -3.3696899414063) + (ang:Right() * -0.02252197265625) +  (ang:Up() * 0.21257019042969)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	
	return mdl, pos, ang
end