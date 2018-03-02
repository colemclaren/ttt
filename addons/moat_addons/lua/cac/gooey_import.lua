-- This file is computer-generated.
CAC.BasePanel  = CAC.BasePanel  or {}
CAC.Containers = CAC.Containers or {}
CAC.ListBox    = CAC.ListBox    or {}
CAC.UTF8       = CAC.UTF8       or {}


if CLIENT then
	-- Timestamp: 2016-04-28 19:58:53
	function CAC.DeprecatedFunction ()
		CAC.Error ("CAC: Derma function should not be called.")
	end

	-- Timestamp: 2016-04-28 19:58:53
	function CAC.DeprecatedFunctionFactory (alternativeFunctionName)
		return function ()
			CAC.Error ("CAC: Derma function should not be called. Use " .. alternativeFunctionName .. " instead.")
		end
	end

	-- Timestamp: 2016-04-28 19:58:53
		function CAC.Register (className, classTable, baseClassName)
			local init = classTable.Init
			
			local basePanelInjected = false
			
			-- Check if GBasePanel methods have already been added to a base class
			local baseClass = vgui.GetControlTable (baseClassName)
			while baseClass do
				if baseClass._ctor then
					basePanelInjected = true
					break
				end
				baseClass = vgui.GetControlTable (baseClass.Base)
			end
			
			if not basePanelInjected then
				-- Merge in GBasePanel methods
				for k, v in pairs (CAC.BasePanel) do
					if not rawget (classTable, k) then
						classTable [k] = v
					end
				end
				
				classTable.Init = function (...)
					-- BasePanel._ctor will check for and avoid multiple initialization
					CAC.BasePanel._ctor (...)
					if init then
						init (...)
					end
				end
			end
			
			vgui.Register (className, classTable, baseClassName)
		end

end


if CLIENT then
	include ("gooey_imported/interpolators/timeinterpolator.lua")
	include ("gooey_imported/interpolators/normalizedtimeinterpolator.lua")
	include ("gooey_imported/interpolators/scaledtimeinterpolator.lua")
	include ("gooey_imported/interpolators/accelerationdecelerationinterpolator.lua")
	include ("gooey_imported/interpolators/liveadditiveinterpolator.lua")
	include ("gooey_imported/interpolators/livesmoothinginterpolator.lua")
	include ("gooey_imported/clipboard.lua")
	include ("gooey_imported/ui/fonts.lua")
	include ("gooey_imported/ui/buttoncontroller.lua")
	include ("gooey_imported/ui/dragcontroller.lua")
	include ("gooey_imported/ui/scrollableviewcontroller.lua")
	include ("gooey_imported/ui/selectioncontroller.lua")
	include ("gooey_imported/ui/imagecacheentry.lua")
	include ("gooey_imported/ui/imagecache.lua")
	include ("gooey_imported/ui/sortorder.lua")
	include ("gooey_imported/ui/keyboard/keyboardmap.lua")
	include ("gooey_imported/ui/mouse/mouseevents.lua")
	include ("gooey_imported/ui/layout/orientation.lua")
	include ("gooey_imported/ui/layout/horizontalalignment.lua")
	include ("gooey_imported/ui/layout/verticalalignment.lua")
	include ("gooey_imported/ui/layout/sizingmethod.lua")
	include ("gooey_imported/ui/render.lua")
	include ("gooey_imported/ui/rendertype.lua")
	include ("gooey_imported/ui/history/historyitem.lua")
	include ("gooey_imported/ui/history/ihistorystack.lua")
	include ("gooey_imported/ui/history/historystack.lua")
	include ("gooey_imported/ui/history/historycontroller.lua")
	include ("gooey_imported/ui/controls/gbasepanel.lua")
	include ("gooey_imported/ui/controls/gpanel.lua")
	include ("gooey_imported/ui/controls/glabel.lua")
	include ("gooey_imported/ui/controls/gurllabel.lua")
	include ("gooey_imported/ui/controls/gbutton.lua")
	include ("gooey_imported/ui/controls/gcheckbox.lua")
	include ("gooey_imported/ui/controls/gimage.lua")
	include ("gooey_imported/ui/controls/gtextentry.lua")
	include ("gooey_imported/ui/controls/gcontainer.lua")
	include ("gooey_imported/ui/controls/gbasescrollbar.lua")
	include ("gooey_imported/ui/controls/ghscrollbar.lua")
	include ("gooey_imported/ui/controls/gvscrollbar.lua")
	include ("gooey_imported/ui/controls/gscrollbarbutton.lua")
	include ("gooey_imported/ui/controls/gscrollbarcorner.lua")
	include ("gooey_imported/ui/controls/gscrollbargrip.lua")
	include ("gooey_imported/ui/controls/gcombobox.lua")
	include ("gooey_imported/ui/controls/gcomboboxitem.lua")
	include ("gooey_imported/ui/controls/gverticallayout.lua")
	include ("gooey_imported/ui/controls/listbox/glistbox.lua")
	include ("gooey_imported/ui/controls/listbox/glistboxitem.lua")
	include ("gooey_imported/ui/controls/listbox/listboxitem.lua")
	include ("gooey_imported/ui/controls/listbox/itemcollection.lua")
	include ("gooey_imported/ui/controls/listbox/keyboardmap.lua")
	include ("gooey_imported/ui/controls/menu/basemenuitem.lua")
	include ("gooey_imported/ui/controls/menu/gmenu.lua")
	include ("gooey_imported/ui/controls/menu/gmenuitem.lua")
	include ("gooey_imported/ui/controls/menu/gmenuseparator.lua")
	include ("gooey_imported/ui/controls/menu/menu.lua")
	include ("gooey_imported/ui/controls/menu/menuitem.lua")
	include ("gooey_imported/ui/controls/menu/menuseparator.lua")
	include ("gooey_imported/ui/controls/menu/visibilitycontrol.lua")
	include ("gooey_imported/ui/controls/tooltips/gtooltip.lua")
	include ("gooey_imported/ui/controls/tooltips/tooltipcontroller.lua")
	include ("gooey_imported/ui/controls/tooltips/tooltipmanager.lua")
	include ("gooey_imported/ui/controls/tooltips/tooltippositioningmode.lua")
end

