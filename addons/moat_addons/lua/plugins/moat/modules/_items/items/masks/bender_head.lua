ITEM.ID = 8009
ITEM.Rarity = 4
ITEM.Name = "Bender Head"
ITEM.Description = "Blackmail is such an ugly word. I prefer extortion. The 'x' makes it sound cool."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bender/bender.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.861)+ (a:Right() * 0.314)+ (a:Up() * -6.522)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end