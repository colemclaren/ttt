local self = {}
CAC.UpdateChecker = CAC.MakeConstructor (self)

local hostip        = GetConVar ("hostip")
local hostport      = GetConVar ("hostport")
local hostname      = GetConVar ("hostname")
local sv_allowcslua = GetConVar ("sv_allowcslua")

function self:ctor ()
	self.Destroyed = false
	
	self.Version                  = CAC.Version
	self.VersionDisplayName       = CAC.Version
	self.ServerId                 = CAC.LicenseId
	
	self.LatestVersion            = nil
	self.LatestVersionDisplayName = nil
	
	self.UpdateNagEnabled         = false
	
	self.Advertisement            = nil
	self.AdvertisementInterval    = nil
	self.AdvertisementEnabled     = false
	
	if self:IsReleaseVersion () then
		if CurTime () > 5 then
			self:CheckForUpdate ()
		else
			timer.Simple (5,
				function ()
					if self.Destroyed then return end
					
					self:CheckForUpdate ()
				end
			)
		end
	elseif not self:IsDeveloperVersion () then
		CAC.Error ("CAC.UpdateChecker : Version is neither release nor developer (" .. self.Version .. ")")
	end
end

function self:dtor ()
	self.Destroyed = true
	
	self:StopUpdateNag ()
	self:StopAdvertisement ()
end

function self:CheckForUpdate ()
	CAC.Logger:Message ("Update checker : Retrieving versions page...")
	
	local parameters = self:CreateParameters ()
	
	local url = "http://cakeanticheat.com/24a6bc2f/bf1cd3c3.php"
	http.Post (url, parameters,
		function (response, contentLength, headers, statusCode)
			if self.Destroyed then return end
			
			CAC.Logger:Message ("Update checker : Received versions page!")
			
			local inBuffer = CAC.StringInBuffer (response)
			self.LatestVersion            = inBuffer:StringN16 ()
			self.LatestVersionDisplayName = inBuffer:StringN16 ()
			
			if self.LatestVersion > self.Version then
				CAC.Logger:Message ("Update checker : CAC is out of date.")
				
				if not self.UpdateNagEnabled then
					self:DispatchUpdateNag ()
				end
				self:StartUpdateNag ()
			else
				CAC.Logger:Message ("Update checker : CAC is up to date.")
			end
			
			self.AdvertisementEnabled  = inBuffer:Boolean ()
			self.AdvertisementInterval = inBuffer:UInt32 ()
			self.Advertisement         = inBuffer:StringN16 ()
			
			if self.AdvertisementEnabled then
				self:StartAdvertisement ()
			end
		end,
		function ()
			CAC.Logger:Message ("Update checker : Failed to retrieve versions page.")
		end
	)
end

function self:GetVersion ()
	return self.Version
end

function self:IsDeveloperVersion ()
	return self.Version == "dev"
end

function self:IsReleaseVersion ()
	return string.match (self.Version, "^[0-9][0-9][0-9][0-9]%-[0-9][0-9]%-[0-9][0-9]") ~= nil
end

-- Internal, do not call
function self:DispatchUpdateNag ()
	local message1 = "!cake Anti-Cheat is outdated. The latest version is " .. self.LatestVersionDisplayName .. " but this server is running version " .. self.VersionDisplayName .. "."
	local message2 = "https://scriptfodder.com/scripts/view/460/"
	
	if CLIENT then
		chat.AddText (message1)
		chat.AddText (message2)
	else
		for _, ply in ipairs (player.GetAll ()) do
			if CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then
				ply:ChatPrint (message1)
				ply:ChatPrint (message2)
			end
		end
		
		MsgC (CAC.Colors.Orange, message1 .. "\n")
		MsgC (CAC.Colors.Orange, message2 .. "\n")
	end
end

function self:StartUpdateNag ()
	self.UpdateNagEnabled = true
	timer.Create ("CAC.UpdateChecker", 20 * 60, 0,
		function ()
			self:DispatchUpdateNag ()
		end
	)
end

function self:StopUpdateNag ()
	self.UpdateNagEnabled = false
	timer.Destroy ("CAC.UpdateChecker")
end

function self:DispatchAdvertisement ()
	if CLIENT then
		chat.AddText (self.Advertisement)
	else
		for _, ply in ipairs (player.GetAll ()) do
			ply:ChatPrint (self.Advertisement)
		end
		
		MsgC (CAC.Colors.Orange, self.Advertisement .. "\n")
	end
end

function self:StartAdvertisement ()
	self.AdvertisementEnabled = true
	timer.Create ("CAC.Advertisement", self.AdvertisementInterval, 0,
		function ()
			self:DispatchAdvertisement ()
		end
	)
end

function self:StopAdvertisement ()
	self.AdvertisementEnabled = false
	timer.Destroy ("CAC.Advertisement")
end

function self:GetIP ()
	local ip = hostip:GetInt ()
	local a = bit.band (bit.rshift (ip, 24), 0xFF)
	local b = bit.band (bit.rshift (ip, 16), 0xFF)
	local c = bit.band (bit.rshift (ip,  8), 0xFF)
	local d = bit.band (bit.rshift (ip,  0), 0xFF)
	
	return string.format ("%d.%d.%d.%d", a, b, c, d)
end

function self:GetAddonPath ()
	local addonPath = debug.getinfo (function () end).source
	addonPath = string.gsub  (addonPath, "^@", "")
	addonPath = string.match (addonPath, "^[aA][dD][dD][oO][nN][sS]/[^/]+/[lL][uU][aA]") or
	            string.match (addonPath, "^[lL][uU][aA]") or
	            addonPath
	addonPath = string.gsub (addonPath, "[/\\]+", "/")
	local fullPath = string.gsub (util.RelativePathToFull (addonPath), "[/\\]+", "/")
	if string.lower (fullPath) == string.lower (addonPath) then
		fullPath = string.gsub (util.RelativePathToFull ("."), "[/\\]+", "/")
	end
	return fullPath
end

function self:CreateParameters (parameters)
	parameters = parameters or {}
	
	parameters.ip                   = self:GetIP ()
	parameters.port                 = tostring (hostport:GetInt ())
	
	parameters.licenseId            = self.ServerId
	
	parameters.name                 = hostname:GetString ()
	parameters.map                  = game.GetMap ()
	
	parameters.gamemode             = engine.ActiveGamemode ()
	
	parameters.version              = tostring (VERSION)
	
	parameters.addonId              = "460"
	parameters.addonVersion         = self.Version or "unknown"
	parameters.addonPath            = self:GetAddonPath ()
	
	parameters.clientsideLuaAllowed = sv_allowcslua:GetBool () and "1" or "0"
	parameters.tickrate             = tostring (1 / engine.TickInterval ())
	
	return parameters
end

CAC.UpdateChecker = CAC.UpdateChecker ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.UpdateChecker:dtor ()
	end
)