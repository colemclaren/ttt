--
-- Inventory Item Stats
--

local stat, mt = setmetatable({
	Count = 0,
	OldChars = {},
	Roster = setmetatable({}, {
		__call = function(s) return s end
	})
}, {
	__call = function(s, ...) return s.Register(...) end
}), {}
mt.__index = mt
mt.__newindex = mt

--
-- Stat Methods
--

function mt:Stat()
	stat.Roster[self.Name] = self
	stat.Roster[self.Char] = self
	stat.Roster[self.ID] = self

	stat.OldChars[self.Char] = self.ID
	if (CLIENT) then
		stat.OldChars[self.ID] = self.Char
	end
	
	return self
end

function mt:SetMethods(t)
	local idx, val, mod, funcs

	for i = 1, #t do
		if (istable(t[i])) then funcs = t[i] end
		if (isnumber(t[i]) or isfunction(t[i])) then mod = t[i] end
		if (isstring(t[i])) then val = idx and t[i] idx = idx or t[i] end
	end

	self.Index, self.Value, self.Methods = idx, val, funcs
	self.ModFunc = isfunction(mod) and mod or self.Methods[mod]

	return self:Stat()
end

function mt:SetTags(t)
	local tags = isstring(t[1]) and {{t[1], t[2], t[3]}} or t

	for i = 1, #tags do
		local tag = t[i]
		tags[i] = {
			Letters = tag[1] or "ERR",
			Desc = tag[2] or "Unknown",
			Render = isfunction(t[3]) and t[3] or self.Methods[t[3]]
		}
	end

	self.Tag = tags[1]
	self.Tags = tags

	return self:Stat()
end

function mt:SetDisplay(t)
	self.Display = {
		Priority = t[1],
		Type = t[2],
		Good = t[3]
	}

	return self:Stat()
end

function mt:SetDefaults(t)
	assert(t[1] == "Gun" or t[1] == "Melee", "Unknown inventory item stat defaults.")

	local id, def = t[1], {}
	for i = 1, 7 do
		def[i] = {
			Min = t.Min[i],
			Max = t.Max[i]
		}
	end

	if (id == "Gun") then
		self.Type = self.Defaults["Melee"] and "Any" or "Gun"
		self.Defaults["Gun"] = def
	elseif (id == "Melee") then
		self.Type = self.Defaults["Gun"] and "Any" or "Melee"
		self.Defaults["Melee"] = def
	end

	return self:Stat()
end

--
-- Stat Functions
--

function stat.Register(name, id, char)
	assert(stat.Roster[id] == nil and stat.Roster[char] == nil, "Inventory item stat with info already exists.")

	stat.Count = stat.Count + 1

	return setmetatable({
		Name = name,
		Char = char,
		ID = id,
		Defaults = {},
		Type = "Any",
		Display = {},
		Tags = {},
		Tag = {},
		Index = false,
		Value = false,
		Methods = false,
		ModFunc = false
	}, mt):Stat()
end

function stat.Get(data)
	if (not (data and data.statid and data.value)) then
		return
	end

	if (not stat.Roster[data.statid]) then
		return
	end

	return data, stat.Roster[data.statid]
end

function stat.Modify(wep, item)
	if (not (wep and item and item.Stats)) then
		return
	end

	local data = item.Stats.Data
	for i = 1, data.Count do
		local d, s = stat.Get(data[i])
		if (not d or not s) then
			continue
		end

		if (s.Value) then
			wep[s.Index][s.Value] = s.ModFunc(d.Value, wep[s.Index][s.Value])
		else
			wep[s.Index] = s.ModFunc(d.Value, wep[s.Index] or 0)
		end
	end
end

mi.Stat = stat