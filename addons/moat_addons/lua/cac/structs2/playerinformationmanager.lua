local self = {}
CAC.PlayerInformationManager = CAC.MakeConstructor (self)

function self:ctor ()
	self.PlayerDataDirectory = "cac/playerdata"
	
	self.PlayerInformationBySteamId = {}
	
	file.CreateDir (self.PlayerDataDirectory)
end

function self:GetPlayerInformation (steamId, loadIfNotLoaded, createIfNotCreated)
	if not self:IsPlayerInformationLoaded (steamId) and
	   loadIfNotLoaded then
		self:LoadPlayerInformation (steamId, createIfNotCreated)
	end
	
	return self.PlayerInformationBySteamId [steamId]
end

function self:IsPlayerInformationLoaded (steamId)
	return self.PlayerInformationBySteamId [steamId]
end

-- Internal, do not call
function self:LoadPlayerInformation (steamId, createIfNotCreated)
	if self:IsPlayerInformationLoaded (steamId) then return end
	
	local playerDirectory = self.PlayerDataDirectory .. "/" .. self:SteamIdToFileName (steamId)
	
	if not file.Exists (playerDirectory, "DATA") then
		if createIfNotCreated then
			local playerInformation = CAC.PlayerInformation (self, steamId, playerDirectory)
			self.PlayerInformationBySteamId [steamId] = playerInformation
			
			playerInformation:Initialize ()
			
			return playerInformation
		else
			return nil
		end
	end
	
	local playerInformation = CAC.PlayerInformation (self, steamId, playerDirectory)
	self.PlayerInformationBySteamId [steamId] = playerInformation
	playerInformation:Load ()
	
	return playerInformation
end

function self:UnloadPlayerInformation (steamId)
	if not self:IsPlayerInformationLoaded (steamId) then return end
	
	self.PlayerInformationBySteamId [steamId]:Save ()
	self.PlayerInformationBySteamId [steamId] = nil
end

function self:SteamIdToFileName (steamId)
	return string.lower (string.gsub (steamId, "[^a-zA-Z_0-9]", "_"))
end

CAC.PlayerInformationManager = CAC.PlayerInformationManager ()