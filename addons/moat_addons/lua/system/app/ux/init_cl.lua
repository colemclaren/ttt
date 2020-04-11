ux = ux or {
	defaults = {},
	cache = {}
}

function ux.Create(...)
	if (not ux.loaded and ux.queue) then
		ux.queue.Add(...)
		return
	end

	local p = {n = select("#", ...), ...}
	if (p.n <= 0 or not p[1]) then return end
	local pc, pl = p[1], p[1]:lower()

	for i = 1, p.n do
		if (IsValid(p[i])) then p.ch = p[i] continue end
		if (isfunction(p[i])) then p.cb = p[i] continue end
		if (istable(p[i])) then p.h = p[i] continue end
	end

	p.gui = vgui.Create(pc, p.ch)
	if (not IsValid(p.gui)) then return end

	ux.defaults["all"](p.gui)

	if (ux.defaults[pl]) then
		ux.defaults[pl](p.gui)
	end

	if (p.h) then for k, v in pairs(p.h) do p.gui[k] = v end end
	if (p.cb) then p.cb(p.gui, p.ch) end

	return p.gui
end

hook("InitPostEntity", function()
	ux.loaded = true
	ux.queue.Run()

	hook.Run "ux.load"
end)