TALENT.ID = 990
TALENT.Name = "Snowball"
TALENT.NameColor = Color(100, 255, 255)
TALENT.Description = "Each shot has a %s_^ chance to shoot a snowball projectile dealing %s damage"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 5, max = 20}
TALENT.Modifications[2] = {min = 10, max = 55}
TALENT.Melee = false
TALENT.NotUnique = false

function TALENT:OnWeaponFired(attacker, dmginfo, talent_mods, is_bow, hit_pos)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local random_num = math.Rand(1, 100)
    local apply_mod = chance > random_num

    if (apply_mod) then
        local ply = dmginfo.Attacker

    	local dmg = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
        local Front = ply:GetAimVector();
	    local Up = ply:EyeAngles():Up();
        local ball = ents.Create("ent_snowball");

        if IsValid(ball) then

            ball:SetPos(ply:GetShootPos() + Front * 10 + Up * 10 * -1)
            ball:SetAngles(Front:Angle())
            ball.Harmless = false
            ball.Damage = dmg
            ball:Spawn()
            ball:Activate()
            ball:SetOwner(ply)

            local Physics = ball:GetPhysicsObject()
            if IsValid(Physics) then
                Physics:ApplyForceCenter(Front:Angle():Forward() * 25000)
            end
        end

        return true
    end
end