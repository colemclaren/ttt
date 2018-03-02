-- weapon_vape_dragon.lua
-- Defines a vape which emits fire

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Dragon's Breath Vape"

SWEP.Instructions = "LMB: Rip Flaming Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nThis juice is highly flammable! But don't worry, it's totally healthy."

SWEP.AdminOnly = true

SWEP.VapeScale = 1.7

SWEP.VapeVMPos1 = Vector(17,-3.2,-2.2)

SWEP.VapeVMPos2 = Vector(21,-7,-10)

SWEP.VapeID = 6

SWEP.SoundPitchMod = -40

SWEP.VapeAccentColor = Vector(1,0.3,0.1)
SWEP.VapeTankColor = Vector(1,0.6,0)