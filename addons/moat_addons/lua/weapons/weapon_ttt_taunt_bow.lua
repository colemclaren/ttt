AddCSLuaFile()

SWEP.HoldType = "normal"
SWEP.PrintName = "Bow Taunt"

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
SWEP.TauntAnimation = ACT_GMOD_GESTURE_BOW
SWEP.TauntOver = CurTime()
SWEP.ViewAngles = Angle(0, 0, 0)

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
	local seq = self.Owner:SelectWeightedSequence(self.TauntAnimation)
	local len = self.Owner:SequenceDuration(seq)

	if SERVER then
		self.Owner:AnimRestartGesture(GESTURE_SLOT_GRENADE, self.TauntAnimation, true)
		self.TauntOver = CurTime() + len
		self:SetTauntActive(true)

		net.Start("MOAT_RESET_ANIMATION")
		net.WriteEntity(self.Owner)
		net.WriteUInt(2, 8)
		net.Broadcast()
	end
end

function SWEP:EndTaunt()
	if (not IsValid(self.Owner)) then return end

	self.Owner:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
	if (CLIENT) then return end
	
	self:SetTauntActive(false)

	net.Start("MOAT_RESET_ANIMATION")
	net.WriteEntity(self.Owner)
	net.WriteUInt(0, 8)
	net.Broadcast()
end

function SWEP:PrimaryAttack()
	if (self:GetNextPrimaryFire() > CurTime() or not IsFirstTimePredicted() or self:GetTauntActive()) then return end

	self:SetNextPrimaryFire(CurTime() + 1)

	if (CLIENT) then
		self.CurrentCamera = 0
	end

	self:InitializeTaunt()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
	if (SERVER and self:GetTauntActive()) then
		local own = self.Owner

		if (self.TauntOver < CurTime()) then
			self:EndTaunt()

			return
		end

		if (own:MoveKeysDown()) then
			self:EndTaunt()

			return
		end
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

function SWEP:OnRemove()
	if (self:GetTauntActive()) then
		self:EndTaunt()
	end
end