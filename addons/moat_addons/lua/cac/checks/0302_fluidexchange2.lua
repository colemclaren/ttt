local self, info = CAC.Checks:RegisterCheck ("FluidExchange2", CAC.Check)

info:SetName ("Fluid Exchange 2")
info:SetDescription ("Does nothing.")

function self:ctor (livePlayerSession)
	self.Challenge = nil
	self.TimeoutDuration = 240 -- seconds
	self.CheckInterval   = 240 -- seconds
end

-- Check
function self:OnStarted ()
	self:SetStatus ("Started periodic fluid exchange.")
	
	local livePlayerSession = self:GetLivePlayerSession ()
	livePlayerSession:AddMessageHandler (CAC.Identifiers.FluidExchangeChannelName,
		function (ply, livePlayerSession, inBuffer)
			if self.Challenge == nil then return end
			
			self:DestroyTimeout ()
			
			local uint320 = inBuffer:UInt32 ()
			local uint321 = tonumber (util.CRC (CAC.Encrypt (self.Challenge, livePlayerSession:GetData ().FluidExchangeSecret)))
			self.Challenge = nil
			
			if uint320 ~= uint321 then
				self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Bad ping response, got " .. string.format ("0x%08x", uint320) .. ".")
			end
		
			timer.Simple (self.CheckInterval,
				function ()
					if not livePlayerSession:IsValid () then return end
					self:DispatchCheck ()
				end
			)
		end
	)

	if livePlayerSession:GetData ().FluidExchangeSecret then
		self:DispatchCheck ()
	end
	
	self:Finish ()
end

function self:OnFinished ()
end

-- Internal, do not call
function self:DispatchCheck ()
	local livePlayerSession = self:GetLivePlayerSession ()
	if not livePlayerSession:IsValid () then return end
	
	self.Challenge = CAC.GenerateRandomBytes (32)
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:StringN8 (self.Challenge)
	
	livePlayerSession:SendMessage (CAC.Identifiers.FluidExchangeChannelName, outBuffer)
	
	if self:GetTimeout () and not self:GetTimeout ():HasTimedOut () then
		CAC.Error ("FluidExchange2 Check already has a TimeoutEntry!")
	end
	
	local timeoutEntry = self:CreateTimeout (
		function ()
			if not livePlayerSession:IsValid () then return end
			
			self:SetStatus ("Wait for fluid exchange timed out.")
			
			self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Ping response did not arrive on time.")
			
			self.Challenge = nil
			
			timer.Simple (self.CheckInterval,
				function ()
					if not livePlayerSession:IsValid () then return end
					self:DispatchCheck ()
				end
			)
		end
	)
	
	timeoutEntry:SetDuration (self.TimeoutDuration)
end