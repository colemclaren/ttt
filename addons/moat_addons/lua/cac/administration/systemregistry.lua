local self = {}
CAC.SystemRegistry = CAC.MakeConstructor (self)

function self:ctor ()
	self.Systems     = {}
	self.SystemsById = {}
end

function self:GetSystemEnumerator (systemType)
	if not self.Systems [systemType] then return CAC.NullEnumerator () end
	
	return CAC.ArrayEnumerator (self.Systems [systemType])
end

function self:GetSystem (systemType, systemId)
	if not self.SystemsById [systemType] then return nil end
	
	return self.SystemsById [systemType] [systemId]
end

function self:GetBestSystem (systemType)
	local bestSystem = nil
	for system in self:GetSystemEnumerator (systemType) do
		if system:IsAvailable () then
			if system:IsDefault () then
				bestSystem = bestSystem or system
			else
				bestSystem = system
			end
		end
	end
	
	return bestSystem
end

function self:RegisterSystem (systemType, system)
	self.Systems     [systemType] = self.Systems     [systemType] or {}
	self.SystemsById [systemType] = self.SystemsById [systemType] or {}
	self.Systems     [systemType] [#self.Systems [systemType] + 1] = system
	self.SystemsById [systemType] [system:GetId ()] = system
end

function self:UnregisterSystem (systemType, system)
	if not self.Systems [systemType] then return end
	
	for k, v in ipairs (self.Systems [systemType]) do
		if v == system then
			table.remove (self.Systems [systemType], k)
			break
		end
	end
	self.SystemsById [systemType] [system:GetId ()] = nil
end

CAC.SystemRegistry = CAC.SystemRegistry ()