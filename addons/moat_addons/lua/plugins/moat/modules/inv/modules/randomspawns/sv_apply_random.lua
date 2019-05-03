local good = {
    --[[ [WEAPON_HEAVY] = true,
    [WEAPON_PISTOL] = true]]
}
hook.Add("Initialize", "moat_ApplyRandom", function()
    good = {
        [WEAPON_HEAVY] = true,
        [WEAPON_PISTOL] = true
    }
end)
local ChanceToMutate = 0.5

hook.Add("TTTWeaponVarsInitialized", "moat_ApplyRandom", function(e)
    if (e:IsWeapon() and not IsValid(e:GetOwner()) and not e.CanBuy and good[e.Kind] and ChanceToMutate > math.random()) then
        local chosen_rarity = 2
        for i = chosen_rarity, 7 do
            if (i == 7) then
                local chance_to_move = math.random(8)

                if (chance_to_move == 8) then
                    chosen_rarity = MOAT_RARITIES[9].ID
                    break
                end
            else
                local chance_to_move = math.random(MOAT_RARITIES[i + 1].Rarity)

                if (chance_to_move ~= MOAT_RARITIES[i + 1].Rarity) then
                    chosen_rarity = MOAT_RARITIES[i].ID
                    break
                end
            end
        end

        local chosen_item

        for _, item in RandomPairs(MOAT_DROPTABLE) do
            if (item.Rarity == chosen_rarity and item.Kind == "tier") then
                chosen_item = item
                break
            end
        end

        local col = chosen_item.NameColor or rarity_names[chosen_rarity][2]
        local numcol = bit.lshift(col.r, 16) + bit.lshift(col.g, 8) + col.b

        local loadout_tbl = {
            c = -1,
            p2 = -2,
            p = numcol,
            item = chosen_item,
            w = e:GetClass()
        }

        e:SetRealPrintName(chosen_item.Name .. " " .. e.PrintName)

        local stattbl = {}
        if (chosen_item.Stats) then
            local stats_left = {}
            for k in pairs(chosen_item.Stats) do
                table.insert(stats_left, k:sub(1,1):lower())
            end


            for i = 1, math.random(chosen_item.MinStats, chosen_item.MaxStats) do
                local stat = table.remove(stats_left, math.random(1, #stats_left))
                stattbl[stat] = math.random(0,  1000) / 1000
            end
        end

        if (chosen_item.Talents) then
            local talents = {}
            stattbl.l = 1
            stattbl.x = 0

            for i = 1, math.random(chosen_item.MinTalents, chosen_item.MaxTalents) do
                local TALENT = m_GetRandomTalent(i, chosen_item.Talents[i], false)
                talents[i] = {
                    e = TALENT.ID,
                    l = 0,
                    m = {}
                }

                for m = 1, #TALENT.Modifications do
                    talents[i].m[m] = math.random(0, 1000) / 1000
                end
            end
            loadout_tbl.t = talents
        end

        loadout_tbl.s = stattbl
        m_ApplyWeaponMods(e, loadout_tbl, chosen_item)
        e:SetTintID(numcol)
        

        if (loadout_tbl.t) then
            loadout_tbl.Talents = {}

            for k5, v5 in ipairs(loadout_tbl.t) do
                loadout_tbl.Talents[k5] = m_GetTalentFromEnum(v5.e)
            end
        end

        net.Start "MOAT_UPDATE_WEP"
            net.WriteUInt(e:EntIndex(), 16)
            net.WriteTable(loadout_tbl)
        net.Broadcast()
    end
end)