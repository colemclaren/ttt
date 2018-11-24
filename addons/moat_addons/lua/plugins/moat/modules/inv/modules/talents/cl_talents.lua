net.Receive("Talents.BostonBasher", function()
	surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
end)

net.Receive("Talents.Silenced",function()
	local e = net.ReadEntity()
	if not e.Primary then return end
	e.Primary.Sound = Sound( "weapons/usp/usp1.wav" )
	if e:GetOwner() == LocalPlayer() then
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

local function talent_chat(wep,old,new,v,tier)
	if wep:GetOwner() ~= LocalPlayer() then return end
	local talent_desc = new.Description
	local talent_desctbl = string.Explode("^", talent_desc)
	for i = 1, table.Count(v.m) do
		local mod_num = math.Round(new.Modifications[i].min + ((new.Modifications[i].max - new.Modifications[i].min) * v.m[i]), 1)

		talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
	end
	talent_desc = string.Implode("", talent_desctbl)
    talent_desc = string.Replace(talent_desc, "_", "%")
	chat.AddText(Material("icon16/arrow_refresh.png"),"Your ", Color(100,100,255), "Wildcard: Tier " .. tostring(tier),Color(255,255,255)," turned into ",Color(255,0,0),new.Name,Color(255,255,255),": ",Color(0,255,0),talent_desc,Color(255,255,255),"!")
end

net.Receive("weapon.UpdateTalents",function()
	local wep = net.ReadEntity()
	local tier = net.ReadInt(8)											
	local talent = net.ReadTable()
	local t_ = net.ReadTable()
	
	if not wep.ItemStats then
		local s = "TalentUpdate" .. wep:EntIndex() .. tier
		timer.Create(s,0.1,0,function()
			if not IsValid(wep) then timer.Destroy(s) return end
			if wep.ItemStats then
				if not wep.ItemStats.Talents then return end
				talent_chat(wep,wep.ItemStats.Talents[tier],talent,t_,tier)
				wep.ItemStats.Talents[tier] = talent
				wep.ItemStats.t[tier] = t_
				timer.Destroy(s)
			end
		end)
	elseif (wep.ItemStats and wep.ItemStats.Talents) then
		talent_chat(wep,wep.ItemStats.Talents[tier],talent,t_,tier)
		wep.ItemStats.Talents[tier] = talent
		wep.ItemStats.t[tier] = t_
	end
end) 
