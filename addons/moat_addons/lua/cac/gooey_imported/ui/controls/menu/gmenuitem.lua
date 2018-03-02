-- Generated from: gooey/lua/gooey/ui/controls/menu/gmenuitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/gmenuitem.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	self.Id = nil
	self.ContainingMenu = nil
	
	self.Item = nil
	
	self.Checked = false
	self.Icon = nil
	
	self:SetContentAlignment (4)
	self:SetTextInset (20, 0)
	
	self:AddEventListener ("Click",
		function (_)
			self:RunAction ()
		end
	)
end

-- Menu
function PANEL:GetContainingMenu ()
	return self.ContainingMenu
end

function PANEL:SetContainingMenu (menu)
	self.ContainingMenu = menu
end

-- Identity
function PANEL:GetId ()
	return self.Id
end

function PANEL:SetId (id)
	self.Id = id
	return self
end

-- MenuItem
function PANEL:GetItem ()
	return self.Item
end

function PANEL:SetItem (menuItem)
	self.Item = menuItem
end

function PANEL:IsItem ()
	return true
end

function PANEL:IsSeparator ()
	return false
end

-- Appearance
function PANEL:GetIcon ()
	return self.Icon and self.Icon.ImageName or nil
end

function PANEL:IsChecked ()
	return self.Checked
end

function PANEL:SetChecked (checked)
	if self.Checked == checked then return self end
	
	self.Checked = checked
	self:DispatchEvent ("CheckedChanged", self.Checked)
	
	return self
end

function PANEL:SetIcon (icon)
	if not icon then
		if self.Icon and self.Icon:IsValid () then
			self.Icon:Remove ()
		end
		self.Icon = nil
		return
	end
	if not self.Icon then
		self.Icon = vgui.Create ("GImage", self)
		self.Icon:SetSize (16, 16)
		self:InvalidateLayout ()
	end
	
	self.Icon:SetImage (icon)
	
	return self
end

-- Size
function PANEL:ContainsPoint (x, y)
	return x >= 0 and x < self:GetWide () and
	       y >= 0 and y < self:GetTall ()
end

function PANEL:GetMinimumContentWidth ()
	return self:GetContentSize () + 30
end

function PANEL:Paint (w, h)
	if self:IsChecked () then
		surface.SetDrawColor (CAC.Colors.LightBlue)
		surface.DrawRect (2, 2, w - 4, h - 4)
		surface.SetDrawColor (CAC.Colors.CornflowerBlue)
		surface.DrawOutlinedRect (2, 2, w - 4, h - 4)
	end
	
	local subMenu = self:GetItem ():GetSubMenu ()
	local activeMenu = self:GetContainingMenu ():GetActiveSubMenu ()
	if not self:IsHovered () and
	   self:GetContainingMenu ():GetHoveredItem () == nil and
	   activeMenu and activeMenu:GetMenu () == subMenu then
		self:GetSkin ().tex.MenuBG_Hover (0, 0, w, h)
	end
	derma.SkinHook ("Paint", "MenuOption", self, w, h)
	
	if self:GetItem ():GetSubMenu () then
		self:GetSkin ().tex.Menu.RightArrow (w - 15 - 4, 0.5 * (h - 15), 15, 15)
	end
	
	surface.SetFont (self:GetFont () or "DermaDefault")
	if self:IsEnabled () then
		surface.SetTextColor (CAC.Colors.Black)
		surface.SetTextPos (22, 4)
	else
		surface.SetTextColor (CAC.Colors.White)
		surface.SetTextPos (23, 5)
		surface.DrawText (self:GetText ())
		surface.SetTextColor (CAC.Colors.Gray)
		surface.SetTextPos (22, 4)
	end
	surface.DrawText (self:GetText ())
	return true
end

function PANEL:PerformLayout (w, h)
	self:SizeToContents ()
	self:SetWidth (self:GetWidth () + 30)
	
	local w = math.max (self:GetParent ():GetWide (), self:GetWidth ())
	
	surface.SetFont (self:GetFont () or "DermaDefault")
	local _, textHeight = surface.GetTextSize ("W")
	self:SetSize (w, textHeight + 9)
	
	if self.Icon then
		self.Icon:SetPos (3, 0.5 * (self:GetHeight () - 16))
	end
	
	if self.SubMenuArrow then
		self.SubMenuArrow:SetSize (15, 15)
		self.SubMenuArrow:CenterVertical ()
		self.SubMenuArrow:AlignRight (4)
	end

	DButton.PerformLayout (self)
end

-- Event handlers
function PANEL:DoClick ()
	self:DispatchEvent ("Click", self.ContainingMenu and self.ContainingMenu:GetTargetItem () or nil)
end

function PANEL:OnActionChanged (action)
	if not self:GetAction () then
		self:SetEnabled (self:GetItem ():IsEnabled ())
		return
	end
	
	local actionMap, control = self:GetActionMap ()
	if actionMap then
		local action = actionMap:GetAction (self:GetAction (), control)
		self:SetEnabled (self:GetItem ():IsEnabled () and action and action:CanRun (control) or false)
		if action then
			if action:GetIcon () then
				self.Item:SetIcon (action:GetIcon ())
			end
			if action:IsToggleAction () then
				self.Item:SetChecked (action:IsToggled ())
			end
		end
	end
end

function PANEL:OnCursorEntered ()
	self.Depressed = input.IsMouseDown (MOUSE_LEFT)
	self.Pressed   = input.IsMouseDown (MOUSE_LEFT)
	
	self:DispatchEvent ("MouseEnter")
	if self.OnMouseEnter then self:OnMouseEnter () end
	
	self:GetContainingMenu ():SetHoveredItem (self)
end

function PANEL:OnCursorExited ()
	self:DispatchEvent ("MouseLeave")
	if self.OnMouseLeave then self:OnMouseLeave () end
	
	if self:GetContainingMenu ():GetHoveredItem () == self then
		self:GetContainingMenu ():SetHoveredItem (nil)
	end
end

function PANEL:OnMousePressed (mouseCode)
	self:DispatchEvent ("MouseDown", mouseCode, self:CursorPos ())
	if self.OnMouseDown then self:OnMouseDown (mouseCode, self:CursorPos ()) end
	
	if not self:IsEnabled () then
		return false
	end
	
	self.m_MenuClicking = true
	
	DButton.OnMousePressed (self, mouseCode)
end

function PANEL:OnMouseReleased (mouseCode)
	self:DispatchEvent ("MouseUp", mouseCode, self:CursorPos ())
	if self.OnMouseUp then self:OnMouseUp (mouseCode, self:CursorPos ()) end
	
	if not self:IsEnabled () then
		return false
	end
	
	DButton.OnMouseReleased (self, mouseCode)

	if self.m_MenuClicking then
		self.m_MenuClicking = false
		if not self:GetItem ():HasSubMenu () or
		   self:HasAction () or
		   self:GetItem ():GetEventProvider ():HasEventListeners ("Click") then
			self.ContainingMenu:CloseMenus ()
		end
	end
end

CAC.Register ("GMenuItem", PANEL, "DMenuOption")