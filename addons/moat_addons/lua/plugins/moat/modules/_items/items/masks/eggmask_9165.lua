ITEM.Name = 'Racin Egg Of Fast Cars'
ITEM.ID = 9165
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/racin_egg_of_fast_cars.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.1922607421875) + (ang:Right() * 0.07916259765625) +  (ang:Up() * 0.7210693359375)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end