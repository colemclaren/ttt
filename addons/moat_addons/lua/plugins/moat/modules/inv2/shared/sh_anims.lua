if (SERVER) then 
	util.AddNetworkString("moat_OpenInventory")
	util.AddNetworkString("moat_InventoryCatChange")
	util.AddNetworkString("MOAT_RESET_ANIMATION")

	function moat_StartInventoryOpenAntimationStart(ply)
		net.Start("moat_OpenInventory")
		net.WriteEntity(ply)
		net.WriteBool(true)
		net.Broadcast()

		if (not ply:IsValid() or ply:Team() == TEAM_SPEC) then return end

		local bones = {
			["ValveBiped.Bip01_R_Forearm"] = {Angle(0, -90, -20), Angle(0, 0, 0)},
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(40, -40, -45), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Head1"] = {Angle(0, -45, -15), Angle(0, 0, 0)}
		}
		ply.WeaponAnims = {}
		local activeewp = ply:GetActiveWeapon()

		if (IsValid(activeewp) and activeewp.SetHoldType) then
			activeewp:SetHoldType("magic")
			table.insert(ply.WeaponAnims, activeewp)
		end

		/*timer.Simple(0.2, function()
			hook.Add("Think", "moatLookAtArm" .. ply:EntIndex(), function()
				if (ply:IsValid() and ply:Team() ~= TEAM_SPEC) then
					for k, v in pairs(bones) do
						local b = ply:LookupBone(k)
						if (not b) then
							continue
						end
						if (ply.InventoryOpen) then
							v[2] = LerpAngle(FrameTime() * 10, v[2], v[1])
							if (math.abs(math.AngleDifference(v[2].p, v[1].p)) > 0.1 or math.abs(math.AngleDifference(v[2].y, v[1].y)) > 0.1 or math.abs(math.AngleDifference(v[2].r, v[1].r)) > 0.1) then
								ply:ManipulateBoneAngles(b, v[2])
							end
						else
							v[2] = LerpAngle(FrameTime() * 10, v[2], Angle(0, 0, 0))

							if (math.abs(math.AngleDifference(v[2].p, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].y, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].r, 0)) > 0.1) then
								ply:ManipulateBoneAngles(b, v[2])
							else
								hook.Remove("Think", "moatLookAtArm" .. ply:EntIndex())
							end
						end
					end
				end
			end)
		end)*/
	end

	function moat_StartInventoryOpenAntimationEnd(ply)
		net.Start("moat_OpenInventory")
		net.WriteEntity(ply)
		net.WriteBool(false)
		net.Broadcast()

		if (ply.WeaponAnims and ply.WeaponAnims[1]) then
			for i = 1, #ply.WeaponAnims do
				local wep = ply.WeaponAnims[i]
				if (not IsValid(wep)) then continue end
				if (not wep.HoldType) then continue end
				
				wep:SetHoldType(wep.HoldType)
			end
		end
	end

	net.Receive("moat_OpenInventory", function(len, ply)
		local open = net.ReadBool()

		ply.InventoryOpen = open
		
		if (open) then
			moat_StartInventoryOpenAntimationStart(ply)
		else
			moat_StartInventoryOpenAntimationEnd(ply)
		end
	end)

	hook.Add("PlayerDisconnected", "moat_InventoryOpenAnimDisconnect", function(ply)
		if (ply.WeaponAnims and ply.WeaponAnims[1]) then
			for i = 1, #ply.WeaponAnims do
				local wep = ply.WeaponAnims[i]
				if (not IsValid(wep)) then continue end
				if (not wep.HoldType) then continue end

				wep:SetHoldType(wep.HoldType)
			end
		end
	end)

	hook.Add("PlayerDeath", "moat_InventoryOpenAnimDeath", function(ply)
		if (ply.WeaponAnims and ply.WeaponAnims[1]) then
			for i = 1, #ply.WeaponAnims do
				local wep = ply.WeaponAnims[i]
				if (not IsValid(wep)) then continue end
				if (not wep.HoldType) then continue end
				
				wep:SetHoldType(wep.HoldType)
			end
		end
	end)

	hook.Add("PlayerSpawn", "moat_InventoryOpenAnimSpawn", function(ply)
		if (IsValid(ply) and ply:Team() ~= TEAM_SPEC) then
			for i = 0, ply:GetBoneCount() - 1 do
				ply:ManipulateBoneAngles(i, angle_zero)
			end
			timer.Simple(5, function()
				if (IsValid(ply) and ply:Team() ~= TEAM_SPEC and ply.InventoryOpen) then
					moat_StartInventoryOpenAntimationStart(ply)
				end
			end)
		end
	end)

	hook.Add("PlayerSwitchWeapon", "moat_FixWeaponSwitching", function(ply, owep, wep)
		if (ply.InventoryOpen and CurTime() - wep:GetCreationTime() > 5) then
			return true
		elseif (wep and wep.HoldType and wep:GetHoldType() ~= wep.HoldType) then
			wep:SetHoldType(wep.HoldType)
		end
	end)

	local ran = math.random(-180, 180)
	local ran90 = math.random(-90, 90)

	local moat_anims = {
		["dab"] = {
			["ValveBiped.Bip01_R_Forearm"] = {Angle(0, -90, -20), Angle(0, 0, 0)},
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(40, -80, -45), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Head1"] = {Angle(0, -45, -15), Angle(0, 0, 0)},
			["ValveBiped.Bip01_L_UpperArm"] = {Angle(-100, 0, 0), Angle(0, 0, 0)}
		},
		["arms"] = {
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)},
			["ValveBiped.Bip01_L_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)}
		},
		["bend"] = {
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Spine"] = {Angle(0, 90, 0), Angle(0, 0, 0)},
			["ValveBiped.Bip01_L_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)}
		},
		["lean"] = {
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Spine"] = {Angle(0, -90, 0), Angle(0, 0, 0)},
			["ValveBiped.Bip01_L_UpperArm"] = {Angle(0, 100, 0), Angle(0, 0, 0)}
		},
		["lean2"] = {
			["ValveBiped.Bip01_Spine"] = {Angle(0, -90, 90), Angle(0, 0, 0)},
		},
		["random"] = {
			["ValveBiped.Bip01_R_Forearm"] = {Angle(ran, ran, ran), Angle(0, 0, 0)},
			["ValveBiped.Bip01_R_UpperArm"] = {Angle(ran, ran, ran), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Head1"] = {Angle(ran, ran, ran), Angle(0, 0, 0)},
			["ValveBiped.Bip01_L_UpperArm"] = {Angle(ran, ran, ran), Angle(0, 0, 0)},
			["ValveBiped.Bip01_Spine"] = {Angle(ran90, ran90, ran90), Angle(0, 0, 0)},
			["ValveBiped.Bip01_R_Calf"] = {Angle(ran90, ran90, ran90), Angle(0, 0, 0)},
			["ValveBiped.Bip01_R_Thigh"] = {Angle(ran90, ran90, ran90), Angle(0, 0, 0)}
		},
	}
	--hook.Remove("Think", "moat_ANimationTesting")
	/*hook.Add("Think", "moat_ANimationTesting", function()
		for _, ply in pairs(player.GetBots()) do
			for k, v in pairs(moat_anims["lean2"]) do
				local b = ply:LookupBone(k)
				v[2] = LerpAngle(FrameTime() * 10, v[2], v[1])
				ply:ManipulateBoneAngles(b, v[2])
			end
		end
	end)*/

	concommand.Add("moat_animationtest", function(plys, cmd, args)
		if (not moat_anims[args[1]] or not moat.isdev(plys)) then return end
		local pl = {plys}
		if (args[2] == "bot") then
			pl = {}
			for k, v in pairs(player.GetBots()) do table.insert(pl, v) end
		end
		if (args[2] == "all") then
			pl = {}
			for k, v in pairs(player.GetAll()) do table.insert(pl, v) end
		end

		for _, ply in pairs(pl) do
			if (not ply.DoAnimationEventStart) then
				ply.DoAnimationEventStart = true
			end

			local ply_anim = table.Copy(moat_anims[args[1]])

			hook.Add("Think", "moat_animation_think" .. args[1] .. ply:EntIndex(), function()
				if (ply:IsValid() and ply:Team() ~= TEAM_SPEC) then
					for k, v in pairs(ply_anim) do
						local b = ply:LookupBone(k)
						if (ply.DoAnimationEventStart) then
							v[2] = LerpAngle(FrameTime() * 10, v[2], v[1])
							if (math.abs(math.AngleDifference(v[2].p, v[1].p)) > 0.1 or math.abs(math.AngleDifference(v[2].y, v[1].y)) > 0.1 or math.abs(math.AngleDifference(v[2].r, v[1].r)) > 0.1) then
								ply:ManipulateBoneAngles(b, v[2])
							else
								if (not args[3]) then
									ply.DoAnimationEventStart = false
								end
							end
						else
							v[2] = LerpAngle(FrameTime() * 10, v[2], Angle(0, 0, 0))

							if (math.abs(math.AngleDifference(v[2].p, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].y, 0)) > 0.1 or math.abs(math.AngleDifference(v[2].r, 0)) > 0.1) then
								ply:ManipulateBoneAngles(b, v[2])
							else
								ply.DoAnimationEventStart = false
								hook.Remove("Think", "moat_animation_think" .. args[1] .. ply:EntIndex())
							end
						end
					end
				end
			end)
		end
	end)
/*
local bones = {
	["ValveBiped.Bip01_R_Forearm"] = Angle(45, -45, 0),
	["ValveBiped.Bip01_R_UpperArm"] = Angle(90, 0, 45),
	["ValveBiped.Bip01_L_UpperArm"] = Angle(-90, 0, -45),
	["ValveBiped.Bip01_L_Forearm"] = Angle(-45, -45, 0),
}

for k, v in pairs(player.GetBots()) do
	v:SelectWeapon("weapon_ttt_unarmed")
end

hook.Add("Think", "moat_ModifyBones", function()
   for _, ply in pairs(player.GetAll()) do
        for k, v in pairs(bones) do
            local b = ply:LookupBone(k)
             ply:ManipulateBoneAngles(b, v)
        end
    end
end)

concommand.Add("moat_getbonelist", function(ply, cmd, args)
	local bonelist = ply:GetBoneCount()

	for i = 1, 100 do
		print(ply:GetBoneName(i))
	end
end)*/

	return
end





hook.Add("CreateMove", "moat_InventoryHandleDucking", function(cmd)
    if (cmd:KeyDown(IN_DUCK) and IsValid(MOAT_INV_BG)) then
        RunConsoleCommand("-duck")
    end
end)

surface.CreateFont("moat_ExtremeLarge", {
    font = "DermaLarge",
    size = 200,
    weight = 800
})
surface.CreateFont("moat_Extreme1Large", {
    font = "DermaLarge",
    size = 100,
    weight = 800
})

local MOAT_PLYS_INV = {}

MOAT_GLOBAL_TEST_VARS = {
	187,
	190,
	9,
	4.3,
	1
}

local function m_InitializeAnimations(ply)
	local col_alpha = -255

	hook.Add("PostDrawTranslucentRenderables", "moat_InventoryOpenCam" .. ply:EntIndex(), function()
		local lp = LocalPlayer()

		if (not IsValid(ply) or ply:Team() == TEAM_SPEC or (IsValid(lp) and ply == lp)) then
			hook.Remove("PostDrawTranslucentRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
			return
		end

		if (IsValid(lp) and lp:Team() == TEAM_SPEC and lp:GetObserverTarget() == ply and lp:GetObserverMode() == OBS_MODE_IN_EYE) then return end

		local b = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if (not b) then return end
		
    	local pos1, ang = ply:GetBonePosition(b)
    	local pos2 = ply:GetManipulateBonePosition(b)
    	ang:RotateAroundAxis(ang:Right(), MOAT_GLOBAL_TEST_VARS[1])
    	ang:RotateAroundAxis(ang:Up(), MOAT_GLOBAL_TEST_VARS[2])

    	local cam_pos = pos1 + pos2 + (ang:Forward() * MOAT_GLOBAL_TEST_VARS[3]) + (ang:Up() * MOAT_GLOBAL_TEST_VARS[4]) + (ang:Right() * MOAT_GLOBAL_TEST_VARS[5])

    	if (MOAT_PLYS_INV[ply][1]) then
    	    col_alpha = Lerp(FrameTime() * 1, col_alpha, 255)
    	else
    		hook.Remove("PostDrawTranslucentRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
    	end

    	local col_alpha = col_alpha * math.Clamp((1 - ((200 + (cam_pos:Distance(LocalPlayer():GetPos())))/1000)), 0, 1)
    	local hsvcol = HSVToColor(CurTime() * 70 % 360, 1, 1 )
    	local angles = ply:EyeAngles()

    	cam.Start3D2D(cam_pos, ang, 0.02)
    		draw.SimpleTextOutlined("Viewing Inventory", "moat_Extreme1Large", 0, -80, Color(255, 255, 255, col_alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 8, Color(0, 0, 0, 15 * (col_alpha/255)))
        	
        	surface.SetDrawColor(hsvcol.r, hsvcol.g, hsvcol.b, col_alpha)
        	surface.DrawRect(-400, 35, 800, 5)
        	
        	draw.SimpleTextOutlined(MOAT_PLYS_INV[ply][2], "moat_ExtremeLarge", 0, 30, Color(255, 255, 255, col_alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 8, Color(0, 0, 0, 15 * (col_alpha/255)))
		cam.End3D2D()
	end)
end

local function remove_view_hook(i)
	hook.Remove("Think", "moat.inventory.view." .. i)
end

/*
    - get the bone position
	- determine optimial angle
	- animate from difference
	- changing the angle based on player angle

	for i = 0, LocalPlayer():GetBoneCount() - 1 do if (not LocalPlayer():LookupBone(LocalPlayer():GetBoneName(i))) then continue end print(LocalPlayer():GetBoneName(i), LocalPlayer():GetManipulateBoneAngles(LocalPlayer():LookupBone(LocalPlayer():GetBoneName(i)))) end
*/
MOAT_GLOBAL_DABONE = {
	Angle(0, -30, 0),
	Angle(-25, -20, -40),
	Angle(10, -30, 0),
	Angle(10, -50, 25)
}

local mw = {
	["ValveBiped.Bip01_R_Forearm"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_Head1"] = true,
	["ValveBiped.Bip01_R_Hand"] = true
}
local function reset_bones(pl, w) -- no fucking idea why it changes others
	for i = 0, pl:GetBoneCount() - 1 do
		local n = pl:GetBoneName(i)
		local l = pl:LookupBone(n)
		if (not l or (mw[n] and not w)) then continue end

		pl:ManipulateBoneAngles(l, Angle(0, 0, 0))
	end
end

net.Receive("moat_OpenInventory", function()
	local ply = net.ReadEntity()
	local open = net.ReadBool()
	ply.InventoryOpen = open

	if (not ply:IsValid() or ply:Team() == TEAM_SPEC) then return end
	MOAT_PLYS_INV[ply] = {open, "Loadout"}

	if (open) then
		reset_bones(ply, true)
		m_InitializeAnimations(ply)
	else
		hook.Remove("PostDrawTranslucentRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
		return
	end

	local idx, val = ply:EntIndex(), 0
	hook.Add("Think", "moat.inventory.view." .. idx, function()
		if (not IsValid(ply) or ply:Team() == TEAM_SPEC) then remove_view_hook(idx) return end
		val = ply.InventoryOpen and Lerp(FrameTime() * 10, val, 1) or Lerp(FrameTime() * 10, val, 0)

		if (val < 1) then
			local p1 = ply:LookupBone "ValveBiped.Bip01_R_Forearm"
			local p2 = ply:LookupBone "ValveBiped.Bip01_R_UpperArm"
			local p3 = ply:LookupBone "ValveBiped.Bip01_Head1"
			local p4 = ply:LookupBone "ValveBiped.Bip01_R_Hand"
			if (not p1 or not p2 or not p3 or not p4) then remove_view_hook(idx) return end

			--reset_bones(ply)
			ply:ManipulateBoneAngles(p1, Angle(MOAT_GLOBAL_DABONE[1].p * val, MOAT_GLOBAL_DABONE[1].y * val, MOAT_GLOBAL_DABONE[1].r * val))
			ply:ManipulateBoneAngles(p2, Angle(MOAT_GLOBAL_DABONE[2].p * val, MOAT_GLOBAL_DABONE[2].y * val, MOAT_GLOBAL_DABONE[2].r * val))
			ply:ManipulateBoneAngles(p3, Angle(MOAT_GLOBAL_DABONE[3].p * val, MOAT_GLOBAL_DABONE[3].y * val, MOAT_GLOBAL_DABONE[3].r * val))
			ply:ManipulateBoneAngles(p4, Angle(MOAT_GLOBAL_DABONE[4].p * val, MOAT_GLOBAL_DABONE[4].y * val, MOAT_GLOBAL_DABONE[4].r * val))
		end

		if (val >= 0.99999) then val = 1 end
		if (val <= 0.00009) then val = 0 remove_view_hook(idx) reset_bones(ply, true) end
	end)
end)

net.Receive("moat_InventoryCatChange", function()
	local cat = net.ReadUInt(4)
	local ply = net.ReadEntity()

	MOAT_PLYS_INV[ply] = {true, MOAT_INV_CATS[cat][1]}

	if (not MOAT_PLYS_INV[ply]) then
		m_InitializeAnimations(ply)
	end
end)

local anims = {
	{ACT_GMOD_GESTURE_AGREE, true},
	{ACT_GMOD_GESTURE_BOW, true},
	{ACT_GMOD_TAUNT_CHEER, true},
	{ACT_ZOMBIE_CLIMB_UP, false},
	{ACT_GMOD_TAUNT_DANCE, true},
	{ACT_GMOD_GESTURE_DISAGREE, true},
	{ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true},
	{ACT_GMOD_TAUNT_LAUGH, true},
	{ACT_HL2MP_ZOMBIE_SLUMP_IDLE, false},
	{ACT_GMOD_TAUNT_ROBOT, true},
	{ACT_GMOD_TAUNT_SALUTE, true},
	{ACT_GMOD_TAUNT_MUSCLE, true},
	{ACT_GMOD_GESTURE_WAVE, true},
	{ACT_GMOD_GESTURE_BECON, true}
}
anims[0] = {ACT_HL2MP_IDLE, true}

net.Receive("MOAT_RESET_ANIMATION", function(len)
	local ply = net.ReadEntity()
	local act = net.ReadUInt(8)

	if (ply:IsValid() and act) then
		if (act == 0) then
			ply:AnimResetGestureSlot(GESTURE_SLOT_GRENADE)
		elseif (anims[act]) then
			ply:AnimRestartGesture(GESTURE_SLOT_GRENADE, anims[act][1], anims[act][2])
		end
	end
end)