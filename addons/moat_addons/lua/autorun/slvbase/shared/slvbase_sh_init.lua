if(SLVBase) then return end // Has already been initialized by another addon
if(SERVER) then
	pcall(require,"tracex") // This module isn't required, but some NPCs might behave slightly dumber
	AI_TYPE_STATIC = 1
	AI_TYPE_GROUND = 2
	AI_TYPE_AIR = 3
	AI_TYPE_WATER = 5
	
	local DoPropSpawnedEffect = DoPropSpawnedEffect
	_G.DoPropSpawnedEffect = function(...)
		local e = ...
		if(e && e.HidePropSpawnedEffect) then return end
		return DoPropSpawnedEffect(...)
	end
end
NODE_LINK_FLAG_JUMP_DOWN = 1
NODE_LINK_FLAG_JUMP_UP = 2

local tblAddonsDerived = {}
SLVBase = {
	AddDerivedAddon = function(name, tblInfo)
		print("Adding derived addon " .. name)
		tblAddonsDerived[name] = tblInfo
	end,
	AddonInitialized = function(name)
		return !name || tblAddonsDerived[name] != nil
	end,
	GetDerivedAddons = function() return tblAddonsDerived end,
	GetDerivedAddon = function(name) return tblAddonsDerived[name] end,
	InitLua = function(dir)
		local dirL = dir .. "/"
		local dirLua = "lua/" .. dirL
		local tbFiles,tbDirs = file.Find(dirLua .. "*","GAME")
		for _,f in ipairs(tbFiles) do
			if(string.Right(f,4) == ".lua") then
				include(dirL .. f)
				if(SERVER) then AddCSLuaFile(dirL .. f) end
			end
		end
		for _,dir in ipairs(tbDirs) do
			if(dir == "client" || dir == "server") then
				local tbFiles = file.Find(dirLua .. dir .. "/*.lua","GAME")
				for _,fSub in ipairs(tbFiles) do
					include(dirL .. dir .. "/" .. fSub)
					if(SERVER) then AddCSLuaFile(dirL .. dir .. "/" .. fSub) end
				end
			end
		end
	end,
	AddNPC = function(Category,Name,Class,KeyValues,fOffset,bOnCeiling,bOnFloor)
		list.Set("NPC",Name,{Name = Name,Class = Class,Category = Category,Offset = fOffset,KeyValues = KeyValues,OnCeiling = bOnCeiling,OnFloor = bOnFloor})
	end,
	RegisterEntity = function(path,name,reload)
		local _ENT = _G.ENT
		ENT = {}
		local r = string.Right(path,1)
		if(r != "/" && r != "\\") then path = path .. "/" end
		if(SERVER) then include(path .. name .. "/init.lua")
		else include(path .. name .. "/cl_init.lua") end
		pcall(scripted_ents.Register,ENT,name,reload)
		ENT = _ENT
	end,
	RegisterWeapon = function(path,name,reload)
		local _SWEP = _G.SWEP
		SWEP = {}
		local r = string.Right(path,1)
		if(r != "/" && r != "\\") then path = path .. "/" end
		if(SERVER) then include(path .. name .. "/init.lua")
		else include(path .. name .. "/cl_init.lua") end
		pcall(weapons.Register,SWEP,name,reload)
		SWEP = _SWEP
	end,
	IsSoundtrackNPCActive = function(filter)
		for _,ent in ipairs(ents.GetAll()) do
			if(ent:IsNPC() && ent.HasSoundtrack && ent != filter) then return ent end
		end
		return false
	end
}

game.AddParticles("particles/centaur_spit.pcf")
game.AddParticles("particles/slv_explosion.pcf")
for _, particle in pairs({
		"svl_explosion",
		"blood_impact_red_01",
		"blood_impact_yellow_01",
		"blood_impact_green_01",
		"blood_impact_blue_01"
	}) do
	PrecacheParticleSystem(particle)
end

HITBOX_GENERIC = 100
HITBOX_HEAD = 101
HITBOX_CHEST = 102
HITBOX_STOMACH = 103
HITBOX_LEFTARM = 104
HITBOX_RIGHTARM = 105
HITBOX_LEFTLEG = 106
HITBOX_RIGHTLEG = 107
HITBOX_GEAR = 108
HITBOX_ADDLIMB = 109
HITBOX_ADDLIMB2 = 110

hook.Add("InitPostEntity", "SLV_PrecacheModels", function()
	local models = {}
	local function AddDir(path)
		for k, v in pairs(file.Find(path .. "*",true)) do
			if string.find(v, ".mdl") then
				table.insert(models, path .. v)
			end
		end
	end
	
	local function AddFile(file)
		table.insert(models, file)
	end
	for i = 1, 6 do AddFile("models/gibs/ice_shard0" .. i .. ".mdl") end
	
	for k, v in pairs(models) do
		util.PrecacheModel(v)
	end
	hook.Remove("InitPostEntity", "SLV_PrecacheModels")
end)

if(SERVER) then
	NPC_STATE_LOST = 8
end

function util.RegisterNPCAnimation(ENT,name,anim,act)
	ENT.CurAnimationID = ENT.CurAnimationID || 1
	ENT.Animations = ENT.Animations || {}
	ENT.AnimationIDs = ENT.AnimationIDs || {}
	ENT.AnimationNames = ENT.AnimationNames || {}
	ENT.AnimationActivities = ENT.AnimationActivities || {}
	
	ENT.Animations[name] = anim
	ENT.AnimationIDs[name] = ENT.CurAnimationID
	ENT.AnimationNames[ENT.CurAnimationID] = name
	if(act) then
		ENT.AnimationActivities[act] = ENT.AnimationActivities[act] || {}
		table.insert(ENT.AnimationActivities[act],name)
	end
	ENT.CurAnimationID = ENT.CurAnimationID +1
end