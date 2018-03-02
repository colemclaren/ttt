-- Generated from: gooey/lua/gooey/ui/controls/menu/visibilitycontrol.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/visibilitycontrol.lua
-- Timestamp:      2016-04-28 19:58:53
local openMenus = {}

function CAC.CloseMenus ()
	for menu, _ in pairs (openMenus) do
		menu:Hide ()
		openMenus [menu] = nil
	end
end

function CAC.IsMenuOpen ()
	return next (openMenus) and true or false
end

function CAC.RegisterOpenMenu (menu)
	openMenus [menu] = true
	
	menu:AddEventListener ("VisibleChanged", "CAC.MenuVisibilityControl",
		function (_, visible)
			if not visible then
				menu:RemoveEventListener ("VisibleChanged", "CAC.MenuVisibilityControl")
				openMenus [menu] = nil
			end
		end
	)
end

hook.Add ("VGUIMousePressed", "CAC.Menus",
	function (panel, mouseCode)
		while panel ~= nil and panel:IsValid () do
			if panel.ClassName == "DMenu" then
				return
			end
			panel = panel:GetParent ()
		end
		
		CAC.CloseMenus ()
	end
)

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.CloseMenus ()
	end
)