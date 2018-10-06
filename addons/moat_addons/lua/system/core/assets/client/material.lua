/*
if (not _Material) then
	_Material = Material
end

local mat_cache = {}
function Material(n, p)
	p = p or ""
	
	if (not mat_cache[n .. p]) then
		mat_cache[n .. p] = _Material(n, p)
	end

	return mat_cache[n .. p]
end
*/