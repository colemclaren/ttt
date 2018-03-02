local self = {}
CAC.DataUpdater = CAC.MakeConstructor (self)

local hostip        = GetConVar ("hostip")
local hostport      = GetConVar ("hostport")
local hostname      = GetConVar ("hostname")
local sv_allowcslua = GetConVar ("sv_allowcslua")

function self:ctor ()
	self.Destroyed = false
	
	self.Version   = CAC.Version
	self.ServerId  = CAC.Identifiers.ServerId
	
	self.BaseUrl   = "http://cakeac.net/24a6bc2f"
	
	self.Waiting   = false
	
	self:Start ()
end

function self:dtor ()
	self.Destroyed = true
	
	self:Stop ()
end

-- Version
function self:GetVersion ()
	return self.Version
end

function self:IsDeveloperVersion ()
	return self.Version == "dev"
end

function self:IsReleaseVersion ()
	return string.match (self.Version, "^[0-9][0-9][0-9][0-9]%-[0-9][0-9]%-[0-9][0-9]") ~= nil
end

-- Urls
function self:GetBaseUrl ()
	return self.BaseUrl
end

function self:GetBlacklistUpdateUrl ()
	return self.BaseUrl .. "/4c1b605f.php"
end

function self:GetSignaturesUpdateUrl ()
	return self.BaseUrl .. "/9a4a2bbf.php"
end

function self:Start ()
	if CurTime () > 5 then
		self:Impulse ()
	else
		timer.Simple (5,
			function ()
				if self.Destroyed then return end
				
				self:Impulse ()
			end
		)
	end
	
	timer.Create ("CAC.DataUpdater", 60 * 5, 0,
		function ()
			self:Impulse ()
		end
	)
end

function self:Stop ()
	timer.Destroy ("CAC.DataUpdater")
end

function self:Impulse ()
	if self.Waiting then return end
	
	local url = self.BaseUrl .. "/ea1cf70b.php"
	
	local parameters = self:CreateParameters ()
	
	local players = player.GetAll ()
	parameters.playerCount    = tostring (#players)
	parameters.maxPlayerCount = tostring (game.MaxPlayers ())
	
	local userBlacklistEnabled = not CAC.Settings or CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):IsBlacklistEnabled         ()
	local userTrackingEnabled  = not CAC.Settings or CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):IsUserTrackingEnabled      ()
	local luaScanningEnabled   = not CAC.Settings or CAC.Settings:GetSettingsGroup ("LuaScannerSettings"   ):IsLuaScanningEnabled       ()
	local luaPatchingEnabled   = not CAC.Settings or CAC.Settings:GetSettingsGroup ("LuaScannerSettings"   ):IsAutomaticPatchingEnabled ()
	parameters.userTrackingEnabled  = tostring (userTrackingEnabled)
	parameters.userBlacklistEnabled = tostring (userBlacklistEnabled)
	parameters.luaScanningEnabled   = tostring (luaScanningEnabled)
	parameters.luaPatchingEnabled   = tostring (luaPatchingEnabled)
	
	if userTrackingEnabled then
		local outBuffer = CAC.StringOutBuffer ()
		for _, v in ipairs (player.GetAll ()) do
			outBuffer:StringN8 (v:SteamID ())
			outBuffer:StringN8 (v:Nick ())
			outBuffer:StringN8 (v:GetUserGroup ())
			outBuffer:Boolean  (v:IsAdmin ())
			outBuffer:Boolean  (v:IsSuperAdmin ())
		end
		parameters.playerBlob = util.Base64Encode (outBuffer:GetString ()) or ""
	end
	
	self.Waiting = true
	http.Post (url, parameters,
		function (response, contentLength, headers, statusCode)
			self.Waiting = false
		end,
		function ()
			self.Waiting = false
		end
	)
end

function self:CheckForUpdate (url, parameters, callback)
	parameters = self:CreateParameters (parameters)
	
	if CAC.IsDebug then
		print (SysTime (), "POST", url)
	end
	
	http.Post (url, parameters,
		function (response, contentLength, headers, statusCode)
			if CAC.IsDebug then
				print (SysTime (), "RECV", url)
			end
			
			callback (true, response, contentLength, headers, statusCode)
		end,
		function (...)
			if CAC.IsDebug then
				print (SysTime (), "RECV", url)
			end
			
			callback (false, ...)
		end
	)
end

-- Internal, do not call
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