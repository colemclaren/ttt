
local self = {}
self.__index = self

function self:Invoke(data, time, pl)
	if (IsValid(data.Player)) then
		self:SetPlayer(data.Player)
	end

	self.Id = self.Name .. CurTime()

	self:Init(data)

	if (isnumber(time) and (istable(pl) or IsValid(pl))) then
		self:SendNotification(time, pl)
	end
end

function self:SetPlayer(pl)
	if (not IsValid(pl)) then return end

	self.Player = pl
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
	timer.Create(self.Id, time / amt, amt, function()
		tickfn(self, data)
	end)
end

EFFECT_BASE = self
