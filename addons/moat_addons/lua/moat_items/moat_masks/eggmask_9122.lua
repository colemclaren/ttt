ITEM.Name = 'Tesla Egg'
ITEM.ID = 9122
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/tesla_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.725)
	pos = pos + (ang:Forward() * -3.4835205078125) + (ang:Right() * -0.01953125) +  (ang:Up() * 5.1614456176758)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end