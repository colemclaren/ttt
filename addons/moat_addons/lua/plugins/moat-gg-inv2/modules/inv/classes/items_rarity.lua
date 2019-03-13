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

function rarity.Generate(num)
	num = num or 1

	for i = 2, 8 do
		if (math.random(1, i) ~= i) then
			break
		end

		num = i
	end

	return (num == 8) and 9 or num
end

function rarity.Get(num)
	return rarity.Roster[num]
end

mi.Rarity = rarity