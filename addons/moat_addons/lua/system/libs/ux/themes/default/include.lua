/*local includes = {}
local function skin()
	if (not old_vgui_create) then
		old_vgui_create = vgui.Create
	end

	function vgui.Create(c, p, n)
		if (moat_already_skin) then
			vgui.Create = old_vgui_create
			return old_vgui_create(c, p, n)
		end

		local dagui = old_vgui_create(c, p, n)
		dagui:SetSkin("moat")
		moat_already_skin = true

		return dagui
	end
end

local function controls()

end

function ux.Theme.Default()


end

function ux.ReplaceSkin()
	if (not old_vgui_create) then
		old_vgui_create = vgui.Create
	end

	function vgui.Create(c, p, n)
		if (moat_already_skin) then
			vgui.Create = old_vgui_create
			return old_vgui_create(c, p, n)
		end

		local dagui = old_vgui_create(c, p, n)
		dagui:SetSkin("moat")
		moat_already_skin = true

		return dagui
	end
end

hook.Add("InitPostEntity", function()
	local c = fetch_asset("https://moat.gg/assets/img/moat_derma.png")
	if (not c or c == e) then timer.Simple(1, pd) return end
	
	look_how_long_this_function_is("Default", c)
	look_how_long_this_function_is("moat", c)
end)*/

return function(fn, p, dir)
	if (dir) then return end

	--includes[p .. fn] = true
end