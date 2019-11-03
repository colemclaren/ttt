local function BuildArgs(args, tbl)
	tbl.n, args.t = tbl.n or #tbl, {}

	for i = 1, tbl.n do
		for arg = 1, args.n do
			local var = args[arg]
			if (not var) then
				continue
			end

			args.t[i] = tbl[i](var) and var or false
		end
	end

	return unpack(args.t)
end

local function CreateArgs(...)
	local args = {n = select("#", ...), ...}
	function args:Build(tbl)
		return BuildArgs(self, tbl)
	end

	return args
end

function yugh.Args(...)
	local args = CreateArgs(...)
	return args
end

function yugh.CheckArgs(...)
	local args = CreateArgs(...)
	assert(args.n > 0, "yugh no args")

	return args
end

function yugh.args(...)
	local args = {n = select("#", ...), ...}
	assert(args.n > 0, "yugh no args")

	args.build = function(tbl)
		tbl.n, args.t = tbl.n or #tbl, {}

		for i = 1, tbl.n do
			for arg = 1, args.n do
				local var = args[arg]
				if (not var) then
					continue
				end

				args.t[i] = tbl[i](var) and var or false
			end
		end

		return unpack(args.t)
	end

	return args
end

function yugh.table(tbl)
	tbl = tbl or {}
	tbl.count = 0
	tbl.contents = {}
	tbl.insert = function(v)
		tbl.count = tbl.count + 1
		tbl.contents[tbl.count] = v
	end
	tbl.iterate = function(func)
		for i = 1, tbl.count do
			func(tbl.contents[i], i)
		end
	end
	tbl.clean = function()
		tbl.count = 0
		tbl.contents = {}
	end

	return tbl
end

function yugh.iterate(tb, func, num)
	if (not tb) then return end
	num = num or #tb

	for i = 1, num do
		if (not tb[i]) then
			continue
		end

		func(tb[i])
	end
end

function yugh.find(p, f, d)
	p = p:match "/$" and p or p .. "/"

	local fs, ds = file.Find(p .. "*", "LUA")
	if (not fs and not ds) then return end

	yugh.iterate(fs, function(n)
		f(n:gsub("%.lua$", ""), p)
	end)

	if (not ds) then return end
	yugh.iterate(ds, function(n)
		if (d) then d(n, p) end
	end)
end