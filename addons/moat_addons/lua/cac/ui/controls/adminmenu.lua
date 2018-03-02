local self = {}

function self:Init ()
	xpcall (
		function ()
			self:SetSize (1000, 604)
			
			-- Animation
			self.XInterpolator = CAC.SigmoidStepResponseInterpolator ()
			
			self.AnimationState = nil
			self.InAnimation = nil
			
			-- Initialize position
			self.XInterpolator:Initialize (self:CalculateInvisibleX ())
			
			self:SetX (self.XInterpolator:GetTargetValue ())
			self:SetY (0.5 * (ScrH () - self:GetTall ()))
			
			self:Hide ()
			self:SetAnimationState ("Hidden")
			
			self:AddEventListener ("AnimationCompleted", "Hide",
				function (_)
					if self.AnimationState == "Showing" then
						self:SetAnimationState ("Shown")
					elseif self.AnimationState == "Hiding" then
						self:SetAnimationState ("Hidden")
						self:SetVisible (false)
					end
				end
			)
			
			self:AddEventListener ("VisibleChanged", "FilterRunner",
				function (_, visible)
					if visible then
						self.XInterpolator:Skip ()
					end
				end
			)
			
			-- Input
			self:MakePopup ()
			self:SetMouseInputEnabled (true)
			self:SetKeyboardInputEnabled (false)
			self.HoldOpen = false
			
			-- Keyboard
			self.EscapeKeyDown = false
			self:SetKeyboardMap (CAC.AdminMenuKeyboardMap)
			
			-- Controls
			self.NavigationMenu = self:Create ("CACNavigationMenu")
			self.NavigationMenu:AddItem ("Players")
			self.NavigationMenu:AddItem ("Incidents")
			self.NavigationMenu:AddItem ("Server")
			self.NavigationMenu:AddItem ("Settings")
			self.NavigationMenu:AddItem ("About")
			
			self.NavigationMenu:AddEventListener ("SelectedItemChanged",
				function (_, lastSelectedItem, selectedItem)
					local lastIndex = lastSelectedItem:GetIndex ()
					local index     = selectedItem:GetIndex ()
					
					self.ContentPanel:SetActiveView (selectedItem:GetId (), index > lastIndex and "Up" or "Down")
				end
			)
			
			self.ContentPanel = self:Create ("CACViewContainer")
			self.ContentPanel:AddView (self:Create ("CACPlayerView"   ), "Players"  )
			self.ContentPanel:AddView (self:Create ("CACIncidentsView"), "Incidents")
			self.ContentPanel:AddView (self:Create ("CACServerView"   ), "Server"   )
			self.ContentPanel:AddView (self:Create ("CACSettingsView" ), "Settings" )
			self.ContentPanel:AddView (self:Create ("CACAboutView"    ), "About"    )
			
			-- TextEntry keyboard focusing
			local focusedTextEntry = nil
			local keyboardInputEnabled = false
			self:AddEventListener ("TextEntryMouseDown",
				function (_, textEntry)
					focusedTextEntry = textEntry
					
					self:SetKeyboardInputEnabled (true)
					self:SetHoldOpen (true)
					
					textEntry:AddEventListener ("LostFocus", "CAC.AdminMenu." .. self:GetHashCode (),
						function (_)
							textEntry:RemoveEventListener ("LostFocus", "CAC.AdminMenu." .. self:GetHashCode ())
							
							if focusedTextEntry == textEntry then
								self:SetKeyboardInputEnabled (false)
								self:SetHoldOpen (false)
							end
						end
					)
				end
			)
		end,
		CAC.Error
	)
end

-- Appearance
function self:Paint (w, h)
	surface.SetDrawColor (CAC.Colors.WhiteSmoke)
	surface.DrawRect (0, 0, w, h)
	
	if not self.NavigationMenu            then return end
	if not self.NavigationMenu:IsValid () then return end
	
	surface.SetDrawColor (CAC.Colors.CornflowerBlue)
	surface.DrawRect (8 + self.NavigationMenu:GetWidth (), 8, w - 16 - self.NavigationMenu:GetWidth (), h - 16)
	
	surface.SetDrawColor (CAC.Colors.WhiteSmoke)
	surface.DrawRect (12 + self.NavigationMenu:GetWidth (), 12, self:GetWidth () - 24 - self.NavigationMenu:GetWidth (), self:GetHeight () - 24)
end

function self:PerformLayout (w, h)
	self.NavigationMenu:SetPos (8, 8)
	self.NavigationMenu:SetSize (192, h - 16)
	
	self.ContentPanel:SetPos (12 + self.NavigationMenu:GetWidth (), 12)
	self.ContentPanel:SetSize (w - 24 - self.NavigationMenu:GetWidth (), h - 24)
end

-- Animation
function self:CalculateVisibleX ()
	return 0.5 * (ScrW () - self:GetWidth ())
end

function self:CalculateInvisibleX ()
	return -self:CalculateVisibleX () - self:GetWidth ()
end

function self:Think ()
	local x = self.XInterpolator:Run ()
	self:SetX (math.floor (x + 0.5))
	self:SetInAnimation (math.abs (self.XInterpolator:GetError ()) >= 0.5)
	
	-- Escape key
	if input.IsKeyDown (KEY_ESCAPE) ~= self.EscapeKeyDown then
		self.EscapeKeyDown = input.IsKeyDown (KEY_ESCAPE)
		if self.EscapeKeyDown then
			self:DispatchKeyboardAction (KEY_ESCAPE)
		end
	end
end

function self:Show ()
	self.XInterpolator:SetTargetValue (self:CalculateVisibleX ())
	self:SetVisible (true)
	self:SetAnimationState ("Showing")
	self:SetInAnimation (true)
end

function self:Hide ()
	self.XInterpolator:SetTargetValue (self:CalculateInvisibleX ())
	self:SetAnimationState ("Hiding")
	self:SetInAnimation (true)
end

function self:ShouldHoldOpen ()
	return self.HoldOpen
end

function self:SetHoldOpen (holdOpen)
	if self.HoldOpen == holdOpen then return self end
	
	self.HoldOpen = holdOpen
	
	return self
end

function self:GetAnimationState ()
	return self.AnimationState
end

function self:SetAnimationState (animationState)
	if self.AnimationState == animationState then return self end
	
	self.AnimationState = animationState
	
	return self
end

function self:IsInAnimation ()
	return self.InAnimation and self:IsVisible ()
end

function self:SetInAnimation (inAnimation)
	if self.InAnimation == inAnimation then return self end
	
	self.InAnimation = inAnimation
	
	if not self.InAnimation then
		self:DispatchEvent ("AnimationCompleted")
	end
	
	return self
end

CAC.Register ("CACAdminMenu", self, "EditablePanel")

concommand.Add ("+cac_menu",
	function ()
		if not CAC.AdminMenu or not CAC.AdminMenu:IsValid () then
			CAC.AdminMenu = vgui.Create ("CACAdminMenu")
			
			CAC:AddEventListener ("Unloaded", "CAC.AdminMenu",
				function ()
					if CAC.AdminMenu and CAC.AdminMenu:IsValid () then
						CAC.AdminMenu:Remove ()
						CAC.AdminMenu = nil
					end
					
					hook.Remove ("GUIMousePressed", "CAC.AdminMenu")
				end
			)
			
			hook.Add ("GUIMousePressed", "CAC.AdminMenu",
				function ()
					if not CAC.AdminMenu              then return end
					if not CAC.AdminMenu:IsValid ()   then return end
					
					if not CAC.AdminMenu:IsVisible () then return end
					if CAC.AdminMenu:ContainsFocus () then return end
					
					CAC.AdminMenu:Hide ()
				end
			)
		end
		
		if CAC.AdminMenu:GetAnimationState () == "Showing" then
			CAC.AdminMenu:Hide ()
		elseif CAC.AdminMenu:GetAnimationState () == "Hiding" or
		       CAC.AdminMenu:GetAnimationState () == "Hidden" then
			CAC.AdminMenu:Show ()
		end
	end
)

concommand.Add ("-cac_menu",
	function ()
		if not CAC.AdminMenu then return end
		if not CAC.AdminMenu:IsValid () then return end
		
		if CAC.AdminMenu:GetAnimationState () == "Shown" and
		   not CAC.AdminMenu:ShouldHoldOpen () then
			CAC.AdminMenu:Hide ()
		end
	end
)