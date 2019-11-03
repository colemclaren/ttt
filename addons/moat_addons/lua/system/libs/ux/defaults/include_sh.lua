ux.defaults = ux.defaults or {}

return function(fn, p, dir)
	if (dir) then return end

	local dn = fn:gsub("%.lua$", ""):lower()
	ux.defaults[dn] = yugh.ish(p .. fn)
end