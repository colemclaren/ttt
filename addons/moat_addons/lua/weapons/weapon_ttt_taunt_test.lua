AddCSLuaFile()

SWEP.HoldType = "normal"
SWEP.PrintName = "Testing Taunt"

if CLIENT then
   SWEP.Slot      = 5
   SWEP.Icon = "moat_inv/moat_taunt.png"

   SWEP.ViewModelFOV = 0
end

SWEP.Base = "weapon_tttbase"
SWEP.ViewModel  = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.CurrentCamera = 0
SWEP.AnimationSpeed = 10
SWEP.TauntAnimationOver = false
SWEP.TauntTable = {
	["ValveBiped.Bip01_Spine"] = {Angle(0, -90, 0), Angle(0, 0, 0)},
	["ValveBiped.Bip01_R_Forearm"] = {Angle(0, -90, -20), Angle(0, 0, 0)},
	["ValveBiped.Bip01_R_UpperArm"] = {Angle(40, -80, -45), Angle(0, 0, 0)},
	["ValveBiped.Bip01_Head1"] = {Angle(0, -45, -15), Angle(0, 0, 0)},
	["ValveBiped.Bip01_L_UpperArm"] = {Angle(-100, 0, 0), Angle(0, 0, 0)}
}

SWEP.Kind = WEAPON_UNARMED
SWEP.AllowDelete = false
SWEP.AllowDrop = false

SWEP.NoSights = true

function SWEP:GetClass()
   return "weapon_ttt_unarmed"
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "TauntActive")
	self:SetTauntActive(false)
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:ShouldDropOnDie()
   return false
end

function SWEP:InitializeTaunt()
	if SERVER then
		self.TauntReady = CurTime() + 0.5
		self.TauntAnimationOver = false
		self:SetTauntActive(true)
	end
end

function SWEP:EndTaunt()
	if (not IsValid(self.Owner)) then return end

	self:SetTauntActive(false)

	for k, v in pairs(self.TauntTable) do
		local b = self.Owner:LookupBone(k)
		self.Owner:ManipulateBoneAngles(b, Angle(0, 0, 0))
	end
end

function SWEP:PrimaryAttack()
	if (self:GetNextPrimaryFire() > CurTime() or not IsFirstTimePredicted() or self:GetTauntActive()) then return end

	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	if (CLIENT) then
		self.CurrentCamera = 0
	end
	self.AnimationSpeed = 10
	self:InitializeTaunt()
end

function SWEP:SecondaryAttack()
	if (self:GetNextSecondaryFire() > CurTime() or not IsFirstTimePredicted() or self:GetTauntActive()) then return end

	self:SetNextSecondaryFire(CurTime() + 1)
	self:SetNextPrimaryFire(CurTime() + 1)

	if (CLIENT) then
		self.CurrentCamera = 0
	end
	self.AnimationSpeed = 30
	self:InitializeTaunt()
end

function SWEP:Reload()
end

function SWEP:Think()
	if (not SERVER) then return end
	if (self:GetTauntActive() and self.TauntReady <= CurTime()) then
		for k, v in pairs(self.TauntTable) do
			local b = self.Owner:LookupBone(k)

			if (self.TauntAnimationOver) then
				v[2] = LerpAngle(FrameTime() * self.AnimationSpeed, v[2], Angle(0, 0, 0))

				if (math.abs(math.AngleDifference(v[2].p, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].y, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].r, 0)) > 0.1) then
					self.Owner:ManipulateBoneAngles(b, v[2])
				else
					self:EndTaunt()
				end
			else
				v[2] = LerpAngle(FrameTime() * self.AnimationSpeed, v[2], v[1])

				if (math.abs(math.AngleDifference(v[2].p, v[1].p)) > 0.1 or math.abs(math.AngleDifference(v[2].y, v[1].y)) > 0.1 or math.abs(math.AngleDifference(v[2].r, v[1].r)) > 0.1) then
					self.Owner:ManipulateBoneAngles(b, v[2])
				else
					self.TauntAnimationOver = true
				end
			end
		end
	end

	local own = self.Owner

	if (self:GetTauntActive() and own:KeyDown(IN_BACK) or own:KeyDown(IN_DUCK) or own:KeyDown(IN_FORWARD) or own:KeyDown(IN_JUMP) or own:KeyDown(IN_MOVELEFT) or own:KeyDown(IN_MOVERIGHT) or own:KeyDown(IN_RELOAD) or own:KeyDown(IN_WALK) or own:KeyDown(IN_USE)) then
		self:EndTaunt()

		return
	end
end

function SWEP:Deploy()
   if SERVER and IsValid(self.Owner) then
      self.Owner:DrawViewModel(false)
   end
   return true
end

function SWEP:Holster()
	if (self:GetTauntActive()) then
		self:EndTaunt()
	end

    return true
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:CalcView(ply, pos, ang, fov)
    if (self:GetTauntActive()) then
    	local calc = {}

    	self.CurrentCamera = Lerp(FrameTime() * 5, self.CurrentCamera, 100)

    	local extra_vec = pos - (ang:Forward() * self.CurrentCamera)

    	local tr = util.TraceLine({
			start = pos,
			endpos = extra_vec,
			filter = ply
		})

    	if (tr.Hit) then
    		extra_vec = tr.HitPos + (ang:Forward() * 10)
    	end

    	calc.origin = extra_vec
    	calc.angles = ang
    	calc.fov = fov

    	return calc.origin, calc.angles, calc.fov, true
    end
end