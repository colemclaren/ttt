--
-- Inventory Item Creation
--

local item, mt = setmetatable({
	Types = {}, TypesID = {},
	Count = 0,
	Roster = setmetatable({}, {
		__call = function(s) return s end
	})
}, {
	__call = function(s, ...) return s.Register(...) end
}), {}
mt.__index = mt

function item.Type(name, id, cosmetic)
	local tb = {ID = id, Name = name, Cosmetic = cosmetic}

	item.TypesID[id] = tb
	item.Types[name] = tb
end

item.Type("Crate", 1)
item.Type("Usable", 2)
item.Type("Tier", 3)
item.Type("Unique", 4)
item.Type("Melee", 5)
item.Type("Power-Up", 6)
item.Type("Other", 7)
item.Type("Hat", 8, true)
item.Type("Mask", 9, true)
item.Type("Body", 10, true)
item.Type("Effect", 11, true)
item.Type("Model", 12, true)

--
-- Item Methods
--

function mt:SetRarity(num)
	self.Rarity = num

	return self
end

function mt:Chance(num)
	self.Rarity = num

	return self
end

function mt:SetType(type)
	local ItemType = isnumber(type) and item.TypesID[type] or item.Types[type] or {ID = type}
	assert(ItemType.ID, "Inventory item type does not exist.")

	if (ItemType.ID and (ItemType.ID == "Paint" or ItemType.ID == "Tint" or ItemType.ID == "Skin")) then
		self.ItemCheck = (ItemType.ID == "Paint" and 10) or (ItemType.ID == "Tint" and 11) or 12
		self.PaintVer = true
		self.Type = 2
	end

	self.Type = ItemType.ID

	return self
end

function mt:SetName(str)
	self.Name = str

	return self
end

function mt:SetColor(tb)
	self.NameColor = Color(tb[1], tb[2], tb[3])

	if (self.PaintVer) then
		self.Clr = {tb[1], tb[2], tb[3]}
	end

	return self
end

function mt:SetTexture(str)
	self.Texture = str

	return self
end

function mt:SetEffect(str, mods)
	self.NameEffect = str
	self.EffectMods = mods

	return self
end

function mt:SetDesc(str)
	self.Description = str

	return self
end

function mt:SetIcon(str)
	self.Image = str

	return self
end

function mt:SetCollection(str)
	self.Collection = str

	return self
end

function mt:Set(str)
	self.Collection = str .. " Collection"

	return self
end

function mt:SetShop(price, active)
	self.Price = price
	self.Active = active

	return self
end

function mt:SetWeapon(str)
	self.Weapon = str

	return self
end

function mt:SetStats(minStats, maxStats)
	self.MinStats = minStats
	self.MaxStats = maxStats
	self.Stats = {}

	if (true) then
		-- self.Stats.Accuracy = {Min = mi.Stats.Accuracy.Defaults[self.Type == 5 and "Melee" or "Gun"][self.Rarity].Min, Max = mi.Stats.Accuracy.Defaults[self.Type == 5 and "Melee" or "Gun"][self.Rarity].Max}
		print(mi.Stat.Count)
		for i = 1, mi.Stat.Count do
			local s, def = mi.Stat.Roster[i], self.Type == 5 and "Melee" or "Gun"
			if (not next(s.Defaults) or (not s.Defaults[def])) then
				continue
			end

			self.Stats[s.Name] = {Min = s.Defaults[def][math.min(self.Rarity, 7)].Min, Max = s.Defaults[def][math.min(self.Rarity, 7)].Max}
		end
	end

	return self
end

function mt:Stat(id, min, max)
	if (self.Stats[id] and self.Stats[id].Min == min and self.Stats[id].Max == max) then
		return self
	end

	self.Stats[id] = {Min = min, Max = max}

	return self
end

function mt:SetTalents(min, max)
	self.MinTalents = min
	self.MaxTalents = max
	self.Talents = {}

	for i = 1, max do
		self.Talents[i] = "random"
	end

	return self
end

function mt:SetTalent(id, name)
	self.Talents[id] = name

	return self
end

function mt:SetModel(str)
	self.Model = str

	return self
end

function mt:SetSkin(str)
	self.Skin = str

	return self
end


function mt:SetParent(str)
	if (str == "eyes") then
		self.Attachment = str
	else
		self.Bone = str
	end

	return self
end

function mt:SetRender(parent, func)
	self:SetParent(parent)
	self.Render = func

	return self
end

function mt:SetDisplay(size, x, y, z, pitch, yaw, roll, skin_id)
	if (isfunction(size)) then
		self.Render = size

		return self
	end

	self.Display = istable(size) and size or {
		Size = size or 1,
		Skin = skin_id or false,
		Position = {x or 0, y or 0, z or 0},
		Rotation = {pitch or 0, yaw or 0, roll or 0}
	}

	return self
end

function mt:SetCheck(id)
	assert(MOAT_ITEM_CHECK[id], "Inventory item check does not exist.")
	self.ItemCheck = id

	return self
end


--
-- Item Functions
--

function item.Register(id)
	assert(item.Roster[id] == nil, "Inventory item with id already exists. (" .. tostring(id or "?") .. ")")

	item.Count = item.Count + 1
	item.Roster[id] = setmetatable({
		ID = id
	}, mt)

	return item.Roster[id]
end

mi.Item = item