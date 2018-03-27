ITEM.Name = 'The Sands Of Time'
ITEM.ID = 9171
ITEM.Description = 'A special cosmetic egg from the 2018 Easter event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Easter 2018 Collection'
ITEM.Model = 'models/roblox_assets/the_sands_of_time.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.81)
	pos = pos + (ang:Forward() * -2.5338745117188) + (ang:Right() * 0.51425170898438) +  (ang:Up() * 0.95062255859375)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end