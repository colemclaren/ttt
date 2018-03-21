local ipairs                  = ipairs

local math_acos               = math.acos
local math_cos                = math.cos
local math_deg                = math.deg
local math_huge               = math.huge
local math_rad                = math.rad
local math_sqrt               = math.sqrt

local string_find             = string.find

local Vector                  = Vector

local ents_FindByClass        = ents.FindByClass
local player_GetAll           = player.GetAll

local Entity_GetAttachment    = debug.getregistry ().Entity.GetAttachment
local Entity_GetBonePosition  = debug.getregistry ().Entity.GetBonePosition
local Entity_GetClass         = debug.getregistry ().Entity.GetClass
local Entity_GetPos           = debug.getregistry ().Entity.GetPos
local Entity_IsValid          = debug.getregistry ().Entity.IsValid
local Entity_LocalToWorld     = debug.getregistry ().Entity.LocalToWorld
local Entity_LookupAttachment = debug.getregistry ().Entity.LookupAttachment
local Entity_LookupBone       = debug.getregistry ().Entity.LookupBone
local Entity_OBBCenter        = debug.getregistry ().Entity.OBBCenter
local Entity_Visible          = debug.getregistry ().Entity.Visible

local Vector_Dot              = debug.getregistry ().Vector.Dot
local Vector_Normalize        = debug.getregistry ().Vector.Normalize
local Vector_Length           = debug.getregistry ().Vector.Length
local Vector___add            = debug.getregistry ().Vector.__add
local Vector___sub            = debug.getregistry ().Vector.__sub

CAC.ShotHandler = {}

function CAC.ShotHandler.IsPotentialTarget (ply, entity)
	if not entity then return false end
	if not Entity_IsValid (entity) then return false end
	
	if entity:IsPlayer () then return true end
	if string_find (Entity_GetClass (entity), "npc_") then return true end
	
	return false
end

function CAC.ShotHandler.GetPotentialTargetList (ply, out)
	out = out or {}
	
	local count = 0
	for _, v in ipairs (player_GetAll ()) do
		if v ~= ply then
			count = count + 1
			out [count] = v
		end
	end
	
	for _, v in ipairs (ents_FindByClass ("*npc_*")) do
		count = count + 1
		out [count] = v
	end
	
	return out, count
end

local temp = {}
function CAC.ShotHandler.GetVisiblePotentialTargetList (ply, out)
	out = out or {}
	
	local unfiltered, unfilteredCount = CAC.ShotHandler.GetPotentialTargetList (ply, temp)
	
	local count = 0
	for i = 1, unfilteredCount do
		if Entity_Visible (ply, unfiltered [i]) then
			count = count + 1
			out [count] = unfiltered [i]
		end
	end
	
	return out
end

local npcBones = {
	["npc_antlion"]          = "Antlion.Head_Bone",
	["npc_antlion_worker"]   = "Antlion.Head_Bone",
	["npc_antlionguard"]     = "Antlion_Guard.head",
	["npc_dog"]              = "Dog_Model.Eye",
	["npc_fastzombie"]       = "ValveBiped.Bip01_Spine4",
	["npc_fastzombie_torso"] = "ValveBiped.Bip01_Spine2",
	["npc_headcrab"]         = "HeadcrabClassic.BodyControl",
	["npc_headcrab_black"]   = "HCblack.torso",
	["npc_headcrab_fast"]    = "HCfast.chest",
	["npc_hunter"]           = "MiniStrider.antennaBase",
	["npc_turret_floor"]     = "Gun",
	["npc_vortigaunt"]       = "ValveBiped.head",
	["npc_zombie"]           = "ValveBiped.Bip01_Spine4",
	["npc_zombie_torso"]     = "ValveBiped.Bip01_Spine2"
}

local npcOffsets = {
	["npc_headcrab"] = Vector (0, 0, 8)
}

local fallbackAttachments = {
	"eyes",
	"anim_attachment_head"
}

local fallbackBones = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_Neck1",
	"ValveBiped.Bip01_Spine4"
}

function CAC.ShotHandler.GetTargetHeadPosition (target)
	if not target then return nil end
	if not Entity_IsValid (target) then return nil end
	
	local offset = npcOffsets [Entity_GetClass (target)] or Vector (0, 0, 0)
	
	-- NPC bones
	local headBoneName = npcBones [Entity_GetClass (target)]
	local headBoneID = headBoneName and Entity_LookupBone (target, headBoneName) or nil
	if headBoneID and headBoneID >= 1 then
		return Vector___add (Entity_GetBonePosition (target, headBoneID), offset)
	end
	
	-- Attachments
	for _, attachmentName in ipairs (fallbackAttachments) do
		local attachmentId = Entity_LookupAttachment (target, attachmentName)
		if attachmentId and attachmentId >= 1 then
			return Vector___add (Entity_GetAttachment (target, attachmentId).Pos, offset)
		end
	end
	
	-- Biped bones
	for _, boneName in ipairs (fallbackBones) do
		local boneId = Entity_LookupBone (target, boneName)
		if boneId and boneId >= 1 then
			return Vector___add (Entity_GetBonePosition (target, boneId), offset)
		end
	end
	
	return Vector___add (Entity_GetPos (target), offset)
end

function CAC.ShotHandler.CalculateAngularErrorFromTrace (trace, targetPosition)
	if not targetPosition then return nil end
	
	-- Calculate normalized trace direction
	local traceDirection = Vector___sub (trace.HitPos, trace.StartPos)
	Vector_Normalize (traceDirection)
	
	-- Calculate target direction
	local targetDirection = Vector___sub (targetPosition, trace.StartPos)
	Vector_Normalize (targetDirection)
	
	return math_deg (math_acos (Vector_Dot (traceDirection, targetDirection)))
end

function CAC.ShotHandler.GetIntendedTarget (ply, trace)
	local minimumCosine = math_cos (math_rad (30))
	
	-- Calculate normalized trace direction
	local traceDirection = Vector___sub (trace.HitPos, trace.StartPos)
	Vector_Normalize (traceDirection)
	
	-- Check if the trace hit a possible target
	if CAC.ShotHandler.IsPotentialTarget (ply, trace.Entity) then
		local midpoint = Entity_LocalToWorld (trace.Entity, Entity_OBBCenter (trace.Entity))
		local playerToTargetMidpoint = Vector___sub (midpoint, trace.StartPos)
		local midpointAngularError = math_deg (math_acos (Vector_Dot (playerToTargetMidpoint, traceDirection) / Vector_Length (playerToTargetMidpoint)))
		
		return trace.Entity, midpointAngularError
	end
	
	-- Otherwise try to find the target with the least angular error
	local bestCosine       = -math_huge
	local bestTargetEntity = nil
	
	for _, v in ipairs (CAC.ShotHandler.GetVisiblePotentialTargetList (ply)) do
		local midpoint = Entity_LocalToWorld (v, Entity_OBBCenter (v))
		local playerToTargetMidpoint = Vector___sub (midpoint, trace.StartPos)
		local midpointAngularErrorCosine = Vector_Dot (playerToTargetMidpoint, traceDirection) / Vector_Length (playerToTargetMidpoint)
		
		if midpointAngularErrorCosine > bestCosine then
			bestCosine       = midpointAngularErrorCosine
			bestTargetEntity = v
		end
	end
	
	-- Avoid reporting targets with too high an angular error
	if bestCosine <= minimumCosine then return nil, nil end
	
	if not bestTargetEntity then return nil, nil end
	
	return bestTargetEntity, math_deg (math_acos (bestCosine))
end

hook.Add ("EntityFireBullets", "CAC.ShotHandler",
	function (entity, bulletInfo)
		if not entity:IsPlayer () then return end
		
		-- {
		--     AmmoType    = "AR2",
		--     Attacker    = <Entity>: [NULL Entity]>,
		--     Callback    = function:(lua/fast_addons/server/bullet_penetration.lua : 161-172),
		--     Damage      = 0,
		--     Dir         = Vector (-  0.607009,     0.740185, -    0.289249),
		--     Distance    = 56755.83984375,
		--     Force       = 1,
		--     HullSize    = 0,
		--     Num         = 1, -- More than 1 for shotguns.
		--     Spread      = Vector (   0.026180,     0.026180,      0.026180),
		--     Src         = Vector ( 925.675720, -9356.741211, -12815.748047),
		--     Tracer     = 2,
		--     TracerName = "Tracer"
		-- }
		
		local t0 = SysTime()
		local trace = util.QuickTrace (bulletInfo.Src, bulletInfo.Dir * math_sqrt (32768 * 32768 * 3), entity)
		local target, midpointAngularError = CAC.ShotHandler.GetIntendedTarget (entity, trace)
		local headAngularError = CAC.ShotHandler.CalculateAngularErrorFromTrace (trace, CAC.ShotHandler.GetTargetHeadPosition (target))
		print (bulletInfo.Num)
		print (GLib.FormatDuration (SysTime () - t0))
		print (target, midpointAngularError, headAngularError)
		
		local originalCallback = bulletInfo.Callback
		
		-- Callback can be called multiple times (eg. for shotgun)
		bulletInfo.Callback = function (ply, trace, damageInfo, ...)
			-- {
			--     Entity            = player.GetByID (1) --[[ BOT, Bot01 ]],
			--     Fraction          =      0.0011311625130475,
			--     FractionLeftSolid =      0,
			--     Hit               = true,
			--     HitBox            =     15,
			--     HitBoxBone        =      0 or nil,
			--     HitGroup          =      3,
			--     HitNoDraw         = false,
			--     HitNonWorld       = true,
			--     HitNormal         = Vector (-    0.034823954105377 ,      0.99938470125198  ,      0.004182904958725 ),
			--     HitPos            = Vector (- 6347.3442382812      ,   3815.4582519531      , -15809.370117188       ),
			--     HitSky            = false,
			--     HitTexture        = "**studio**" or "PROPS/CARPETFLOOR001A",
			--     HitWorld          = false,
			--     MatType           =     70,
			--     Normal            = Vector (-    0.40824568271637  , -    0.87170422077179  , -    0.27104830741882  ),
			--     PhysicsBone       =      0,
			--     StartPos          = Vector (- 6321.134765625       ,   3871.421875          , -15791.96875           ),
			--     StartSolid        = false,
			--     SurfaceProps      =     39
			-- }
			
			local t0 = SysTime()
			local target, midpointAngularError = CAC.ShotHandler.GetIntendedTarget (entity, trace)
			local headAngularError = CAC.ShotHandler.CalculateAngularErrorFromTrace (trace, CAC.ShotHandler.GetTargetHeadPosition (target))
			print (GLib.FormatDuration (SysTime () - t0))
			print (">" , target, midpointAngularError, headAngularError)
			
			if originalCallback then
				return originalCallback (ply, trace, damageInfo, ...)
			end
		end

	end
)

CAC:AddEventListener ("Unloaded",
	function ()
		hook.Remove ("EntityFireBullets", "CAC.ShotHandler")
	end
)