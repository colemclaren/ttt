TALENT.ID = 10102
TALENT.Name = "Laser"
TALENT.NameColor = Color(255, 119, 0)
TALENT.Description = "LASERS"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 1, max = 1}
TALENT.Modifications = {}
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.Collection = "Summer Climb Collection"

function TALENT:ModifyWeapon(weapon, talent_mods)
    net.Start "apply_tracer"
        net.WriteUInt(weapon:GetEntityID(), 32)
        net.WriteString "paintball"
    net.Broadcast()
end