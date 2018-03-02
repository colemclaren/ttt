local tblAmmoCount = {}
usermessage.Hook("SLV_SetAmmunition", function(um)
	local ammo = um:ReadString()
	if !ammo then return end
	local amount = um:ReadShort()
	if !amount then return end
	tblAmmoCount[ammo] = amount
end)

local meta = FindMetaTable("Player")
local tblAmmoTypeNames = {
	[1] = "ar2",
	[2] = "ar2altfire",
	[3] = "pistol",
	[4] = "smg1",
	[5] = "357",
	[6] = "xbowbolt",
	[7] = "buckshot",
	[8] = "rpg_round",
	[9] = "smg1_grenade",
	[10] = "grenade",
	[11] = "slam",
	[12] = "alyxgun",
	[13] = "sniperround",
	[14] = "sniperpenetratedround",
	[15] = "thumper",
	[16] = "gravity",
	[17] = "battery",
	[18] = "gaussenergy",
	[19] = "combinecannon",
	[20] = "airboatgun",
	[21] = "striderminigun",
	[22] = "helicoptergun"
}
local function ToAmmoName(i)
	return tblAmmoTypeNames[i] || ""
end
function meta:GetAmmunition(ammo)
	if type(ammo) == "number" then ammo = ToAmmoName(ammo) end
	if util.IsDefaultAmmoType(ammo) then return self:GetAmmoCount(ammo) end
	return tblAmmoCount[ammo] || 0
end

local function Extinguish(ent)
	local hk = "slv_entignite" .. ent:EntIndex()
	ent:RemoveCallOnRemove(hk)
	hook.Remove("Think",hk)
	for idx,ent in pairs(ent.tbFlames) do
		if(ent:IsValid()) then ent:Remove() end
	end
	ent.tbFlames = nil
end
usermessage.Hook("slv_ignite",function(um)
	local ent = um:ReadEntity()
	if(!ent:IsValid() || ent.tbFlames) then return end
	local i = 0
	local bonepos, boneang = ent:GetBonePosition(i)
	ent.tbFlames = {}
	while(bonepos) do
		local bDontAdd
		local distMin = math.huge
		for idx,entFlame in pairs(ent.tbFlames) do
			if(idx != i) then
				local dist = bonepos:Distance(entFlame:GetPos())
				if(dist <= 12) then bDontAdd = true; break end
			end
		end
		if(!bDontAdd) then
			local entFlame = ClientsideModel("models/error.mdl")
			entFlame:SetNoDraw(true)
			entFlame:DrawShadow(false)
			entFlame:SetPos(bonepos)
			ParticleEffectAttach("burning_gib_01",PATTACH_ABSORIGIN_FOLLOW,entFlame,0)
			ent.tbFlames[i] = entFlame
		end
		i = i +1
		bonepos, boneang = ent:GetBonePosition(i)
	end
	local hk = "slv_entignite" .. ent:EntIndex()
	ent:CallOnRemove(hk,Extinguish,ent)
	hook.Add("Think",hk,function()
		if(ent:IsValid()) then
			for idx,entFlame in pairs(ent.tbFlames) do
				if(entFlame:IsValid()) then
					entFlame:SetPos(ent:GetBonePosition(idx))
				end
			end
		end
	end)
end)

usermessage.Hook("slv_extinguish",function(um)
	local ent = um:ReadEntity()
	if(!ent:IsValid() || !ent.tbFlames) then return end
	Extinguish(ent)
end)

local tbSounds = {}
usermessage.Hook("slv_snd_new",function(um)
	local snd = um:ReadString()
	local sndIdx = um:ReadShort()
	local idx = um:ReadShort()
	tbSounds[sndIdx] = {}
	util.CallOnEntityValid(function(ent)
		local csp = CreateSound(ent,snd)
		csp:Play()
		if(tbSounds[sndIdx].pitch) then csp:ChangePitch(tbSounds[sndIdx].pitch,tbSounds[sndIdx].delta) end
		if(tbSounds[sndIdx].vol) then csp:ChangeVolume(tbSounds[sndIdx].vol,0) end
		if(tbSounds[sndIdx].sec) then csp:FadeOut(tbSounds[sndIdx].sec); tbSounds[sndIdx] = nil; return end
		if(tbSounds[sndIdx].lvl) then print("Setting sound level to: ", tbSounds[sndIdx].lvl); csp:SetSoundLevel(tbSounds[sndIdx].lvl) end
		tbSounds[sndIdx] = csp
	end,idx,2)
end)

usermessage.Hook("slv_snd_pitch",function(um)
	local idx = um:ReadShort()
	local pitch = um:ReadFloat()
	local delta = um:ReadFloat()
	if(!tbSounds[idx]) then return end
	if(type(tbSounds[idx]) == "table") then tbSounds[idx].pitch = pitch; tbSounds[idx].delta = delta; return end
	tbSounds[idx]:ChangePitch(pitch,delta)
end)

usermessage.Hook("slv_snd_vol",function(um)
	local idx = um:ReadShort()
	local vol = um:ReadFloat()
	if(!tbSounds[idx]) then return end
	if(type(tbSounds[idx]) == "table") then tbSounds[idx].vol = vol; return end
	tbSounds[idx]:ChangeVolume(vol,0)
end)

usermessage.Hook("slv_snd_fade",function(um)
	local idx = um:ReadShort()
	local sec = um:ReadFloat()
	if(!tbSounds[idx]) then return end
	if(type(tbSounds[idx]) == "table") then tbSounds[idx].sec = sec; return end
	tbSounds[idx]:FadeOut(sec)
	tbSounds[idx] = nil
end)

usermessage.Hook("slv_snd_sndlvl",function(um)
	local idx = um:ReadShort()
	local sndlvl = um:ReadFloat()
	if(!tbSounds[idx]) then return end
	if(type(tbSounds[idx]) == "table") then tbSounds[idx].lvl = sndlvl; return end
	tbSounds[idx]:SetSoundLevel(sndlvl)
end)

usermessage.Hook("slv_snd_stop",function(um)
	local idx = um:ReadShort()
	if(!tbSounds[idx]) then return end
	tbSounds[idx]:Stop()
	tbSounds[idx] = nil
end)