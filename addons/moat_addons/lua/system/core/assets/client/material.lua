local Mats = {}
local _Material = Material
function Material(n, p)
	p = p or ""

	if (not Mats[n .. p]) then
		Mats[n .. p] = _Material(n, Either(type(p) == "string", p, false))
	end

	return Mats[n .. p]
end