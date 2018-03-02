VA.PhysObj = VA.PhysObj or {}

local tostring                 = tostring

local PhysObj_IsValid          = debug.getregistry ().PhysObj.IsValid
local PhysObj_IsMotionEnabled  = debug.getregistry ().PhysObj.IsMotionEnabled
local PhysObj_EnableMotion     = debug.getregistry ().PhysObj.EnableMotion
local PhysObj_GetMass          = debug.getregistry ().PhysObj.GetMass
local PhysObj_GetPos           = debug.getregistry ().PhysObj.GetPos
local PhysObj_GetAngles        = debug.getregistry ().PhysObj.GetAngles
local PhysObj_GetVelocity      = debug.getregistry ().PhysObj.GetVelocity
local PhysObj_GetAngleVelocity = debug.getregistry ().PhysObj.GetAngleVelocity
local PhysObj_SetPos           = debug.getregistry ().PhysObj.SetPos
local PhysObj_SetAngles        = debug.getregistry ().PhysObj.SetAngles
local PhysObj_SetVelocity      = debug.getregistry ().PhysObj.SetVelocity

local Vector_Zero              = Vector (0, 0, 0)
local Angle_Zero               = Angle (0, 0, 0)

local VA_Vector_IsFinite       = VA.Vector.IsFinite
local VA_Vector_IsSanePosition = VA.Vector.IsSanePosition
local VA_Angle_IsFinite        = VA.Angle.IsFinite
local VA_Angle_IsSane          = VA.Angle.IsSane

function VA.PhysObj.IsFinite (physObj)
	if not PhysObj_IsValid (physObj) then return true end
	
	if not VA_Vector_IsFinite (PhysObj_GetPos           (physObj)) then return false end
	if not VA_Angle_IsFinite  (PhysObj_GetAngles        (physObj)) then return false end
	if not VA_Vector_IsFinite (PhysObj_GetVelocity      (physObj)) then return false end
	if not VA_Vector_IsFinite (PhysObj_GetAngleVelocity (physObj)) then return false end
	
	return true
end
if Profiler then VA.PhysObj.IsFinite = Profiler:Wrap (VA.PhysObj.IsFinite, "VA.PhysObj.IsFinite") end

function VA.PhysObj.IsSane (physObj)
	if not PhysObj_IsValid (physObj) then return true end
	
	if not VA_Vector_IsSanePosition (PhysObj_GetPos           (physObj)) then return false end
	if not VA_Angle_IsSane          (PhysObj_GetAngles        (physObj)) then return false end
	if not VA_Vector_IsFinite       (PhysObj_GetVelocity      (physObj)) then return false end
	if not VA_Vector_IsFinite       (PhysObj_GetAngleVelocity (physObj)) then return false end
	
	return true
end
if Profiler then VA.PhysObj.IsSane = Profiler:Wrap (VA.PhysObj.IsSane, "VA.PhysObj.IsSane") end

function VA.PhysObj.IsOctreeSane (physObj)
	if not PhysObj_IsValid (physObj) then return true end
	
	if not VA_Vector_IsSanePosition (PhysObj_GetPos (physObj)) then return false end
	
	return true
end
if Profiler then VA.PhysObj.IsOctreeSane = Profiler:Wrap (VA.PhysObj.IsOctreeSane, "VA.PhysObj.IsOctreeSane") end

function VA.PhysObj.Defuse (physObj, disableMotionWhenDone)
	VA.PhysObj.Print (physObj)
	if not PhysObj_IsValid (physObj) then return end
	
	local finished = true
	
	local position        = PhysObj_GetPos           (physObj)
	local angle           = PhysObj_GetAngles        (physObj)
	local velocity        = PhysObj_GetVelocity      (physObj)
	local angularVelocity = PhysObj_GetAngleVelocity (physObj)
	
	local i = 0
	while i < 5 and
		  (not VA_Vector_IsFinite (position       ) or
		   not VA_Angle_IsFinite  (angle          ) or
		   not VA_Vector_IsFinite (velocity       ) or
		   not VA_Vector_IsFinite (angularVelocity)) do
		i = i + 1
		
		-- If position is not zeroed before angle,
		-- *** ERROR *** Excessive sizelevel (##) for element spam can happen with ragdolls
		if not VA_Vector_IsFinite (position) then
			PhysObj_SetPos (physObj, Vector_Zero)
			VA.Print ("\t        { [Iteration " .. i .. "] Position zeroed, was [" .. tostring (position) .. "]. }")
			finished = false
		end
		
		if not VA_Angle_IsFinite  (angle) then
			PhysObj_SetAngles (physObj, Angle_Zero)
			VA.Print ("\t        { [Iteration " .. i .. "] Angle zeroed, was (" .. tostring (angle) .. "). }")
			finished = false
		end
		
		-- If angle is not zeroed before position, position
		-- may instantly snap back to a non-finite value.
		position = PhysObj_GetPos (physObj)
		if not VA_Vector_IsFinite (position) then
			PhysObj_SetPos (physObj, Vector_Zero)
			VA.Print ("\t        { [Iteration " .. i .. "] Position zeroed, was [" .. tostring (position) .. "]. }")
			finished = false
		end
		if not VA_Vector_IsFinite (velocity) then
			PhysObj_SetVelocity (physObj, Vector_Zero)
			VA.Print ("\t        { [Iteration " .. i .. "] Velocity zeroed, was [" .. tostring (velocity) .. "]. }")
			finished = false
		end
		
		if VA_Vector_IsFinite (PhysObj_GetPos (physObj)) and
		   VA_Angle_IsFinite (PhysObj_GetAngles (physObj)) and
		   not VA_Vector_IsFinite (angularVelocity) then
			local motionEnabled = PhysObj_IsMotionEnabled (physObj)
			PhysObj_EnableMotion (physObj, true)
			PhysObj_EnableMotion (physObj, false)
			PhysObj_EnableMotion (physObj, motionEnabled)
			VA.Print ("\t        { [Iteration " .. i .. "] Angular velocity zeroed, was [" .. tostring (angularVelocity) .. "]. }")
			finished = false
		end
		
		position        = PhysObj_GetPos           (physObj)
		angle           = PhysObj_GetAngles        (physObj)
		velocity        = PhysObj_GetVelocity      (physObj)
		angularVelocity = PhysObj_GetAngleVelocity (physObj)
	end
	
	if not VA_Vector_IsFinite (angularVelocity) then
		VA.Print ("\t        { [Iteration " .. i .. "] Cannot zero angular velocity ([" .. tostring (angularVelocity) .. "])! }")
	end
	
	if (not VA_Vector_IsFinite (position       ) or
		not VA_Angle_IsFinite  (angle          ) or
		not VA_Vector_IsFinite (velocity       ) or
		not VA_Vector_IsFinite (angularVelocity)) then
		VA.Print ("\t        { ABORTING, PhysObj still not finite after 5 iterations. }")
	elseif disableMotionWhenDone then
		PhysObj_EnableMotion (physObj, false)
	end
end

function VA.PhysObj.Print (physObj)
	if PhysObj_IsValid (physObj) then
		VA.Print ("\tPhysObj { " .. PhysObj_GetMass (physObj) .. " kg at [" .. tostring(PhysObj_GetPos (physObj)) .. "] ∠(" .. tostring(PhysObj_GetAngles (physObj)) .. ") }")
		VA.Print ("\t        { moving at [" .. tostring(PhysObj_GetVelocity (physObj)) .. "] ∠[" .. tostring(PhysObj_GetAngleVelocity (physObj)) .. "] }")
	else
		VA.Print ("\tPhysObj { Invalid }")
	end
end
