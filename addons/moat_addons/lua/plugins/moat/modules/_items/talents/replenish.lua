TALENT.ID = 99
TALENT.Name = "Replenish"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 122)
TALENT.Description = "Your gun has a %s_^ chance to refill a bullet if you hit someone"
TALENT.Tier = 2
TALENT.Melee = false
TALENT.NotUnique = true
TALENT.LevelRequired = {min = 15, max = 19}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 50, max = 90}

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    if (chance > math.random() * 100) then
        local old_callback = dmginfo.Callback

        dmginfo.Callback = function(att, tr, dmginfo)
            if (old_callback) then
                old_callback(att, tr, dmginfo)
            end
            
            if (tr.AltHitreg) then
                return
            end
            if (IsValid(tr.Entity) and tr.Entity:IsPlayer()) then
                wep:SetClip1(wep:Clip1() + 1)
            end
        end
    end
end