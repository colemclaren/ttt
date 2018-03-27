ITEM.Name = 'Egg Of Life'
ITEM.ID = 9179
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_life.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	pos = pos + (ang:Forward() * -3.17578125) + (ang:Right() * 0.01104736328125) +  (ang:Up() * -2.2247161865234)
	
	return mdl, pos, ang
end