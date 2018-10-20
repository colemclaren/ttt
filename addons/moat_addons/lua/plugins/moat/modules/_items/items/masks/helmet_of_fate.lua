ITEM.ID = 8024
ITEM.Rarity = 6
ITEM.Name = "Helmet of Fate"
ITEM.Description = "This is the Helmet of Fate. It is not a 'shiny target'. It holds untold power."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/fate/fate.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -5.006)+ (a:Right() * -0.002)+ (a:Up() * -1.971)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end