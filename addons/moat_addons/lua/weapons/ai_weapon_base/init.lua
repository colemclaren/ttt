
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight = 2
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.NPCFireRate = 0.8

local function CnvSnd(tb,snd)
	local br = string.find(snd,"[[]")
	if(br) then
		local _br = string.find(snd,"[]]",br +1)
		if(_br) then
			local str = string.sub(snd,br +1,_br -1)
			local sep = string.find(str,"-")
			if(sep) then
				local Start = string.sub(str,1,sep -1)
				Start = tonumber(Start)
				local End = string.sub(str,sep +1,string.len(str))
				End = tonumber(End)
				if(Start && End) then
					local strStart = string.sub(snd,1,br -1)
					local strEnd = string.sub(snd,_br +1,string.len(snd))
					for i = Start, End do
						table.insert(tb,strStart .. i .. strEnd)
					end
					return
				end
			end
		end
	end
	table.insert(tb,snd)
end

function SWEP:InitSounds()
	local sounds = table.Copy(self.sounds)
	self.sounds = {}
	self.sounds["BaseClass"] = nil
	for name, sounds in pairs(sounds) do
		self.sounds[name] = {}
		if(type(sounds) == "table") then for _, snd in ipairs(sounds) do CnvSnd(self.sounds[name],snd) end
		else CnvSnd(self.sounds[name],sounds) end
		if(type(sounds) == "table") then table.MakeSequential(self.sounds[name]) end
	end
end

function SWEP:PlaySound(sSound,flDelay,bClientOnly)
	local iWav = string.find(sSound, ".wav")
	if(iWav) then
		if bClientOnly then self.Owner:ConCommand("playgamesound " .. sSound)
		else self.Owner:EmitSound(sSound, 75, 100) end
		return
	end
	if(!self.sounds[sSound]) then return end
	local _sSound
	if(type(self.sounds[sSound]) == "string") then _sSound = self.sounds[sSound]
	else _sSound = self.sounds[sSound][math.random(1,table.Count(self.sounds[sSound]))] end
	if(flDelay && flDelay > 0) then
		table.insert(self.tblSoundsDelayed, {sSound = _sSound, flDelay = CurTime() +flDelay, bClientOnly = bClientOnly})
		return
	end
	if(bClientOnly) then self.Owner:ConCommand("playgamesound " .. _sSound)
	else self.Owner:EmitSound(_sSound,75,100) end
end