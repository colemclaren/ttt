TALENT.ID = 87
TALENT.Suffix = "the BOOM"
TALENT.Name = "BOOM"
TALENT.NameColor = Color(255, 128, 0)
TALENT.Description = "Every second of firing, this gun will fire %s^ explosive rounds dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 0.84, max = 1.20} -- Chance to trigger
TALENT.Modifications[2] = {min = 13.37, max = 42}	-- Explosion damage

TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (not gmod.GetGamemode():AllowPVP()) then return end
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))

    if (not IsValid(wep)) then
        return
    end

    if (not wep.Primary or not wep.Primary.Delay) then
        attacker:PrintMessage(HUD_PRINTCENTER, "Your gun does not have valid stats for Explosive.")
        return
    end

    local pellets_per_sec = (wep.Primary.ReverseShotsDamage and wep.Primary.Damage or wep.Primary.NumShots or 1) / wep.Primary.Delay
    chance = chance / pellets_per_sec


    local dmg = self.Modifications[2].min + (self.Modifications[2].max - self.Modifications[2].min) * math.min(1, talent_mods[2])

    if (is_bow and hit_pos) then
        if (chance > math.random()) then
            local exp = ents.Create("env_explosion")
            exp:SetOwner(attacker)
            exp:SetPos(hit_pos)
            exp:Spawn()
            exp:SetKeyValue("iMagnitude", tostring(dmg / 2))
            exp:Fire("Explode", 0, 0)
        end
    else
        local cb = dmginfo.Callback
        dmginfo.Callback = function(att, tr, dmginfo)
            if (not tr.AltHitreg and chance > math.random()) then
                local exp = ents.Create("env_explosion")
                exp:SetOwner(attacker)
                exp:SetPos(tr.HitPos)
                exp:Spawn()
                exp:SetKeyValue("iMagnitude", tostring(dmg / 2))
                exp:Fire("Explode", 0, 0)
            end
            if (cb) then
                return cb(att, tr, dmginfo)
            end
        end
    end
end