local p = {}
ux.p = setmetatable({}, {
	__index = p,
	__newindex = function() end
})

p.mg = {
	blue = Color(103, 152, 235),
	blue_dark = Color(69, 126, 223),
	blue_darker = Color(35, 98, 205),
	blue_light = Color(143, 180, 244),
	blue_lighter = Color(193, 215, 251),

	yellow = Color(255, 225, 97),
	yellow_dark = Color(255, 217, 60),
	yellow_darker = Color(255, 210, 22),
	yellow_light = Color(255, 233, 138),
	yellow_lighter = Color(255, 243, 190),

	orange = Color(255, 199, 97),

	dark = Color(23, 24, 26),
	dark_darker = Color(22, 25, 30),
	dark_blue = Color(31, 40, 59),
	dark_bluer = Color(31, 35, 44),
	dark_gray = Color(59, 69, 87),
	dark_grayer = Color(46, 50, 59),

	text = Color(132, 146, 166),
	white = Color(239, 246, 255),
	shadow = Color(25, 44, 64),
	light = Color(255, 255, 255, 165.75),
	shop = Color(255, 205, 0, 150),
	shop2 = Color(255, 205, 0, 255)
}

-- mg colors
p.mblue = Color(51, 153, 255)
p.mcyan = Color(0, 200, 255)

-- basic palette colors
p.white = Color(255, 255, 255)
p.black = Color(0, 0, 0)
p.red = Color(255, 0, 0)
p.orange = Color(255, 128, 0)
p.yellow = Color(255, 255, 0)
p.lime = Color(128, 255, 0)
p.green = Color(0, 255, 0)
p.teal = Color(0, 255, 128)
p.cyan = Color(0, 255, 255)
p.sky = Color(0, 128, 255)
p.blue = Color(0, 0, 255)
p.purple = Color(128, 0, 255)
p.hotpink = Color(255, 0, 255)
p.pink = Color(255, 0, 128)

-- rainbow color
p.rainbow = Color(255, 255, 255)
p.rainbowfunc = function(n)
	return HSVToColor(CurTime() * n % 360, 1, 1)
end
hook.Add("Think", function()
	p.rainbow = p.rainbowfunc(70)
end)