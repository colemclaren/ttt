-- weapon_vape_golden.lua
-- Defines a vape with gold accent and shaded tank

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Golden Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nAn elegant, golden vape for the classy cloud chaser."

SWEP.VapeAccentColor = Vector(1,0.8,0)
SWEP.VapeTankColor = Vector(0.1,0.1,0.1)