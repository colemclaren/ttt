VA.Entity = VA.Entity or {}

local PhysObj_IsAsleep = debug.getregistry ().PhysObj.IsAsleep

function VA.Entity.PhysObjEnumerator (ent)
	local i = 0
	local physObjCount = ent:GetPhysicsObjectCount ()
	if ent:EntIndex () == 0 then physObjCount = 1 end
	
	return function ()
		if i >= physObjCount then return nil end
		local physObj = ent:GetPhysicsObjectNum (i)
		i = i + 1
		return physObj
	end
end

function VA.Entity.IsFinite (ent)
	return VA.Enumerator.All (VA.Entity.PhysObjEnumerator (ent), VA.PhysObj.IsFinite)
end
if Profiler then VA.Entity.IsFinite = Profiler:Wrap (VA.Entity.IsFinite, "VA.Entity.IsFinite") end

function VA.Entity.IsSane (ent)
	return VA.Enumerator.All (VA.Entity.PhysObjEnumerator (ent), VA.PhysObj.IsSane)
end
if Profiler then VA.Entity.IsSane = Profiler:Wrap (VA.Entity.IsSane, "VA.Entity.IsSane") end

function VA.Entity.IsAsleep (ent)
	return VA.Enumerator.All (VA.Entity.PhysObjEnumerator (ent), PhysObj_IsAsleep)
end
if Profiler then VA.Entity.IsAsleep = Profiler:Wrap (VA.Entity.IsAsleep, "VA.Entity.IsAsleep") end

function VA.Entity.IsAwake (ent)
	return VA.Enumerator.Any (VA.Entity.PhysObjEnumerator (ent),
		function (physObj)
			return not PhysObj_IsAsleep (physObj)
		end
	)
end
if Profiler then VA.Entity.IsAwake = Profiler:Wrap (VA.Entity.IsAwake, "VA.Entity.IsAwake") end

function VA.Entity.IsOctreeSane (ent)
	return VA.Enumerator.All (VA.Entity.PhysObjEnumerator (ent), VA.PhysObj.IsOctreeSane)
end

function VA.Entity.Defuse (ent, disableMotionWhenDone)
	VA.Enumerator.ForEach (VA.Entity.PhysObjEnumerator (ent), VA.PhysObj.Defuse, disableMotionWhenDone)
	
	if ent:GetClass () == "npc_dog" or ent:GetModel () == "models/dog.mdl" then
		VA.Print ("\t* Dog defused!")
	end
end

function VA.Entity.PrintPhysObjs (ent)
	VA.Enumerator.ForEach (VA.Entity.PhysObjEnumerator (ent), VA.PhysObj.Print)
end

function VA.Entity.Process (ent, alreadyRemoving)
	if Profiler then Profiler:Begin ("VA.Entity.Process") end
	
	if ent:IsRagdoll () then
		-- Ragdoll:PhysicsDestroy results in a crash 100% of the time
		-- so we have to try to defuse instead.
		VA.Entity.Defuse (ent, true)
		
		-- Must not remove before the PhysObjs are defused, otherwise
		-- *** ERROR *** Excessive sizelevel (###) for element spam happens
		-- if PhysObj positions are non-finite.
		-- Must not remove on the same simulation frame as position defusal, otherwise
		-- *** ERROR *** Excessive sizelevel (41) for element happens
		if not alreadyRemoving then
			timer.Simple (0.01,
				function ()
					if not ent:IsValid () then return end
					
					VA.Print ("\tRemoving!")
					
					local owner = ent.CPPIGetOwner and ent:CPPIGetOwner ()
					VA.Broadcast ("Attempted to prevent VPhysics crash due to non-finite ragdoll " .. VA.Entity.ToString (ent) .. ", owned by " .. VA.Entity.ToString (owner) .. " but there is still a high chance of a server crash.")
					
					ent:Remove ()
				end
			)
		end
	elseif ent:IsPlayerHolding () then
		-- If physcannon-held nan'd PhysObjs are not defused,
		-- *** ERROR *** Excessive sizelevel (###) for element happens
		-- if PhysObj positions are non-finite.
		VA.Entity.Defuse (ent)
		VA.CrashPrevented (ent, "held with gravity gun.")
		ent:PhysicsDestroy ()
	else
		-- Avoid touching, since this can break collisions and result
		-- in vphysics corruption
		VA.Entity.PrintPhysObjs (ent)
		ent:PhysicsDestroy ()
	end
	
	if Profiler then Profiler:End () end
end

function VA.Entity.ToString (ent)
	if not ent or not ent:IsValid () then return "[NULL]" end
	
	if ent:IsPlayer () then
		return "[" .. ent:EntIndex () .. "] " .. ent:SteamID () .. " (" .. ent:Nick () .. ")"
	else
		return "[" .. ent:EntIndex () .. "] " .. ent:GetClass ()
	end
end
