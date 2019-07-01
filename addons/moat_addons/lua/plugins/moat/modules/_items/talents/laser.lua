TALENT.ID = 10102
TALENT.Name = "Energizing"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Damage is increased by %s_^ for each consecutive hit, up to a maximum of %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 8, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 4, max = 8 } -- Every shot hit increases
TALENT.Modifications[2] = { min = 35, max = 45 } -- Maximum
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Summer Climb Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
    weapon:ApplyTracer "laser"
    net.Start "apply_tracer"
        net.WriteUInt(weapon:GetEntityID(), 32)
        net.WriteString "laser"
    net.Broadcast()
end

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end

    local Increase = (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1]) / 100
    local Maximum = (self.Modifications[2].min + (self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]) / 100

    wep.BaseDamage = wep.BaseDamage or wep.Primary.Damage

    local pellets_per_shot = wep.Primary.ReverseShotsDamage and wep.Primary.Damage or wep.Primary.NumShots or 1

    if (wep.Energizer_PelletsHit and (wep.Energizer_PelletsHit + wep.Energizer_PelletsHitAHR) / pellets_per_shot < 0.5) then
        wep.Primary.Damage = wep.BaseDamage
        wep.EnergizerStacks = 0
    end

    wep.Energizer_PelletsHit = 0
    wep.Energizer_PelletsHitAHR = 0
    local cb = dmginfo.Callback
	dmginfo.Callback = function(att, tr, dmginfo)
        if (IsValid(tr.Entity)) then
            if (tr.AltHitreg) then
                wep.Energizer_PelletsHitAHR = wep.Energizer_PelletsHitAHR + 1
            else
                wep.Energizer_PelletsHit = wep.Energizer_PelletsHit + 1
            end

            if ((wep.Energizer_PelletsHit + wep.Energizer_PelletsHitAHR) / pellets_per_shot >= 0.5) then
                wep.EnergizerStacks = (wep.EnergizerStacks or 0) + 1
                wep.Primary.Damage = wep.BaseDamage * (1 + math.min(Maximum, wep.EnergizerStacks * Increase))
            end
        end
        if (cb) then
            return cb(att, tr, dmginfo)
        end
	end
end