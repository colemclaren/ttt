local _R = debug.getregistry()
if(!GAMEMODE.Aftermath) then
	hook.Add("OnEntityCreated","slv_npcupdaterelationships",function(ent) // Need to apply relationships manually for vanilla NPCs
		if(ent:IsValid() && ent:IsNPC() && !ent.bScripted) then
			timer.Simple(0,function() // Wait for it to initialize properly
				if(ent:IsValid()) then
					for _,entTgt in ipairs(ents.GetAll()) do
						if(entTgt:IsNPC() && entTgt != ent && entTgt.bScripted) then
							local b,e = pcall(entTgt.UpdateFactionRelationship,entTgt,ent)
							if(!b) then ErrorNoHalt(e) end
						end
					end
				end
			end)
		end
	end)
end
function ENT:GetNPCFaction() return self.NPCFaction || NPC_FACTION_NONE end

function ENT:GetFactionDisposition(tgt)
	local faction = self:GetNPCFaction()
	local factionTgt
	if(type(tgt) == "number") then factionTgt = tgt
	elseif(type(tgt) == "string") then
		faction = _R.NPCFaction.GetFaction(faction)
		return (self.m_tbFactionDisp && self.m_tbFactionDisp[faction:GetID()]) || faction:Disposition(tgt)
	elseif(type(tgt) != "table") then
		faction = _R.NPCFaction.GetFaction(faction)
		return (self.m_tbFactionDisp && self.m_tbFactionDisp[faction:GetID()]) || faction:Disposition(tgt)
	else factionTgt = tgt end
	return (self.m_tbFactionDisp && self.m_tbFactionDisp[faction:GetID()]) || faction:GetFactionDisposition(factionTgt)
end

function ENT:UpdateFactionRelationships()
	local faction = self:GetNPCFaction()
	faction = _R.NPCFaction.GetFaction(faction)
	for _,ent in ipairs(ents.GetAll()) do
		if((ent:IsNPC() || ent:IsPlayer()) && ent != self) then
			local rel = gamemode.Call("SetupRelationship",self,ent)
			if(rel != true) then
				if(!self:ApplyCustomEntityDisposition(ent) && !self:ApplyCustomClassDisposition(ent) && !self:ApplyCustomFactionDisposition(ent)) then
					if(ent:IsPlayer() || ((!ent.ApplyCustomEntityDisposition || !ent:ApplyCustomEntityDisposition(self)) && (!ent.ApplyCustomClassDisposition || !ent:ApplyCustomClassDisposition(self)) && (!ent.ApplyCustomFactionDisposition || !ent:ApplyCustomFactionDisposition(self)))) then
						local disp
						if(ent:IsPlayer() && ent.GetFaction) then
							local factionPl = ent:GetFaction()
							if(!ent:IsWearingFactionArmor()) then factionPl = FACTION_NONE end
							disp = faction:GetPlayerFactionDisposition(factionPl)
						else disp = faction:Disposition(ent) end
						self:AddEntityRelationship(ent,disp,100)
						if(ent:IsNPC()) then ent:AddEntityRelationship(self,disp,100) end
					end
				end
			end
		end
	end
end

function ENT:UpdateFactionRelationship(ent)
	if(self:ApplyCustomEntityDisposition(ent) || self:ApplyCustomClassDisposition(ent) || self:ApplyCustomFactionDisposition(ent)) then return end
	local faction = self:GetNPCFaction()
	if(faction == NPC_FACTION_NONE) then return end
	faction = _R.NPCFaction.GetFaction(faction)
	local disp = faction:Disposition(ent)
	self:AddEntityRelationship(ent,disp,100)
	if(ent:IsNPC()) then ent:AddEntityRelationship(self,disp,100) end
end

function ENT:SetNPCFaction(faction)
	self.NPCFaction = faction
	if(!self.m_bInitialized) then return end
	self:UpdateFactionRelationships()
end

function ENT:ApplyCustomFactionDisposition(ent)
	if(!self.m_tbFactionDisp) then return false end
	local faction
	if(ent:IsNPC()) then if(!ent.GetNPCFaction) then return false end; faction = ent:GetNPCFaction()
	elseif(!ent.GetFaction) then return false
	else faction = GAMEMODE:PlayerFactionToNPCFaction(ent:GetFaction()) end
	if(self.m_tbFactionDisp[faction]) then
		local disp = self.m_tbFactionDisp[faction]
		self:AddEntityRelationship(ent,disp,100)
		if(ent:IsNPC()) then ent:AddEntityRelationship(self,disp,100) end
		return true
	end
	return false
end

function ENT:ApplyCustomClassDisposition(ent)
	if(!self.m_tbFactionDisp) then return false end
	local class = ent:GetClass()
	if(!self.m_tbFactionDisp[class]) then return false end
	local disp = self.m_tbFactionDisp[class]
	self:AddEntityRelationship(ent,disp,100)
	if(ent:IsNPC()) then ent:AddEntityRelationship(self,disp,100) end
	return true
end

function ENT:ApplyCustomEntityDisposition(ent)
	if(!self.m_tbEntDisp || !self.m_tbEntDisp[ent]) then return false end
	local disp = self.m_tbEntDisp[class]
	self:AddEntityRelationship(ent,disp,100)
	if(ent:IsNPC()) then ent:AddEntityRelationship(self,disp,100) end
	return true
end

function ENT:AddFactionDisposition(faction,disp)
	self.m_tbFactionDisp = self.m_tbFactionDisp || {}
	self.m_tbFactionDisp[faction] = disp
end

function ENT:AddClassDisposition(class,disp)
	self.m_tbClassDisp = self.m_tbClassDisp || {}
	self.m_tbClassDisp[class] = disp
end

function ENT:AddEntityDisposition(ent,disp)
	self.m_tbEntDisp = self.m_tbEntDisp || {}
	self.m_tbEntDisp[ent] = disp
end