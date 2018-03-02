DEFINE_BASECLASS("ttt_slam_base")

CreateConVar("ttt_slam_beamsize", 2, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "How visible is the laser beam of the SLAM for innocents.")

function ENT:Initialize()
	if (IsValid(self)) then
		self:SetModel(self.Model)

		if SERVER then
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_NONE)
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

		self:SetDefusable(false)
		self.Exploding = false
		self:SetBodygroup(0, 1)

		local phys = self:GetPhysicsObject()
		if (IsValid(phys)) then
			phys:Wake()
			phys:EnableMotion(false)
		end

		if SERVER then
			self:SendWarn(true)
		end

		timer.Simple(1.5, function() if IsValid(self) then self:ActivateSLAM() end end)
	end
end
