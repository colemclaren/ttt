net.Receive("Talents.BostonBasher", function()
	surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
end)

net.Receive("Talents.Silenced",function()
	local e = net.ReadEntity()
	if (not IsValid(e)) then return end

	e.Silenced = true
	if not e.Primary then return end

	e.Primary.Sound = Sound( "weapons/usp/usp1.wav" )
	if (e:GetOwner() == LocalPlayer()) then
		chat.AddText(Material("icon16/arrow_refresh.png"),Color(255,255,255),"Your weapon (  ",Color(255,0,0)," " .. e.PrintName .. " ",Color(255,255,255), "  ) is now silenced!")
	end
end)

net.Receive("Switch_wep_primary",function()
	local e = net.ReadEntity()
	local new_primary = net.ReadTable()
	local old_primary = e.Primary
	e.Primary = new_primary
	local n = net.ReadEntity()
	if not e.PrintName then e.PrintName = "" end
	if not n.PrintName then n.PrintName = e.PrintName end
	e.PrintName = "Copied " .. (n.PrintName or e.PrintName)
	if not IsValid(e:GetOwner()) then return end
	if not IsValid(LocalPlayer()) then return end
	if e:GetOwner() == LocalPlayer() then
		old_primary.Damage = math.Round(old_primary.Damage)
		new_primary.Damage = math.Round(new_primary.Damage)
		surface.PlaySound("Resource/warning.wav")
		chat.AddText(Color(255,255,255),"Your weapon turned into a ",Color(0,255,0), e.PrintName,Color(255,255,255), ", with ",Color(255,0,0),tostring(new_primary.Damage)," (",tostring(old_primary.Damage),"+",tostring(new_primary.Damage - old_primary.Damage),") DMG",Color(255,255,255)," and ",Color(255,0,0),tostring(net.ReadInt(8)),Color(255,255,255),"  active talents!")
	end
end)

net.Receive("Ass_talent",function()
	chat.AddText(Material("icon16/arrow_refresh.png"),"The body of ",net.ReadString()," is now gone!")
end)

local function talent_chat(new,v,tier,wild)
	local talent_desc = new.Description
	local talent_desctbl = string.Explode("^", talent_desc)
	for i = 1, table.Count(v.m) do
		local mod_num = math.Round(new.Modifications[i].min + ((new.Modifications[i].max - new.Modifications[i].min) * v.m[i]), 1)

		talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
	end
	talent_desc = string.Implode("", talent_desctbl)
    talent_desc = string.Replace(talent_desc, "_", "%")

	talent_desc = string.Grammarfy(talent_desc)
	chat.AddText(Material("icon16/arrow_refresh.png"),"Your ", Color(100,100,255), ( wild and "Wild! - Tier " or "Wildcard: Tier ") .. tostring(tier),Color(255,255,255),(wild and " added " or " turned into "),Color(255,0,0),new.Name,Color(255,255,255)," | ",Color(0,255,0),talent_desc,Color(255,255,255),(wild and " to your gun!" or ""))
end

net.Receive("weapon.UpdateTalents",function()
	local wild = net.ReadBool()
	local wep = net.ReadEntity()
	local tier = net.ReadInt(8)											
	local talent = net.ReadTable()
	talent.Description = talent.Description and string.Grammarfy(talent.Description) or ""
	local t_ = net.ReadTable()
	if (not IsValid(wep)) then return end
	timer.Simple(1,function()
		if (not IsValid(wep)) then return end
		if not wep.ItemStats then
			local s = "TalentUpdate" .. wep:EntIndex() .. tier
			timer.Create(s,0.1,0,function()
				if not IsValid(wep) then timer.Destroy(s) return end
				if wep.ItemStats then
					if not wep.ItemStats.Talents then return end
					table.insert(wep.ItemStats.Talents,talent)
					-- wep.ItemStats.Talents[tier] = talent
					table.insert(wep.ItemStats.t,t_)
					-- wep.ItemStats.t[tier] = t_
					timer.Destroy(s)
				end
			end)
		elseif (wep.ItemStats and wep.ItemStats.Talents) then
			table.insert(wep.ItemStats.Talents,talent)
			-- wep.ItemStats.Talents[tier] = talent
			table.insert(wep.ItemStats.t,t_)
			-- wep.ItemStats.t[tier] = t_
		end
	end)
	if (IsValid(wep) and IsValid(wep:GetOwner()) and wep:GetOwner() == LocalPlayer()) then
		talent_chat(talent,t_,tier,wild)
	end
end) 

local MEME = {}
local WORLDMODELS = {}

function MEME:ViewModelDrawn(old, vm)
    if (self.InsideDraw) then
        return
    end

    self.InsideDraw = true

	vm:DrawModel()
    self.ViewModelFlip = not self.ViewModelFlip
    vm:SetupBones()
	vm:DrawModel()

    self.InsideDraw = false
end

function MEME:DrawWorldModel(old)
    local WorldModel = WORLDMODELS[self.WorldModel]
    local _Owner = self:GetOwner()

    local lp = LocalPlayer()
    if (lp ~= _Owner) then
        if (lp:GetObserverMode() == OBS_MODE_IN_EYE and lp:GetObserverTarget() == _Owner) then
            return
        end
    end

    if (old) then
        old(self)
    else
        self:DrawModel()
	end
	
    if (IsValid(_Owner)) then
		-- Specify a good position
		
		local boneid = _Owner:LookupBone "ValveBiped.Bip01_L_Hand" -- Right Hand
		local b3 = WorldModel:LookupBone "ValveBiped.Bip01_R_Hand"
        if not boneid or not b3 then return end

		local matrix = _Owner:GetBoneMatrix(boneid)
		local mpos, mang
		local m3 = WorldModel:GetBoneMatrix(b3)
		if (m3) then
			mpos, mang = m3:GetTranslation(), m3:GetAngles()
		else
			mpos, mang = WorldModel:GetBonePosition(b3)
		end

		if not matrix or not mpos then return end
		
		local pos, ang = LocalToWorld(vector_origin, Angle(0, 0, 180), matrix:GetTranslation(), matrix:GetAngles())
		local lpos, lang = WorldToLocal(WorldModel:GetPos(), WorldModel:GetAngles(), mpos, mang)
		pos, ang = LocalToWorld(lpos, lang, pos, ang)

		if (self.Offset) then
			pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
			ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
			ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
			ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
			ang:RotateAroundAxis(ang:Forward(), 180)
		end

		local offsetVec = Vector(0, -5, 0)
		local offsetAng = Angle(-5, -10, 0)

		pos, ang = LocalToWorld(offsetVec, offsetAng, pos, ang)

		WorldModel:SetPos(pos)
		WorldModel:SetAngles(ang)
        WorldModel:SetupBones()

    else
        WorldModel:SetPos(self:GetPos() + self:GetAngles():Right() * 5)
        WorldModel:SetAngles(self:GetAngles())
    end

    WorldModel:DrawModel()
end

function MEME:Think(old)
    if (old) then
        old(self)
    end
    
    self.ViewModelFlip = not self.ViewModelFlip
end

local needed = {}

local function doweapon(wep)
	wep.UseHands = false
	wep.HoldType = "duel"
	wep.IronSightsPos = nil
	wep.IronSightsAng = nil
	wep:SetHoldType "duel"
	if (not WORLDMODELS[wep.WorldModel]) then
		WORLDMODELS[wep.WorldModel] = ClientsideModel(wep.WorldModel)
		WORLDMODELS[wep.WorldModel]:SetNoDraw(true)
	end
	
	wep.Tracer = 3
	
	for k, fn in pairs(MEME) do
		local old = wep[k]
		wep[k] = function(self, ...)
			fn(self, old, ...)
		end
	end
end

hook.Add("TTTEndRound", "moat_talents.Dual", function()
	needed = {}
end)


hook.Add("OnEntityCreated", "moat_talents.Dual", function(ent)
	if (needed[ent:EntIndex()]) then
		needed[ent:EntIndex()] = nil
		timer.Simple(0, function()
			doweapon(ent)
		end)
	end
end)

net.Receive("moat_talents.Dual", function()
	local wep = net.ReadUInt(32)
	if (IsValid(Entity(wep))) then
		doweapon(Entity(wep))
		return
	end
	needed[wep] = true
end)