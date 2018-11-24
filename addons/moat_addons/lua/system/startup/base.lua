AddCSLuaFile()

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


if (CLIENT) then
	if (not _SCF) then _SCF = surface.CreateFont end
	THE_FONTS = {}
	function surface.CreateFont(name, tbl)
		/*
		table.insert(THE_FONTS, {Name = name, Tbl = tbl})
		_SCF(name, tbl)
		*/
	end

	concommand.Add("list_fonts", function()
		local fs = ""
		for i = 1, #THE_FONTS do
			local f = THE_FONTS[i]
			if (not f.Name or not f.Tbl) then continue end
			local s = "surface.CreateFont('" .. f.Name .. "', {"
			if (f.Tbl.font) then s = s .. "font = '" .. f.Tbl.font .. "'," end
			if (f.Tbl.extended) then s = s .. "extended = true," end
			if (f.Tbl.size) then s = s .. "size = " .. f.Tbl.size .. "," end
			if (f.Tbl.weight) then s = s .. "weight = " .. f.Tbl.weight .. "," end
			if (f.Tbl.blursize) then s = s .. "blursize = " .. f.Tbl.blursize .. "," end
			if (f.Tbl.scanlines) then s = s .. "scanlines = " .. f.Tbl.scanlines .. "," end
			if (f.Tbl.antialias != nil and f.Tbl.antialias == false) then s = s .. "antialias = false," end
			if (f.Tbl.underline) then s = s .. "underline = true," end
			if (f.Tbl.italic) then s = s .. "italic = true," end
			if (f.Tbl.strikeout) then s = s .. "strikeout = true," end
			if (f.Tbl.symbol) then s = s .. "symbol = true," end
			if (f.Tbl.rotary) then s = s .. "rotary = true," end
			if (f.Tbl.shadow) then s = s .. "shadow = true," end
			if (f.Tbl.additive) then s = s .. "additive = true," end
			if (f.Tbl.outline) then s = s .. "outline = true," end
			fs = fs .. string.TrimRight(s, ',') .. "})\n"
		end

		file.Write("fonts.txt", fs)
	end)
end