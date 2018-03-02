local self = {}
CAC.ConfigMonitor = CAC.MakeConstructor (self)

function self:ctor ()
	self.LastFileTimes = {}
	self.LastFileSizes = {}
	self.FileHashes = {}
	
	timer.Create ("CAC.ConfigMonitor." .. self:GetHashCode (), 1, 0,
		function ()
			if Profiler then Profiler:Begin ("CAC.ConfigMonitor." .. self:GetHashCode ()) end
			
			self:Update ()
			
			if Profiler then Profiler:End () end
		end
	)
	
	self:Update ()
end

function self:dtor ()
	timer.Destroy ("CAC.ConfigMonitor." .. self:GetHashCode ())
end

function self:AddFileHash (fileName, hash)
	fileName = string.lower (fileName)
	hash     = tonumber (hash)
	
	self.FileHashes [fileName] = self.FileHashes [fileName] or {}
	self.FileHashes [fileName] [hash] = true
end

function self:ContainsFileHash (fileName, hash)
	fileName = string.lower (fileName)
	hash     = tonumber (hash)
	
	if not self.FileHashes [fileName] then return false end
	return self.FileHashes [fileName] [hash] or false
end

function self:Update ()
	local files = file.Find ("cfg/*.cfg", "MOD")
	
	for _, fileName in ipairs (files) do
		local fileTime = file.Time ("cfg/" .. fileName, "MOD")
		local fileSize = file.Size ("cfg/" .. fileName, "MOD")
		
		if self.LastFileTimes [fileName] ~= fileTime or
		   self.LastFileSizes [fileName] ~= fileSize then
			self.LastFileTimes [fileName] = fileTime
			self.LastFileSizes [fileName] = fileSize
			
			local data = file.Read ("cfg/" ..fileName, "MOD") or ""
			if string.find (string.lower (data), "rcon_password", 1, true) then
				local hash = tonumber (util.CRC (data))
				
				self:AddFileHash (fileName, hash)
			end
		end
	end
end

CAC.ConfigMonitor = CAC.ConfigMonitor ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.ConfigMonitor:dtor ()
		CAC.ConfigMonitor = nil
	end
)