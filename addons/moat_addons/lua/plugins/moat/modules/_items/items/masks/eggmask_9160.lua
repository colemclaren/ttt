ITEM.Name = 'Eggtraterrestrial'
ITEM.ID = 9160
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggtraterrestrial.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -2.8681640625) + (ang:Right() * 0.01214599609375) +  (ang:Up() * 1.1173782348633)
	ang:RotateAroundAxis(ang:Right(), -107.69999694824)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end