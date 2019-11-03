print("Loaded anti-ragdoll!")

util.AddNetworkString("MoatSendLua")

local function KillRagdolls()
    local e = ents.FindByClass("prop_ragdoll")

    for k, v in pairs(e) do
        if (v:IsValid()) then
            v:SetVelocity(vector_origin)

            for i = 0, v:GetPhysicsObjectCount() - 1 do
                local subphys = v:GetPhysicsObjectNum(i)

                if (IsValid(subphys)) then
                    subphys:EnableMotion(false)
                    subphys:SetMass(subphys:GetMass() * 20)
                    subphys:SetVelocity(vector_origin)
                    subphys:Sleep()
                    subphys:RecheckCollisionFilter()
                    subphys:SetMass(subphys:GetMass() / 20)
                    subphys:EnableMotion(true)
                end
            end

            v:CollisionRulesChanged()
        end
    end
end

function BroadcastLua(str)
    if (str == 'chat.AddText("[GMCPanel] We have frozen all props to stop a srvr; crash.")') then
        KillRagdolls()

        return
    end

    net.Start("MoatSendLua")
    net.WriteString(str)
    net.Broadcast()
end

local freezespeed = 2500
local removespeed = 1000

function CheckForBuggedRagdolls()
	for k, ent in pairs(ents.FindByClass("prop_ragdoll")) do
		if IsValid(ent) then
			if ent.player_ragdoll then
                local velo = ent:GetVelocity():Length()
                local ply = false
				
				if (!ent.IS_HELD) then
					if velo >= removespeed then
						ent:Remove()
						ServerLog("Caught ragdoll entity moving too fast ("..velo.."), removing offending ragdoll entity from world.\n")
						local messageToShow = "A ragdoll was prevented from crashing the server!("
						
						if CORPSE.GetFound(ent, true) then
							PrintMessage(HUD_PRINTTALK, messageToShow .. "unID'd body)")
						else
							PrintMessage(HUD_PRINTTALK, messageToShow .. ent:GetNW2String("nick") .. "'s body)")
						end
					elseif velo >= freezespeed then
						AMB_KillVelocity(ent)
						ServerLog("[!CRASHCATCHER!] Caught ragdoll entity moving too fast ("..velo.."), disabling motion. \n")
					end
				end
			end
		end
	end
end

timer.Create("moat_checkForBuggedRags", 2, 0, function()
	CheckForBuggedRagdolls()
end)

function AMB_SetSubPhysMotionEnabled(ent, enable)
	if not IsValid(ent) then return end
   
	ent:SetVelocity(vector_origin)
       
	if !(enable) then
		ent:SetColor(Color(255,0,255,255))
	else
		ent:SetColor(Color(255,255,255,255))
	end
       
	if !(enable) then
		if IsValid(ent:GetOwner()) then
			ent:GetOwner():GetWeapon("weapon_zm_carry"):Reset(false)
		end
	end
 
	for i=0, ent:GetPhysicsObjectCount()-1 do
		local subphys = ent:GetPhysicsObjectNum(i)
		if IsValid(subphys) then
			subphys:EnableMotion(enable)
			if !(enable) then
				subphys:SetVelocity(vector_origin)
				subphys:SetMass(subphys:GetMass()*20)
			end
			if enable then
				subphys:SetMass(subphys:GetMass()/20)
				subphys:Wake()
			end
		end
    end   
 
	ent:SetVelocity(vector_origin)
end
 
function AMB_KillVelocity(ent)
   AMB_SetSubPhysMotionEnabled(ent, false)
   timer.Simple(3, function() AMB_SetSubPhysMotionEnabled(ent, true) end)
end