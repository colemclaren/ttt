ITEM.Name = 'Egg Of Innocence'
ITEM.ID = 9170
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/egg_of_innocence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.35)
	pos = pos + (ang:Forward() * -3.1703491210938) + (ang:Right() * 0.00592041015625) +  (ang:Up() * 1.5388488769531)
	
	return mdl, pos, ang
end