local self = {}
CAC.VNetSystem = CAC.MakeConstructor (self)

function self:ctor (livePlayerSession, ply)
	self.LivePlayerSession = livePlayerSession
	self.Player            = ply

	self.ChannelIds = {}
	self.IdChannels = {}
	self.Handlers   = {}
	
	self.ReceiveCount = 0
	self.SendCount    = 0
end

function self:ResetCounters ()
	self.ReceiveCount = 0
	self.SendCount    = 0
end

function self:AddReceiver (channelName, handler)
	if not handler then return end
	
	local channelId = self:GetChannelId (channelName)
	self.Handlers [channelId] = handler
end

function self:GetChannelId (channelName)
	if not self.ChannelIds [channelName] then
		local channelId = tonumber (util.CRC (channelName))
		self.ChannelIds [channelName] = channelId
		self.IdChannels [channelId] = channelName
	end
	
	return self.ChannelIds [channelName]
end

function self:GetChannelName (channelId)
	return self.IdChannels [channelId]
end

function self:HandleMessage (bitCount)
	self.ReceiveCount = self.ReceiveCount + 1
	
	local channelId = net.ReadUInt (32)
	local handler   = self.Handlers [channelId]
	if not handler then return end
	
	local data = net.ReadData (bitCount / 8 - 4)
	local inBuffer = CAC.StringInBuffer (data)
	handler (self.Player, self.LivePlayerSession, inBuffer)
end

function self:Send (channelName, data)
	if type (data) == "table" then
		data = data:GetString ()
	end

	local channelId = self:GetChannelId (channelName)
	
	net.Start (CAC.Identifiers.MultiplexedDataChannelName)
		net.WriteUInt (channelId, 32)
		net.WriteData (data, #data)
	net.Send (self.Player)
end

function self:__call (...)
	local clone = self.__ictor (...)
	
	for channelId, handler in pairs (self.Handlers) do
		local channelName = self:GetChannelName (channelId)
		
		clone:AddReceiver (channelName, handler)
	end
	
	return clone
end

CAC.VNetSystem = CAC.VNetSystem ()
