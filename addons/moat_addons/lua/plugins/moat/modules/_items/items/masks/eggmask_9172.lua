ITEM.Name = 'The Eggteen-twelve Overture'
ITEM.ID = 9172
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_eggteen-twelve_overture.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.66)
	pos = pos + (ang:Forward() * -2.2990112304688) + (ang:Right() * -0.16574096679688) +  (ang:Up() * 1.9350891113281)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end