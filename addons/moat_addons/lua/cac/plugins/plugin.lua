local self = {}
CAC.Plugin = CAC.MakeConstructor (self)

function self:ctor (eventSource)
	self.EventSource = eventSource
	
	self.Enabled     = false
	
	self.Hooks       = CAC.WeakKeyTable ()
end

function self:dtor ()
	self:Disable ()
	self:ClearHooks ()
end

function self:GetName ()
	CAC.Error ("Plugin:GetName : Not implemented.")
end

-- State
function self:Enable ()
	if self.Enabled then return true end
	
	if not self:CanEnable () then return false end
	
	local success, r0 = pcall (self.OnEnable, self)
	if not success then
		CAC.Logger:Message ("Failed to enable plugin " .. self:GetName () .. ": " .. r0)
	end
	
	if r0 ~= false then
		self.Enabled = true
		return true
	else
		return false
	end
end

function self:Disable ()
	if not self.Enabled then return end
	
	local success, r0 = pcall (self.OnDisable, self)
	if not success then
		CAC.Logger:Message ("Failed to disable plugin " .. self:GetName () .. ": " .. r0)
	end
	self:ClearHooks ()
	
	self.Enabled = false
end

function self:IsEnabled ()
	return self.Enabled
end

function self:SetEnabled (enabled)
	if self.Enabled == enabled then return self end
	
	if enabled then
		self:Enable ()
	else
		self:Disable ()
	end
	
	return self
end

function self:CanEnable ()
	return true
end

-- Hooks
function self:ClearHooks ()
	for object, eventTable in pairs (self.Hooks) do
		for eventName, _ in pairs (eventTable) do
			object:RemoveEventListener (eventName, "CAC.Plugin." .. self:GetName ())
		end
	end
	
	self.Hooks = CAC.WeakKeyTable ()
end

function self:Hook (object, eventName, callback)
	if isstring (object) then
		callback  = eventName
		eventName = object
		object    = self.EventSource
	end
	
	self.Hooks [object] = self.Hooks [object] or {}
	self.Hooks [object] [eventName] = true
	
	object:AddEventListener (eventName, "CAC.Plugin." .. self:GetName (), callback)
end

function self:Unhook (object, eventName)
	if isstring (object) then
		eventName = object
		object    = self.EventSource
	end
	
	self.Hooks [object] = self.Hooks [object] or {}
	self.Hooks [object] [eventName] = nil
	
	if not next (self.Hooks [object]) then
		self.Hooks [object] = nil
	end
	
	object:RemoveEventListener (eventName, "CAC.Plugin." .. self:GetName (), callback)
end

-- Internal, do not call
function self:OnEnable ()
end

function self:OnDisable ()
end