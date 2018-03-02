-- Generated from: gooey/lua/gooey/ui/controls/gtextentry.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gtextentry.lua
-- Timestamp:      2016-04-28 19:58:52
local _R = debug.getregistry ()

local self = {}

--[[
	Events:
		BorderColorChanged (borderColor)
			Fired when this panel's border color has changed.
		HelpTextChanged (helpText)
			Fired when this text entry's help text has changed.
		HelpTextColorChanged (helpTextColor)
			Fired when this text entry's help text color has changed.
		HelpTextFontChanged (helpTextFont)
			Fired when this text entry's help text font has changed.
]]

function self:Init ()
	self:SetAllowNonAsciiCharacters (true)
	
	self.BorderColor = nil
	
	self.HelpText     = nil
	self.HelpTextFont = "DermaDefaultItalic"
	
	self:AddEventListener ("MouseDown", "CAC.TextEntry." .. self:GetHashCode (),
		function (_)
			local parent = self:GetParent ()
			while parent and parent:IsValid () do
				if isfunction (parent.OnTextEntryMouseDown) then
					parent:OnTextEntryMouseDown (self)
				end
				if isfunction (parent.DispatchEvent) then
					parent:DispatchEvent ("TextEntryMouseDown", self)
				end
				parent = parent:GetParent ()
			end
		end
	)
end

-- Colors
function self:GetBorderColor ()
	return self.BorderColor or CAC.Colors.Black
end

function self:GetDefaultBackgroundColor ()
	return CAC.Colors.White
end

function self:SetBorderColor (borderColor)
	self.BorderColor = borderColor
	self:DispatchEvent ("BorderColorChanged", self.BorderColor)
	return self
end

-- Help text
function self:GetHelpText ()
	return self.HelpText
end

function self:GetHelpTextColor ()
	return self.HelpTextColor
end

function self:GetHelpTextFont ()
	return self.HelpTextFont
end

function self:SetHelpText (helpText)
	if self.HelpText == helpText then return self end
	
	self.HelpText = helpText
	
	self:DispatchEvent ("HelpTextChanged", self.HelpText)
	
	return self
end

function self:SetHelpTextColor (helpTextColor)
	if self.HelpTextColor == helpTextColor then return self end
	
	self.HelpTextColor = helpTextColor
	
	self:DispatchEvent ("HelpTextColorChanged", self.HelpTextColor)
	
	return self
end

function self:SetHelpTextFont (helpTextFont)
	if self.HelpTextFont == helpTextFont then return self end
	
	self.HelpTextFont = helpTextFont
	
	self:DispatchEvent ("HelpTextFontChanged", self.HelpTextFont)
	
	return self
end

-- Text
function self:GetText ()
	return _R.Panel.GetText (self)
end

function self:SetText (text)
	if self:GetText () == text then return self end
	
	self.Text = text
	_R.Panel.SetText (self, text)
	
	self:DispatchEvent ("TextChanged", self.Text)
	
	return self
end

function self:Paint (w, h)
	if self.m_bBackground then
		if not self:IsEnabled () then
			self:GetSkin ().tex.TextBox_Disabled (0, 0, w, h, self:GetBackgroundColor ())
		elseif self:IsFocused () then
			self:GetSkin ().tex.TextBox_Focus (0, 0, w, h, self:GetBackgroundColor ())
		else
			self:GetSkin ().tex.TextBox (0, 0, w, h, self:GetBackgroundColor ())
		end
	end
	
	if self.BorderColor then
		surface.SetDrawColor (self.BorderColor)
		surface.DrawOutlinedRect (0, 0, w, h)
	end
	
	-- Help text
	if self:GetText () == "" then
		self:PaintHelpText (w, h)
	end
	
	-- Text
	self:DrawTextEntryText (self:GetTextColor (), self:GetHighlightColor (), self:GetCursorColor ())
end

function self:PaintHelpText (w, h)
	if not self:GetHelpText () then return end
	
	surface.SetFont (self:GetHelpTextFont ())
	local textWidth, textHeight = surface.GetTextSize (self:GetHelpText ())
	surface.SetTextPos (3, self:IsMultiline () and 1 or (0.5 * (h - textHeight) + 1))
	surface.SetTextColor (self:GetHelpTextColor () or CAC.Colors.Silver)
	surface.DrawText (self:GetHelpText ())
end

function self:Think ()
	-- Hacky fix for OnTextChanged not being called on undo
	if self.Text ~= self:GetText () then
		self:OnTextChanged ()
		
		-- Hacky fix for undo bug
		if self.Text == "" then
			self:SetText (" ")
			self:SetText ("")
		end
	end
end

-- Compatibility with Derma skin's PaintTextEntry
function self:HasFocus ()
	return self:IsFocused ()
end

-- Compatibility with spawn menu hooks
function self:HasParent (control)
	return _R.Panel.HasParent (self, control)
end

-- Event handlers
CAC.CreateMouseEvents (self)

function self:OnKeyCodePressed (keyCode)
	return self:DispatchKeyboardAction (keyCode) or DTextEntry.OnKeyCodeTyped (self, keyCode)
end
self.OnKeyCodeTyped = self.OnKeyCodePressed

function self:OnTextChanged ()
	self.Text = self:GetText ()
	self:DispatchEvent ("TextChanged", self:GetText ())
end

CAC.Register ("GTextEntry", self, "DTextEntry")
