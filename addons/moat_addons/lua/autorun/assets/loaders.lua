AddCSLuaFile()

moat.dontincludelist = moat.dontincludelist or {}
moat.dontinclude = function(l)
	local t = istable(l) and l or {l}
	for i = 1, #t do
		moat.dontincludelist[(t[i]:EndsWith("/") or t[i]:EndsWith(".lua")) and t[i] or t[i] .. "/"] = true
	end
end

moat.devfile, moat.devfiles = function(p)
	return p:StartWith "dev_" or p:find "/dev_"
end, {count = 0}

moat.includedsv, moat.includesv = moat.includedsv or {}, function(p)
	if (CLIENT or moat.dontincludelist[p] or moat.includedsv[p] or (moat.devfile(p) and not SERVER_ISDEV)) then return end

	include(p)
	moat.includedsv[p] = true
	moat.debug(p)
end

moat.includedcl, moat.includecl = moat.includedcl or {}, function(p)
	if (moat.dontincludelist[p] or moat.includedcl[p] or (moat.devfile(p) and not SERVER_ISDEV)) then return end
	if (SERVER) then
		AddCSLuaFile(p)

		if (moat.devfile(p) and SERVER_ISDEV) then
			moat.devfiles.count = moat.devfiles.count + 1
			moat.devfiles[moat.devfiles.count] = p
		end

		return
	end

	include(p)
	moat.includedcl[p] = true
	moat.debug(p)
end

moat.includesh = function(p) moat.includesv(p) moat.includecl(p) end
function moat.include_(p, pf, ps, pfp)
	assert(type(p) == "string", "moat.include_ couldn't include file!!!")
	if (not p:EndsWith(".lua")) then return end

	ps = ps or string.Explode("/", p) or {"???", "???"}
	pf = pf or ps[#ps] or "???"
	pfp = pfp or ps[#ps - 1] or "???"

	if (pf:StartWith "_") then return end
	if (pf:StartWith "cl_" or pf:StartWith "client") then moat.includecl(p) return end
	if (pf:StartWith "sv_" or pf:StartWith "server") then moat.includesv(p) return end

	if (pfp:StartWith "_") then return end
	if (pfp:StartWith "cl_" or pfp:StartWith "client") then moat.includecl(p) return end
	if (pfp:StartWith "sv_" or pfp:StartWith "server") then moat.includesv(p) return end

	moat.includesh(p)
end

moat.includepathsv = function(p) moat.includepath(p, true) end
moat.includepathcl = function(p) moat.includepath(p, false) end
function moat.includepath_(p)
	assert(type(p) == "string", "moat.includepath_ couldn't include path!!!")
	if (p:StartWith "_") then return end
	if (p:StartWith "server") then moat.includepathsv(p) return end
	if (p:StartWith "client") then moat.includepathcl(p) return end
	moat.includepath(p)
end

function moat.includecheck(p)
	return (not p) or (p:StartWith "_") or (moat.dontincludelist[p]) or (p:StartWith "dev_" and not SERVER_ISDEV)
end

function moat.includepath(p)
	moat.debug(p, cl)
	assert(type(p) == "string", "moat.includepath couldn't include path!!!")
	p = p:EndsWith("/") and p or p .. "/"

	if (p:StartWith "_") then return end
	if (p:StartWith "dev_" and not SERVER_ISDEV) then return end
	if (moat.dontincludelist[p]) then return end

	local ps, fs = file.Find(p .. "*", "LUA")
	if (not ps and not fs) then return end

	if (ps and file.Exists(p .. "init.lua", "LUA")) then
		moat.include_(p .. "init.lua")
	end

	if (fs and file.Exists(p .. "init", "LUA")) then
		moat.includepath(p .. "init")
	end

	if (fs) then
		for _, fn in ipairs(fs) do
			if (moat.includecheck(fn)) then continue end
			moat.includepath_(p .. fn)
		end
	end

	if (ps) then
		for _, pn in ipairs(ps) do
			if (moat.includecheck(pn)) then continue end
			moat.include_(p .. pn, pn)
		end
	end
end