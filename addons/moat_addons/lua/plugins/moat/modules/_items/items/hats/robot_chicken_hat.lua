ITEM.ID = 8092
ITEM.Rarity = 5
ITEM.Name = "Robot Chicken Hat"
ITEM.Description = "Why did the chicken REALLY cross the road? To get hit by a car, stolen by a mad scientist, and transformed into a terrifying cyborg that you can wear on your head. So the next time you hear someone telling you that joke, set that smug joke-teller straight, because you've got the FACTS."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_robotchicken.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.775)
	p = p + (a:Forward() * -4.184)+ (a:Right() * 0.081)+ (a:Up() * 6.122)

	return m, p, a
end