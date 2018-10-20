ITEM.ID = 8012
ITEM.Rarity = 2
ITEM.Name = "Bunny Hood"
ITEM.Description = "You got the Bunny Hood! My, what long ears it has! Will the power of the wild spring forth?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bunnyhood/bunnyhood.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.875)
	p = p + (a:Forward() * -3.479)+ (a:Right() * 0.112)+ (a:Up() * 4.168)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), -0.1)


	return m, p, a
end