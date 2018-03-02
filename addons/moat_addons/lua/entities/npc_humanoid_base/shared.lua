ENT.Base = "npc_creature_base"
ENT.Type = "ai"

function ENT:OnGestureEnded(name)
	if(name == "1hmidletoshieldidle" || name == "shieldblock" || name == "shieldhit") then
		if(CLIENT) then
			self:PlayGesture("shieldblock")
			self:MaintainAnimation(1)
		end
	end
	if(name == "bow_draw" || name == "bow_drawidle") then
		local wep = self:GetActiveWeapon()
		if(CLIENT) then
			self:PlayGesture("bow_drawidle")
			self:MaintainAnimation(1)
		elseif(name == "bow_draw") then
			self.m_cspPull = CreateSound(self,"weapons/bow/bow_pull0" .. math.random(1,3) .. ".mp3")
			self.m_cspPull:Play()
			self:StopSoundOnDeath(self.m_cspPull)
		end
	end
end

if(CLIENT) then
	if(Swords_Installed) then
		net.Receive("sky_swords_parry",function(len)
			local ent = net.ReadEntity()
			local bParry = net.ReadUInt(1) == 1
			if(!ent:IsValid()) then return end
			ent.Parry = bParry
		end)
		function ENT:Initialize()
			net.Start("sky_swords_parry_req")
				net.WriteEntity(self)
			net.SendToServer()
		end
	end
	net.Receive("sky_human_arrow",function(len)
		local npc = net.ReadEntity()
		if(!npc:IsValid()) then return end
		local idx = npc:EntIndex()
		local ent = ClientsideModel("models/skyrim/weapons/draugrarrow.mdl")
		local hk = "sky_human_arrow" .. idx
		hook.Add("Think",hk,function()
			if(!npc:IsValid()) then
				if(ent:IsValid()) then ent:Remove() end
				hook.Remove("Think",hk)
			else
				local attID = npc:LookupAttachment("arrow")
				local att = npc:GetAttachment(attID)
				local attIDBow = npc:LookupAttachment("bow_string")
				local attBow = npc:GetAttachment(attIDBow)
				ent:SetPos(att.Pos)
				local ang = (att.Pos -attBow.Pos):Angle()
				ent:SetAngles(ang)
			end
		end)
		npc.m_entArrow = ent
	end)
	net.Receive("sky_human_arrow_undeploy",function(len)
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local entArrow = ent.m_entArrow
		if(!IsValid(entArrow)) then return end
		entArrow:Remove()
		hook.Remove("Think","sky_human_arrow" .. ent:EntIndex())
	end)
	net.Receive("sky_human_poss",function(len)
		local start = net.ReadUInt(1) == 1
		if(!start) then
			hook.Remove("PlayerBindPress","possdraugrswitchweapon")
			return
		end
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		hook.Add("PlayerBindPress","possdraugrswitchweapon",function(pl,bind,pressed)
			if(!ent:IsValid()) then hook.Remove("PlayerBindPress","possdraugrswitchweapon")
			elseif(pressed) then
				bind = string.lower(bind)
				if(string.find(bind,"invprev")) then
					net.Start("sky_human_poss_wep")
						net.WriteUInt(0,1)
					net.SendToServer()
					return true
				elseif(string.find(bind,"invnext")) then
					net.Start("sky_human_poss_wep")
						net.WriteUInt(1,1)
					net.SendToServer()
					return true
				end
			end
		end)
	end)
end