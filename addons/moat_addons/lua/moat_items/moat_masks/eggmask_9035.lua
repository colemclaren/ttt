ITEM.Name = 'Golden Egg Of Kings'
ITEM.ID = 9035
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/golden_egg_of_kings.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end