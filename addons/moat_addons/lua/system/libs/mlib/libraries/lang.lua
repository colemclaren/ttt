local lt = {
	Available = {},
	Strings = {}
}

Lang.Inventory.Rarities {
	[0] = "Stock",
	[1] = "Worn",
	[2] = "Standard",
	[3] = "Specialized",
	[4] = "Superior",
	[5] = "High-End",
	[6] = "Ascended",
	[7] = "Cosmic",
	[8] = "Extinct",
	[9] = "Planetary",
	[10] = "Interstellar"
}

function lt.Get()

end

function lt.Add(k, ...)

end

function lt.Exists(k)

end

function lt.Remove(k)

end

function lt.Render(k, ...)

end

Lang = setmetatable(lt, {
	__call = function(s, ...) return s.Render(...) end
})