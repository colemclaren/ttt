ITEM.Name = 'Malicious Egg'
ITEM.ID = 9177
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/malicious_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.925)
	pos = pos + (ang:Forward() * -3.4658203125) + (ang:Right() * 0.069549560546875) +  (ang:Up() * 0.090347290039063)
	
	return mdl, pos, ang
end