ITEM.Name = 'Supersonic Egg'
ITEM.ID = 9188
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/supersonic_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.61)
	pos = pos + (ang:Forward() * -2.2730712890625) + (ang:Right() * -0.17501831054688) +  (ang:Up() * 0.95858764648438)
	
	return mdl, pos, ang
end