if SERVER then
    AddCSLuaFile()
end

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Shuriken"
local collided = false
local ent = self

function ENT:Initialize()
    self.Hits = 0
    self.TargetReached = false
    collided = false
    self.CollideCount = 0
    self.Drop = false
    self:SetModel("models/boomerang/boomerang.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
    	phys:SetMass(0.5)
    end
end

function ENT:PhysicsCollide(data, phys)
    if self.Drop then return end
    self.CollideCount = self.CollideCount + 1
    local hitEntity = data.HitEntity

    if hitEntity == self.Owner then
        local boomerang = self.Owner:Give("weapon_ttt_boomerang")

        if SERVER then
            timer.Simple(0, function() self:Remove() end)
        end
    end

    if IsValid(hitEntity) then
        if hitEntity:IsPlayer() then
            self.Hits = self.Hits + 2
        end

        self:EmitSound("weapons/crossbow/hitbod1.wav")
        local dmg = DamageInfo()
        dmg:SetAttacker(self.Owner)
        dmg:SetDamage(200)
        dmg:SetDamageForce(self:GetVelocity() * 100)
        --dmg:SetInflictor(self:GetNW2Entity("boomerang_swep"))
        dmg:SetDamageType(DMG_SLASH)
        dmg:SetDamagePosition(hitEntity:GetPos())
        hitEntity:TakeDamageInfo(dmg)
    end

    if not hitEntity:IsPlayer() and hitEntity:GetClass() ~= "prop_ragdoll" then
        self.Owner:SetNW2Entity("boomerang_swep", self)

        timer.Create("propTimer", 1, 1, function()
            deploySwep(self)
        end)

        self.Drop = true
    else
        self:SetAngles(Angle(20, 0, 90))
        self:NextThink(CurTime())
    end
end

function deploySwep(ent)
    --local ent = LocalPlayer():GetNW2Entity("boomerang_swep")
    local weapon = ents.Create("weapon_ttt_boomerang")
    weapon:SetPos(ent:GetPos())
    weapon:SetAngles(ent:GetAngles())
    weapon:SetVelocity(ent:GetVelocity())
    weapon:Spawn()
    weapon:Activate()
    weapon:SetModel("models/boomerang/boomerang.mdl")
    weapon.Hits = ent.Hits

    if SERVER then
        ent:Remove()
    end
end

function ENT:Think()
	if (CLIENT or self.Drop) then return end
    if self.Hits >= 4 then
        self:Remove()
    end

    local targetPos = self:GetNW2Vector("targetPos")
    local Pos = self:GetPos()
    local ownerPos = self.Owner:GetShootPos()

    --print("targetPos ", targetPos, " Pos ", Pos, " ownerPos ", ownerPos)
    if not self.TargetReached and (targetPos:Distance(Pos) < 500) then
        self:SetVelocity(Vector(0, 0, 0))
        --self:GetPhysicsObject():ApplyForceCenter(Vector(0,0,100))
        self:GetPhysicsObject():ApplyForceCenter(((ownerPos + Vector(0, 0, 70)) - Pos):GetNormalized() * 2000)
        --self:GetPhysicsObject():AddAngleVelocity(Vector(0,-100,0))
        --self:SetAngles(Angle(20,0,90))
        self.TargetReached = true
        --self:GetPhysicsObject():AddAngleVelocity(Vector(0,-100,0))
        --self:SetAngles(Angle(20,0,90))
        --self:GetPhysicsObject():AddAngleVelocity(Vector(0,-100,0))

        return
    elseif not self.TargetReached then
        self:GetPhysicsObject():ApplyForceCenter((targetPos - Pos):GetNormalized() * 1000)
    else
        self:GetPhysicsObject():ApplyForceCenter(((ownerPos) - Pos):GetNormalized() * 1000)
    end

    if (self.TargetReached and self:GetPos():Distance(self.Owner:GetPos()) < 150) then
        self.Owner:Give("weapon_ttt_boomerang")
        local boomerang = self.Owner:GetWeapon("weapon_ttt_boomerang")
        boomerang.Hits = self.Hits

        if SERVER then
            self:Remove()
        end
    end
end