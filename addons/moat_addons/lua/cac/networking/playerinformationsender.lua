local self = {}
CAC.PlayerInformationSender = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor (playerInformation)
	self.PlayerInformation = nil
	
	self.AccountInformationSender         = CAC.AccountInformationSender         ()
	self.GameInformationSender            = CAC.GameInformationSender            ()
	self.OperatingSystemInformationSender = CAC.OperatingSystemInformationSender ()
	self.LocationInformationSender        = CAC.LocationInformationSender        ()
	self.HardwareInformationSender        = CAC.HardwareInformationSender        ()
	
	self.AccountInformationSender        :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("AccountInformation"        ) return outBuffer end)
	self.GameInformationSender           :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("GameInformation"           ) return outBuffer end)
	self.OperatingSystemInformationSender:AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("OperatingSystemInformation") return outBuffer end)
	self.LocationInformationSender       :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("LocationInformation"       ) return outBuffer end)
	self.HardwareInformationSender       :AddEventListener ("CreateOutBuffer", function (_) local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer () outBuffer:StringN8 ("HardwareInformation"       ) return outBuffer end)
	
	self.AccountInformationSender        :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.GameInformationSender           :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.OperatingSystemInformationSender:AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.LocationInformationSender       :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	self.HardwareInformationSender       :AddEventListener ("DispatchPacket", function (_, outBuffer) self:DispatchEvent ("DispatchPacket", outBuffer) end)
	
	CAC.EventProvider (self)
	
	self:SetPlayerInformation (playerInformation)
end

function self:dtor ()
	self:SetPlayerInformation (nil)
end

function self:GetPlayerInformation ()
	return self.PlayerInformation
end

function self:SetPlayerInformation (playerInformation)
	if self.PlayerInformation == playerInformation then return self end
	
	self:UnhookPlayerInformation (self.PlayerInformation)
	
	self.PlayerInformation = playerInformation
	
	self.AccountInformationSender        :SetObject (self.PlayerInformation and self.PlayerInformation:GetAccountInformation         ())
	self.GameInformationSender           :SetObject (self.PlayerInformation and self.PlayerInformation:GetGameInformation            ())
	self.OperatingSystemInformationSender:SetObject (self.PlayerInformation and self.PlayerInformation:GetOperatingSystemInformation ())
	self.LocationInformationSender       :SetObject (self.PlayerInformation and self.PlayerInformation:GetLocationInformation        ())
	self.HardwareInformationSender       :SetObject (self.PlayerInformation and self.PlayerInformation:GetHardwareInformation        ())
	
	self:HookPlayerInformation (self.PlayerInformation)
	
	return self
end

function self:SendFullUpdate ()
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("FullUpdate")
	self.PlayerInformation:Serialize (outBuffer)
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:HookPlayerInformation (playerInformation)
	if not playerInformation then return end
end

function self:UnhookPlayerInformation (playerInformation)
	if not playerInformation then return end
end
