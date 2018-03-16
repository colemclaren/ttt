ITEM.ID = 7820
ITEM.Name = "Gift Package"
ITEM.Description = "Every player will receive a holiday crate when this item is used"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.Price = 5000
ITEM.Collection = "Gift Collection"
ITEM.Image = "moat_inv/gift_usable64.png"
ITEM.ItemCheck = 1
ITEM.ItemUsed = function(pl, slot, item)
 -- 	m_ResetTalents(pl, slot, item)
 --     m_SendInvItem(pl, slot)
end