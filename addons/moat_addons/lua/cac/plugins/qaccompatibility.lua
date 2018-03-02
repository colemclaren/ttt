local self = CAC.Plugins:CreatePlugin ("QACCompatibility")

function self:ctor ()
	self.NetReceivers = {}
end

-- Plugin
function self:CanEnable ()
	return self:IsQACPresent ()
end

function self:OnEnable ()
	-- Disable QAC's lua verification process since:
	--     1. CAC's is more thorough
	--     2. QAC will flag CAC clientside files as foreign
	
	self.NetReceivers ["checksum"]  = self.NetReceivers ["checksum"]  or net.Receivers ["checksum"]
	self.NetReceivers ["checksaum"] = self.NetReceivers ["checksaum"] or net.Receivers ["checksaum"]
	
	if net.Receivers ["checksum"] then
		net.Receive ("checksum",  function () end)
	end
	if net.Receivers ["checksaum"] then
		net.Receive ("checksaum", function () end)
	end
end

function self:OnDisable ()
	net.Receivers ["checksum"]  = self.NetReceivers ["checksum"]
	net.Receivers ["checksaum"] = self.NetReceivers ["checksaum"]
end

-- QACCompatibility
function self:IsQACPresent ()
	return QAC ~= nil
end

function self:IsQACHook (eventName, hookName)
	return eventName == "OnGamemodeLoaded" and hookName == "___scan_g_init"
end

function self:IsQACNetReceiver (channelName)
	return channelName == "Ping2" or
	       channelName == "quack" or
		   channelName == "gcontrolled_vars"
end