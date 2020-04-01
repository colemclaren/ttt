ITEM.Name = 'Tiny Egg Of Nonexistence'
ITEM.ID = 9166
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tiny_egg_of_nonexistence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * -0.1636962890625) +  (ang:Up() * 7.4242324829102)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end