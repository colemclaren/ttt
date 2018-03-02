-- Generated from: gooey/lua/gooey/ui/controls/gcheckbox.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gcheckbox.lua
-- Timestamp:      2016-04-28 19:58:52
local PANEL = {}

--[[
	Events:
		CheckStateChanged (bool checked)
			Fired when this checkbox has been checked or unchecked.
]]

function PANEL:Init ()
	self.Checked = false
	
	self:SetContentAlignment (4)
	self:SetText ("")
	self:SetTextColor (self:GetSkin ().Colours.Label.Default)
end

function PANEL:IsChecked ()
	return self.Checked
end

function PANEL:Paint (w, h)
	local checkWidth  = 15
	local checkHeight = 15
	local x = 0
	local y = 0.5 * (h - checkHeight)
	
	if self:IsChecked () then
		if self:IsEnabled () then
			self:GetSkin ().tex.Checkbox_Checked (x, y, checkWidth, checkHeight)
		else
			self:GetSkin ().tex.CheckboxD_Checked (x, y, checkWidth, checkHeight)
		end
	else
		if self:IsEnabled () then
			self:GetSkin ().tex.Checkbox (x, y, checkWidth, checkHeight)
		else
			self:GetSkin ().tex.CheckboxD (x, y, checkWidth, checkHeight)
		end
	end
	return false
end

function PANEL:PerformLayout (w, h)
	self:SetTextInset (20, 0)
end

function PANEL:SetChecked (checked)
	if self.Checked == checked then return end
	self.Checked = checked
	self:DispatchEvent ("CheckStateChanged", checked)
end

PANEL.SetValue = PANEL.SetChecked

-- Event handlers
function PANEL:DoClick ()
	if not self:IsEnabled () then return end
	self:SetChecked (not self.Checked)
end

CAC.Register ("GCheckbox", PANEL, "GButton")