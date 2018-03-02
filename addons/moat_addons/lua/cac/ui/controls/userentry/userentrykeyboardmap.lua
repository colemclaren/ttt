CAC.UserEntryKeyboardMap = CAC.KeyboardMap ()

CAC.UserEntryKeyboardMap:Register (KEY_UP,
	function (self, key, ctrl, shift, alt)
		if not self:GetSuggestionFrame ()              then return end
		if not self:GetSuggestionFrame ():IsVisible () then return end
		
		self:GetSuggestionFrame ():SelectPrevious ()
		return true
	end
)

CAC.UserEntryKeyboardMap:Register (KEY_DOWN,
	function (self, key, ctrl, shift, alt)
		if not self:GetSuggestionFrame ()              then return end
		if not self:GetSuggestionFrame ():IsVisible () then return end
		
		self:GetSuggestionFrame ():SelectNext ()
		return true
	end
)

CAC.UserEntryKeyboardMap:Register ({ KEY_TAB, KEY_ENTER },
	function (self, key, ctrl, shift, alt)
		if not self:GetSuggestionFrame ()              then return end
		if not self:GetSuggestionFrame ():IsVisible () then return end
		
		self:CommitSuggestion (self:GetSuggestionFrame ():GetSelectedItem ())
		return true
	end
)

CAC.UserEntryKeyboardMap:Register (KEY_ESCAPE,
	function (self, key, ctrl, shift, alt)
		if not self:GetSuggestionFrame ()              then return end
		if not self:GetSuggestionFrame ():IsVisible () then return end
		
		self:GetSuggestionFrame ():SetVisible (false)
		return true
	end
)