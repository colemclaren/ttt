-- Generated from: gooey/lua/gooey/ui/controls/listbox/keyboardmap.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/listbox/keyboardmap.lua
-- Timestamp:      2016-04-28 19:58:53
CAC.ListBox.KeyboardMap = CAC.KeyboardMap ()

CAC.ListBox.KeyboardMap:Register (KEY_PAGEUP,
	function (self, key, ctrl, shift, alt)
		self.VScroll:ScrollAnimated (-self.ScrollableViewController:GetViewHeight ())
		return true
	end
)

CAC.ListBox.KeyboardMap:Register (KEY_PAGEDOWN,
	function (self, key, ctrl, shift, alt)
		self.VScroll:ScrollAnimated (self.ScrollableViewController:GetViewHeight ())
		return true
	end
)

CAC.ListBox.KeyboardMap:Register (KEY_HOME,
	function (self, key, ctrl, shift, alt)
		self.VScroll:SetViewOffset (0, true)
		return true
	end
)

CAC.ListBox.KeyboardMap:Register (KEY_END,
	function (self, key, ctrl, shift, alt)
		self.VScroll:SetViewOffset (self.ScrollableViewController:GetContentHeight (), true)
		return true
	end
)

CAC.ListBox.KeyboardMap:Register (KEY_A,
	function (self, key, ctrl, shift, alt)
		if not ctrl then return end
		
		for listBoxItem in self:GetItemEnumerator () do
			self.SelectionController:AddToSelection (listBoxItem)
		end
		return true
	end
)