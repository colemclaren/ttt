-- weapon_vape_mega.lua
-- Defines a big vape that makes massive clouds (admin only recommended)

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
	function SWEP:SecondaryAttack()
		if GetConVar("vape_block_sounds"):GetBool() then return end

		if (self.SecondaryAttackWait and self.SecondaryAttackWait > CurTime()) then return end
		self.SecondaryAttackWait = CurTime() + 5
		
		local pitch = 100 + (self.SoundPitchMod or 0) + (self.Owner:Crouching() and 40 or 0)
		local s = "vapegogreen.wav"
		if math.random() > 0.5 then s = "vapenaysh.wav" end
		self:EmitSound(s, 80, pitch + math.Rand(-5,5))
		if SERVER then
			net.Start("VapeTalking")
			net.WriteEntity(self.Owner)
			net.WriteFloat(CurTime() + (0.6*100/pitch))
			net.Broadcast()
		end
	end
end

SWEP.PrintName = "Mega Vape"

SWEP.Instructions = "LMB: Rip MASSIVE Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nOriginally developed for military use, this powerful vape quickly creates a large vape-screen ideal for concealment."

SWEP.AdminOnly = true

SWEP.VapeID = 2

SWEP.SoundPitchMod = -30

SWEP.VapeScale = 2.5

SWEP.VapeVMPos1 = Vector(15,-3,-1.5)

SWEP.VapeVMPos2 = Vector(18,-6,-9)

--HOT ROD VAPE
SWEP.VapeAccentColor = Vector(1,0,0.3)
SWEP.VapeTankColor = Vector(0.1,0.1,0.1)

function SWEP:PrimaryAttack()
	if SERVER then
		VapeUpdate(self.Owner, self.VapeID)
	end
	--Takes slightly longer to breathe
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.15)
end