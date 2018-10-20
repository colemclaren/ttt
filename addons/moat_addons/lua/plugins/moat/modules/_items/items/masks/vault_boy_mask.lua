ITEM.ID = 8065
ITEM.Rarity = 6
ITEM.Name = "Vault Boy Mask"
ITEM.Description = "The real pussy destroyer. I'm a motherfuckin' pimp-ass mask who loves hot babes on the daily."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/vaultboy/vaultboy.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.758)+ (a:Right() * 0.015)+ (a:Up() * 1.482)
	a:RotateAroundAxis(a:Up(), 90)


	return m, p, a
end