ITEM.Name = 'Scribbled Egg'
ITEM.ID = 9176
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/scribbled_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.525)
	pos = pos + (ang:Forward() * -3.6149291992188) + (ang:Right() * 0.11465454101563) +  (ang:Up() * 2.0404052734375)
	ang:RotateAroundAxis(ang:Right(), -180)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end