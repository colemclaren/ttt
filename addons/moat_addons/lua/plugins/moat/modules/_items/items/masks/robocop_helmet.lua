ITEM.ID = 8050
ITEM.Rarity = 5
ITEM.Name = "Robocop Helmet"
ITEM.Description = "Dead or Alive, you're coming with me."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/robocop/robocop.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.054)+ (a:Right() * 0.079)+ (a:Up() * 2.747)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end