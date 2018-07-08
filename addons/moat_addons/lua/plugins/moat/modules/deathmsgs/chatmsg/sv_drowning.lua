hook.Add("EntityTakeDamage", "swaggertyes", function(ent, info)
    if (info:GetDamageType() == DMG_DROWN and ent:IsPlayer()) then
        local health = ent:Health() - info:GetDamage()
        if (health <= 0) then
            ent.DiedByWater = true
        end
    end
end)

hook.Add("PlayerSpawn", "whatthefuckamIdoing", function(ply)
    if ply.DiedByWater or false then
        ply.DiedByWater = false
    end
end)