DEFINE_BASECLASS("ttt_slam_base")

AccessorFunc(ENT, "PlacedBy", "PlacedBy") -- used to decide, which weapon can detonate this entity

function ENT:Initialize()
	if (IsValid(self)) then
		self:SetModel(self.Model)

		if SERVER then
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
		end
		self:SetSolid(SOLID_BBOX)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		if SERVER then
			self:SetUseType(SIMPLE_USE)
			self:SetMaxHealth(10)
		end
		self:SetHealth(10)

		if (self:GetPlacer()) then
			if (!self:GetPlacer():IsActiveTraitor()) then
				self.Avoidable = false
			end
		else
			self:SetPlacer(nil)
		end

		self:SetDefusable(true)
		self.Exploding = false

		-- Even if the laser isn't used, change the bodygroup,
		-- so you're be able to see weather it is defused or not.
		self:SetBodygroup(0, 1)

		if SERVER then
			self:SendWarn(true)
		end
	end
end
