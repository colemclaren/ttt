
local self = {}
self.__index = self

function self:OnEnd() end

function self:Invoke(data, time, pl)
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

	if (not pl.ActiveEffects) then
		pl.ActiveEffects = {}
	end

	table.insert(pl.ActiveEffects, self)
end

function self:SendNotification(time, pl)
	if (pl:GetInfo("moat_enable_effects") ~= "1") then return end

	if (not isstring(self.Message)) then return end
	if (not IsColor(self.Color)) then return end
	if (not isstring(self.Material)) then return end

	local now = CurTime()

	net.Start("moat.status.init")
	net.WriteString(self.Message)
	net.WriteFloat(now + time)
	net.WriteString(self.Material)
	net.WriteColor(self.Color)
	net.WriteString(self.Id)
	net.WriteFloat(now)
	net.Send(pl)
end

function self:CreateTimer(time, amt, tickfn, data)
	if (not isfunction(tickfn)) then
		error("bad argument #3 to 'CreateTimer' (function expected, got " .. type(tickfn) .. ")")
	end

	local id = self.Id
	self.Data = data
	self.Active = true

	local function timerCallback()
		if (not self.Active) then return end

		tickfn(self, data)

		local _reps = timer.RepsLeft(id)
		if (isnumber(_reps) and _reps < 1) then
			self.Active = false

			self.OnEnd(self, data)
		end
	end
	timer.Create(id, time / amt, amt, timerCallback)

	self.Time = time
	self.Amount = amt
	self.Callback = timerCallback
end

function self:CreateEndTimer(time, data)
	local id = self.Id
	self.Data = data
	self.Active = true

	local function timerCallback()
		if (not self.Active) then return end

		local _reps = timer.RepsLeft(id)
		if (not isnumber(_reps)) then return end
		if (_reps >= 1) then return end

		self.Active = false
		self.OnEnd(self, data)
	end
	timer.Create(id, 1, time, timerCallback)
	-- Setting the reps to 1 will make timer.RepsLeft and timer.TimeLeft return nil, this makes us unable to change the time later on

	self.Time = time
	self.Amount = amt
	self.Callback = timerCallback
end

function self:AddTime(time)	
	if (not self.Active) then return end

	local repsLeft = timer.RepsLeft(self.Id)
	local newTime = repsLeft + time
	timer.Adjust(self.Id, 1, newTime, self.Callback)

	if (self.Player) then
		local now = CurTime()

		net.Start("moat.status.adjust")
		net.WriteString(self.Id)
		net.WriteFloat(now + newTime)
		net.WriteFloat(now)
		net.Send(self.Player)
	end
end

function self:Reset()
	if (not self.Active) then return end
	self.Active = false

	timer.Remove(self.Id)
	if (isfunction(self.OnEnd)) then
		self.OnEnd(self, self.Data)
	end
end

EFFECT_BASE = self
