-- weapon_vape_american.lua
-- Defines a vape which emits red, white, and blue clouds and plays Donald Trump sounds

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "American Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB: Bing Bong\nReload: MAGA\n\nA patriotic vape made in honor of President Trump."

SWEP.VapeID = 7
SWEP.VapeAccentColor = Vector(0.5,0.5,0.5)

--tells the matproxy to substitute red/white/blue fader (todo: change how this works)
SWEP.VapeTankColor = Vector(-2,-2,-2)

function SWEP:SecondaryAttack()
	--this makes it so the "bing bong" sounds the same to everyone instead of the owner hearing a different noise due to randomness
	if CLIENT then return else SuppressHostEvents(NULL) end

	if (self.SecondaryAttackWait and self.SecondaryAttackWait > CurTime()) then return end
	self.SecondaryAttackWait = CurTime() + 5

	if GetConVar("vape_block_sounds"):GetBool() then return end
	
	local pitch = 100 + (self.SoundPitchMod or 0) + (self.Owner:Crouching() and 40 or 0)
	self:EmitSound("vapebing"..tostring(math.random(1,2))..".wav", 80, pitch + math.Rand(-25,25))
	if SERVER then
		net.Start("VapeTalking")
		net.WriteEntity(self.Owner)
		net.WriteFloat(CurTime() + (0.9*100/pitch))
		net.Broadcast()
	end
end

function SWEP:Reload()
	if GetConVar("vape_block_sounds"):GetBool() then return end

	if (self.SecondaryAttackWait and self.SecondaryAttackWait > CurTime()) then return end
	self.SecondaryAttackWait = CurTime() + 5
	
	if self.reloading then return end
	self.reloading=true
	timer.Simple(0.5, function() self.reloading=false end)

	local pitch = 100 + (self.SoundPitchMod or 0) + (self.Owner:Crouching() and 40 or 0)
	self:EmitSound("vapemaga.wav", 80, pitch + math.Rand(-5,5))
	if SERVER then
		net.Start("VapeTalking")
		net.WriteEntity(self.Owner)
		net.WriteFloat(CurTime() + (2.2*100/pitch))
		net.Broadcast()
	end
end