local self = {}
CAC.SingleConVarMonitor = CAC.MakeConstructor (self)

--[[
	Events:
		ConVarChanged (bool, int, float, string)
			Fired when the convar's value has changed.
]]

function self:ctor (conVarName)
	self.ConVarName = conVarName
	self.ConVar     = GetConVar (self.ConVarName)
	
	if not self.ConVar then
		CAC.Logger:Message ("Cannot find convar " .. self.ConVarName .. "!")
	end
	
	self.Types               = {}
	
	self.LastValues          = {}
	self.LastValueStartTimes = {}
	self.LastValueEndTimes   = {}
	
	self:AddType ("Boolean", debug.getregistry ().ConVar.GetBool  )
	self:AddType ("Integer", debug.getregistry ().ConVar.GetInt   )
	self:AddType ("Float",   debug.getregistry ().ConVar.GetFloat )
	self:AddType ("String",  debug.getregistry ().ConVar.GetString)
	
	CAC.EventProvider (self)
	
	cvars.AddChangeCallback (self.ConVarName,
		function (conVarName, oldValueString, newValueString)
			self:Update ()
		end,
		"CAC.SingleConVarMonitor." .. self:GetHashCode ()
	)
end

function self:dtor ()
	cvars.RemoveChangeCallback (self.ConVarName, "CAC.SingleConVarMonitor." .. self:GetHashCode ())
end

function self:GetConVar ()
	return self.ConVar
end

function self:GetConVarName ()
	return self.ConVarName
end

function self:Update (t)
	t = t or SysTime ()
	
	local conVarChanged = false
	
	for typeName, f in pairs (self.Types) do
		local value = f (self.ConVar)
		
		if self.LastValues [typeName] ~= value then
			self.LastValueEndTimes [typeName] [self.LastValues [typeName]] = t
			self.LastValues [typeName] = value
			self.LastValueStartTimes [typeName] [self.LastValues [typeName]] = t
			
			conVarChanged = true
		end
	end
	
	if conVarChanged then
		self:DispatchConVarChanged ()
	end
end

function self:ValidateValue (typeName, value)
	local methodName = "Validate" .. typeName .. "Value"
	
	return self [methodName] (self, value)
end

-- Internal, do not call
function self:AddType (typeName, f)
	self.Types [typeName] = f
	self.LastValues [typeName] = self.Types [typeName] (self.ConVar)
	self.LastValueStartTimes [typeName] = self.LastValueStartTimes [typeName] or {}
	self.LastValueEndTimes   [typeName] = self.LastValueEndTimes   [typeName] or {}
	
	self ["Get" .. typeName .. "Value"] = function (self)
		return self.LastValues [typeName]
	end
	
	self ["Validate" .. typeName .. "Value"] = function (self, value)
		self:Update ()
		
		if self.LastValues [typeName] == value then return true end
		
		return SysTime () - (self.LastValueEndTimes [typeName] [value] or 0) < 60
	end
end

function self:DispatchConVarChanged ()
	self:DispatchEvent ("ConVarChanged", self:GetBooleanValue (), self:GetIntegerValue (), self:GetFloatValue (), self:GetStringValue ())
end