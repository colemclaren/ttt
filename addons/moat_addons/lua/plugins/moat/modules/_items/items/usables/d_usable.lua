ITEM.ID = 13
ITEM.Name = "Detective Token"
ITEM.Description = "Use this item during the preparing phase to be guaranteed to be a Detective next round"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.ShopDesc = "Become a Detective on the next round!\n(Purchasing will give you a one-time Detective Token usable)"

ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/detective_token.png"

ROLE_TOKEN_PLAYERS = ROLE_TOKEN_PLAYERS or {}

ITEM.ItemUsed = function(pl, slot, item)
	if (not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		ROLE_TOKEN_PLAYERS[pl] = ROLE_DETECTIVE
	end
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