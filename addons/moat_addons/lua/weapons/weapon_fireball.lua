AddCSLuaFile()
SWEP.PrintName			= "Fireball"
SWEP.Author			    = "Mind"
SWEP.Instructions		= "Ignite it!"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Base         = "weapon_elementalbase"

SWEP.VElements = {
	["fire"] = { type = "Sprite", sprite = "sprites/flamelet2", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(-0.454, 1.19, -1.402), size = { x = 4.047, y = 7.139 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0.239, 0.079, -0.32), angle = Angle(0, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/effects/splode_sheet", skin = 0, bodygroup = {} },
	["fire+"] = { type = "Sprite", sprite = "sprites/flamelet5", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(-0.083, 0.875, -0.401), size = { x = 4.343, y = 4.796 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.WElements = {
	["ball"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.069, 2.607, -0.309), angle = Angle(-3.623, 127.172, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/effects/splode_sheet", skin = 0, bodygroup = {} },
	["fire"] = { type = "Sprite", sprite = "sprites/flamelet2", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.107, 2.796, -1.619), size = { x = 4.047, y = 7.139 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["fire+"] = { type = "Sprite", sprite = "sprites/flamelet5", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.567, 2.161, -0.816), size = { x = 4.343, y = 4.796 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
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

SWEP.Element = "fire"
SWEP.EntityClass = "fireball_ent"

SWEP.SoundNames = {
	sound1 = "ambient/fire/firebig.wav",
	sound2 = "ambient/fire/fire_med_loop1.wav",
	bong = "ambient/fire/mtov_flame2.wav"
}