
local self = {}
self.__index = self

self.Effects = {}
self.ActiveEffects = {}

function self:Invoke() end

function self:CreateEffect(name)
	assert(isstring(name), "bad argument #1 to 'CreateEffect' (string expected, got " .. type(name) .. ")")
	
	if (self.Effects[name]) then
		local effect = {}
		effect.__index = effect
		
		setmetatable(effect, self.Effects[name])
		table.insert(self.ActiveEffects, effect)
		
		return effect
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
	for _, effect in pairs(self.ActiveEffects) do
		effect:Reset()
	end
	
	self.ActiveEffects = {}
end

STATUS_BASE = self
