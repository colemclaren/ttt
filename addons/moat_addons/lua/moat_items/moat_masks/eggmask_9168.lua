ITEM.Name = 'Egg Of Space'
ITEM.ID = 9168
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_space.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.9876098632813) + (ang:Right() * -0.25494384765625) +  (ang:Up() * 0.9698486328125)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -280.20001220703)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end