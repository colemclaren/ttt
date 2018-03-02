-- weapon_vape_hallucinogenic.lua
-- Defines a vape which makes hallucinogenic effects on the user's screen

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Hallucinogenic Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nThis juice contains hallucinogens (don't worry, they're healthy and all-natural)"

SWEP.VapeAccentColor = Vector(0.5,1,0)
SWEP.VapeTankColor = Vector(-1,-1,-1)

SWEP.VapeID = 5

if CLIENT then
	hook.Add("RenderScreenspaceEffects","HallucinogenicVape",function()
		if (vapeHallucinogen or 0) > 0 then
			if vapeHallucinogen>100 then vapeHallucinogen=100 end
			local alpha = vapeHallucinogen/100
			DrawMotionBlur( 0.04, alpha, 0 )

			local tab = {}
			tab[ "$pp_colour_colour" ] =   1 + (alpha*0.25)
			tab[ "$pp_colour_contrast" ] = 1 + alpha
			tab[ "$pp_colour_brightness" ] = -0.1*alpha
			DrawColorModify(tab)

		end
	end)

	timer.Create("HallucinogenicVapeCounter",0.1,0,function()
		if (vapeHallucinogen or 0) > 0 then vapeHallucinogen = vapeHallucinogen-1 end
	end)
end