ENT.Type = "anim"
ENT.PrintName = "Harpoon"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile("shared.lua")

    --[[---------------------------------------------------------

   Name: ENT:Initialize()

---------------------------------------------------------]]
    function ENT:Initialize()
        self:SetModel("models/props_junk/harpoon002a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
        self.Entity:SetSolid(SOLID_VPHYSICS)
        local phys = self.Entity:GetPhysicsObject()

        --self.NextThink = CurTime() +  1
        if (phys:IsValid()) then
            phys:Wake()
            phys:SetMass(10)
        end

        self.InFlight = true
        util.PrecacheSound("physics/metal/metal_grenade_impact_hard3.wav")
        util.PrecacheSound("physics/metal/metal_grenade_impact_hard2.wav")
        util.PrecacheSound("physics/metal/metal_grenade_impact_hard1.wav")
        util.PrecacheSound("physics/flesh/flesh_impact_bullet1.wav")
        util.PrecacheSound("physics/flesh/flesh_impact_bullet2.wav")
        util.PrecacheSound("physics/flesh/flesh_impact_bullet3.wav")
        self.Hit = {Sound("physics/metal/metal_grenade_impact_hard1.wav"), Sound("physics/metal/metal_grenade_impact_hard2.wav"), Sound("physics/metal/metal_grenade_impact_hard3.wav")}
        self.FleshHit = {Sound("physics/flesh/flesh_impact_bullet1.wav"), Sound("physics/flesh/flesh_impact_bullet2.wav"), Sound("physics/flesh/flesh_impact_bullet3.wav")}
        self:GetPhysicsObject():SetMass(2)
        self.Entity:SetUseType(SIMPLE_USE)
        self.CanTool = false
    end

    --[[---------------------------------------------------------

   Name: ENT:Think()

---------------------------------------------------------]]
    function ENT:Think()
        if not IsValid(self) or not IsValid(self.Entity) then return end
        self.lifetime = self.lifetime or CurTime() + 20

        if CurTime() > self.lifetime then
            self:Remove()
        end

        if self.InFlight and self.Entity:GetAngles().pitch <= 55 then
            self.Entity:GetPhysicsObject():AddAngleVelocity(Vector(0, 10, 0))
        end
    end

    --[[---------------------------------------------------------

   Name: ENT:Disable()

---------------------------------------------------------]]
    function ENT:Disable()
        self.PhysicsCollide = function() end
        self.lifetime = CurTime() + 30
        self.InFlight = false
        self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    end

    --[[---------------------------------------------------------

   Name: ENT:PhysicsCollided()

---------------------------------------------------------]]
    function ENT:PhysicsCollide(data, phys)
        local damager

        if IsValid(self.Owner) then
            damager = self.Owner
        else
            damager = self.Entity

            return
        end

        pain = (data.Speed / 4)

        local Ent = data.HitEntity
		if (not IsValid(Ent) or Ent:IsWorld()) then
			return
		end

        if Ent:IsWorld() and self.InFlight then
            if data.Speed > 500 then
                self:EmitSound(Sound("weapons/blades/impact.mp3"))
                self:SetPos(data.HitPos - data.HitNormal * 10)
                self:SetAngles(self.Entity:GetAngles())
                self:GetPhysicsObject():EnableMotion(false)
            else
                self:EmitSound(self.Hit[math.random(1, #self.Hit)])
            end

            self:Disable()
        elseif Ent.Health then
            if not (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then
                util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
                self:EmitSound(self.Hit[math.random(1, #self.Hit)])
                self:Disable()
            end

            if (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then
                local effectdata = EffectData()
                effectdata:SetStart(data.HitPos)
                effectdata:SetOrigin(data.HitPos)
                effectdata:SetScale(1)
                util.Effect("BloodImpact", effectdata)
                self:EmitSound(self.FleshHit[math.random(1, #self.Hit)])
                self:Disable()
                self.Entity:GetPhysicsObject():SetVelocity(data.OurOldVelocity / 4)
                Ent:TakeDamage(pain, damager, self.Entity)
            end
        end

		if (Ent:IsPlayer()) then
			self:Remove()
		end

        self.Entity:SetOwner(NUL)
    end

    --[[---------------------------------------------------------

   Name: ENT:Use()

---------------------------------------------------------]]
    function ENT:Use(activator, caller)
		if (activator:IsPlayer()) then
      		activator:Give("ttt_m9k_harpoon")
      		self.Entity:Remove()
        end
    end
end

if CLIENT then
    function ENT:Draw()
        self.Entity:DrawModel()
    end
end