ITEM.ID = 8078
ITEM.Rarity = 5
ITEM.Name = "Estilo Muerto"
ITEM.Description = "Help the traitors celebrate Day of the Dead by wearing this hat and then killing them."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_estilomuerto.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.024)+ (a:Right() * 0.038)+ (a:Up() * 3.298)

	return m, p, a
end