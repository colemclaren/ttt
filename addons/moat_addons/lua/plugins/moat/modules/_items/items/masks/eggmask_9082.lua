ITEM.Name = 'Rabid Egg'
ITEM.ID = 9082
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/rabid_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.4830322265625) + (ang:Right() * 0.535400390625) +  (ang:Up() * 6.05029296875)
	
	return mdl, pos, ang
end