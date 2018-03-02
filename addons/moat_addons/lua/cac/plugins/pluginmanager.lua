local self = {}
CAC.PluginManager = CAC.MakeConstructor (self)

function self:ctor ()
	self.EventSource     = CAC.EventProvider ()
	
	self.Plugins         = {}
	self.PluginFactories = {}
	
	self.Destroyed       = false
end

function self:dtor ()
	self:DisableAllPlugins ()
	
	for plugin in self:GetPluginEnumerator () do
		plugin:dtor ()
	end
	
	self.Destroyed = true
end

function self:CreatePlugin (pluginName)
	local t = {}
	self.PluginFactories [pluginName] = CAC.MakeConstructor (t, CAC.Plugin)
	
	t.GetName = function (self)
		return pluginName
	end
	
	return t
end

function self:GetPlugin (pluginName)
	return self.Plugins [pluginName]
end

function self:Initialize ()
	if self.Destroyed then return end
	
	for pluginName, pluginFactory in pairs (self.PluginFactories) do
		if not self.Plugins [pluginName] then
			self.Plugins [pluginName] = pluginFactory (self.EventSource)
		end
	end
	
	self:EnableAllPlugins ()
end

function self:GetPluginEnumerator ()
	return CAC.ValueEnumerator (self.Plugins)
end

function self:EnableAllPlugins ()
	for plugin in self:GetPluginEnumerator () do
		local enabled = plugin:Enable ()
		
		if enabled then
			CAC.Logger:Message ("Enabled plugin \"" .. plugin:GetName () .. "\".")
		else
			CAC.Logger:Message ("Skipped plugin \"" .. plugin:GetName () .. "\".")
		end
	end
end

function self:DisableAllPlugins ()
	for plugin in self:GetPluginEnumerator () do
		plugin:Disable ()
	end
end

function self:DispatchEvent (eventName, ...)
	return self.EventSource:DispatchEvent (eventName, ...)
end

CAC.Plugins = CAC.PluginManager ()