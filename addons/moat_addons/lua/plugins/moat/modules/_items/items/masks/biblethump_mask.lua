ITEM.ID = 8032
ITEM.Rarity = 5
ITEM.Name = "Biblethump Mask"
ITEM.Description = "The face of a crying baby from the indie game The Binding of Isaac. Also a Twitch emote."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/isaac/isaac.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -4.675)+ (a:Right() * -0.003)+ (a:Up() * -7.871)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end