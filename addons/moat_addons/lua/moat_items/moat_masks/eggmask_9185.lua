ITEM.Name = 'Combo Egg Of Trolllolol'
ITEM.ID = 9185
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/combo_egg_of_trolllolol.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -2.29052734375) + (ang:Right() * 0.00537109375) +  (ang:Up() * 1.2985763549805)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end