ITEM.Name = "Dog Talent Mutator"
ITEM.ID = 4082
ITEM.Description = "Using this item will add the Dog Lover talent to any weapon. It will replace the tier two talent if one already exists. Only 200 of these mutators can be produced."
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.Image = "https://i.moat.gg/BT4wO.png"
ITEM.ItemCheck = 4
ITEM.ItemUsed = function(pl, slot, item)
	m_AssignDogLover(pl, slot, item)
    m_SendInvItem(pl, slot)
end