ITEM.ID = 4529
ITEM.Rarity = 6
ITEM.Name = "Holy Cuteness"
ITEM.Description = "OMFGGG MOM ITS SO CUTE!!!! CAN WE KEEP ITT PELASE PLEASE PELASEEEE .."
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/moat/mg_hat_easterchick.mdl"
ITEM.Image = "https://cdn.moat.gg/f/SIiqea9734CbYeG8n3yW6ae0HrBPraSp.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -2.04)+ (a:Right() * 0.001)+ (a:Up() * 9.416)

	return m, p, a
end