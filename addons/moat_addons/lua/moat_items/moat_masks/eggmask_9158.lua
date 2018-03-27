ITEM.Name = 'Leftover Egg Of Whatevers Left'
ITEM.ID = 9158
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/leftover_egg_of_whatevers_left.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.8)
	pos = pos + (ang:Forward() * -0.37835693359375) + (ang:Right() * 0.055572509765625) +  (ang:Up() * 0.68265533447266)
	
	return mdl, pos, ang
end