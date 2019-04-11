
TALENT.ID = 36
TALENT.Name = "Wild: Tier 3"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "After a kill, this talent has a %s_^ chance to morph into a random talent"
TALENT.Tier = 3
-- TALENT.LevelRequired = {min = -5, max = -10}
TALENT.LevelRequired = {min = 20, max = 30}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 60}

TALENT.Melee = false
TALENT.NotUnique = false

util.AddNetworkString("weapon.UpdateTalents")


local tier = 3
local id = TALENT.ID
function wild_t3(weapon,talent_mods)
    local talents = table.Copy(MOAT_TALENTS)

    local active = weapon.Talents[tier].l <= weapon.level
    if (not active) then return end


    for k,v in pairs(talents) do 
        if v.Tier ~= tier or v.ID == id or (v.ID == 154) or ((v.Collection or "") == "Meme Collection") then 
            talents[k] = nil 
        end 
    end

    local talent, tk = table.Random(talents)

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
        net.WriteBool(true)
        net.WriteEntity(weapon.Weapon)
        net.WriteInt(tier,8)
        net.WriteTable(talent)
        net.WriteTable(t)
        net.Broadcast()
    end)

end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) and GetRoundState() ~= ROUND_PREP then
    	wild_t3(att:GetActiveWeapon(),talent_mods)
    end
end