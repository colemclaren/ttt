ITEM.Name = 'Alien Arteggfact'
ITEM.ID = 9174
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/alien_arteggfact.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -2.7769999504089) + (ang:Right() * -0) +  (ang:Up() * 1.1000000238419)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end