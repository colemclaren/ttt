ITEM.Name = 'Supersonic Egg'
ITEM.ID = 9188
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/supersonic_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.61)
	pos = pos + (ang:Forward() * -2.2730712890625) + (ang:Right() * -0.17501831054688) +  (ang:Up() * 0.95858764648438)
	
	return mdl, pos, ang
end