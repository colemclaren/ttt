ITEM.Name = 'Egg Of Innocence'
ITEM.ID = 9170
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_innocence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.35)
	pos = pos + (ang:Forward() * -3.1703491210938) + (ang:Right() * 0.00592041015625) +  (ang:Up() * 1.5388488769531)
	
	return mdl, pos, ang
end