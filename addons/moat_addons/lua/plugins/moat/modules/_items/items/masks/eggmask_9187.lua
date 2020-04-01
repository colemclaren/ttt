ITEM.Name = 'Mercurial Egg'
ITEM.ID = 9187
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/mercurial_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.898681640625) + (ang:Right() * 0.0714111328125) +  (ang:Up() * 2.8903656005859)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end