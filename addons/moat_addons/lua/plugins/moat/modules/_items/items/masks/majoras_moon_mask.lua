ITEM.ID = 8040
ITEM.Rarity = 2
ITEM.Name = "Majora's Moon Mask"
ITEM.Description = "I... I shall consume. Consume... Consume everything.."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/moon/moon.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.979)+ (a:Right() * -0.001)+ (a:Up() * -0.718)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end