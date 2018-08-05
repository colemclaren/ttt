ITEM.ID = 13
ITEM.Name = "Detective Token"
ITEM.Description = "Use this item during the preparation phase with atleast 8 players online to be guaranteed to be a Detective next round. (Unless you're a traitor)"
ITEM.Rarity = 8
ITEM.Active = false

ITEM.Price = 75000
ITEM.ShopDesc = "Become a Detective on the next round!"

ITEM.Collection = "Limited Collection"
ITEM.Image = "https://i.moat.gg/18-08-04-38B.png"

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