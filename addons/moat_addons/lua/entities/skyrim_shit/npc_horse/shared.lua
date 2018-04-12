ENT.Base = "npc_creature_base"
ENT.Type = "ai"
function ENT:Interaction()
	local ent = self:GetNetworkedEntity("mount")
	if(ent:IsValid() && ent == LocalPlayer()) then return "Dismount" end
	return "Mount"
end
function ENT:CanInteract(pl)
	local ent = pl:GetNetworkedEntity("mount")
	if(!ent:IsValid() || ent == self) then return true end
	return false
end

ENT.PrintName = "Horse"
ENT.Category = "Skyrim"
//ENT.NPCID = "0005PQS3"

function ENT:IsMounted() return self:GetNetworkedBool("mounted") end

hook.Add("CalcMainActivity","playermount",function(pl,vel)
	local ent = pl:GetNetworkedEntity("mount")
	if(ent:IsValid()) then return ACT_HL2MP_IDLE_CROUCH_KNIFE,-1 end
end)

function ENT:Name()
	local owner = self:GetNetworkedEntity("plOwner")
	if(owner:IsValid()) then return owner:GetName() .. "'s Horse" end
	return "Horse"
end

if(CLIENT) then
	language.Add("npc_horse","Horse")
	hook.Add("CalcCamOrigin","playermount",function()
		local pl = LocalPlayer()
		local ent = pl:GetNetworkedEntity("mount")
		if(ent:IsValid()) then
			local att = ent:LookupAttachment("mount")
			att = ent:GetAttachment(att)
			if(att) then
				return att.Pos +Vector(0,0,20)
			end
		end
	end)
end