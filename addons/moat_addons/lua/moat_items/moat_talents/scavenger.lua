TALENT.ID = 82
TALENT.Name = "Scavenger"
TALENT.NameColor = Color(178, 102, 255)
TALENT.Description = "Players have a %s_^ chance to drop %s primary ammo (or until filled) if killed with this weapon"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 50}
TALENT.Modifications[2] = {min = 5, max = 30}
TALENT.Melee = false
TALENT.NotUnique = true

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local random_num = math.Rand(1, 100)
    local apply_mod = chance > random_num

    if (apply_mod) then
    	local ammo = math.Round(self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]))
        local ammo_class = inf.AmmoEnt or "item_ammo_smg1_ttt"
        local ammo_pos = vic:GetPos()
        local ammo_ent = ents.Create(ammo_class)
        if (IsValid(ammo_ent)) then
            ammo_pos.z = ammo_pos.z + 5
            ammo_ent.AmmoAmount = ammo
            ammo_ent:SetPos(ammo_pos)
            ammo_ent:SetAngles(VectorRand():Angle())
            ammo_ent:Spawn()
            ammo_ent:PhysWake()

            net.Start("Moat.Talents.Notify")
            net.WriteUInt(1, 8)
            net.WriteString("Scavenger activated on kill!")
            net.Send(att)
        end
    end
end