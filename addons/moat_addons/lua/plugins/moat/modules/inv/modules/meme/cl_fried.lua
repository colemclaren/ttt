local FriedLocalPlayer, FriedPlayers, FriedScreen = CurTime(), {Count = 0, Delete = {}}, {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.06,
	["$pp_colour_contrast"] = 0.99,
	["$pp_colour_colour"] = 3.14,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

net.ReceivePlayer("Moat.Talents.DeepFried", function(pl)
	local t = net.ReadDouble()
	print(pl, t)
	if (IsValid(LocalPlayer()) and pl == LocalPlayer()) then
		FriedLocalPlayer = FriedLocalPlayer > CurTime() and FriedLocalPlayer + t or CurTime() + t

		return
	end

	for i = 1, FriedPlayers.Count do
		if (pl == FriedPlayers[i].Player) then
			FriedPlayers[i].Time = FriedPlayers[i].Time + t

			return
		end
	end

	local now = CurTime()

	table.insert(FriedPlayers, {Player = pl, Time = CurTime() + t, Start = now})
	FriedPlayers.Count = FriedPlayers.Count + 1

	cdn.PlayURL("https://cdn.moat.gg/f/deepfried.mp3", 0, function(s)
		for k, v in ipairs(FriedPlayers) do
			if (v.Start == now) then FriedPlayers[k].Sound = s end
		end
	end, "3d noplay")

	PrintTable(FriedPlayers)
end)

hook("RenderScreenspaceEffects", function()
	if (FriedLocalPlayer < CurTime()) then
		return
	end

	DrawSharpen(3.49, 5)
	DrawSobel(0.68)
	DrawColorModify(FriedScreen)
	DrawMaterialOverlay("models/props_lab/tank_glass001", .3)
end)

local debugwhite = Material "models/debug/debugwhite"
hook("PostDrawOpaqueRenderables", function()
	if (FriedPlayers.Count == 0) then
		return
	end

	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()

	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)

		cam.Start3D(EyePos(), EyeAngles())

			for i = 1, FriedPlayers.Count do
				local fry = FriedPlayers[i]

				-- the count is off somehow
				if (not fry) then
					FriedPlayers.Count = #FriedPlayers

					continue
				end

				-- mark index for removal
				if (fry.Time < CurTime() or not IsValid(fry.Player) or not fry.Player:IsActive()) then
					table.insert(FriedPlayers.Delete, i)

					if (IsValid(fry.Sound)) then
						fry.Sound:Stop()
					end

					continue
				end
				
				local x = ((fry.Time - CurTime())/(fry.Time - fry.Start))

				render.SetBlend(1 - (.6 * x))
				render.SetColorModulation(0.2 + (0.8 * x), 0.1 + (0.7 * x), 0.35 * x)
				render.MaterialOverride(debugwhite)

				fry.Player:DrawModel()

				if (IsValid(fry.Sound)) then
					fry.Sound:SetPos(fry.Player:GetPos())

					if (fry.Sound:GetState() ~= GMOD_CHANNEL_PLAYING) then
						fry.Sound:SetVolume(1)
						fry.Sound:Play()
					end
				end
			end

			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			render.MaterialOverride()

		cam.End3D()

	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilEnable(false)

	for k, v in ipairs(FriedPlayers.Delete) do
		table.remove(FriedPlayers, v)
		FriedPlayers.Count = math.max(FriedPlayers.Count - 1, 0)
	end

	FriedPlayers.Delete = {}
end)