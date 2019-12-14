local RANGE_NUMBER = 30 -- This is the number that divides the cone ( Higher number = higher range )
local RANGE_CAP = 0.35 -- 35% 

hook.Add("EntityTakeDamage", "moat_ApplyRange", function(ent, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if (not attacker:IsPlayer()) then return end
    if (not dmginfo:IsBulletDamage()) then return end
    local weapon = attacker:GetActiveWeapon()
    local weapon_tbl = weapon:GetTable()

    -- This is where we apply the range modifier
    if (weapon_tbl and weapon_tbl.Primary and weapon_tbl.Primary.Cone and not weapon_tbl.ChargeSpeed) then
        local attackerpos = attacker:GetPos()
        local entpos = ent:GetPos()
        local distance = attackerpos:Distance(entpos)
        local range_mod = weapon:GetRange() / 100 + 1

        local optimal_range = weapon:GetCurrentRange()

        if (not optimal_range) then
            if (weapon_tbl.Primary.Ammo and weapon_tbl.Primary.Ammo == "Buckshot") then
                optimal_range = 50 / weapon_tbl.Primary.Cone
            else
                optimal_range = RANGE_NUMBER / weapon_tbl.Primary.Cone
            end
        end

        optimal_range = optimal_range * range_mod

        if (distance > optimal_range) then
            local falloff_range = (weapon:GetCurrentMaxRange() or optimal_range) * range_mod

            dmginfo:ScaleDamage(RANGE_CAP + (1 - RANGE_CAP) * (1 - math.min(1, math.max(0, (distance - optimal_range) / falloff_range))))
        end
    end
end)
