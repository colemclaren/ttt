local self = {}
CAC.LivePlayerSessionController = CAC.MakeConstructor (self)

-- This controller:
--     Creates LivePlayerSessions for connected players
--     Destroys LivePlayerSessions for disconnected players
--     Saves active PlayerSessions and active PlayerInformations at 30 second intervals
--     Send some lua to clients to ensure that the dynamic lua whitelisting system is working

function self:ctor (playerMonitor, livePlayerSessionManager)
	self.PlayerMonitor            = playerMonitor            or CAC.PlayerMonitor
	self.LivePlayerSessionManager = livePlayerSessionManager or CAC.LivePlayerSessionManager
	
	timer.Create ("CAC.LivePlayerSessionController", 30, 0,
		function ()
			self:SaveAllLivePlayerSessionData ()
		end
	)
	
	self.PlayerMonitor:AddPlayerExistenceListener ("CAC.LivePlayerSessionController." .. self:GetHashCode (),
		function (_, ply, userId, isLocalPlayer)
			self:EnsureSessionCreated (ply)
		end
	)
	
	self.PlayerMonitor:AddEventListener ("PlayerDisconnected", "CAC.LivePlayerSessionController." .. self:GetHashCode (),
		function (_, ply, userId)
			if ply and
			   ply:IsValid () then
				local livePlayerSession = self.LivePlayerSessionManager:GetLivePlayerSession (ply)
				self:TerminateSession (livePlayerSession)
			else
				for livePlayerSession in self.LivePlayerSessionManager:GetEnumerator () do
					if not livePlayerSession:GetPlayer () or
					   not livePlayerSession:GetPlayer ():IsValid () then
						self:TerminateSession (livePlayerSession)
					end
				end
			end
		end
	)
	
	hook.Add ("CheckPassword", "CAC.CheckPassword",
		function (communityId, ip, _, _, name)
			local steamId = CAC.CommunityIdToSteamId (communityId)
			local blacklistEntry = CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserBlacklist():GetEntry (steamId)
			if not blacklistEntry then return end
			
			MsgC (CAC.Colors.Red, "Rejected connection from " .. steamId .. " (" .. name .. ", " .. ip .. ") (" .. blacklistEntry:GetReason () .. ")\n")
			
			return false, blacklistEntry:GetKickReason ()
		end
	)
end

function self:dtor ()
	self:SaveAllLivePlayerSessionData ()
	
	self.PlayerMonitor:RemovePlayerExistenceListener ("CAC.LivePlayerSessionController." .. self:GetHashCode ())
	self.PlayerMonitor:RemoveEventListener ("PlayerDisconnected", "CAC.LivePlayerSessionController." .. self:GetHashCode ())
	
	timer.Destroy ("CAC.LivePlayerSessionController")
	
	hook.Remove ("CheckPassword", "CAC.CheckPassword")
end

function self:EnsureSessionCreated (ply)
	if self.LivePlayerSessionManager:GetLivePlayerSession (ply) then
		return self.LivePlayerSessionManager:GetLivePlayerSession (ply)
	end
	
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (ply:SteamID (), true, true)
	local playerSession     = playerInformation:CreateSession (os.time ())
	local livePlayerSession = self.LivePlayerSessionManager:CreateLivePlayerSession (ply, ply:SteamID (), playerSession)
	
	self:HookLivePlayerSession (livePlayerSession)
	self:HookPlayerSession (playerSession)
	
	-- Initialization
	-- Account information
	CAC.AccountInformation.FromPlayer (ply, playerInformation:GetAccountInformation ())
	CAC.AccountInformation.FromPlayer (ply, playerSession    :GetAccountInformation ())
	
	-- Location information
	CAC.LocationInformation.FromPlayer (ply, playerInformation:GetLocationInformation ())
	CAC.LocationInformation.FromPlayer (ply, playerSession    :GetLocationInformation ())
	
	-- Log
	playerSession:GetLog ():AppendLine ("Player connected.")
	playerSession:GetLog ():AppendLine ("    Name: " .. ply:Name ())
	playerSession:GetLog ():AppendLine ("    Steam ID: " .. ply:SteamID ())
	playerSession:GetLog ():AppendLine ("    Profile URL: https://steamcommunity.com/profiles/" .. (ply:SteamID64 () or ""))
	playerSession:GetLog ():AppendLine ("    IP Address: " .. ply:IPAddress ())
	playerSession:GetLog ():AppendLine ("")
	
	-- Save the stubs
	self:SaveLivePlayerSessionData (livePlayerSession)
	
	-- Initiate checks
	CAC.Plugins:DispatchEvent ("PlayerConnected", ply, livePlayerSession)
	
	if not ply:IsBot () then
		if CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserWhitelist ():GetUserWhitelistStatus (ply:SteamID ()) >= CAC.WhitelistStatus.SuppressChecks then
			playerSession:GetLog ():AppendLine ("Player is whitelisted, checks are disabled.")
		else
			-- This is the beginning
			timer.Simple (10,
				function ()
					if not ply:IsValid () then return end
					
					for nextCheckId in CAC.Checks:GetNextCheckEnumerator ("") do
						livePlayerSession:StartCheck (nextCheckId)
					end
				end
			)
		end
	end
	
	-- Test to ensure that the dynamic lua information is being updated correctly.
	-- This should not cause a detection
	timer.Simple (0.5,
		function ()
			if not ply            then return end
			if not ply:IsValid () then return end
			
			ply:SendLua ([[RunString     ([=[RunString ([==[RunString ([===[timer.Create ("\x01", 60, 0, function () return RunString, CompileString, "ABC" end) return [====[DRAGON DILDOS]====] ]===])]==])]=], [=[LuaCmdTest]=])]])
			ply:SendLua ([[RunStringEx   ([=[RunString ([==[RunString ([===[timer.Create ("\x02", 60, 0, function () return RunString, CompileString, "ABC" end) return [====[DRAGON DILDOS]====] ]===])]==])]=], [=[LuaCmdTest]=])]])
			ply:SendLua ([[CompileString ([=[RunString ([==[RunString ([===[timer.Create ("\x03", 60, 0, function () return RunString, CompileString, "ABC" end) return [====[DRAGON DILDOS]====] ]===])]==])]=], [=[LuaCmdTest]=])]])
		end
	)
	
	-- Blacklist
	local blacklistEntry = CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserBlacklist():GetEntry (ply:SteamID ())
	if blacklistEntry then
		timer.Simple (0.5,
			function ()
				if not ply            then return end
				if not ply:IsValid () then return end
				
				ply:Kick (blacklistEntry:GetKickReason ())
				
				playerSession:GetLog ():AppendLine ("")
				playerSession:GetLog ():AppendLine ("Player is on anticheat blacklist (" .. blacklistEntry:GetReason () .. ")")
				playerSession:GetLog ():AppendLine ("Kicked by anticheat.")
			end
		)
	end
	
	return livePlayerSession
end

function self:TerminateSession (livePlayerSession)
	local playerSession     = livePlayerSession:GetPlayerSession ()
	local playerInformation = livePlayerSession:GetPlayerInformation ()
	
	-- Terminate session
	playerSession:SetEndTime (os.time ())
	playerSession:SetFinished (true)
	
	-- Terminate log
	playerSession:GetLog ():AppendLine ("")
	playerSession:GetLog ():AppendLine ("Player disconnected.")
	
	-- Save it all
	self:SaveLivePlayerSessionData (livePlayerSession)
	
	-- Destroy
	self.LivePlayerSessionManager:DestroyLivePlayerSession (livePlayerSession:GetUserId ())
	
	self:UnhookLivePlayerSession (livePlayerSession)
end

-- Internal, do not call
function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:SaveAllLivePlayerSessionData ()
	-- We're in charge of saving things!
	for livePlayerSession in self.LivePlayerSessionManager:GetEnumerator () do
		self:SaveLivePlayerSessionData (livePlayerSession)
	end
end

function self:SaveLivePlayerSessionData (livePlayerSession)
	livePlayerSession:GetPlayerInformation ():Save ()
	
	if CAC.Settings:ShouldSaveAllSessions () or
	   livePlayerSession:GetPlayerSession ():HasDetections () then
		livePlayerSession:GetPlayerSession ():Save ()
	end
	
	if livePlayerSession:GetPlayerSession ():ShouldSaveLog () then
		livePlayerSession:GetPlayerSession ():GetLog ():Save ()
	end
end