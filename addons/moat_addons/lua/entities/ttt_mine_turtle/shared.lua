DEFINE_BASECLASS("ttt_mine_base")

ENT.Model = Model("models/props/de_tides/vending_turtle.mdl")

ENT.PreExplosionSound = Sound("")
ENT.ClickSound = Sound("weapons/mine_turtle/click.wav")
ENT.HelloSound = Sound("weapons/mine_turtle/hello.wav")
ENT.HelloTurtleSound = Sound("weapons/mine_turtle/hello_mine_turtle.wav")

ENT.ScanRadius = 100

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

		self:SetDefusable(false)
		self.Exploding = false
		self.HelloPlayed = false

		if SERVER then
			self:SendWarn(true)
		end

		timer.Simple(1.5, function()
			if IsValid(self) then
				self:SetDefusable(true)
				sound.Play(self.BeepSound, self:GetPos(), 65, 110, 0.7)
			end
		end)
	end
end

function ENT:UseOverride(activator)
	if (IsValid(self) and (!self.Exploding) and IsValid(activator) and activator:IsPlayer()) then
		local owner = self:GetPlacer()
		if ((self:IsActive() and owner == activator) or (!self:IsActive())) then
			-- check if the user already has a mine turtle
			if (activator:HasWeapon("weapon_ttt_mine_turtle")) then
				local weapon = activator:GetWeapon("weapon_ttt_mine_turtle")
				weapon:SetClip1(weapon:Clip1() + 1)
			else
				local weapon = activator:Give("weapon_ttt_mine_turtle")
				weapon:SetClip1(1)
			end

			-- remove the entity
			if activator:HasWeapon("weapon_ttt_mine_turtle") then
				if (self:GetPlacer() != activator) then
					activator:EmitSound(self.HelloTurtleSound)
				end
				self:Remove()
			else
				LANG.Msg(activator, "mine_turtle_full")
			end
		end
	end
end
