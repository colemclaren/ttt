DEFINE_BASECLASS("ttt_mine_base")

ENT.Model = Model("models/props_combine/combine_mine01.mdl")

ENT.BeepSound = Sound("npc/roller/mine/rmine_blades_out1.wav")



ENT.Warmup = 45
ENT.ActivationRadius = 225
ENT.DamageRadius = 280

local v32 = Vector(32, 32, 32)
local vn32 = Vector(-32, -32, -32)
function ENT:Initialize()
    self:SetModel(self.Model)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
	end
    self:SetSolid(SOLID_BBOX)
    self:SetCollisionBounds(vn32, v32)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self:SetDefusable(false)
	self.Dying = false
	self.Armed = false

	if SERVER then
		self:SendWarn(true)

        self:SetMaxHealth(50)
        local phys = self:GetPhysicsObject()

        if IsValid(phys) then
            phys:SetMass(200)
        end
    end

    self:SetHealth(50)
end
