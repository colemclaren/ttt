AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')
local sndBreak = Sound("Watermelon.BulletImpact")

function ENT:Initialize()
    self:SetModel("models/weapons/w_chickeneggnade_thrown.mdl")
    -- Initiate  physics
    local mins = Vector(-4, -4, -7)
    local maxs = Vector(4, 4, 7)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetCollisionBounds(mins, maxs)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.Spawning = false
end

function ENT:BreakEffects(pos, norm)
    norm = norm or Vector(0, 0, 1)
    local fx = EffectData()
    fx:SetOrigin(pos)
    fx:SetNormal(norm)
    util.Effect("egg_break", fx)
    self:EmitSound(sndBreak)
end

function ENT:PhysicsCollide(data)
    timer.Simple(0.05, function()
        if (not IsValid(self) or self.Spawning) then return end
        self.Spawning = true

        local pos = data.HitPos
        local norm = data.HitNormal
        pos = pos + 4 * data.HitNormal
        -- Play an effect
		if (self.BreakEffects) then
			self:BreakEffects(pos, norm)
		end
        -- Spawn the chicken
        local chicken = ents.Create("ttt_chicken")
        chicken:SetPos(pos)
        chicken:Spawn()
        chicken:Activate()
        -- Set its owner
        local owner = self:GetOwner()

        if not owner:IsValid() then
            owner = chicken
        end

        chicken:SetAttacker(owner)
        -- Kill yourself
        self:Remove()
    end)
end