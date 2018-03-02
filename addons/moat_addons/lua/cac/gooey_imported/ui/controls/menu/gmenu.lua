-- Generated from: gooey/lua/gooey/ui/controls/menu/gmenu.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/gmenu.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	self.ClassName = "DMenu"
	self:SetVisible (false)
	
	self.TargetItem = nil
	
	self.Menu = nil
	self.ItemControls = {}
	
	-- Anchoring
	self.AnchorOrientation = CAC.Orientation.Vertical
	self.AnchorX = 0
	self.AnchorY = 0
	self.AnchorW = 0
	self.AnchorH = 0
	
	self.AnchorVerticalAlignment = CAC.VerticalAlignment.Top
	self.AnchorHorizontalAlignment = CAC.HorizontalAlignment.Top
	
	-- Submenus
	self.HoverActionTime = 0
	self.HoveredItem = nil
	self.ActiveSubMenu = nil
	
	self:SetMouseInputEnabled (true)
	self:SetKeyboardInputEnabled (true)
	
	-- Remove ourselves from the derma menu list
	local _, menuList = debug.getupvalue (RegisterDermaMenuForClose, 1)
	menuList [#menuList] = nil
	
	self:SetDeleteSelf (false)
	
	CAC:AddEventListener ("Unloaded", "CAC.Menu." .. self:GetHashCode (),
		function ()
			self:Remove ()
		end
	)
	
	self:AddEventListener ("VisibleChanged",
		function (_, visible)
			if visible then
				CAC.RegisterOpenMenu (self)
				
				self:PerformLayout ()
				
				-- Set the enabled state and icons of all menu items associated with an action
				local actionMap, control = self:GetActionMap ()
				if actionMap then
					for menuItem in self:GetEnumerator () do
						if menuItem:IsItem () then
							if menuItem:GetAction () then
								local action = actionMap:GetAction (menuItem:GetAction (), control)
								menuItem:SetEnabled (menuItem:GetItem ():IsEnabled () and action and action:CanRun (control) or false)
								if action then
									if action:GetIcon ()then
										menuItem:SetIcon (action:GetIcon ())
									end
									if action:IsToggleAction () then
										menuItem:SetChecked (action:IsToggled ())
									end
								end
							else
								menuItem:SetEnabled (menuItem:GetItem ():IsEnabled ())
							end
						end
					end
				end
				
				DMenu.Open (self, self:GetPos ())
				
				-- This fixes menu items somehow losing mouse focus as 
				-- soon as a mouse press occurs when another panel has keyboard focus.
				self:SetKeyboardInputEnabled (true)
				self:Focus ()
			else
				DMenu.Hide (self)
				
				self:CloseSubMenu ()
				self:SetHoveredItem (nil)
				self:GetMenu ():DispatchEvent ("MenuClosed")
			end
		end
	)
end

function PANEL:CloseMenus ()
	CAC.CloseMenus ()
end

function PANEL:CloseSubMenu ()
	if not self.ActiveSubMenu then return end
	if not self.ActiveSubMenu:IsValid () then return end
	
	self.ActiveSubMenu:Hide ()
	self.ActiveSubMenu = nil
end

function PANEL:GetAnchorHorizontalAlignment ()
	return self.AnchorHorizontalAlignment
end

function PANEL:GetAnchorVerticalAlignment ()
	return self.AnchorVerticalAlignment
end

function PANEL:GetEnumerator ()
	local children = self:GetCanvas ():GetChildren ()
	local i = 0
	return function ()
		i = i + 1
		while children [i] and children [i]:IsMarkedForDeletion () do
			i = i + 1
		end
		return children [i]
	end
end

function PANEL:GetHoveredItem ()
	return self.HoveredItem
end

function PANEL:GetItemById (id)
	for control in self:GetEnumerator () do
		if control.Id == id then
			return control
		end
	end
	return nil
end

function PANEL:GetMenu ()
	return self.Menu
end

function PANEL:GetTargetItem ()
	return self.TargetItem
end

function PANEL:Hide ()
	self:SetVisible (false)
end

function PANEL:Open ()
	self:SetVisible (true)
end

function PANEL:OpenSubMenu (item, menu)
	if item and not item:IsEnabled () then return end
	
	local activeSubMenu = self:GetActiveSubMenu ()
	if activeSubMenu then
		if menu and activeSubMenu:GetMenu () == menu then return end
		
		self:CloseSubMenu ()
	end
	
	if not menu then return end

	local x, y = item:LocalToScreen (0, 0)
	local activeSubMenu = menu:Show (self, self:GetTargetItem (), x + 3, y, item:GetWide () - 6, item:GetTall (), CAC.Orientation.Horizontal)
	
	self:SetActiveSubMenu (activeSubMenu)
end

function PANEL:PerformLayout ()
	DMenu.PerformLayout (self)
	
	local w, h = self:GetMinimumWidth (), 0
	
	for control in self:GetEnumerator () do
		w = math.max (w, control:GetMinimumContentWidth ())
    end
	
	-- Enforce fixed width
	w = self.Menu:GetWidth () or w
	for control in self:GetEnumerator () do
		control:SetWide (w)
		control:SetPos (0, h)
		control:InvalidateLayout (true)
		
		if control:IsVisible () then
			h = h + control:GetTall ()
		end
	end
	
	self:SetWidth (w)
	self:SetHeight (h)
	self:Reanchor ()
	
	DScrollPanel.PerformLayout (self)
end

function PANEL:SetAnchorOrientation (anchorOrientation)
	if self.AnchorOrientation == anchorOrientation then return end
	
	self.AnchorOrientation = anchorOrientation
	
	if self:IsVisible () then
		self:Reanchor ()
	end
end

function PANEL:SetAnchorRectangle (x, y, w, h)
	self.AnchorX = x
	self.AnchorY = y
	self.AnchorW = w
	self.AnchorH = h
	
	if self:IsVisible () then
		self:Reanchor ()
	end
end

function PANEL:SetHoveredItem (hoveredItem)
	self.HoveredItem = hoveredItem
	if self.HoveredItem then
		self.HoverActionTime = CurTime () + 0.2
	else
		self.HoverActionTime = math.huge
	end
end

function PANEL:SetMenu (menu)
	if self.Menu == menu then return self end
	
	for control in self:GetEnumerator () do
		self:UnhookMenuItem (control.Item)
	end
	self:Clear ()
	self.ItemControls = {}
	
	self:UnhookMenu (self.Menu)
	
	self.Menu = menu
	
	if self.Menu then
		for menuItem in self.Menu:GetEnumerator () do
			self:AddMenuItem (menuItem)
		end
	end
	self:HookMenu (self.Menu)
	
	return self
end

function PANEL:SetTargetItem (targetItem)
	self.TargetItem = targetItem
end

-- Event handlers
function PANEL:OnRemoved ()
	if self:IsVisible () then self:Hide () end
	
	self:SetMenu (nil)
	
	CAC:RemoveEventListener ("Unloaded", "CAC.Menu." .. self:GetHashCode ())
end

function PANEL:Think ()
	if CurTime () > self.HoverActionTime then
		local subMenu = nil
		local hoveredItem = self:GetHoveredItem () and self:GetHoveredItem ():GetItem ()
		if hoveredItem and
		   hoveredItem:IsEnabled () and
		   hoveredItem:IsItem () then
			subMenu = hoveredItem:GetSubMenu ()
		end
		
		local currentSubMenu = self:GetActiveSubMenu () and self:GetActiveSubMenu ():GetMenu ()
		
		if subMenu ~= currentSubMenu then
			self:CloseSubMenu ()
			if subMenu then
				self:OpenSubMenu (self:GetHoveredItem (), subMenu)
			end
		end
		
		self.HoverActionTime = math.huge
	end
end

-- Internal, do not call
function PANEL:GetActiveSubMenu ()
	return self.ActiveSubMenu
end

function PANEL:Reanchor ()
	local x = self.AnchorX + (self.AnchorOrientation == CAC.Orientation.Horizontal and self.AnchorW or 0)
	local horizontalAlignment = CAC.HorizontalAlignment.Left
	if x + self:GetWide () > ScrW () then
		local leftClearance = self.AnchorX - self:GetWide ()
		local rightClearance = ScrW () - x - self:GetWide ()
		if leftClearance > rightClearance then
			x = self.AnchorX - self:GetWide () + (self.AnchorOrientation == CAC.Orientation.Vertical and self.AnchorW or 0)
			horizontalAlignment = CAC.HorizontalAlignment.Right
		end
	end
	
	local y = self.AnchorY + (self.AnchorOrientation == CAC.Orientation.Vertical and self.AnchorH or 0)
	local verticalAlignment = CAC.VerticalAlignment.Top
	if y + self:GetTall () > ScrH () then
		local topClearance = self.AnchorY - self:GetTall ()
		local bottomClearance = ScrH () - y - self:GetTall ()
		if topClearance > bottomClearance then
			y = self.AnchorY - self:GetTall () + (self.AnchorOrientation == CAC.Orientation.Horizontal and self.AnchorH or 0)
			verticalAlignment = CAC.VerticalAlignment.Bottom
		end
	end
	
	self:SetAnchorVerticalAlignment (verticalAlignment)
	self:SetAnchorHorizontalAlignment (horizontalAlignment)
	self:SetPos (x, y)
end

function PANEL:SetActiveSubMenu (subMenu)
	self.ActiveSubMenu = subMenu
end

function PANEL:SetAnchorHorizontalAlignment (anchorHorizontalAlignment)
	if self.AnchorHorizontalAlignment == anchorHorizontalAlignment then return end
	
	self.AnchorHorizontalAlignment = anchorHorizontalAlignment
end

function PANEL:SetAnchorVerticalAlignment (anchorVerticalAlignment)
	if self.AnchorVerticalAlignment == anchorVerticalAlignment then return end
	
	self.AnchorVerticalAlignment = anchorVerticalAlignment
end

function PANEL:AddMenuItem (menuItem)
	if not menuItem then return end
	
	local control = nil
	
	if menuItem:IsSeparator () then
		control = self:AddSeparator (menuItem)
	elseif menuItem:IsItem () then
		control = self:AddButton (menuItem)
	end
	
	if not control then return end
	
	CAC.BindProperty (control, menuItem, "Enabled",     "CAC.Menu." .. self:GetHashCode ())
	CAC.BindProperty (control, menuItem, "ToolTipText", "CAC.Menu." .. self:GetHashCode ())
	CAC.BindProperty (control, menuItem, "Visible",     "CAC.Menu." .. self:GetHashCode ())
	
	self.ItemControls [menuItem] = control
	
	control:AddEventListener ("Click", "CAC.Menu." .. self:GetHashCode (),
		function (_, targetItem)
			menuItem:DispatchEvent ("Click", targetItem)
		end
	)
	
	control:AddEventListener ("MouseEnter", "CAC.Menu." .. self:GetHashCode (),
		function (_, ...)
			menuItem:DispatchEvent ("MouseEnter", ...)
		end
	)
	
	control:AddEventListener ("MouseLeave", "CAC.Menu." .. self:GetHashCode (),
		function (_, ...)
			menuItem:DispatchEvent ("MouseLeave", ...)
		end
	)
end

function PANEL:AddButton (menuItem)
	local control = vgui.Create ("GMenuItem", self)
	control:SetId (menuItem:GetId ())
	control:SetContainingMenu (self)
	control:SetItem (menuItem)
	
	CAC.BindProperty (control, menuItem, "Action",  "CAC.Menu." .. self:GetHashCode ())
	CAC.BindProperty (control, menuItem, "Checked", "CAC.Menu." .. self:GetHashCode ())
	CAC.BindProperty (control, menuItem, "Icon",    "CAC.Menu." .. self:GetHashCode ())
	CAC.BindProperty (control, menuItem, "Text",    "CAC.Menu." .. self:GetHashCode ())
	
	self:AddPanel (control)
	
	return control
end

function PANEL:AddSeparator (menuItem)
    local control = vgui.Create ("GMenuSeparator", self)
	control:SetId (menuItem:GetId ())
	control:SetContainingMenu (self)
	control:SetItem (menuItem)
	
    control:SetTall (1)
	
    self:AddPanel (control)
	
	return control
end

PANEL.AddSpacer = PANEL.AddSeparator

function PANEL:RemoveMenuItem (menuItem)
	if not menuItem then return end
	
	self:UnhookMenuItem (menuItem)
	
	if self.ItemControls [menuItem] then
		self.ItemControls [menuItem]:Remove ()
		self.ItemControls [menuItem] = nil
	end
end

function PANEL:UnhookMenuItem (menuItem)
	local control = self.ItemControls [menuItem]
	
	control:RemoveEventListener ("Click",      "CAC.Menu." .. self:GetHashCode ())
	control:RemoveEventListener ("MouseEnter", "CAC.Menu." .. self:GetHashCode ())
	control:RemoveEventListener ("MouseLeave", "CAC.Menu." .. self:GetHashCode ())
	
	-- BaseMenuItems
	CAC.UnbindProperty (control, menuItem, "Enabled",     "CAC.Menu." .. self:GetHashCode ())
	CAC.UnbindProperty (control, menuItem, "ToolTipText", "CAC.Menu." .. self:GetHashCode ())
	CAC.UnbindProperty (control, menuItem, "Visible",     "CAC.Menu." .. self:GetHashCode ())
	
	-- MenuItems
	CAC.UnbindProperty (control, menuItem, "Action",      "CAC.Menu." .. self:GetHashCode ())
	CAC.UnbindProperty (control, menuItem, "Checked",     "CAC.Menu." .. self:GetHashCode ())
	CAC.UnbindProperty (control, menuItem, "Icon",        "CAC.Menu." .. self:GetHashCode ())
	CAC.UnbindProperty (control, menuItem, "Text",        "CAC.Menu." .. self:GetHashCode ())
end

function PANEL:HookMenu (menu)
	if not menu then return end
	
	menu:AddEventListener ("Cleared", "CAC.Menu." .. self:GetHashCode (),
		function (_)
			for control in self:GetEnumerator () do
				self:UnhookMenuItem (control.Item)
			end
			self:Clear ()
			self.ItemControls = {}
		end
	)
	
	menu:AddEventListener ("ItemAdded", "CAC.Menu." .. self:GetHashCode (),
		function (_, menuItem)
			self:AddMenuItem (menuItem)
		end
	)
	
	menu:AddEventListener ("ItemRemoved", "CAC.Menu." .. self:GetHashCode (),
		function (_, menuItem)
			self:RemoveMenuItem (menuItem)
		end
	)
	
	menu:AddEventListener ("WidthChanged", "CAC.Menu." .. self:GetHashCode (),
		function (_, width)
			self:PerformLayout ()
		end
	)
end

function PANEL:UnhookMenu (menu)
	if not menu then return end
	
	menu:RemoveEventListener ("Cleared",      "CAC.Menu." .. self:GetHashCode ())
	menu:RemoveEventListener ("ItemAdded",    "CAC.Menu." .. self:GetHashCode ())
	menu:RemoveEventListener ("ItemRemoved",  "CAC.Menu." .. self:GetHashCode ())
	menu:RemoveEventListener ("WidthChanged", "CAC.Menu." .. self:GetHashCode ())
end

CAC.Register ("GMenu", PANEL, "DMenu")