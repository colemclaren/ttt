hook.Remove("PlayerTick", "TickWidgets")

VA = VA or {}

function VA.Print (message)
	if epoe then
		epoe.PushPayload(epoe.IS_MSGN, "[VPhysics Airbag] " .. message)
	end
	
	ServerLog ("[VPhysics Airbag] " .. message .. "\n")
end

function VA.Broadcast (message)
	VA.Print (message)
	
	for _, v in ipairs (player.GetAll ()) do
		if v:IsAdmin () then
			v:ChatPrint ("[VPhysics Airbag] " .. message)
		end
	end
end

function VA.CrashPrevented (ent, message)
	message = message or ""
	
	if #message > 0 then
		message = ", " .. message
	end
	
	local owner = ent.CPPIGetOwner and ent:CPPIGetOwner ()
	VA.Broadcast ("Prevented VPhysics crash due to non-finite entity " .. VA.Entity.ToString (ent) .. ", owned by " .. VA.Entity.ToString (owner) .. message)
end

include ("math.lua")
include ("enumerator.lua")
include ("physobj.lua")
include ("entity.lua")
include ("ragdolls.lua")

VA.Ragdolls.Initialize ()

-- Players are resistant to removal, fix up their PhysObjs
function VA.ProcessPlayers ()
	if Profiler then Profiler:Begin ("VA.ProcessPlayers") end
	
	for _, ply in pairs (player.GetAll ()) do
		if not VA.Entity.IsFinite (ply) then
			VA.Print ("\tFound " .. VA.Entity.ToString (ply) .. " with " .. ply:GetPhysicsObjectCount () .. " PhysObj(s) at [" .. tostring (ply:GetPos ()) .. "] ∠(" .. tostring (ply:GetAngles ()) .. ")")
			
			VA.Entity.PrintPhysObjs (ply)
			
			-- Do not attempt to zero out non-finite PhysObj fields
			-- Adjusting the position (before removal?) seems to fuck up collisions
			
			-- This PhysObj is tainted, give the player a new one
			ply:PhysicsDestroy ()
			ply:Spawn ()
			
			ply:ChatPrint ("You feel like you are become nan, destroyer of octrees.")
			ply:ChatPrint ("The feeling passes...")
			
			VA.Print ("\t\tConfiscated PhysObj and gave the player a new one.")
			VA.CrashPrevented (ply, "caused by a non-finite prop colliding with the player.")
		end
	end
	
	if Profiler then Profiler:End () end
end

hook.Add ("Think", "VA.Think",
	function ()
		if Profiler then Profiler:Begin ("VA.Think") end
		
		local shouldProcessPlayers = false
		
		for ent in VA.Ragdolls.GetEnumerator () do
			if VA.Entity.IsAwake (ent) then
				if not VA.Entity.IsFinite (ent) then
					local owner = ent.CPPIGetOwner and ent:CPPIGetOwner ()
					VA.Print ("Non-finite " .. VA.Entity.ToString (ent) .. " owned by " .. VA.Entity.ToString (owner) .. (ent:IsPlayerHolding () and ", held by player" or ""))
					VA.Entity.Process (ent, false)
					
					shouldProcessPlayers = true
				end
				-- elseif not VA.Entity.IsSane (ent) then
				-- 	local owner = ent.CPPIGetOwner and ent:CPPIGetOwner ()
				-- 	VA.Print ("Non-sane " .. VA.Entity.ToString (ent) .. " owned by " .. VA.Entity.ToString (owner) .. (ent:IsPlayerHolding () and ", held by player" or ""))
				-- 	VA.Entity.PrintPhysObjs (ent)
				-- end
			end
		end
		
		-- if shouldProcessPlayers then
			VA.ProcessPlayers ()
		-- end
		
		if Profiler then Profiler:End () end
	end
)

hook.Add ("EntityRemoved", "VA.EntityRemoved",
	function (ent)
		if VA.Entity.IsFinite (ent) then return end
		
		local owner = ent.CPPIGetOwner and ent:CPPIGetOwner ()
		VA.Print ("Removal of non-finite " .. VA.Entity.ToString (ent) .. " owned by " .. VA.Entity.ToString (owner) .. (ent:IsPlayerHolding () and ", held by player" or ""))
		VA.Entity.Process (ent, true)
		
		-- Players are resistant to removal, fix up their PhysObjs
		VA.ProcessPlayers ()
	end
)
