local self = {}

local smallTextColor = Color (  0,   0,   0, 192)
function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.LuaScanResultEntry = nil
	self.Header             = false
	self.Type               = nil
	self.CommentLabel       = self:Create ("CACLabel")
	self.CommentLabel:SetContentAlignment (7)
	self.CommentLabel:SetWrap (true)
	self.CommentLabel:SetFont (CAC.Font ("Roboto", 14))
		:SetTextColor (smallTextColor)
		:SetText ("")
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			self:UpdateHeight ()
		end
	)
end

function self:Paint (w, h)
	if self:IsHeader () then
		self:PaintHeader (w, h)
	else
		self:PaintLuaScanResultEntry (w, h)
	end
end

function self:PaintHeader (w, h)
	local text = ""
	if self:IsNetReceiver () then text = "Net Receivers"
	elseif self:IsConsoleCommand () then text = "Console Commands"
	elseif self:IsHook () then text = "Hook" end
	
	surface.SetFont (CAC.Font ("Roboto", 20))
	local textWidth, textHeight = surface.GetTextSize (text)
	local y = 0.5 * (h - textHeight)
	surface.SetTextPos (4, y)
	surface.SetTextColor (CAC.Colors.Black)
	surface.DrawText (text)
	
	surface.SetDrawColor (CAC.Colors.CornflowerBlue)
	surface.DrawLine (0, h - 1, w, h - 1)
end

local backgroundColor
local iconBackgroundColor = Color (255, 255, 255,  64)
function self:PaintLuaScanResultEntry (w, h)
	local luaScanResultEntry = self:GetLuaScanResultEntry ()
	
	if self:IsHoveredRecursive () then
		self.HoverInterpolationFilter:Impulse ()
	end
	
	-- Background
	if self:IsSelected () then
		local col = self:GetSkin ().combobox_selected
		surface.SetDrawColor (col)
		surface.DrawRect (0, 0, w, h)
	else
		local baseBackgroundColor    = CAC.Colors.Gainsboro
		local hoveredBackgroundColor = CAC.Colors.LightSteelBlue
		
		if luaScanResultEntry then
			if luaScanResultEntry:GetLuaSignature ():IsSafe () then
				baseBackgroundColor    = CAC.Colors.LightGreen
				hoveredBackgroundColor = CAC.Colors.Green
			elseif luaScanResultEntry:GetLuaSignature ():IsExploitable () then
				baseBackgroundColor    = CAC.Colors.Wheat
				hoveredBackgroundColor = CAC.Colors.Orange
			elseif luaScanResultEntry:GetLuaSignature ():IsBackdoor () then
				baseBackgroundColor    = CAC.Colors.DarkSalmon
				hoveredBackgroundColor = CAC.Colors.Tomato
			end
		end
		
		backgroundColor = CAC.Color.Lerp (1 - 0.5 * self.HoverInterpolationFilter:Evaluate (), hoveredBackgroundColor, baseBackgroundColor, backgroundColor)
		surface.SetDrawColor (backgroundColor)
		surface.DrawRect (0, 0, w, h)
	end
	
	if not luaScanResultEntry then return end
	
	local icon  = "icon16/help.png"
	local name     = "???"
	local location = luaScanResultEntry:GetLuaSnapshotEntry ():GetFormattedLocation ()
	
	if luaScanResultEntry:IsNetReceiver () then
		icon = "icon16/lorry.png"
		name = self.LuaScanResultEntry:GetName ()
	elseif luaScanResultEntry:IsConsoleCommand () then
		icon = "icon16/application_xp_terminal.png"
		name = self.LuaScanResultEntry:GetName ()
	elseif luaScanResultEntry:IsHook () then
		icon = "icon16/lightning.png"
		name = self.LuaScanResultEntry:GetEventName () .. " : " .. luaScanResultEntry:GetName ()
	end
	
	local x = 4
	local y = 4
	draw.RoundedBox (8, x, y, h - 8, h - 8, iconBackgroundColor)
	CAC.ImageCache:GetImage (icon):Draw (CAC.RenderContext, x + 0.5 * (h - 8 - 16), y + 0.5 * (h - 8 - 16))
	
	local font1 = CAC.Font ("Roboto", 18)
	local font2 = CAC.Font ("Roboto", 14)
	surface.SetFont (font1)
	local _, font1Height = surface.GetTextSize ("W")
	surface.SetFont (font2)
	local _, font2Height = surface.GetTextSize ("W")
	
	x = x + h - 8 + 4
	y = 6
	surface.SetFont (font1)
	surface.SetTextPos (x, y)
	surface.SetTextColor (CAC.Colors.Black)
	surface.DrawText (name)
	y = y + font1Height
	
	surface.SetFont (font2)
	surface.SetTextPos (x, y)
	surface.SetTextColor (smallTextColor)
	surface.DrawText (location)
	
	-- Status
	local statusText      = ""
	local statusTextColor = CAC.Colors.Black
	local statusIcon      = nil
	
	if luaScanResultEntry:GetLuaSignature ():IsUnknown () then
		statusText      = "Unknown"
		statusIcon      = "help"
	elseif luaScanResultEntry:GetLuaSignature ():IsSafe () then
		statusText      = "Safe"
		statusTextColor = CAC.Colors.Green
		statusIcon      = "accept"
	elseif luaScanResultEntry:GetLuaSignature ():IsExploitable () then
		statusText      = "Exploitable"
		statusTextColor = CAC.Colors.Firebrick
		statusIcon      = "error"
		
		if luaScanResultEntry:IsPatched () then
			statusText      = "Exploit patched"
			statusTextColor = CAC.Colors.Green
			statusIcon      = "accept"
		elseif luaScanResultEntry:IsPatchable () then
			statusText = "Exploitable - Unpatched"
		elseif not luaScanResultEntry:GetLuaSignature ():GetPatcherCode () then
			statusText = "Exploitable - No patch available"
		end
	elseif luaScanResultEntry:GetLuaSignature ():IsBackdoor () then
		statusText      = "Backdoor"
		statusTextColor = CAC.Colors.Red
		statusIcon      = "exclamation"
		
		if luaScanResultEntry:IsPatched () then
			statusText      = "Backdoor patched"
			statusTextColor = CAC.Colors.Green
			statusIcon      = "accept"
		elseif luaScanResultEntry:IsPatchable () then
			statusText = "Backdoor - Unpatched"
		elseif not luaScanResultEntry:GetLuaSignature ():GetPatcherCode () then
			statusText = "Backdoor - No patch available"
		end
	end
	
	x = 0.6 * w
	y = 15
	if statusIcon then
		CAC.ImageCache:GetImage ("icon16/" .. statusIcon .. ".png"):Draw (CAC.RenderContext, x, y - 0.5 * 16)
	end
	surface.SetFont (font1)
	surface.SetTextColor (statusTextColor)
	surface.SetTextPos (x + 20, y - 0.5 * font1Height)
	surface.DrawText (statusText)
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
	
	self.CommentLabel:SetPos (h, 0.5 * h + 2)
	self.CommentLabel:SetSize (w - self.CommentLabel:GetX () - 4, h - self.CommentLabel:GetY ())
end

function self:OnRemoved ()
	self:SetLuaScanResultEntry (nil)
end

-- Data
function self:GetLuaScanResultEntry ()
	return self.LuaScanResultEntry
end

function self:GetType ()
	return self.Type
end

function self:IsNetReceiver ()
	return self.Type == CAC.LuaEntryPointType.NetReceiver
end

function self:IsConsoleCommand ()
	return self.Type == CAC.LuaEntryPointType.ConsoleCommand
end

function self:IsHook ()
	return self.Type == CAC.LuaEntryPointType.Hook
end

function self:IsHeader ()
	return self.Header
end

function self:SetLuaScanResultEntry (luaScanResultEntry)
	if self.LuaScanResultEntry == luaScanResultEntry then return self end
	
	self:UnhookLuaScanResultEntry (self.LuaScanResultEntry)
	self.LuaScanResultEntry = luaScanResultEntry
	self:HookLuaScanResultEntry (self.LuaScanResultEntry)
	
	self:SetType (self.LuaScanResultEntry and self.LuaScanResultEntry:GetType () or CAC.LuaEntryPointType.NetReceiver)
	
	self:Update ()
	
	return self
end

function self:SetType (type)
	self.Type = type
	return self
end

function self:SetHeader (header)
	if self.Header == header then return self end
	
	self.Header = header
	self:UpdateHeight ()
	
	return self
end

-- Internal, do not call
function self:Update ()
	if not self.LuaScanResultEntry then return end
	
	self.CommentLabel:SetText (self.LuaScanResultEntry:GetLuaSignature ():GetComment () or "")
end

function self:UpdateHeight ()
	if self:IsHeader () then
		self:GetListBoxItem ():SetHeight (24)
	else
		self:GetListBoxItem ():SetHeight (72)
	end
end

function self:HookLuaScanResultEntry (luaScanResultEntry)
	if not luaScanResultEntry then return end
	
	luaScanResultEntry:AddEventListener ("PatchableChanged", "CAC.CACLuaScanResultListBoxItem." .. self:GetHashCode (),
		function (_, whitelistStatus)
			self:Update ()
		end
	)
	luaScanResultEntry:AddEventListener ("PatchedChanged", "CAC.CACLuaScanResultListBoxItem." .. self:GetHashCode (),
		function (_, whitelistStatus)
			self:Update ()
		end
	)
end

function self:UnhookLuaScanResultEntry (luaScanResultEntry)
	if not luaScanResultEntry then return end
	
	luaScanResultEntry:RemoveEventListener ("PatchableChanged", "CAC.CACLuaScanResultListBoxItem." .. self:GetHashCode ())
	luaScanResultEntry:RemoveEventListener ("PatchedChanged",   "CAC.CACLuaScanResultListBoxItem." .. self:GetHashCode ())
end

CAC.Register ("CACLuaScanResultListBoxItem", self, "GListBoxItem")