if (SERVER) then

	local PLAYER = FindMetaTable "Player"
	PLAYER.O_AnimResetGestureSlot = PLAYER.O_AnimResetGestureSlot or PLAYER.AnimResetGestureSlot
	function PLAYER:AnimResetGestureSlot(slot)
		self:O_AnimResetGestureSlot(slot)
		net.Start "moat.animresetgestureslot"
			net.WriteEntity(self)
			net.WriteUInt(slot, 8)
		net.Broadcast()
	end

	PLAYER.O_AnimRestartGesture = PLAYER.O_AnimRestartGesture or PLAYER.AnimRestartGesture
	function PLAYER:AnimRestartGesture(slot, activity, autokill)
		self:O_AnimRestartGesture(slot, activity, autokill)
		net.Start "moat.animrestartgesture"
		net.WriteEntity(self)
			net.WriteUInt(slot, 8)
			net.WriteUInt(activity, 8)
			net.WriteBool(autokill)
		net.Broadcast()
	end
	util.AddNetworkString "moat.animrestartgesture"
	util.AddNetworkString "moat.animresetgestureslot"
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

		if (activeewp) then
			activeewp:SetHoldType("normal")
			table.insert(ply.WeaponAnims, activeewp)
		end

		timer.Simple(0.2, function()
			hook.Add("Think", "moatLookAtArm" .. ply:EntIndex(), function()
				if (ply:IsValid() and ply:Team() ~= TEAM_SPEC) then
					for k, v in pairs(bones) do
						local b = ply:LookupBone(k)
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
		end)
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
				wep:SetHoldType(wep.HoldType)
			end
		end
	end

	net.Receive("moat_OpenInventory", function(len, ply)
		local open = net.ReadBool()

		if (ply.InventoryOpen ~= open) then
			if (open) then
				moat_StartInventoryOpenAntimationStart(ply)
			else
				moat_StartInventoryOpenAntimationEnd(ply)
			end
		end
		ply.InventoryOpen = open
	end)

	hook.Add("PlayerDisconnected", "moat_InventoryOpenAnimDisconnect", function(ply)
		if (ply.WeaponAnims and ply.WeaponAnims[1]) then
			for i = 1, #ply.WeaponAnims do
				local wep = ply.WeaponAnims[i]
				if (not IsValid(wep)) then continue end
				wep:SetHoldType(wep.HoldType)
			end
		end
	end)

	hook.Add("PlayerDeath", "moat_InventoryOpenAnimDeath", function(ply)
		if (ply.WeaponAnims and ply.WeaponAnims[1]) then
			for i = 1, #ply.WeaponAnims do
				local wep = ply.WeaponAnims[i]
				if (not IsValid(wep)) then continue end
				wep:SetHoldType(wep.HoldType)
			end
		end
	end)

	hook.Add("PlayerSpawn", "moat_InventoryOpenAnimSpawn", function(ply)
		if (ply:IsValid() and ply:Team() ~= TEAM_SPEC) then
			timer.Simple(5, function()
				if (ply.InventoryOpen) then
					hook.Remove("Think", "moatLookAtArm" .. ply:EntIndex())
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
		if (not moat_anims[args[1]] or plys:SteamID() ~= "STEAM_0:0:46558052") then return end
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

local function m_InitializeAnimations(ply)
	local col_alpha = -255

	hook.Add("PostDrawOpaqueRenderables", "moat_InventoryOpenCam" .. ply:EntIndex(), function()
		if (not ply:IsValid() or ply:Team() == TEAM_SPEC or ply == LocalPlayer()) then
			hook.Remove("PostDrawOpaqueRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
			return
		end

		local b = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if (not b) then return end

		local pos1, ang = ply:GetBonePosition(b)
		local pos2 = ply:GetManipulateBonePosition(b)
		ang:RotateAroundAxis(ang:Right(), 187)
		ang:RotateAroundAxis(ang:Up(), 180)

		local cam_pos = pos1 + pos2 + (ang:Forward() * 11) + (ang:Up() * 4) + (ang:Right() * -1)

		if (MOAT_PLYS_INV[ply][1]) then
			col_alpha = Lerp(FrameTime(), col_alpha, 255)
		else
			hook.Remove("PostDrawOpaqueRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
		end

		col_alpha = col_alpha * math.Clamp(1 - (200 + cam_pos:Distance(LocalPlayer():GetPos())) / 1000, 0, 1)
		local hsvcol = HSVToColor(CurTime() * 70 % 360, 1, 1 )

		cam.Start3D2D(cam_pos, ang, 0.02)
			draw.SimpleTextOutlined("Viewing Inventory", "moat_Extreme1Large", 0, -80, Color(255, 255, 255, col_alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 8, Color(0, 0, 0, 15 * (col_alpha/255)))

			surface.SetDrawColor(hsvcol.r, hsvcol.g, hsvcol.b, col_alpha)
			surface.DrawRect(-400, 35, 800, 5)

			draw.SimpleTextOutlined(MOAT_PLYS_INV[ply][2], "moat_ExtremeLarge", 0, 30, Color(255, 255, 255, col_alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 8, Color(0, 0, 0, 15 * (col_alpha/255)))
		cam.End3D2D()
	end)
end

net.Receive("moat_OpenInventory", function()
	local ply = net.ReadEntity()
	local open = net.ReadBool()

	MOAT_PLYS_INV[ply] = {open, "Loadout"}

	if (open) then
		m_InitializeAnimations(ply)
	else
		hook.Remove("PostDrawOpaqueRenderables", "moat_InventoryOpenCam" .. ply:EntIndex())
	end
end)

net.Receive("moat_InventoryCatChange", function()
	local cat = net.ReadUInt(4)
	local ply = net.ReadEntity()

	MOAT_PLYS_INV[ply] = {true, M_INV_CATS[cat][1]}

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

net.Receive("moat.animresetgestureslot", function()
	net.ReadEntity():AnimResetGestureSlot(net.ReadUInt(8))
end)
net.Receive("moat.animrestartgesture", function()
	net.ReadEntity():AnimRestartGesture(net.ReadUInt(8), net.ReadUInt(8), net.ReadBool())
end)