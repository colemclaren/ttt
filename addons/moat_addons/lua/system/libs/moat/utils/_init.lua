-- moat addon initializer
-- this should never be ran
if (true) then return end

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
moat.includesv = function(p) if (moat.dontincludelist[p]) then return end if (SERVER) then include(p) end moat.debug(p) end
moat.includecl = function(p) if (moat.dontincludelist[p]) then return end if (SERVER) then AddCSLuaFile(p) else include(p) end moat.debug(p) end
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
	if (pf:StartWith "cl_" or pf:StartWith "client_") then moat.includecl(p) return end
	if (pf:StartWith "sv_" or pf:StartWith "server_") then moat.includesv(p) return end

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

function moat.includepath(p)
	moat.debug(p, cl)
	assert(type(p) == "string", "moat.includepath couldn't include path!!!")
	if (not p:EndsWith("/")) then p = p .. "/" end

	if (p:StartWith "_") then return end
	if (p:StartWith "dev_" and not SERVER_ISDEV) then return end
	if (moat.dontincludelist[p]) then return end

	local ps, fs = file.Find(p .. "*", "LUA")
	if (not ps and not fs) then return end

	if (fs) then
		if (file.Exists(p .. "init", "LUA")) then
			moat.includepath_(p .. "init")
		end

		for _, fn in ipairs(fs) do
			if (not fn) then continue end
			moat.includepath_(p .. fn)
		end
	end

	if (ps) then
		if (file.Exists(p .. "init.lua", "LUA")) then
			moat.include_(p .. "init.lua")
		end

		for _, pn in ipairs(ps) do
			if (not pn) then continue end
			moat.include_(p .. pn, pn)
		end
	end
end