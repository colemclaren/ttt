ux.grad = {
	u = Material "vgui/gradient-u",
	d = Material "vgui/gradient-d",
	l = Material "vgui/gradient-l",
	r = Material "vgui/gradient-r"
}

local icon16 = {}
ux.icon16 = setmetatable(icon16, {
	__call = function(s, k) return "icon16/" .. k .. ".png" end,
	__index = function(t, k)
		icon16[k] = Material("icon16/" .. k .. ".png")
		return icon16[k]
	end
})