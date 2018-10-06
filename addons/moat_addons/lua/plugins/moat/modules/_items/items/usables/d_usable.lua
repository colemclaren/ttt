ITEM.ID = 13
ITEM.Name = "Detective Token"
ITEM.Description = "Use this item during the preparation phase with atleast 8 players online to be guaranteed to be a Detective next round. (Unless you're a Traitor, which will make you a Detective the next round)"
ITEM.Rarity = 8
ITEM.Active = false

ITEM.Price = 100000
ITEM.ShopDesc = "Become a Detective on the next round!\n(Purchasing will give you a one-time Detective Token usable)"
ITEM.LimitedShop = 1533707286

ITEM.Collection = "Limited Collection"
ITEM.Image = "https://cdn.moat.gg/f/4Cf2vezj6BNhBLTQ7pP2smE87BVm.png"

ROLE_TOKEN_PLAYERS = {}

ITEM.ItemUsed = function(pl, slot, item)
	ROLE_TOKEN_PLAYERS[pl] = ROLE_DETECTIVE
end

hook.Add("TTTBeginRound", "RoleTokens", function()
    timer.Simple(3,function()
        for k,v in pairs(ROLE_TOKEN_PLAYERS) do
            if not IsValid(k) then continue end
            if (ROLE_TOKEN_PLAYERS[k] == ROLE_DETECTIVE) and k:IsTraitor() then continue end
            k:SetRole(v)
            ROLE_TOKEN_PLAYERS[k] = nil
        end
    end)
end)