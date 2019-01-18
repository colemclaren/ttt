
local self = {}
self.__index = self

function self:Invoke(data, time, pl)
	self.Id = self.Name .. SysTime()
	
	if (IsValid(data.Player)) then
		self:SetPlayer(data.Player)
	end
	
	self:Init(data)

	if (isnumber(time) and (istable(pl) or IsValid(pl))) then
		self:SendNotification(time, pl)
	end
end

function self:SetPlayer(pl)
	if (not IsValid(pl)) then return end

	self.Player = pl
	
	self.Id = self.Id .. "_" .. pl:EntIndex()
end

function self:SetOnEnd(onendfn)
	if (not isfunction(onendfn)) then
		error("onendfn is not a function")
	end
	
	self.OnEnd = onendfn
end


function self:SendNotification(time, pl)
	if (not isstring(self.Message)) then return end
	if (not IsColor(self.Color)) then return end
	if (not isstring(self.Material)) then return end

	net.Start("moat.status.init")
		net.WriteString(self.Message)
		net.WriteFloat(CurTime() + time)
		net.WriteString(self.Material)
		net.WriteColor(self.Color)
		net.WriteString(self.Id)
		net.WriteFloat(CurTime())
	net.Send(pl)
end

function self:CreateTimer(time, amt, tickfn, data)	
	if (not isfunction(tickfn)) then
		error("tickfn is not a function")
	end
	
	local id = self.Id
	
	timer.Create(id, time / amt, amt, function()
		tickfn(self, data)
		
		local doRemove = self.ShouldRemove
		local reps = timer.RepsLeft(id)
		if (doRemove or ((isnumber(reps) and (reps < 1)))) then
			if (isfunction(self.OnEnd)) then
				self:OnEnd(data)
			end
		end
		
		if (doRemove) then
			timer.Remove(id)
		end
	end)
end

function self:Reset()
	self.ShouldRemove = true
end

EFFECT_BASE = self
