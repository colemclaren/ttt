local good = {
    --[[ [WEAPON_HEAVY] = true,
    [WEAPON_PISTOL] = true]]
}
RANDOM_DROPS = RANDOM_DROPS or {}
RANDOM_DROPS.Minimum = 4
local fn = function()
    good = {
        [WEAPON_HEAVY] = true,
        [WEAPON_PISTOL] = true
    }
end
hook.Add("Initialize", "moat_ApplyRandom", fn)
if (gmod.GetGamemode()) then
    fn()
end

hook.Add("TTTWeaponCreated", "moat_ApplyRandom", function(e)
    if (IsValid(e:GetOwner()) or  e.CanBuy or not good[e.Kind]) then
        return
    end
    timer.Simple(0, function()
        if (not IsValid(e) or IsValid(e:GetOwner())) then
            return 
        end

        local chosen_rarity = mi.Rarity.Get(RANDOM_DROPS.Minimum)
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
                local talent = m_GetRandomTalent(i, chosen_item.Talents[i], false)
                talents[i] = {
                    e = talent.ID,
                    l = 0,
                    m = {}
                }

				if (talent.Modifications) then
					for k, v in ipairs(talent.Modifications) do
						talents[i].m[k] = math.random(0, 1000) / 1000
                	end
				end
            end
            loadout_tbl.t = talents
        end

        loadout_tbl.s = stattbl
        m_ApplyWeaponMods(e, loadout_tbl, chosen_item)
        e:SetTintID(numcol)
        

		if (loadout_tbl.t) then
            loadout_tbl.Talents = GetItemTalents(loadout_tbl)
        end

        net.Start "MOAT_UPDATE_WEP"
            net.WriteUInt(e:EntIndex(), 16)
            net.WriteTable(loadout_tbl)
        net.Broadcast()
    end)
end)