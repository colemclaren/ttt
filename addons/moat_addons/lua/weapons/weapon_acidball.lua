AddCSLuaFile()
SWEP.PrintName			= "Contagio"
SWEP.Author			    = "Mind"
SWEP.Instructions		= "Destroy it!"
SWEP.Base         = "weapon_elementalbase"
SWEP.ViewModel = "models/weapons/v_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.VElements = {
	["acid"] = { type = "Sprite", sprite = "effects/splash3", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(1.544, 1.705, -3.240), size = { x = 3.194, y = 7.973 }, color = Color(0, 200, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.239, 0.079, -0.32), angle = Angle(0, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255,255,255,255), surpresslightning = false, material = "acid/acid1", skin = 0, bodygroup = {} },
	["acid+"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.239, 0.079, -0.32), size = { x = 3, y = 3}, color = Color(0, 200, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.WElements = {
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.069, 2.607, -0.309), angle = Angle(-3.623, 127.172, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255,255,255,255), surpresslightning = false, material = "acid/acid1", skin = 0, bodygroup = {} },
	["acid+"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.069, 2.607, -0.309), size = { x = 3, y = 3 }, color = Color(0, 200, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.SoundNames = {
	sound1 = "ambient/water/water_flow_loop1.wav",
	sound2 = "ambient/water/leak_1.wav"
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

SWEP.Element = "acid"
SWEP.EntityClass = "acidball_ent"
SWEP.BongPitch = 400

function SWEP:GetSound(name)
	if (name == "bong") then
		return "ambient/water/water_splash"..math.random(1,3)..".wav"
	end
	return self.SoundNames[name]
end