local plyMeta = FindMetaTable('Player')

function plyMeta:canBeMoatFrozen()
	return (IsValid(self) && self:Team() != TEAM_SPEC && not GetGlobal("MOAT_MINIGAME_ACTIVE") && GetRoundState() == ROUND_ACTIVE)
end

if (SERVER) then
	util.AddNetworkString("Moat.Talents.Notify")

	util.AddNetworkString("Moat.Talents.Mark")
	util.AddNetworkString("Moat.Talents.Mark.End")

	util.AddNetworkString("Moat.Talents.Visionary")
	util.AddNetworkString("Moat.Talents.Visionary.End")
	util.AddNetworkString("JennyDoggo")
	util.AddNetworkString('moatNotifyMeticulous')
else
	net.Receive('moatNotifyMeticulous', function(len)
		chat.AddText(Color( 205, 127, 50 ), 'Through the power of your weapon, you have refilled your entire clip!' )
	end)

	net.Receive("Talents.BostonBasher", function()
		surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
	end)

	net.Receive("Talents.Silenced",function()
		local e = net.ReadEntity()
		if (not IsValid(e)) then return end

		e.Silenced = true
		if not e.Primary then return end

		e.Primary.Sound = Sound( "weapons/usp/usp1.wav" )
		if (e:GetOwner() == LocalPlayer()) then
			chat.AddText(Material("icon16/arrow_refresh.png"),Color(255,255,255),"Your weapon (  ",Color(255,0,0)," " .. e.PrintName .. " ",Color(255,255,255), "  ) is now silenced!")
		end
	end)

	net.Receive("Switch_wep_primary",function()
		local e = net.ReadEntity()
		local new_primary = net.ReadTable()
		local old_primary = e.Primary
		e.Primary = new_primary
		local n = net.ReadEntity()
		if not e.PrintName then e.PrintName = "" end
		if not n.PrintName then n.PrintName = e.PrintName end
		e.PrintName = "Copied " .. (n.PrintName or e.PrintName)
		if not IsValid(e:GetOwner()) then return end
		if not IsValid(LocalPlayer()) then return end
		if e:GetOwner() == LocalPlayer() then
			old_primary.Damage = math.Round(old_primary.Damage)
			new_primary.Damage = math.Round(new_primary.Damage)
			surface.PlaySound("Resource/warning.wav")
			chat.AddText(Color(255,255,255),"Your weapon turned into a ",Color(0,255,0), e.PrintName,Color(255,255,255), ", with ",Color(255,0,0),tostring(new_primary.Damage)," (",tostring(old_primary.Damage),"+",tostring(new_primary.Damage - old_primary.Damage),") DMG",Color(255,255,255)," and ",Color(255,0,0),tostring(net.ReadInt(8)),Color(255,255,255),"  active talents!")
		end
	end)

	net.Receive("Ass_talent",function()
		chat.AddText(Material("icon16/arrow_refresh.png"),"The body of ",net.ReadString()," is now gone!")
	end)

	local function talent_chat(new,v,tier,wild)
		local talent_desc = new.Description
		local talent_desctbl = string.Explode("^", talent_desc)
		for i = 1, table.Count(v.m) do
			local mod_num = math.Round(new.Modifications[i].min + ((new.Modifications[i].max - new.Modifications[i].min) * math.min(1, v.m[i])), 1)

			talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
		end
		talent_desc = string.Implode("", talent_desctbl)
		talent_desc = string.Replace(talent_desc, "_", "%")

		talent_desc = string.Grammarfy(talent_desc)
		chat.AddText(Material("icon16/arrow_refresh.png"),"Your ", Color(100,100,255), ( wild and "Wild! - Tier " or "Wildcard: Tier ") .. tostring(tier),Color(255,255,255),(wild and " added " or " turned into "),Color(255,0,0),new.Name,Color(255,255,255)," | ",Color(0,255,0),talent_desc,Color(255,255,255),(wild and " to your gun!" or ""))
	end

	net.Receive("weapon.UpdateTalents",function()
		local wild = net.ReadBool()
		local wep = net.ReadEntity()
		local tier = net.ReadInt(8)											
		local talent = net.ReadTable()
		talent.Description = talent.Description and string.Grammarfy(talent.Description) or ""
		local t_ = net.ReadTable()
		if (not IsValid(wep)) then return end
		timer.Simple(1,function()
			if (not IsValid(wep)) then return end
			if not wep.ItemStats then
				local s = "TalentUpdate" .. wep:EntIndex() .. tier
				timer.Create(s,0.1,0,function()
					if not IsValid(wep) then timer.Destroy(s) return end
					if wep.ItemStats then
						if not wep.ItemStats.Talents then return end
						table.insert(wep.ItemStats.Talents,talent)
						-- wep.ItemStats.Talents[tier] = talent
						table.insert(wep.ItemStats.t,t_)
						-- wep.ItemStats.t[tier] = t_
						timer.Destroy(s)
					end
				end)
			elseif (wep.ItemStats and wep.ItemStats.Talents) then
				table.insert(wep.ItemStats.Talents,talent)
				-- wep.ItemStats.Talents[tier] = talent
				table.insert(wep.ItemStats.t,t_)
				-- wep.ItemStats.t[tier] = t_
			end
		end)
		if (IsValid(wep) and IsValid(wep:GetOwner()) and wep:GetOwner() == LocalPlayer()) then
			talent_chat(talent,t_,tier,wild)
		end
	end) 

	local OMEGA = {}
	local WORLDMODELS = {}

	function OMEGA:ViewModelDrawn(old, vm)
		if (self.InsideDraw) then
			return
		end

		self.InsideDraw = true

		vm:DrawModel()
		self.ViewModelFlip = not self.ViewModelFlip
		vm:SetupBones()
		vm:DrawModel()

		self.InsideDraw = false
	end

	function OMEGA:DrawWorldModel(old)
		local WorldModel = WORLDMODELS[self.WorldModel]
		local _Owner = self:GetOwner()

		local lp = LocalPlayer()
		if (lp ~= _Owner) then
			if (lp:GetObserverMode() == OBS_MODE_IN_EYE and lp:GetObserverTarget() == _Owner) then
				return
			end
		end

		if (old) then
			old(self)
		else
			self:DrawModel()
		end
		
		if (IsValid(_Owner)) then
			-- Specify a good position
			
			local boneid = _Owner:LookupBone "ValveBiped.Bip01_L_Hand" -- Right Hand
			local b3 = WorldModel:LookupBone "ValveBiped.Bip01_R_Hand"
			if not boneid or not b3 then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			local mpos, mang
			local m3 = WorldModel:GetBoneMatrix(b3)
			if (m3) then
				mpos, mang = m3:GetTranslation(), m3:GetAngles()
			else
				mpos, mang = WorldModel:GetBonePosition(b3)
			end

			if not matrix or not mpos then return end
			
			local pos, ang = LocalToWorld(vector_origin, Angle(0, 0, 180), matrix:GetTranslation(), matrix:GetAngles())
			local lpos, lang = WorldToLocal(WorldModel:GetPos(), WorldModel:GetAngles(), mpos, mang)
			pos, ang = LocalToWorld(lpos, lang, pos, ang)

			if (self.Offset) then
				pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
				ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
				ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
				ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
				ang:RotateAroundAxis(ang:Forward(), 180)
			end

			local offsetVec = Vector(0, -5, 0)
			local offsetAng = Angle(-5, -10, 0)

			pos, ang = LocalToWorld(offsetVec, offsetAng, pos, ang)

			WorldModel:SetPos(pos)
			WorldModel:SetAngles(ang)
			WorldModel:SetupBones()

		else
			WorldModel:SetPos(self:GetPos() + self:GetAngles():Right() * 5)
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end

	function OMEGA:Think(old)
		if (old) then
			old(self)
		end
		
		self.ViewModelFlip = not self.ViewModelFlip
	end

	local needed = {}

	local function doweapon(wep)
		wep.UseHands = false
		wep.HoldType = "duel"
		wep.IronSightsPos = nil
		wep.IronSightsAng = nil
		wep:SetHoldType "duel"
		if (not WORLDMODELS[wep.WorldModel]) then
			WORLDMODELS[wep.WorldModel] = ClientsideModel(wep.WorldModel)
			WORLDMODELS[wep.WorldModel]:SetNoDraw(true)
		end
		
		wep.Tracer = 3
		
		for k, fn in pairs(OMEGA) do
			local old = wep[k]
			wep[k] = function(self, ...)
				fn(self, old, ...)
			end
		end
	end

	hook.Add("TTTEndRound", "moat_talents.Dual", function()
		needed = {}
	end)

	hook.Add("OnEntityCreated", "moat_talents.Dual", function(ent)
		if (needed[ent:EntIndex()]) then
			needed[ent:EntIndex()] = nil
			timer.Simple(0, function()
				doweapon(ent)
			end)
		end
	end)

	net.Receive("moat_talents.Dual", function()
		local wep = net.ReadUInt(32)
		if (IsValid(Entity(wep))) then
			doweapon(Entity(wep))
			return
		end
		needed[wep] = true
	end)

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
			if (not IsValid(vic) or vic:Team() == TEAM_SPEC or vic.Skeleton) then
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
				if (not IsValid(vic) or vic:Team() == TEAM_SPEC or vic.Skeleton) then
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
			if (not IsValid(v) or v:Team() == TEAM_SPEC or v.Skeleton) then continue end
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

	net.Receive("Moat.Talents.DeepFried", function()
		local pl = net.ReadPlayer()
		if (not IsValid(pl)) then return end
		local t = net.ReadDouble()

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

		cdn.PlayURL("https://static.moat.gg/f/deepfried.mp3", 0, function(s)
			for k, v in ipairs(FriedPlayers) do
				if (v.Start == now) then FriedPlayers[k].Sound = s end
			end
		end, "3d noplay")
	end)

	hook("RenderScreenspaceEffects", function()
		if (FriedLocalPlayer < CurTime()) then
			return
		end

		if (not LocalPlayer():IsActive()) then
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

	local doggo_save = {}
	local doggo_play = CurTime()
	hook.Add("HUDPaint", "moat_JennyDoggo", function()
		if (doggo_play <= CurTime()) then return end
		
		local scrw, scrh = ScrW(), ScrH()
		local img = 1
		for i = 1, 28 do
			img = i
			if (i > 14) then img = i - 14 end

			if (not doggo_save[i] or (doggo_save[i] and doggo_save[i].lastupdate and doggo_save[i].lastupdate < CurTime() - 0.1)) then doggo_save[i] = {math.random(1, scrw - 256), math.random(1, scrh - 256), lastupdate = CurTime()} end
			cdn.DrawImage("https://static.moat.gg/assets/img/doggo/" .. img .. ".png", doggo_save[i][1], doggo_save[i][2], 256, 256, Color(255, 255, 255))
		end
	end)

	net.Receive("JennyDoggo", function()
		local owner = net.ReadBool()
		if (owner) then
			chat.AddText(Material("icon16/heart.png"), Color(255, 0, 127), "You have overwelmed your target with doggo :D")
			return
		end

		local amt = net.ReadDouble()
		doggo_play = CurTime() + amt 
	end)
end
