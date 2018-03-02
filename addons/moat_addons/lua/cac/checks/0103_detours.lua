local self, info = CAC.Checks:RegisterCheck ("Detours")

info:SetName ("Function Detours")
info:SetDescription ("Reports call stacks of detoured functions.")

function self:ctor (livePlayerSession)
end

function self:OnStarted ()
	self:SetStatus ("Sending function detours...")
	self:SendPayload ("Detours")
	
	self:Finish ()
end

function self:OnFinished ()
end