
if (SERVER) then
	util.AddNetworkString("Moat.Talents.Notify")

	util.AddNetworkString("Moat.Talents.Mark")
	util.AddNetworkString("Moat.Talents.Mark.End")

	util.AddNetworkString("Moat.Talents.Visionary")
	util.AddNetworkString("Moat.Talents.Visionary.End")

else
	-- Global
	local mat = CreateMaterial("Moat.Talents.Mat", "VertexLitGeneric", {["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$ignorez"] = 1})
	
	function Moat_Talents_PreDrawHalos()
		Moat_Talents_MarkHalo()
		Moat_Talents_VisionaryHalo()
	end
	
	function Moat_Talents_RenderScreenspaceEffects()
		Moat_Talents_MarkChams()
		Moat_Talents_VisionaryChams()
	end
	
	-- Notify
	local tal_cols = {
		Color(178, 102, 255, 255),
		Color(0, 255, 128, 255)
	}
	
	net.Receive("Moat.Talents.Notify", function()
		local col = tal_cols[net.ReadUInt(8)] or Color(0, 255, 255, 255)
		local str = net.ReadString()

		chat.AddText(Material("icon16/accept.png"), col, str)
	end)
	
	-- Mark
	local markedPlayers = {}
	
	net.Receive("Moat.Talents.Mark", function()
		local vic = net.ReadEntity()
		if (not IsValid(vic)) then return end
		if (vic == LocalPlayer()) then return end
		
		local color = net.ReadColor()
		if (not color) then
			color = Color(0, 255, 0)
		end
		
		markedPlayers[vic] = color
	end)
	
	net.Receive("Moat.Talents.Mark.End", function()
		local vic = net.ReadEntity()
		if (not IsValid(vic)) then return end
		if (vic == LocalPlayer()) then return end
		
		markedPlayers[vic] = nil
	end)
	
	function Moat_Talents_MarkHalo()
		local colors = {}

		for vic, color in pairs(markedPlayers) do
			if (not IsValid(vic) or vic:Team() == TEAM_SPEC) then
				markedPlayers[vic] = nil
				continue 
			end

			if (not colors[color]) then
				colors[color] = {}
			end

			table.insert(colors[color], vic)
		end

		for color, players in pairs(colors) do
			halo.Add(players, color, 2, 2, 1, true, true)
		end
	end
	
	local function complementColor(color, add)
		return color + add <= 255 and color + add or color + add - 255
	end
	
	function Moat_Talents_MarkChams()
		cam.Start3D()
			for vic, color in pairs(markedPlayers) do
				if (not IsValid(vic) or vic:Team() == TEAM_SPEC) then
					markedPlayers[vic] = nil
					continue 
				end
				
				local modColor = Color(color.r / 255, color.g / 255, color.b / 255)

				render.SuppressEngineLighting(true)

				render.SetColorModulation(modColor.r, modColor.g, modColor.b)
				render.MaterialOverride(mat)
				vic:DrawModel()

				if (IsValid(vic:GetActiveWeapon())) then
					render.SetColorModulation(complementColor(color.r, 150) / 255, complementColor(color.g, 150) / 255, complementColor(color.b, 150) / 255)
					vic:GetActiveWeapon():DrawModel()
				end
				
				render.SetColorModulation(modColor.r, modColor.g, modColor.b)
				render.MaterialOverride()
				render.SetModelLighting(BOX_TOP, modColor.r, modColor.g, modColor.b)
				vic:DrawModel()

				render.SuppressEngineLighting(false)
			end
		cam.End3D()
	end
	
	
	-- Visionary
	local vision_col = Color(255, 255, 0)
	local vision_col_mod = Color(vision_col.r / 255, vision_col.g / 255, vision_col.b / 255)
	local vision_dist = false
	
	net.Receive("Moat.Talents.Visionary", function()
		local f = net.ReadDouble() * 25
		
		vision_dist = f * f
	end)
	
	net.Receive("Moat.Talents.Visionary.End", function()
		vision_dist = false
	end)
	
	function Moat_Talents_VisionaryHalo()
		if (not vision_dist) then return end

		local localPos = LocalPlayer():GetPos()
		local visn = {}

		for k, v in pairs(player.GetAll()) do
			if (not IsValid(v) or v:Team() == TEAM_SPEC) then continue end
			if (LocalPlayer():IsTraitor() and v:IsTraitor()) then continue end
			if (v:GetPos():DistToSqr(localPos) > vision_dist) then continue end

			table.insert(visn, v)
		end

		halo.Add(visn, vision_col, 2, 2, 1, true, true)
	end
	
	function Moat_Talents_VisionaryChams()
		if (not vision_dist) then return end
		local localPos = LocalPlayer():GetPos()

		cam.Start3D()
			for k, v in pairs(player.GetAll()) do
				if (not IsValid(v) or v:Team() == TEAM_SPEC) then continue end
				if (LocalPlayer():IsTraitor() and v:IsTraitor()) then continue end
				if (v:GetPos():DistToSqr(localPos) > vision_dist) then continue end

				render.SuppressEngineLighting(true)

				render.SetColorModulation(vision_col_mod.r, vision_col_mod.g, vision_col_mod.b)
				render.MaterialOverride(mat)
				v:DrawModel()

				if (IsValid(v:GetActiveWeapon())) then
					render.SetColorModulation(complementColor(vision_col.r, 150) / 255, complementColor(vision_col.g, 150) / 255, complementColor(vision_col.b, 150) / 255)
					v:GetActiveWeapon():DrawModel()
				end
				
				render.SetColorModulation(vision_col_mod.r, vision_col_mod.g, vision_col_mod.b)
				render.MaterialOverride()
				render.SetModelLighting(BOX_TOP, vision_col_mod.r, vision_col_mod.g, vision_col_mod.b)
				v:DrawModel()

				render.SuppressEngineLighting(false)
			end
		cam.End3D()
	end
end

local HermesBootsSpeed, HermesBoots = 1.2
hook.Add("TTTPlayerSpeedModifier", "moat_ApplyWeaponWeight", function(pl, shit, mv)
	if (not IsValid(pl)) then
		return
	end

	local wep = pl:GetActiveWeapon()
	if (IsValid(wep) and wep.weight_mod and wep.weight_mod ~= 1) then
		shit.mul = shit.mul + (1 - wep.weight_mod)
	end

	if (pl:GetNW2Float("Marathon Runner", 1) > 1) then
		shit.mul = shit.mul * pl:GetNW2Float("Marathon Runner", 1)
	end

	if (pl:GetNW2Float("Frozen Speed", 0) > 0) then
		shit.mul = shit.mul * (1 - pl:GetNW2Float("Frozen Speed", 0))
	end

	if (pl:GetNW2Float("Speed Talent", 1) > 1) then
		shit.mul = shit.mul * pl:GetNW2Float("Speed Talent", 1)
	end

	if (pl:GetNW2Float("Speed Modifier", 1) > 1) then
		shit.mul = shit.mul * pl:GetNW2Float("Speed Modifier", 1)
	end

	if (EQUIP_HERMES_BOOTS and pl:HasEquipmentItem(EQUIP_HERMES_BOOTS)) then
		if (CLIENT and HermesBoots == nil) then
			HermesBoots = GetConVar("moat_hermes_boots")
		elseif (SERVER) then
			HermesBoots = pl:GetInfo("moat_hermes_boots")
			if (not HermesBoots or not tonumber(HermesBoots)) then
				HermesBoots = 1
			else
				HermesBoots = tonumber(HermesBoots)
			end
		end

		if (CLIENT and HermesBoots and HermesBoots:GetInt() >= 1) then
			shit.mul = shit.mul * HermesBootsSpeed
		elseif (SERVER and HermesBoots and HermesBoots >= 1) then
			shit.mul = shit.mul * HermesBootsSpeed
		end
	end

	if (not pl:IsActiveTraitor()) then
		if (GetGlobalString("cur_random_round", "") == "Inverted") then 
        	mv:SetForwardSpeed(mv:GetForwardSpeed() * -1)
        	mv:SetSideSpeed(mv:GetSideSpeed() * -1)
    	elseif (GetGlobalString("cur_random_round", "") == "Crab") then
        	mv:SetForwardSpeed(0)
		end
	end
	
	if (GetGlobalString("cur_random_round", "") == "Fast") then
		shit.mul = shit.mul * 3
	end

	shit.mul = math.Round(shit.mul, 5)
end)