ITEM.Name = 'Faster Than Light Egg'
ITEM.ID = 9155
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/faster_than_light_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.8)
	pos = pos + (ang:Forward() * -3.838623046875) + (ang:Right() * 0.036529541015625) +  (ang:Up() * 0.59132385253906)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end