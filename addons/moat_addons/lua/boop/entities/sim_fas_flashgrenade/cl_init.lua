include('shared.lua')

language.Add("ent_mad_flash", "Flash Grenade")

local FLASHTIMER = 5 // time in seconds, for the grenade to transition from full white to clear
local EFFECT_DELAY = 2 // time, in seconds when the effects still are going on, even when the whiteness of the flash is gone (set to -1 for no effects at all =]).

local Endflash, Endflash2

	/*---------------------------------------------------------
	   Name: ENT:Think()
	---------------------------------------------------------*/
	function ENT:Think()

		if self.Entity:GetDTBool(0) then
			local light = DynamicLight(self:EntIndex())

			if (light) then
				light.Pos = self.Entity:GetPos()
				light.r = 255
				light.g = 255
				light.b = 255
				light.Brightness = 4
				light.Size = 1000
				light.Decay = 1000
				light.DieTime = CurTime() + 0.5
			end
		end
	end

	/*---------------------------------------------------------
	   Name: ENT:Draw()
	---------------------------------------------------------*/
	function ENT:Draw()

		self.Entity:DrawModel()
	end

	/*---------------------------------------------------------
	   Name: ENT:IsTranslucent()
	---------------------------------------------------------*/
	function ENT:IsTranslucent()

		return true
	end
	
	function FlashEffect() if LocalPlayer():GetNetworkedFloat("FLASHED_END") > CurTime() then

		local pl 			= LocalPlayer()
		local FlashedEnd 		= pl:GetNetworkedFloat("FLASHED_END")
		local FlashedStart 	= pl:GetNetworkedFloat("FLASHED_START")
		
		local Alpha

		if(FlashedEnd - CurTime() > FLASHTIMER) then
			Alpha = 150
		else
			local FlashAlpha = 1 - (CurTime() - (FlashedEnd - FLASHTIMER)) / (FlashedEnd - (FlashedEnd - FLASHTIMER))
			Alpha = FlashAlpha * 150
		end
		
			surface.SetDrawColor(255, 255, 255, math.Round(Alpha))
			surface.DrawRect(0, 0, surface.ScreenWidth(), surface.ScreenHeight())
		end 
	end
	hook.Add("HUDPaint", "FlashEffect", FlashEffect)
	
		local function StunEffect()
		local pl 			= LocalPlayer()
		local FlashedEnd 		= pl:GetNetworkedFloat("FLASHED_END")
		local FlashedStart 	= pl:GetNetworkedFloat("FLASHED_START")
	
		if (FlashedEnd > CurTime() and FlashedEnd - EFFECT_DELAY - CurTime() <= FLASHTIMER) then
			local FlashAlpha = 1 - (CurTime() - (FlashedEnd - FLASHTIMER)) / (FLASHTIMER)
			DrawMotionBlur(0, FlashAlpha / ((FLASHTIMER + EFFECT_DELAY) / (FLASHTIMER * 4)), 0)
		elseif (FlashedEnd > CurTime()) then
			DrawMotionBlur(0, 0.01, 0)
		else
			DrawMotionBlur(0, 0, 0)
		end
	end
	hook.Add("RenderScreenspaceEffects", "StunEffect", StunEffect)