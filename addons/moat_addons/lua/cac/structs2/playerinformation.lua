local self = {}
CAC.PlayerInformation = CAC.MakeConstructor (self)

function self:ctor (playerInformationManager, steamId, playerDirectory)
	self.PlayerInformationManager = playerInformationManager
	
	-- Serialization
	self.PlayerDirectory = playerDirectory
	self.SaveNeeded      = false
	
	-- Identity
	self.AccountInformation = CAC.AccountInformation ()
	self.AccountInformation:SetSteamId (steamId)
	
	-- Information
	self.GameInformation            = CAC.GameInformation ()
	self.OperatingSystemInformation = CAC.OperatingSystemInformation ()
	self.LocationInformation        = CAC.LocationInformation ()
	self.HardwareInformation        = CAC.HardwareInformation ()
	
	-- Sessions
	self.Sessions = {}
	
	self.AccountInformation        :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.GameInformation           :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.OperatingSystemInformation:AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.LocationInformation       :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	self.HardwareInformation       :AddEventListener ("Changed", function () self:MarkUnsaved () end)
	
	CAC.EventProvider (self)
end

function self:GetSteamId ()
	return self.AccountInformation:GetSteamId ()
end

-- ISerializable
function self:Serialize (outBuffer)
	self.AccountInformation        :Serialize (outBuffer)
	self.GameInformation           :Serialize (outBuffer)
	self.OperatingSystemInformation:Serialize (outBuffer)
	self.LocationInformation       :Serialize (outBuffer)
	self.HardwareInformation       :Serialize (outBuffer)
end

function self:Deserialize (inBuffer)
	self.AccountInformation        :Deserialize (inBuffer)
	self.GameInformation           :Deserialize (inBuffer)
	self.OperatingSystemInformation:Deserialize (inBuffer)
	self.LocationInformation       :Deserialize (inBuffer)
	self.HardwareInformation       :Deserialize (inBuffer)
end

-- Serialization
function self:GetPlayerDirectory ()
	return self.PlayerDirectory
end

function self:Load ()
	if not file.Exists (self.PlayerDirectory .. "/playerinformation.txt", "DATA") then return end
	
	local data = file.Read (self.PlayerDirectory .. "/playerinformation.txt", "DATA")
	
	local inBuffer = CAC.StringInBuffer (data)
	
	local version = inBuffer:UInt32 ()
	if version ~= 1 then
		CAC.Logger:Message ("PlayerInformation:Load : Cannot handle version " .. version .. " files. Current version is 1.")
		self.SaveNeeded = false
		return
	end
	
	self:Deserialize (inBuffer)
	
	self.SaveNeeded = false
end

function self:Save ()
	if self.SaveNeeded then
		file.CreateDir (self.PlayerDirectory)
		
		local outBuffer = CAC.StringOutBuffer ()
		
		outBuffer:UInt32 (1) -- version
		
		self:Serialize (outBuffer)
		
		file.CreateDir (self.PlayerDirectory)
		file.Write (self.PlayerDirectory .. "/playerinformation.txt", outBuffer:GetString ())
	end
	
	self.SaveNeeded = false
end

function self:MarkUnsaved ()
	self.SaveNeeded = true
end

function self:Initialize ()
end

-- Identity
function self:GetSteamId ()
	return self.AccountInformation:GetSteamId ()
end

function self:GetAccountInformation ()
	return self.AccountInformation
end

-- Information
function self:GetGameInformation ()
	return self.GameInformation
end

function self:GetOperatingSystemInformation ()
	return self.OperatingSystemInformation
end

function self:GetLocationInformation ()
	return self.LocationInformation
end

function self:GetHardwareInformation ()
	return self.HardwareInformation
end

-- Sessions
function self:CreateSession (timestamp)
	local sessionId = sessionId or timestamp or os.time ()
	
	if self.Sessions [sessionId] then
		return self.Sessions [sessionId]
	end
	
	local playerSession = CAC.PlayerSession (self, sessionId)
	self.Sessions [sessionId] = playerSession
	
	return playerSession
end

function self:GetSession (sessionId)
	return self.Sessions [sessionId]
end

function self:GetSessionEnumerator ()
	return CAC.Enumerator.Map (CAC.ArrayEnumerator (file.Find (self.PlayerDirectory .. "/session_*.txt", "DATA")), CAC.PlayerSession.SessionIdFromFileName)
end

function self:LoadSession (sessionId)
	if self.Sessions [sessionId] then return self.Sessions [sessionId] end
	
	if not self:SessionExists (sessionId) then return nil end
	
	local playerSession = CAC.PlayerSession (self, sessionId)
	playerSession:Load ()
	self.Sessions [sessionId] = playerSession
	
	return playerSession
end

function self:SessionExists (sessionId)
	if self.Sessions [sessionId] then return true end
	
	return file.Exists (self.PlayerDirectory .. "/" .. CAC.PlayerSession.FileNameFromSessionId (sessionId), "DATA")
end