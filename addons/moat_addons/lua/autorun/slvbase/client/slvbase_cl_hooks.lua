local tbEntsFrozen = {}
local numEntsFrozen = 0
net.Receive("slv_freeze_end",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid() || !table.HasValue(tbEntsFrozen,ent)) then return end
	for _, entTgt in ipairs(tbEntsFrozen) do
		if(entTgt == ent) then
			table.remove(tbEntsFrozen,_)
			numEntsFrozen = numEntsFrozen -1
			break
		end
	end
	if(ent == LocalPlayer()) then
		hook.Remove("InputMouseApply", "PLViewCalc_EntFreeze")
		hook.Remove("HUDPaint", "Effect_FreezeScreenOverlay")
		//if IsValid(vmModel) then vmModel:Remove(); ent:GetViewModel():SetColor(255,255,255,255) end
	end
	if(numEntsFrozen > 0) then return end
	util.RemoveHookSafe("RenderScreenspaceEffects","Effect_EntFreezeOverlay")
end)

hook.Add("Move","MovePlFrozen",function(pl,move)
	local frz = pl:GetNetworkedInt("FreezePercent");
	if(frz > 0) then
		local flScale = 1 -(frz /100);
		move:SetForwardSpeed(move:GetForwardSpeed() *flScale);
		move:SetSideSpeed(move:GetSideSpeed() *flScale);
		move:SetUpSpeed(move:GetUpSpeed() *flScale);
	end
end)
local mat = Material("effects/freeze_overlayeffect01")
net.Receive("slv_freeze_start",function(len)
	local ent = net.ReadEntity()
	local percent = net.ReadUInt(8)
	if(!ent:IsValid() || table.HasValue(tbEntsFrozen,ent)) then return end
	ent:SetNetworkedInt("FreezePercent",percent)
	table.insert(tbEntsFrozen,ent)
	numEntsFrozen = numEntsFrozen +1
	if(ent == LocalPlayer()) then
		hook.Add("InputMouseApply", "PLViewCalc_EntFreeze", function(cmd, x, y, ang)
			local frz = 1 -(ent:GetNetworkedInt("FreezePercent") *0.01)
			local scP = (GetConVarNumber("m_pitch") *frz)
			local scY = (GetConVarNumber("m_yaw") *frz)
			ang.p = ang.p +y *scP;
			ang.y = ang.y -x *scY;
			cmd:SetViewAngles(ang)
			return true
		end)
		
		hook.Add("HUDPaint","Effect_FreezeScreenOverlay",function()
			local flAlpha = (ent:GetNetworkedInt("FreezePercent") *0.01) *255
			surface.SetDrawColor(255,255,255,flAlpha)
			surface.SetTexture(surface.GetTextureID("HUD/freeze_screen"))
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
		end)
	end
	if(numEntsFrozen > 1) then return end
	hook.Add("RenderScreenspaceEffects", "Effect_EntFreezeOverlay", function()
		for i = numEntsFrozen,1,-1 do
			local ent = tbEntsFrozen[i]
			if(!ent:IsValid() || ent:GetNetworkedInt("FreezePercent") == 0) then
				table.remove(tbEntsFrozen,i)
				numEntsFrozen = numEntsFrozen -1
				if(numEntsFrozen == 0) then
					hook.Remove("RenderScreenspaceEffects", "Effect_EntFreezeOverlay")
				end
			else
				local entTgt = ent:GetNetworkedEntity("ragdoll")
				if(entTgt:IsValid()) then ent = entTgt end
				if(ent:IsPlayer() || util.IsValidModel(ent:GetModel())) then
					local flBlend = ent:GetNetworkedInt("FreezePercent") *0.01
					render.SetColorModulation(1,1,1)
					cam.Start3D(EyePos(),EyeAngles())
						render.SetBlend(flBlend)
						render.MaterialOverride(mat)
							ent:DrawModel()
							if(ent:IsPlayer()) then
								local wep = ent:GetActiveWeapon()
								if(IsValid(wep)) then wep:DrawModel() end
							end
						render.MaterialOverride()
						render.SetBlend(1)
					cam.End3D()
				end
			end
		end
	end)
end)

usermessage.Hook("HLR_EntsCollide", function(um)
	local entA = um:ReadEntity()
	local entB = um:ReadEntity()
	if !IsValid(entA) || !IsValid(entB) then return end
	local bCollide = um:ReadBool()
	if bCollide then entA:Collide(entB)
	else entA:NoCollide(entB) end
end)

usermessage.Hook("SLV_UpdateCollisions", function(um)
	local am = um:ReadShort()
	for i = 1, am do
		local entA = um:ReadEntity()
		local am = um:ReadShort()
		for j = 1, am do
			local entB = um:ReadEntity()
			entA:NoCollide(entB)
		end
	end
	am = um:ReadShort()
	for i = 1, am do
		local entA = um:ReadEntity()
		local am = um:ReadShort()
		for j = 1, am do
			local class = um:ReadString()
			entA:NoCollide(class)
		end
	end
end)

usermessage.Hook("HLR_EntsCollideClass", function(um)
	local entA = um:ReadEntity()
	local class = um:ReadString()
	if !IsValid(entA) || !class then return end
	local bCollide = um:ReadBool()
	if bCollide then entA:Collide(class)
	else entA:NoCollide(class) end
end)

usermessage.Hook("HLR_FadeScreen", function(um)
	local sCol = um:ReadString()
	if !sCol then return end
	sCol = string.Explode(",", sCol)
	local color = Color(tonumber(sCol[1]), tonumber(sCol[2]), tonumber(sCol[3]), tonumber(sCol[4]))
	local durFade = um:ReadFloat()
	local durHold = um:ReadFloat()
	local fadeSc = color.a /durFade
	local startFade = CurTime() +durHold
	hook.Add("HUDPaint", "HLR_FadeScreen_HUDPaint", function()
		local a = CurTime() < startFade && color.a || math.Clamp(color.a -fadeSc *(CurTime() -startFade), 0, color.a)
		if a == 0 then hook.Remove("HUDPaint", "HLR_FadeScreen_HUDPaint"); return end
		surface.SetDrawColor(color.r, color.g, color.b, a)
		surface.DrawRect(0 , 0, ScrW(), ScrH())
	end)
end)

local tblSpriteTraces = {}
local matSpriteTrace = Material("trails/laser")
local function DrawTraces()
	hook.Add("RenderScreenspaceEffects", "Effect_DrawSpriteTraces", function()
		cam.Start3D(EyePos(), EyeAngles())
			for k, data in pairs(tblSpriteTraces) do
				if CurTime() >= data.tDeath then
					tblSpriteTraces[k] = nil
					if table.Count(tblSpriteTraces) == 0 then hook.Remove("RenderScreenspaceEffects", "Effect_DrawSpriteTraces") end
				else
					render.SetMaterial(matSpriteTrace)
					render.DrawBeam(data.posStart, data.posEnd, data.width, 1, 1, data.col)
				end
			end
		cam.End3D()
	end)
end

function util.CreateSpriteTrace(posStart, posEnd, fLifeTime, width, col)
	fLifeTime = fLifeTime || 5
	width = width || 50
	col = col || Color(255,0,0,255)
	table.insert(tblSpriteTraces, {
		posStart = posStart,
		posEnd = posEnd,
		tDeath = CurTime() +fLifeTime,
		width = width,
		col = col
	})
	if table.Count(tblSpriteTraces) == 1 then DrawTraces() end
end

function util.CreateSpriteBox(posStart, posEnd, fLifeTime, width, col)
	local tblPositions = {
		{posStart, Vector(posStart.x, posStart.y, posEnd.z)},
		{posStart, Vector(posStart.x, posEnd.y, posStart.z)},
		{posStart, Vector(posEnd.x, posStart.y, posStart.z)},
		{posEnd, Vector(posEnd.x, posEnd.y, posStart.z)},
		{posEnd, Vector(posEnd.x, posStart.y, posEnd.z)},
		{posEnd, Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posStart.x, posEnd.y, posStart.z), Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posEnd.x, posStart.y, posEnd.z), Vector(posEnd.x, posStart.y, posStart.z)},
		{Vector(posStart.x, posStart.y, posEnd.z), Vector(posEnd.x, posStart.y, posEnd.z)},
		{Vector(posEnd.x, posEnd.y, posStart.z), Vector(posStart.x, posEnd.y, posStart.z)},
		{Vector(posStart.x, posStart.y, posEnd.z), Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posEnd.x, posEnd.y, posStart.z), Vector(posEnd.x, posStart.y, posStart.z)}
	}
	for k, v in pairs(tblPositions) do
		util.CreateSpriteTrace(v[1], v[2], fLifeTime, width, col)
	end
end

function util.ClientsideEffect(...)
	local tblEntsEffects = ents.FindByClass("class CLuaEffect")
	util.Effect(...)
	for _, ent in ipairs(ents.FindByClass("class CLuaEffect")) do
		if(!table.HasValue(tblEntsEffects,ent)) then
			return ent
		end
	end
	return NULL
end

usermessage.Hook("HLR_CreateSpriteTrace", function(um)
	local posStart = um:ReadVector()
	local posEnd = um:ReadVector()
	if !posStart || !posEnd then return end
	local fLifeTime = um:ReadFloat()
	local width = um:ReadFloat()
	local sCol = um:ReadString()
	sCol = string.Explode(",", sCol)
	local col = Color(sCol[1], sCol[2], sCol[3], sCol[4])
	util.CreateSpriteTrace(posStart, posEnd, fLifeTime, width, col)
end)