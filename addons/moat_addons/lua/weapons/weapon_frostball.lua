AddCSLuaFile()
SWEP.PrintName			= "Glacies"			
SWEP.Author			    = "Mind"
SWEP.Instructions		= "Freeze it!"
SWEP.Base         = "weapon_elementalbase"

SWEP.VElements = {
	["frost"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.239, 0.079, -0.32), size = { x = 5, y = 5 }, color = Color(185,201,255,255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.239, 0.079, -0.32), angle = Angle(0, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(197,227,255,255), surpresslightning = false, material = "ice/ice1", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.069, 2.607, -0.309), angle = Angle(-3.623, 127.172, 0), size = Vector(0.218, 0.218, 0.218), color = Color(197,227,255,255), surpresslightning = false, material = "ice/ice1", skin = 0, bodygroup = {} },
	["frost"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.069, 2.607, -0.309), size = { x = 5, y = 5 }, color = Color(185,201,255,255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 7.777, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.444, 5.556, -7.778) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, -7.778, -1.111) },
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12.223, 16.666, -25.556) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 63.333) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-18.889, -34.445, -32.223) }
}

SWEP.BongPitch = 55
SWEP.EntityClass = "frostball_ent"

function SWEP:GetSound(name)
	if (name == "bong") then
		return "physics/glass/glass_strain"..math.random(1,4)..".wav"
	end
	return self.SoundNames[name]
end

if CLIENT then
	SWEP.ang = 0
	SWEP.ang2 = 0
	SWEP.ran1 = 0
end

SWEP.time = 0
SWEP.snd = 0

function SWEP:Think()
	local canthrow = self:CanThrow()
	local owner = self:GetOwner()
	if owner:KeyReleased(IN_ATTACK) then 
		self:SetHoldTime(0)
		if (canthrow) then
			self:Bong()
		end
	end

	if SERVER then return end

	self.ang2 = math.Approach(self.ang2, 4, 0.72)

	if owner:KeyDown(IN_ATTACK) then
		self.ang2 = math.Approach(self.ang2, 25, 1)

		if CurTime() > self.snd then self.snd = CurTime() + 0.8 self:EmitSound("weapons/ice/icefr.wav") end
	end

	self.ang = self.ang + self.ang2
	self.VElements["ball"].angle.yaw = self.ang
	self.WElements["ball"].angle.yaw = self.ang

	if CLIENT then

		self.ran1 = math.Rand(5,6)	
	
		if owner:KeyDown(IN_ATTACK) then 
			self.ran1 = math.Rand(7,10)
		end

		self.VElements["frost"].size = Vector(self.ran1, self.ran1, 0)
		self.WElements["frost"].size = Vector(self.ran1, self.ran1, 0)
	end
end