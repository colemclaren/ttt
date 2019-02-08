local wl, u = {}, {
	["motato"] = "76561198053381832",
	["meepen"] = "76561198050165746",
	["velkon"] = "76561198154133184",
	["footsies"] = "76561198106061489",
	["ling"] = "76561198044542936",
	["poke"] = "76561198009551777",
	["dante"] = "76561198098542457",
	["george"] = "76561198039378503",
	["the suess"] = "76561198059864637",
	["zero"] = "76561198014504949",
	["leo"] = "76561198245961734"
}

-- communitylead
wl[100] = {
	[u["motato"]] = true,
	[u["meepen"]] = true,
	[u["velkon"]] = true,
	[u["ling"]] = true

}

-- techlead
wl[95] = {
	[u["meepen"]] = true,
	[u["velkon"]] = true,
	[u["ling"]] = true
}

-- operationslead
wl[90] = {
	-- [u["poke"]] = true,
	-- [u["george"]] = true
}

-- headadmin
wl[35] = {
	[u["leo"]] = true
	-- [u["poke"]] = true,
	-- [u["george"]] = true,
	-- [u["zero"]] = true
}

moat.ranks.whitelist = wl