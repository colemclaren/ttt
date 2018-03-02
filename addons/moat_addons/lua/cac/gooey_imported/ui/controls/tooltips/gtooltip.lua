-- Generated from: gooey/lua/gooey/ui/controls/tooltips/gtooltip.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/tooltips/gtooltip.lua
-- Timestamp:      2016-04-28 19:58:53
local PANEL = {}

function PANEL:Init ()
	self.Label = vgui.Create ("GLabel", self)
	self.Label:SetTextColor (CAC.Colors.Black)
	
	self.Locked = false
	
	self:SetBackgroundColor (CAC.Colors.Snow)
	
	self:AddEventListener ("TextChanged",
		function (_, text)
			self.Label:SetText (text)
			self:PerformLayout ()
		end
	)
	
	self:AddEventListener ("VisibleChanged",
		function (_, visible)
			if visible then
				self:Show ()
			else
				CAC.RemoveRenderHook (CAC.RenderType.ToolTip, "CAC.ToolTip." .. self:GetHashCode ())
			end
		end
	)
	
	CAC:AddEventListener ("Unloaded", "CAC.ToolTip." .. self:GetHashCode (),
		function ()
			self:Remove ()
		end
	)
	
	self:SetText ("ToolTip")
end

function PANEL:Free ()
	self.Locked = false
end

function PANEL:GetText ()
	return self.Label:GetText ()
end

function PANEL:IsFree ()
	return not self.Locked
end

function PANEL:IsLocked ()
	return self.Locked
end

function PANEL:Lock ()
	self.Locked = true
end

function PANEL:Paint (w, h)
end

function PANEL:PerformLayout ()
	self.Label:SetPos (6, 2)
	self.Label:SizeToContents ()
	
	local w, h = self.Label:GetSize ()
	self:SetSize (w + 12, h + 4)
end

local borderColor = Color (32, 32, 32, 255)
function PANEL:Show ()
	self:SetVisible (true)
	self:MakePopup ()
	self:MoveToFront ()
	self:SetKeyboardInputEnabled (false)
	self:SetMouseInputEnabled (false)
	
	CAC.AddRenderHook (CAC.RenderType.ToolTip, "CAC.ToolTip." .. self:GetHashCode (),
		function ()
			if not self:IsValid ()   then return end
			if not self:IsVisible () then return end
			local x, y = self:GetPos ()
			local w, h = self:GetSize ()
			draw.RoundedBox (4, x,     y,     w,     h,     borderColor)
			draw.RoundedBox (4, x + 1, y + 1, w - 2, h - 2, self:GetBackgroundColor ())
			self:PaintAt (x, y)
		end
	)
end

-- Event handlers
function PANEL:OnRemoved ()
	CAC.RemoveRenderHook (CAC.RenderType.ToolTip, "CAC.ToolTip." .. self:GetHashCode ())
	CAC:RemoveEventListener ("Unloaded", "CAC.ToolTip." .. self:GetHashCode ())
end

CAC.Register ("GToolTip", PANEL, "GPanel")