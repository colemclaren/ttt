TALENT.ID = 32
TALENT.Name = "Wildcard: Tier 2"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "When this talent is unlocked, it will morph into a different talent every round"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Melee = false
TALENT.NotUnique = false

-- if (item_to_drop.MinTalents and item_to_drop.MaxTalents and item_to_drop.Talents) then
--     dropped_item.s.l = 1
--     dropped_item.s.x = 0
--     dropped_item.t = {}
--     local talents_chosen = {}
--     local talents_to_loop = dev_talent_tbl or item_to_drop.Talents

--     for k, v in ipairs(talents_to_loop) do
--         talents_chosen[k] = m_GetRandomTalent(k, v, false)
--     end

--     for i = 1, table.Count(talents_chosen) do
--         local talent_tbl = talents_chosen[i]
--         dropped_item.t[i] = {}
--         dropped_item.t[i].e = talent_tbl.ID
--         dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
--         dropped_item.t[i].m = {}

--         for k, v in ipairs(talent_tbl.Modifications) do
--             dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
--         end
--     end
-- end

util.AddNetworkString("weapon.UpdateTalents")

local tier = 2
local id = TALENT.ID
function wildcard_t2(weapon,talent_mods)
    local talents_chosen = {}
    local talents = table.Copy(MOAT_TALENTS)

    local active = weapon.Talents[tier].l <= weapon.level
    if (not active) then return end


    for k,v in pairs(talents) do 
        if v.Tier ~= tier or v.ID == id or (v.ID == 154) then 
            talents[k] = nil 
        end 
    end

    local talent = table.Random(talents)
   
    local t = {
        e = talent.ID,
        l = weapon.Talents[tier].l,
        m = {}
    }

    for k,v in pairs(talent.Modifications) do
        t.m[k] = math.Round(math.Rand(0, 1), 2)
    end

    weapon.Weapon.Talents[tier] = t
    weapon.Weapon.ItemStats.t[tier] = t
    weapon.Weapon.ItemStats.Talents[tier] = talent

    if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
        loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
        loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
        loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
    end


    m_ApplyTalentsToWeapon(weapon.Weapon,t)

    for k,v in pairs(talent) do
        if isfunction(v) then talent[k] = nil end
    end

    timer.Simple(1,function()
        net.Start("weapon.UpdateTalents")
        net.WriteEntity(weapon.Weapon)
        net.WriteInt(tier,8)
        net.WriteTable(talent)
        net.WriteTable(t)
        net.Broadcast()
    end)

    -- PrintTable(talents)

    -- for i = 1, table.Count(talents_chosen) do
    --     local talent_tbl = talents_chosen[i]
    --     dropped_item.t[i] = {}
    --     dropped_item.t[i].e = talent_tbl.ID
    --     dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
    --     dropped_item.t[i].m = {}

    --     for k, v in ipairs(talent_tbl.Modifications) do
    --         dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
    --     end
    -- end
end

function TALENT:ModifyWeapon( weapon, talent_mods )
    timer.Simple(1,function()
        wildcard_t2(weapon,talent_mods)
    end)
end