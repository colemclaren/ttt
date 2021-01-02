--
-- Inventory Item Rarities
--

local rarity, mt = setmetatable({
	Count = 0,
	Roster = {}
}, {
	__call = function(s, ...) return s.Get(...) end
}), {}
mt.__index = mt
mt.__newindex = mt

--
-- Rarity Methods
--

function mt:SetName(str)
	self.Name = str

	return self
end

function mt:SetIcon(url)
	self.Icon = url

	return self
end

function mt:SetColor(tb)
	self.Color = Color(tb[1], tb[2], tb[3])

	return self
end

function mt:SetPrice(min, max)
	self.Price = {
		Min = min,
		Max = max
	}

	return self
end

--
-- Rarity Functions
--

function rarity.Register(id)
	assert(rarity.Roster[id] == nil, "Inventory item rarity with id already exists.")

	rarity.Count = rarity.Count + 1
	rarity.Roster[id] = setmetatable({ID = id,
		Name = "Stock",
		Color = Color(255, 255, 255),
		Icon = "https://i.moat.gg/HchBd.png",
		Price = {Min = 0, Max = 0}
	}, mt)

	return rarity.Roster[id]
end

function rarity.GetTable(id)
	return rarity.Roster[id]
end

function rarity.Get(low, high)
	if (low and high and low == high) then
		return low or high
	end

	for i = low or 1, high or 9 do
		if ((high and high ~= 8 or not high) and i == 8) then
			return (low and low == 8) and low or 9
		end

		if (math.random(i + 1) ~= i + 1) then
			return i
		end
	end

	return 9
end

mi.Rarity = rarity