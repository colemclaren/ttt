include('shared.lua')
include("cl_aftm.lua")
include('cl_gestures.lua')
include('sh_gestures.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:DrawTranslucent()
end

function ENT:SetRagdollBones(bIn)
	self.m_bRagdollSetup = bIn
end

function ENT:DoRagdollBone(PhysBoneNum, BoneNum)
end

usermessage.Hook("slv_create_soundevent",function(um)
	local pos = um:ReadVector()
	local ev = um:ReadChar()
	
	--sound.Play( String sound, Vector origin, Number amplitude, Number pitch )
end)
local function IncludeBase(ent,t)
	if(t.Base) then
		local list = scripted_ents.GetList()
		if(list[t.Base] && list[t.Base].t.Base && list[t.Base].t.Base != t.Base) then
			IncludeBase(ent,list[t.Base].t)
		end
	end
	table.Merge(ent,t)
end
hook.Add("OnEntityCreated","SLV_ClientInitFix",function(ent)
	if(IsValid(ent) && ent:IsNPC()) then
		local class = ent.ClassName || ent:GetClass()
		local list = scripted_ents.GetList()
		if(list[class]) then
			IncludeBase(ent,list[class].t)
			if(ent.Initialize) then
				local success,err = pcall(ent.Initialize,ent)
				if(!success) then ErrorNoHalt(err) end
			end
			if(ent.BuildBonePositions) then ent:AddCallback("BuildBonePositions",ent.BuildBonePositions) end
		end
	end
end)
local matTrace = Material("trails/laser.vmt")
local matSprite = Material("sprites/blueglow2.vmt")
usermessage.Hook("slv_dbg_path",function(um)
	local numNodes = um:ReadShort()
	local nodes = {}
	local vecOffset = Vector(0,0,20)
	for i = 1,numNodes do
		table.insert(nodes,um:ReadVector() +vecOffset)
	end
	if(numNodes == 0) then return end
	local col = Color(255,0,0,255)
	local colSprite = Color(0,0,255,255)
	hook.Add("RenderScreenspaceEffects","ai_debug_drawpath", function()
		cam.Start3D(EyePos(),EyeAngles())
			for i = 1,numNodes do
				if(i > 1) then
					render.SetMaterial(matTrace)
					render.DrawBeam(nodes[i -1],nodes[i],60,1,1,col)
				end
				render.SetMaterial(matSprite)
				render.DrawSprite(nodes[i],80,80,colSprite)
			end
		cam.End3D()
	end)
end)

usermessage.Hook("slv_npc_bodypart",function(um)
	local ent = um:ReadEntity()
	if(!ent:IsValid()) then return end
	local model = um:ReadString()
	
end)

local cspSoundtrack
net.Receive("slv_npc_soundtrack",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid()) then return end
	if(cspSoundtrack) then cspSoundtrack:Stop() end
	local tracks,dur = ent:GetSoundtracks()
	local num = #tracks
	if(num == 0) then return end
	local r = math.random(1,num)
	local track = tracks[r]
	cspSoundtrack = CreateSound(LocalPlayer(),track)
	cspSoundtrack:SetSoundLevel(0.2)
	cspSoundtrack:Play()
	if(dur[r] == 0) then return end
	local tm = RealTime() +dur[r] // RealTime to make sure we don't start the new track before the old one has stopped.
	hook.Add("Think","slv_npc_soundtrack",function()
		if(!ent:IsValid()) then
			if(!SLVBase.IsSoundtrackNPCActive()) then
				cspSoundtrack:FadeOut(4)
				hook.Remove("Think","slv_npc_soundtrack")
				return
			end
		end
		if(RealTime() >= tm) then
			if(r == num) then r = 1
			else r = r +1 end
			cspSoundtrack:Stop()
			cspSoundtrack = CreateSound(LocalPlayer(),track)
			cspSoundtrack:SetSoundLevel(0.2)
			cspSoundtrack:Play()
			track = tracks[r]
			local dur = dur[r]
			tm = RealTime() +dur
		end
	end)
end)