ITEM.Name = 'The Mad Egg'
ITEM.ID = 9088
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/the_mad_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -3.113525390625) + (ang:Right() * 1.1524658203125) +  (ang:Up() * -0.19969940185547)
	
	return mdl, pos, ang
end