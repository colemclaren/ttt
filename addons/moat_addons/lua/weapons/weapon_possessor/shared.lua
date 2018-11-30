SWEP.PrintName = "Possessor"

SWEP.Author = "Silverlan"
SWEP.Contact = "Silverlan@gmx.de"
SWEP.Purpose = "Take control over a NPC"
SWEP.Instructions = "Aim at a NPC and use primary fire to possess it. Vanilla NPCs can not be possessed!"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/half-life/v_hgun.mdl"
SWEP.WorldModel = "models/weapons/half-life/w_hgun.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	if SERVER then
		self.Weapon:SetWeaponHoldType("ar2")
	end
end

function SWEP:Reload()
end

function SWEP:Think()
end

function SWEP:GetCapabilities()
	return false
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.2)
	if CLIENT then return end
	local pos = self.Owner:GetShootPos()
	local ang = self.Owner:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ang*8000)
	tracedata.filter = self.Owner
	local trace = util.TraceLine(tracedata) 
	if trace.Entity && IsValid( trace.Entity ) && trace.Entity:Health() > 0 then
		if !trace.Entity.bScripted || trace.Entity.DontPossess then
			self.Owner:ChatPrint("You can't possess this NPC!")
			return
		elseif trace.Entity.bControlled then
			self.Owner:ChatPrint("You can't possess this NPC, it's being controlled by someone else!")
			return
		elseif trace.Entity:IsPossessed() then
			self.Owner:ChatPrint("You can't possess this NPC, it's being possessed by someone else!")
			return
		end
		local entPossession = ents.Create("obj_possession_manager")
		entPossession:SetPossessor(self.Owner)
		entPossession:SetTarget(trace.Entity)
		entPossession:Spawn()
		entPossession:StartPossession()
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
end 

function SWEP:OnRemove( )
end
