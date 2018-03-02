SWEP.Author = "Silverlan"
SWEP.Contact = "Silverlan@gmx.de"
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.HoldType = "pistol"

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.ViewModel		= "models/weapons/v_pistol.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"
SWEP.AnimPrefix		= "python"

SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.AmmoPickup	= 32
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoSize = -1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.AmmoPickup	= 0
SWEP.PowerAttack = false
SWEP.Taunt = false

SWEP.Type = "1hm"
SWEP.Base = "ai_translator"

function SWEP:Initialize()
	self:SetNoDraw(true)
	self:DrawShadow(false)
	local data = SLVBase.GetDerivedAddon("Skyrim")
	self.m_itemData = data:GetItems()
	if(self.itemID) then
		local data = self.m_itemData[self.itemID]
		self.Type = data.holdType
	end
	if(SERVER) then self:InitSounds() end
end

function SWEP:Undeploy()
	if(self.EndAttack) then self:EndAttack() end
	self.Weapon:SetNextSecondaryFire(CurTime() +999)
	self.Weapon:SetNextPrimaryFire(CurTime() +999)
	if(self.OnHolster) then self:OnHolster() end
end

function SWEP:Equip(owner)
	self:SetNoDraw(true)
	self:DrawShadow(false)
	local fnext = CurTime() +self.DelayEquip
	self:SetNextPrimaryFire(fnext)
	self:SetNextSecondaryFire(fnext)
end

local acts = {
	["1hm"] = {
		[ACT_IDLE] = ACT_IDLE_ANGRY,
		[ACT_WALK] = ACT_WALK_RELAXED,
		[ACT_RUN] = ACT_RUN_RELAXED,
		[ACT_MELEE_ATTACK2] = ACT_MELEE_ATTACK2,
		[ACT_GESTURE_MELEE_ATTACK1] = ACT_GESTURE_MELEE_ATTACK1,
		[ACT_SIGNAL_ADVANCE] = ACT_SIGNAL_ADVANCE
	},
	["2gs"] = {
		[ACT_IDLE] = ACT_IDLE_AIM_RELAXED,
		[ACT_WALK] = ACT_WALK_AIM_RELAXED,
		[ACT_RUN] = ACT_RUN_AIM_RELAXED,
		[ACT_MELEE_ATTACK2] = ACT_GESTURE_MELEE_ATTACK2,
		[ACT_GESTURE_MELEE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK1_LOW,
		[ACT_SIGNAL_ADVANCE] = ACT_SIGNAL_FORWARD
	},
	["bow"] = {
		[ACT_IDLE] = ACT_IDLE_AIM_AGITATED,
		[ACT_WALK] = ACT_WALK_AIM_STIMULATED,
		[ACT_RUN] = ACT_RUN_AIM_STIMULATED
	},
	["2hm"] = {
		[ACT_IDLE] = ACT_COMBAT_IDLE,
		[ACT_WALK] = ACT_WALK_SCARED,
		[ACT_RUN] = ACT_RUN_SCARED,
		[ACT_MELEE_ATTACK2] = ACT_BUSY_LEAN_LEFT,
		[ACT_SIGNAL_ADVANCE] = ACT_SIGNAL_GROUP
	}
}

function SWEP:TranslateActivity(act)
	local itemID = self.itemID
	local data = self.m_itemData[itemID]
	local holdType = data.holdType
	if(holdType && acts[holdType] && acts[holdType][act]) then act = acts[holdType][act] end
	local owner = self:GetOwner()
	return IsValid(owner) && owner:TranslateActivity(act) || act
end

local gestures = {
	["1hm"] = {
		[ACT_ARM] = ACT_ARM,
		[ACT_DISARM] = ACT_DISARM,
		[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK1
	},
	["2gs"] = {
		[ACT_ARM] = ACT_VM_PULLBACK_HIGH,
		[ACT_DISARM] = ACT_VM_PULLBACK,
		[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK_SWING_GESTURE
	},
	["bow"] = {
		[ACT_ARM] = ACT_SLAM_STICKWALL_IDLE,
		[ACT_DISARM] = ACT_SLAM_STICKWALL_ND_IDLE
	},
	["2hm"] = {
		[ACT_ARM] = ACT_ITEM_DROP,
		[ACT_DISARM] = ACT_ITEM_THROW,
		[ACT_MELEE_ATTACK1] = ACT_DI_ALYX_ZOMBIE_MELEE
	}
}

function SWEP:TranslateGesture(act)
	local itemID = self.itemID
	local data = self.m_itemData[itemID]
	local holdType = data.holdType
	if(holdType && gestures[holdType] && gestures[holdType][act]) then act = gestures[holdType][act] end
	local owner = self:GetOwner()
	return IsValid(owner) && owner:TranslateGesture(act) || act
end

function SWEP:PrimaryAttack(pos,dir)
	if(CurTime() < self:GetNextPrimaryFire()) then return end
	self.Weapon:SetNextSecondaryFire(CurTime() +self.Primary.Delay)
	self.Weapon:SetNextPrimaryFire(CurTime() +self.Primary.Delay)
	self.Weapon:DoPrimaryAttack(pos,dir)
	self.Weapon:OnPrimaryAttack()
end

function SWEP:DoPrimaryAttack(pos,dir) end

function SWEP:OnPrimaryAttack() end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end