
local self = {}
self.__index = self

self.Effects = {}
self.ActiveEffects = {}

function self:Invoke() end

function self:CreateEffect(name)
	if (not isstring(name)) then
		error("bad argument #1 to 'CreateEffect' (string expected, got " .. type(name) .. ")")
	end

	if (self.Effects[name]) then
		local effect = {}
		effect.__index = effect

		setmetatable(effect, self.Effects[name])

		effect.Id = effect.Name .. SysTime()
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

function self:GetEffectFromPlayer(name, pl)
	if (not isstring(name)) then
		error("bad argument #1 to 'GetEffectFromPlayer' (string expected, got " .. type(name) .. ")")
	end

	if (not pl.ActiveEffects) then return end

	for _, effect in pairs(pl.ActiveEffects) do
		if (effect.Name == name and effect.Active) then
			return effect
		end
	end
end

function self:Reset()
	for _, effect in pairs(self.ActiveEffects) do
		effect:Reset()
	end

	self.ActiveEffects = {}
end

STATUS_BASE = self
