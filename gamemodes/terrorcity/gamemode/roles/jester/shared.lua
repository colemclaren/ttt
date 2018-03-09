InstallRoleHook("ScalePlayerDamage", function(ply, hitgroup, dmginfo)
    return dmginfo:GetAttacker()
end)

function ROLE:ScalePlayerDamage(ply, hg, dmginfo)
    dmginfo:ScaleDamage(0)
end