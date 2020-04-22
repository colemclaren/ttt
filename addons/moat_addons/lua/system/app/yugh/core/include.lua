AddCSLuaFile()

local it = {}
it.order = {
	skip = "ignore",
	includer = "include",
	before = {
		"init",
		"utils",
		"core"
	},
	priority = {
		"server",
		"client",
		"shared"
	},
	after = {
		"included"
	},
	realms = function(p)
		return {p,
			"sv_" .. p, p .. "_sv",
			"cl_" .. p, p .. "_cl",
			"sh_" .. p, p .. "_sh"
		}
	end
}

function it.init()
	if (yugh.include.started) then return end
	yugh.include.started = true

	local a = {}
	for k, v in pairs(it.order.after) do
		local r = it.order.realms(k)
		for i = 1, #r do a[r[i]] = true a[r[i] .. ".lua"] = true end
	end
	it.order.after = a
end

function it.realm(str, m, r, dev)
	str, m, r, dev = str:match"([^/]+)[/]$" or str:match"([^/]+)%.lua$" or str, function(p)
		return str:match(p)
	end

	if (yugh.include.dev.check(str)) then
		if (not Server or not Server.IsDev) then
			return "skip"
		end

		str, dev = yugh.include.dev.normalize(str), true
	end

	if (m"^_" or it.skip(str)) then
		return "skip"
	end

	if ((m"^cl_" or m"_cl$" or m"^client$") or (m"^ux$" or m"^ui$" or m"^interface$")) then
		r = "cl"
	end

	if (m"^sv_" or m"_sv$" or m"^server$") then
		r = "sv"
	end

	if (m"^sh_" or m"_sh$" or m"^shared$") then
		r = "sh"
	end

	return r, dev
end

function it.file(p, n, fn, dev)
	if (not p:match "%.lua$") then return end

	n = n or p:match "[/]([^/]+)$"

	fn, dev = fn or "sh", false
	for d in (p:gmatch "([^/]+)") do
		local realm, isdev = it.realm(d)
		if (isdev) then dev = true end
		if (not realm) then continue end

		fn = realm

		if (realm == "skip") then break end
	end

	return yugh.include.internal(p, fn, dev)
end

function it.table(p, f, tb, a, s)
	if (not tb) then return end

	for _, n in ipairs(tb) do
		if (a and a[n]) then
			if (not s) then s = {} end
			s[#s + 1] = n

			continue
		end

		if (f) then
			it.file(p .. n, n)
		else
			it.load(p .. n)
		end
	end
end

function it.path(p, fs, dirs)
	local b, l, a, sf, sd = it.order.before, it.order.priority, it.order.after

	it.try(p, b)
	it.try(p, l)

	it.table(p, true, fs, a, sf)
	it.table(p, false, dirs, a, sd)

	it.table(p, true, sf)
	it.table(p, false, sd)
end

function it.iterate(tb, func, num)
	if (not tb) then return end
	num = num or #tb

	for i = 1, num do
		if (not tb[i]) then
			continue
		end

		func(tb[i])
	end
end

function it.load(str)
	local p = str:match "/$" and str or str .. "/"

	local t = it.realm(p)
	if (t and t == "skip") then
		return
	end

	local lua, dirs = file.Find(p .. "*", "LUA")
	if (not lua and not dirs) then
		return
	end

	if (it.try(p, it.order.skip)) then
		return
	end

	local c, func, name = it.try(p, it.order.includer)
	if (c) then
		if (func and name) then
			it.iterate(lua, function(n) if (n ~= name) then func(n, p) end end)
			it.iterate(dirs, function(n) if (n ~= name) then func(n, p, true) end end)
		end

		return
	end

	it.init()
	it.path(p, lua, dirs)
end

function it.try(p, n, u, f)
	if (n and istable(n)) then
		for i = 1, #n do
			if (not n[i]) then continue end
			it.try(p, n[i], u)
		end

		return
	end

	local e = function(s, d)
		if (u and ((d and u == "files") or (not d and u == "folders"))) then
			return
		end

		s = d and s or s .. ".lua"
		if (not file.Exists(p .. s, "LUA")) then return else f = true end

		return d and it.load(p .. s) or it.file(p .. s, s), s
	end

	local try = it.order.realms(n)
	for i = 1, 2 do
		for r = 1, #try do
			local func, name = e(try[r], i == 2)
			if (n == it.order.includer and f) then
				return true, func, name
			end
		end
	end

	return f
end

it.loaded = {l = {}, check = function(fp)
		local included = yugh.include.loaded.l[fp]
		if (not included) then
			yugh.include.loaded.l[fp] = true
		end

		return included
	end, is = function(fp)
		return yugh.include.loaded.l[fp]
	end
}

it.blacklist = {l = {}, ft = {}, fc = 0, f = function(p, r)
		if (yugh.include.blacklist.fc == 0) then
			return false
		end

		for i = 1, yugh.include.blacklist.fc do
			if (yugh.include.blacklist.ft[i] and yugh.include.blacklist.ft[i](p, r)) then
				return true
			end
		end

		return false
	end, check = function(fp, r)
		return yugh.include.blacklist.l[fp] or yugh.include.blacklist.f(fp, r)
	end
}

function it.skip(fp, r)
	return it.blacklist.check(fp, r) or (r and r == "skip")
end

it.sv = SERVER and include or function() end
it.cl = SERVER and AddCSLuaFile or include
it.sh = function(p) AddCSLuaFile(p) return include(p) end

LUA_INCLUDE = LUA_INCLUDE or {["sv"] = {}, ["cl"] = {}, ["sh"] = {}}
function it.internal(fp, r, dev)
	r = r or "sh"

	if (it.skip(fp, r)) then
		return
	end

	if (it.loaded.check(fp)) then
		return
	end

	if (dev and (r == "cl" or r == "sh")) then
		yugh.include.dev(fp)
	end

	if (r == "sv" and SERVER) then /*table.insert(LUA_INCLUDE["sv"], fp)*/ return it.sv(fp) end
	if (r == "cl") then /*table.insert(LUA_INCLUDE["cl"], fp)*/ return it.cl(fp) end
	if (r == "sh") then /*table.insert(LUA_INCLUDE["sv"], fp) table.insert(LUA_INCLUDE["cl"], fp)*/ return it.sh(fp) end
end


yugh.include = yugh.include or it

local include_thing = function(self, fp, base)
	if (base and isstring(base)) then fp = base .. fp end

	if (fp:match "/$") then
		self.load(fp)
	else
		fp = fp:match "%.lua$" and fp or fp .. ".lua"
		return self.file(fp)
	end
end

local include_func = function(self, fp, base, rf)
	if (isstring(fp)) then
		if (fp:match "^/") then
			return function(i) return self(i, fp:gsub("^/", "")) end
		end
	
		fp, rf = {fp}, true
	end

	if (istable(fp)) then
		for i = 1, #fp do
			local f = include_thing(self, fp[i], base)
			if (f and rf) then return f end
		end

		return self
	end
end

local blacklist_func = function(self, v)
	if (isstring(v)) then v = {v} end
	if (istable(v)) then
		for i = 1, #v do
			self.l[v[i]] = true
		end
	end

	if (isfunction(v)) then
		self.fc = self.fc + 1
		self.ft[self.fc] = v
	end
end

setmetatable(yugh.include, {__call = include_func})
setmetatable(yugh.include.blacklist, {__call = blacklist_func})

yugh.i = yugh.include
yugh.isv = yugh.include.sv
yugh.icl = yugh.include.cl
yugh.ish = yugh.include.sh

yugh.include.dev = yugh.include.dev or {l = {}, c = 0, check = function(str)
		return (str:match"^dev_" or str:match"_dev$")
	end, normalize = function(str)
		return str:gsub("_dev$", ""):gsub("^dev_", "")
	end
}

setmetatable(yugh.include.dev, {
	__call = function(self, fp, r)
		if (not Server or not Server.IsDev) then return end

		self.c = self.c + 1
		self.l[self.c] = fp
	end
})