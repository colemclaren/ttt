
local self = {}
self.__index = self

self.Effects = {}

function self:Invoke() end

function self:CreateEffect(name)
	assert(isstring(name), "bad argument #1 to 'CreateEffect' (string expected, got " .. type(name) .. ")")
	
	if (self.Effects[name]) then
		return setmetatable({}, self.Effects[name])
	else
		local effect = {}
		effect.__index = effect
		effect.Name = name
		
		setmetatable(effect, EFFECT_BASE)
		
		self.Effects[name] = effect
	
		return effect
	end
end

function self:Reset()
	--[[for _, effect in pairs(self.Effects) do
		effect:Reset()
	end
	
	self.InvokedList = {}]]
end

STATUS_BASE = self
