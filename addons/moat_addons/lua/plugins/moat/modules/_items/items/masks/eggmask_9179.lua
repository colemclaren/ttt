ITEM.Name = 'Egg Of Life'
ITEM.ID = 9179
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_life.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	pos = pos + (ang:Forward() * -3.17578125) + (ang:Right() * 0.01104736328125) +  (ang:Up() * -2.2247161865234)
	
	return mdl, pos, ang
end