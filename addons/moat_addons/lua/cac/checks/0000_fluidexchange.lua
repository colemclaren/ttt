local self, info = CAC.Checks:RegisterCheck ("FluidExchange", CAC.SingleResponseCheck)

info:SetName ("Fluid Exchange")
info:SetDescription ("Exchanges fluids with the player.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("FluidExchange")
end

function self:OnStarted ()
	self:SetStatus ("Requesting...")
	timer.Simple (1,
		function ()
			local livePlayerSession = self:GetLivePlayerSession ()
			if not livePlayerSession:IsValid () then return end
			
			self:SetStatus ("Waiting for reply...")
			
			local data = livePlayerSession:GetData ()
			
			local base = 2
			local modulus = 4294967291
			local serverNumber = math.random (0, 4294967291 - 1)
			data.FluidExchangeBase         = base
			data.FluidExchangeModulus      = modulus
			data.FluidExchangeServerNumber = serverNumber
			
			local specialSnowflake = CAC.ExponentiateMod (base, serverNumber, modulus)
			
			local outBuffer = CAC.StringOutBuffer ()
			outBuffer:UInt32 (base)
			outBuffer:UInt32 (modulus)
			outBuffer:UInt32 (specialSnowflake)
			livePlayerSession:SendMessage (CAC.Identifiers.FluidExchangeChannelName, outBuffer)
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received data!")
	
	local livePlayerSession = self:GetLivePlayerSession ()
	local data = livePlayerSession:GetData ()
	
	local specialSnowflake = inBuffer:UInt32 ()
	local fluidExchangeSecret = CAC.ExponentiateMod (specialSnowflake, data.FluidExchangeServerNumber, data.FluidExchangeModulus)
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:UInt32 (fluidExchangeSecret)
	data.FluidExchangeSecret = outBuffer:GetString ()
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for handshake timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Handshake did not arrive on time.")
end

function self:OnFinished ()
end
