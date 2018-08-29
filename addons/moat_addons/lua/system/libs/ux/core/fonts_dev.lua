local f = {}
f.default = system.IsLinux() and "DejaVu Sans" or "Arial"
f.custom = file.Exists("download/resource/fonts/lato-regular.ttf", "MOD")
f.base = {
	light = {font = f.custom and "Lato Light" or f.default, weight = 300, antialias = true},
	regular = {font = f.custom and "Lato" or f.default, weight = 400, antialias = true},
	bold = {font = f.custom and "Lato" or f.default, weight = 700, antialias = true},
	black = {font = f.custom and "Lato Black" or f.default, weight = 900, antialias = true},
	italic = {
		light = {font = f.custom and "Lato Italic" or f.default, weight = 300, italic = not f.custom, antialias = true},
		regular = {font = f.custom and "Lato Italic" or f.default, weight = 400, italic = not f.custom, antialias = true},
		bold = {font = f.custom and "Lato Italic" or f.default, weight = 700, italic = not f.custom, antialias = true},
		black = {font = f.custom and "Lato Italic" or f.default, weight = 900, italic = not f.custom, antialias = true}
	}
}

function f.load(_uxbf, suffix)
	uxbf = _uxbf or f.base
	suffix = suffix and suffix .. "." or ""

	for i = 1, 128 do
		uxbf.light.size, uxbf.regular.size, uxbf.bold.size, uxbf.black.size = i, i, i, i
		surface.CreateFont("ux.light." .. suffix .. i, uxbf.light)
		surface.CreateFont("ux." .. suffix .. i, uxbf.regular)
		surface.CreateFont("ux.bold." .. suffix .. i, uxbf.bold)
		surface.CreateFont("ux.black." .. suffix .. i, uxbf.black)
	end

	if (not _uxbf) then f.load(uxbf.italic, "italic") end
end

ux.font = f
ux.font.load()
hook("InitPostEntity", ux.font.load)