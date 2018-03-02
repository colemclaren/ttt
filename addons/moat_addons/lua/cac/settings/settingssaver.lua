local self = {}
CAC.SettingsSaver = CAC.MakeConstructor (self)

function self:ctor (logger, settings)
	self.Logger     = logger or CAC.Logger
	self.Settings   = settings
	
	self.SaveNeeded = false
	
	self.Settings:AddEventListener ("Changed", "CAC.SettingsSaver." .. self:GetHashCode (),
		function ()
			self.SaveNeeded = true
		end
	)
	
	timer.Create ("CAC.SettingsSaver", 60, 0,
		function ()
			self:Save ()
		end
	)
	
	self:Load ()
end

function self:dtor ()
	self:Save ()
	
	self.Settings:RemoveEventListener ("Changed", "CAC.SettingsSaver." .. self:GetHashCode ())
	
	timer.Destroy ("CAC.SettingsSaver")
end

function self:Load ()
	if not file.Exists ("cac/settings.txt", "DATA") then
		self.SaveNeeded = true
		return
	end
	
	local inBuffer = CAC.StringInBuffer (file.Read ("cac/settings.txt", "DATA"))
	
	inBuffer:String () -- discard warning
	
	local version = inBuffer:UInt32 ()
	local settingsDeserializer = CAC.SerializerRegistry:GetDeserializer ("Settings", version)
	if not settingsDeserializer then
		self.Logger:Message ("SettingsSaver:Load : Cannot load version " .. version .. " files. Current version is " .. CAC.SerializerRegistry:GetLatestDeserializerVersion ("Settings") .. ".")
		return
	end
	
	settingsDeserializer (self.Settings, inBuffer)
	self.SaveNeeded = false
	
	self.Settings:GetSettingsGroup ("DetectionResponseSettings"):ClampDetectionResponses ()
end

function self:Save ()
	if not self.SaveNeeded then return end
	
	local outBuffer = CAC.StringOutBuffer ()
	
	outBuffer:String ([[

============================================================
Warning: Do not try editing this file without a hex editor.
         You'll probably end up corrupting it.
         
         In fact, you shouldn't even be editing this
         by hand unless you're sure you know what you're
         doing.
============================================================
]])
	
	local version    = CAC.SerializerRegistry:GetLatestSerializerVersion ("Settings")
	local settingsSerializer = CAC.SerializerRegistry:GetSerializer ("Settings", version)
	outBuffer:UInt32 (version)
	
	settingsSerializer (self.Settings, outBuffer)
	
	file.CreateDir ("cac")
	file.Write ("cac/settings.txt", outBuffer:GetString ())
	
	self.SaveNeeded = false
end