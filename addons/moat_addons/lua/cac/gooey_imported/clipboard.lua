-- Generated from: gooey/lua/gooey/clipboard.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/clipboard.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.Clipboard = CAC.MakeConstructor (self)

--[[
	Events:
		TextChanged (text)
			Fired when the clipboard text has changed.
]]

function self:ctor ()
	self.ClipboardText = ""
	
	self.ObtainedClipboardText = false
	self.IgnoreTextChange = true
	
	self.ClipboardControllers = CAC.WeakKeyTable ()
	
	self.CopyTextEntry  = nil
	self.PasteTextEntry = nil
	--[[
	timer.Create ("CAC.Clipboard", 0.5, 0,
		function ()
			self:UpdateClipboardText ()
		end
	)
	]]
	
	self:CreateTextEntry ()
	
	CAC.EventProvider (self)
	
	CAC:AddEventListener ("Unloaded", "CAC.Clipboard." .. self:GetHashCode (),
		function ()
			self:dtor ()
		end
	)
end

function self:dtor ()
	if self.CopyTextEntry and self.CopyTextEntry:IsValid () then
		self.CopyTextEntry:Remove ()
	end
	if self.PasteTextEntry and self.PasteTextEntry:IsValid () then
		self.PasteTextEntry:Remove ()
	end
	
	CAC:RemoveEventListener ("Unloaded", "CAC.Clipboard." .. self:GetHashCode ())
	
	timer.Destroy ("CAC.Clipboard")
	timer.Destroy ("CAC.Clipboard.CreateTextEntry")
end

function self:CreateTextEntry ()
	if DTextEntry then
		self.CopyTextEntry  = vgui.Create ("DTextEntry")
		self.PasteTextEntry = vgui.Create ("DTextEntry")
		self.PasteTextEntry:SetMultiline (true)
	else
		timer.Create ("CAC.Clipboard.CreateTextEntry", 0.5, 1,
			function ()
				self:CreateTextEntry ()
			end
		)
		return
	end
	
	self.CopyTextEntry:SetText ("")
	self.CopyTextEntry:SetVisible (false)
	
	self.PasteTextEntry:SetText ("")
	self.PasteTextEntry:SetVisible (false)
	self.PasteTextEntry.OnTextChanged = function ()
		if self.IgnoreTextChange then return false end
		
		local newClipboardText = self.PasteTextEntry:GetText ()
		if newClipboardText == self.ClipboardText then return end
		
		self.ClipboardText = newClipboardText
		self:DispatchTextChanged ()
		
		self.ObtainedClipboardText = true
	end
end

function self:GetText ()
	return self.ClipboardText
end

function self:IsClipboardControllerRegistered (clipboardController)
	return self.ClipboardControllers [clipboardController] or false
end

function self:IsEmpty ()
	return false
	-- return self.ClipboardText == ""
end

function self:RegisterClipboardController (clipboardController)
	self.ClipboardControllers [clipboardController] = true
end

-- TextEntry hack thanks to Python1320
function self:SetText (newClipboardText)
	if not CAC.UTF8.ContainsSequences (newClipboardText) then
		SetClipboardText (newClipboardText)
	else
		local _, newlineCount = string.gsub (newClipboardText, "\n", "")
		newClipboardText = newClipboardText .. string.rep (" ", newlineCount)
		
		self.CopyTextEntry:SetText (newClipboardText)
		self.CopyTextEntry:SelectAllText ()
		self.CopyTextEntry:CutSelected ()
	end
	
	if self.ClipboardText == newClipboardText then return end
	
	self.ClipboardText = newClipboardText
	self:DispatchTextChanged ()
	
	self.ObtainedClipboardText = true
end

function self:UnregisterClipboardController (clipboardController)
	self.ClipboardControllers [clipboardController] = nil
end

function self:UpdateClipboardText (callback)
	if not self.PasteTextEntry or not self.PasteTextEntry:IsValid () then return end
	
	self.ObtainedClipboardText = false
	
	self.IgnoreTextChange = true
	self.PasteTextEntry:SetText ("")
	self.IgnoreTextChange = false
	self.PasteTextEntry:PostMessage ("DoPaste", "", "")
	
	if callback then
		self:AddEventListener ("TextChanged", callback,
			function ()
				self:RemoveEventListener ("TextChanged", callback)
				callback (self:GetText ())
			end
		)
	end
	
	timer.Simple (0.2,
		function ()
			if not self.PasteTextEntry or not self.PasteTextEntry:IsValid () then return end
			
			if not self.ObtainedClipboardText then
				self.PasteTextEntry:OnTextChanged ()
				
				if callback then
					callback (self:GetText ())
					self:RemoveEventListener ("TextChanged", callback)
				end
			end
		end
	)
end

-- Internal, do not call
function self:DispatchTextChanged (text)
	text = text or self.ClipboardText
	
	for clipboardController, _ in pairs (self.ClipboardControllers) do
		clipboardController:DispatchEvent ("ClipboardTextChanged", self.ClipboardText)
	end
	self:DispatchEvent ("TextChanged", self.ClipboardText)
end

CAC.Clipboard = CAC.Clipboard ()