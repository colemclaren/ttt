TALENT.ID = 87
TALENT.Name = "Explosive"
TALENT.NameColor = Color(255, 128, 0)
TALENT.Description = "Every quarter second of firing, this gun has a %s_^ chance to fire an explosive round dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 21, max = 40}
TALENT.Modifications[2] = {min = 13.37, max = 42}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local random_num = math.random() * 100

    if (not is_bow) then
        if (not IsValid(wep)) then
            return
        end
        if (not wep.Primary or not wep.Primary.Delay) then
            attacker:PrintMessage(HUD_PRINTCENTER, "Your gun does not have valid stats for Explosive.")
            return
        end
        local rps = (wep.Primary.NumShots or 1) / wep.Primary.Delay
        chance = math.min(chance * 4 / rps, 25) -- 4 = quarter second
    end

    local apply_mod = chance > random_num

    if (apply_mod) then
    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])

        if (is_bow and hit_pos) then
            local exp = ents.Create("env_explosion")
            exp:SetOwner(attacker)
            exp:SetPos(hit_pos)
            exp:Spawn()
            exp:SetKeyValue("iMagnitude", tostring(dmg/2))
            exp:Fire("Explode", 0, 0)
        else
            dmginfo.Callback = function(att, tr, dmginfo)
                if (tr.AltHitreg) then
                    return
                end
                local exp = ents.Create("env_explosion")
                exp:SetOwner(attacker)
                exp:SetPos(tr.HitPos)
                exp:Spawn()
                exp:SetKeyValue("iMagnitude", tostring(dmg / 2))
                exp:Fire("Explode", 0, 0)
            end
        end
    end
end