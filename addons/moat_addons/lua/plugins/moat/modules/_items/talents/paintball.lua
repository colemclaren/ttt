TALENT.ID = 10103
TALENT.Name = "Paintballs"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "Removes all body part multipliers. Increases damage by %s_^"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 8, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = { min = -5, max = 5 } -- Every shot hit increases
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Summer Climb Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
    weapon:ApplyTracer "paintball"
    net.Start "apply_tracer"
        net.WriteUInt(weapon:GetEntityID(), 32)
        net.WriteString "paintball"
    net.Broadcast()

    function weapon:ScaleDamage()
    end
    function weapon:GetHeadshotMultiplier()
        return 1
    end

    weapon.Primary.Damage = weapon.Primary.Damage * (1 + (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1]) / 100)
end