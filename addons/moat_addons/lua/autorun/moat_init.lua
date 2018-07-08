-- and god said
-- let there be light \o/
if (moat) then return end
moat = moat or {}

function moat.print(...)
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end
	local msgt, msgc = {}, 3
	msgt[1] = Color(0, 255, 255)
	msgt[2] = "moat | "
	msgt[3] = Color(255, 255, 255)

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = args[i]
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end

function moat.debug(...)
	if (not DEBUG) then return end
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end

	local fn = debug.getinfo(2)
	local msgt, msgc = {}, 8
	msgt[1] = Color(0, 255, 255)
	msgt[2] = "debug | "
	msgt[3] = Color(255, 0, 0)
	msgt[4] = SERVER and "SV" or "CL"
	msgt[5] = Color(0, 255, 255)
	msgt[6] = " | "
	msgt[7] = Color(255, 255, 0)
	msgt[8] = fn and fn.name or "unknown"

	if (not DEBUG_LOAD and (msgt[8] == "includesv" or msgt[8] == "includecl" or msgt[8] == "includepath")) then
		return
	end

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = Color(0, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = " | "
		msgc = msgc + 1
		msgt[msgc] = Color(255, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = args[i] or "nil"
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end

-- our includers
moat.dontincludelist = moat.dontincludelist or {}
moat.dontinclude = function(p) if (not p:EndsWith("/") and not p:EndsWith(".lua")) then p = p .. "/" end moat.dontincludelist[p] = true end
moat.includedsv = moat.includedsv or {}
moat.includesv = function(p)
	if (moat.dontincludelist[p] or moat.includedsv[p]) then return end
	if (SERVER) then include(p) end

	moat.includedsv[p] = true
	moat.debug(p)
end
moat.includedcl = moat.includedcl or {}
moat.includecl = function(p)
	if (moat.dontincludelist[p] or moat.includedcl[p]) then return end 
	if (SERVER) then AddCSLuaFile(p) else include(p) end

	moat.includedcl[p] = true
	moat.debug(p)
end
moat.includesh = function(p) moat.includesv(p) moat.includecl(p) end
moat.includepathsv = function(p) moat.includepath(p, true) end
moat.includepathcl = function(p) moat.includepath(p, false) end
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

function moat.includepath_(p)
	assert(type(p) == "string", "moat.includepath_ couldn't include path!!!")
	if (p:StartWith "_") then return end
	if (p:StartWith "server") then moat.includepathsv(p) return end
	if (p:StartWith "client") then moat.includepathcl(p) return end
	moat.includepath(p)
end

function moat.includecheck(p)
	if (not p) then return true end
	if (p:StartWith "_") then return true end
	if (moat.dontincludelist[p]) then return true end
	if (p:StartWith "dev_" and not SERVER_ISDEV) then return true end
	return false
end

function moat.includepath(p)
	moat.debug(p, cl)
	assert(type(p) == "string", "moat.includepath couldn't include path!!!")
	if (not p:EndsWith("/")) then p = p .. "/" end

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

moat.includesh "system/constants/_servers.lua"
if (SERVER_ISDEV) then
	moat.includesh "autorun_dev/dev_init.lua"
end

-- load our super duper cool configs
moat.cfg = moat.cfg or {}
moat.includesv "system/config/server.lua"
if (SERVER_ISDEV) then moat.includesv "autorun_dev/realms/server.lua" end
moat.includecl "system/config/client.lua"
if (SERVER_ISDEV) then moat.includecl "autorun_dev/realms/client.lua" end
moat.includesh "system/config/shared.lua"
if (SERVER_ISDEV) then moat.includesh "autorun_dev/realms/shared.lua" end

-- load our constants
moat.includepath "system/constants"
moat.includepath "system/core"

-- load our old autorun stuff - need to rewrite everything
moat.includepath "loaders"

moat.plugins = moat.plugins or {}

--moat.includepath "plugins"