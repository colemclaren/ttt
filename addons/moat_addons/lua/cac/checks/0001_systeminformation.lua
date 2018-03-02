local self, info = CAC.Checks:RegisterCheck ("SystemInformation", CAC.SingleResponseCheck)

info:SetName ("System Information")
info:SetDescription ("Retrieves basic player system information.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("SystemInformationReporter")
end

function self:OnStarted ()
	self:SetStatus ("Requesting system information...")
	self:SetStatus ("Waiting for system information...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received system information!")
	
	local gameInformation = CAC.GameInformation ()
	
	gameInformation:Deserialize (inBuffer)
	local operatingSystem = math.min (inBuffer:UInt8 (), CAC.OperatingSystem.Other)
	local cpuVendor       = math.min (inBuffer:UInt8 (), CAC.CpuVendor.Other      )
	local country         = inBuffer:StringN8 ()
	local steamId         = inBuffer:StringN8 ()
	
	self:GetLivePlayerSession ():GetPlayerSession     ():GetGameInformation            ():Copy (gameInformation)
	self:GetLivePlayerSession ():GetPlayerInformation ():GetGameInformation            ():Copy (gameInformation)
	
	self:GetLivePlayerSession ():GetPlayerSession     ():GetOperatingSystemInformation ():SetOperatingSystem (operatingSystem)
	self:GetLivePlayerSession ():GetPlayerInformation ():GetOperatingSystemInformation ():SetOperatingSystem (operatingSystem)
	
	self:GetLivePlayerSession ():GetPlayerSession     ():GetHardwareInformation        ():SetCpuVendor (cpuVendor)
	self:GetLivePlayerSession ():GetPlayerInformation ():GetHardwareInformation        ():SetCpuVendor (cpuVendor)
	
	self:GetLivePlayerSession ():GetPlayerSession     ():GetLocationInformation        ():SetCountry (country)
	self:GetLivePlayerSession ():GetPlayerInformation ():GetLocationInformation        ():SetCountry (country)
	
	local serverSteamId = self:GetLivePlayerSession ():GetSteamId ()
	if steamId ~= "" and
	   steamId ~= serverSteamId and
	   not game.SinglePlayer () then
		-- Technically truth engineering?
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Clientside Steam ID (" .. CAC.String.EscapeNonprintable (steamId) .. ") does not match serverside Steam ID (" .. serverSteamId .. ")")
	end 

	if VERSION <= 1 then
		-- Great, server version is useless.
	elseif VERSION == "1.78" then
		-- Baelish / STEAM_0:1:40273675 / 76561198040813079 is a fucking idiot.
		-- https://scriptfodder.com/scripts/view/1016
		MsgC (CAC.Colors.Red, "[WARNING] 911 Emergency Dispatch Mod (https://scriptfodder.com/scripts/view/1016) is overriding the game version with its own \"1.78\".\n")
		MsgC (CAC.Colors.Red, "[WARNING] Tell the author they are an idiot.\n")
	elseif gameInformation:GetVersion () == 1 then
		-- Bad game install (?), let it through anyway
		self:SetStatus ("Warning: Reported game version is 1 (bad game installation?).")
	elseif gameInformation:GetVersion () < VERSION or
	       gameInformation:GetVersion () > VERSION + 20000 then
		self:SetStatus ("Reported game version does not match server's game version (expected " .. tostring (VERSION) .. ", got " .. tostring (gameInformation:GetVersion ()) .. ").")
		self:AddDetectionReasonFiltered ("GameVersionMismatch", "Reported game version does not match server's game version (expected " .. tostring (VERSION) .. ", got " .. tostring (gameInformation:GetVersion ()) .. ").")
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for system information timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "System information did not arrive on time.")
end

function self:OnFinished ()
	self:SendPayload ("AdminUIPreloader")
end
