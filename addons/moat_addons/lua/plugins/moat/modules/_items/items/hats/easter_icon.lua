ITEM.ID = 4539
ITEM.Rarity = 7
ITEM.Name = "Easter Icon"
ITEM.Description = "But from this earth, this grave, this dust, my God shall raise me up, I trust"
ITEM.Collection = "Easter 2019 Collection"
ITEM.Model = "models/moat/mg_hat_easteregg.mdl"
ITEM.Image = "https://cdn.moat.gg/f/gDiWD4es5YoG7tfZ6oDWRI8LZy3bbWWg.png"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 9.259)

	return m, p, a
end