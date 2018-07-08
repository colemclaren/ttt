ITEM.Name = 'Rabid Egg'
ITEM.ID = 9082
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/rabid_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.4830322265625) + (ang:Right() * 0.535400390625) +  (ang:Up() * 6.05029296875)
	
	return mdl, pos, ang
end