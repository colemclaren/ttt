local self = {}
CAC.ConVarMonitor = CAC.MakeConstructor (self)

--[[
	Events:
		ConVarChanged (conVarName, bool, int, float, string)
			Fired when a convar has changed.
]]

function self:ctor ()
	self:AddType ("Boolean")
	self:AddType ("Integer")
	self:AddType ("Float"  )
	self:AddType ("String" )
	
	self.ConVarMonitors = {}
	
	for conVarName, _ in CAC.RestrictedConVars:GetEnumerator () do
		self:AddConVar (conVarName)
	end
	
	CAC.EventProvider (self)
	
	timer.Create ("CAC.ConVarMonitor." .. self:GetHashCode (), 1, 0,
		function ()
			if Profiler then Profiler:Begin ("CAC.ConVarMonitor." .. self:GetHashCode ()) end
			
			self:Update ()
			
			if Profiler then Profiler:End () end
		end
	)
end

function self:dtor ()
	for _, conVarMonitor in pairs (self.ConVarMonitors) do
		self:UnhookConVarMonitor (conVarMonitor)
		conVarMonitor:dtor ()
	end
	
	timer.Destroy ("CAC.ConVarMonitor." .. self:GetHashCode ())
end

function self:Update (t)
	local t0 = SysTime ()
	for _, conVarMonitor in pairs (self.ConVarMonitors) do
		conVarMonitor:Update (t)
	end
end

function self:ValidateValue (conVarName, typeName, value)
	local methodName = "Validate" .. typeName .. "Value"
	
	return self [methodName] (self, conVarName, value)
end

-- Internal, do not call
function self:AddConVar (conVarName)
	if self.ConVarMonitors [conVarName] then return end
	
	if not ConVarExists (conVarName) then return end
	
	self.ConVarMonitors [conVarName] = CAC.SingleConVarMonitor (conVarName)
	self:HookConVarMonitor (self.ConVarMonitors [conVarName])
end

function self:AddType (typeName)
	local methodName = "Get" .. typeName .. "Value"
	self [methodName] = function (self, conVarName)
		if not self.ConVarMonitors [conVarName] then return nil end
		
		return self.ConVarMonitors [conVarName] [methodName] (self.ConVarMonitors [conVarName])
	end
	
	local methodName = "Validate" .. typeName .. "Value"
	self [methodName] = function (self, conVarName, value)
		if not self.ConVarMonitors [conVarName] then return nil end
		
		return self.ConVarMonitors [conVarName] [methodName] (self.ConVarMonitors [conVarName], value)
	end
end

function self:HookConVarMonitor (conVarMonitor)
	if not conVarMonitor then return end
	
	conVarMonitor:AddEventListener ("ConVarChanged", "ConVarMonitor." .. self:GetHashCode (),
		function (_, bool, int, float, string)
			self:DispatchEvent ("ConVarChanged", conVarMonitor:GetConVarName (), bool, int, float, string)
		end
	)
end

function self:UnhookConVarMonitor (conVarMonitor)
	if not conVarMonitor then return end
	
	conVarMonitor:RemoveEventListener ("ConVarChanged", "ConVarMonitor." .. self:GetHashCode ())
end

CAC.ConVarMonitor = CAC.ConVarMonitor ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.ConVarMonitor:dtor ()
		CAC.ConVarMonitor = nil
	end
)