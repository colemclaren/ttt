ITEM.Name = 'Snowspheroid'
ITEM.ID = 9186
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/snowspheroid.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.81)
	pos = pos + (ang:Forward() * -2.9716796875) + (ang:Right() * 0.13156127929688) +  (ang:Up() * 2.1076202392578)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end