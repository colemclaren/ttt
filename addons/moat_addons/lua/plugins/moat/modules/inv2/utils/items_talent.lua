--
-- Inventory Item Talents
--

local talent, mt = setmetatable({
	Count = 0,
	Tiers = {
		[1] = {5, 10},
		[2] = {15, 20},
		[3] = {25, 30},
		[4] = {40, 60},
		[5] = {75, 100}
	},
	Roster = setmetatable({}, {
		__call = function(s) return s end
	})
}, {
	__call = function(s, ...) return s.Register(...) end
}), {}
mt.__index = mt
mt.__newindex = mt

--
-- Talent Methods
--

function mt:Talent()
	talent.Roster[self.Name] = self
	talent.Roster[self.ID] = self

	return self
end

function mt:SetName(name)
	talent.Roster[self.Name] = nil
	self.Name = name

	return self:Talent()
end

function mt:SetColor(r, g, b, a)
	if (istable(r)) then
		self.NameColor = Color(r[1] or r.r or 0, r[2] or r.g or 0, r[3] or r.b or 0, r[4] or r.a or 255)
	elseif (isnumber(r)) then
		self.NameColor = Color(r or 0, g or 0, b or 0, a or 255)
	else
		self.NameColor = r
	end
	
	return self:Talent()
end

function mt:SetStyle(str_effect, fields)
	if (istable(str_effect)) then
		fields = str_effect[2]
		str_effect = str_effect[1]
	end

	self.NameEffect = {Style = str_effect, Fields = fields}
	
	return self:Talent()
end

function mt:SetDesc(desc)
	self.Description = desc
	
	return self:Talent()
end

function mt:SetLevel(num_tier, skip_level)
	if (istable(num_tier)) then
		skip_level = num_tier[2]
		num_tier = num_tier[1]
	end

	assert(num_tier and talent.Tiers[num_tier],
		"Failed on talent mt:SetTier call attempt!\n	num_tier: " .. tostring(num_tier))

	self.Tier = num_tier

	if (not skip_level) then
		self:SetLevel(talent.Tiers[num_tier][1], talent.Tiers[num_tier][2])
	end

	return self:Talent()
end

function mt:SetLevels(min, max)
	if (istable(min)) then
		max = min[2]
		min = min[1]
	end

	self.LevelRequired = {Min = min, Max = max or min}

	return self:Talent()
end

function mt:SetDesc(desc)
	self.Description = desc
	
	return self:Talent()
end

function mt:Mod(str_id, min, max)
	if (istable(str_id)) then
		max = str_id[3]
		min = str_id[2]
		str_id = str_id[1]
	end

	assert(str_id and self.Modifications[str_id] == nil,
		"Failed on talent mt:Mod call attempt!\n	str_id: " .. tostring(str_id))

	self.Modifications.Count = self.Modifications.Count + 1
	self.Modifications[self.Modifications.Count] = {
		ID = str_id,
		Min = min,
		Max = max or min
	}

	return self:Talent()
end

function mt:CanMelee(bool)
	self.Melee = bool

	return self:Talent()
end

function mt:Hook(event, func, fields)
	if (istable(event)) then
		fields = event[3] or {}
		func = event[2]
		event = event[1]
	end

	local id = fields.ID or "Talent." .. self.Name .. "." .. event
	self.Hooks[event] = {
		Function = func,
		Fields = fields,
		ID = id
	}

	hook(event, id, function(...)

	end)


	return self:Talent()
end

--
-- Talent Functions
--

function talent.Register(id, name, level, available_at_random)
	assert(id and name and talent.Roster[id] == nil,
		"Failed on talent.Register call attempt!\n	id: " .. tostring(id) .. "\n	name: " .. tostring(name))

	talent.Count = talent.Count + 1

	if (available_at_random == nil) then
		available_at_random = true 
	end

	return setmetatable({
		ID = id,
		Name = name,
		NameColor = Color(255, 255, 255),
		NameEffect = false,
		Description = "This talent has no description. You can set one using the talent:SetDescription('...') method.",
		Tier = level,
		LevelRequired = {Min = talent.Tiers[level] and talent.Tiers[level][1] or level, Max = talent.Tiers[level] and talent.Tiers[level][2] or level},
		Modifications = {Count = 0},
		Melee = false,
		NotUnique = available_at_random,
		Hooks = {}
	}, mt):Talent()
end

function talent.Get(data)
	assert(data and data.talentid and talent.Roster[data.talentid], 
		"Failed on talent.Get call attempt!\n	data: " .. tostring(data))

	return data, talent.Roster[data.statid]
end

mi.Talent = talent