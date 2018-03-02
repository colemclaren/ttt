CAC.AdminMenuKeyboardMap = CAC.KeyboardMap ()

CAC.AdminMenuKeyboardMap:Register (KEY_ESCAPE,
	function (self, key, ctrl, shift, alt)
		if self:ContainsFocus () then
			self:SetKeyboardInputEnabled (false)
		else
			self:Hide ()
		end
	end
)