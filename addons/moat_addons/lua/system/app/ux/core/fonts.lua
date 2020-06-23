local scf, f = _SCF or surface.CreateFont, {}
f.default = "Tahoma"
if (system.IsOSX()) then
	f.default = system.IsLinux() and "DejaVu Sans" or "Helvetica"
end

f.custom = system.IsWindows()
f.base = {
	[0] = {font = f.custom and "Lato Light" or f.default, weight = 300, antialias = true},
	[1] = {font = f.custom and "Lato" or f.default, weight = 400, antialias = true},
	[2] = {font = f.custom and "Lato" or f.default, weight = 700, antialias = true},
	[3] = {font = f.custom and "Lato Black" or f.default, weight = 900, antialias = true},
	italic = {
		[0] = {font = f.custom and "Lato Italic" or f.default, weight = 300, italic = not f.custom, antialias = true},
		[1] = {font = f.custom and "Lato Italic" or f.default, weight = 400, italic = not f.custom, antialias = true},
		[2] = {font = f.custom and "Lato Italic" or f.default, weight = 700, italic = not f.custom, antialias = true},
		[3] = {font = f.custom and "Lato Italic" or f.default, weight = 900, italic = not f.custom, antialias = true}
	}
}

function f.size(kind, new_size, italic)
	local font = f.base[kind]
	if (italic) then
		font = f.base.italic[kind]
	end

	font.size = new_size or 14
	return font
end

function f.load(suffix, _uxbf)
	suffix = suffix and suffix .. "." or ""
	uxbf = _uxbf or f.base

	for i = 1, 128 do
		-- scf("ux1." .. suffix .. i, f.size(0, i))
		scf("ux." .. suffix .. i, f.size(1, i))
		-- scf("ux2." .. suffix .. i, f.size(2, i))
		-- scf("ux3." .. suffix .. i, f.size(3, i))
	end
end

ux.font = f
ux.font.load()
hook("InitPostEntity", ux.font.load)