local self = {}

--[[
	Events:
		GetText ()
			Fired when the clipboard text needs to be generated.
]]

function self:Init ()
	self:SetIcon ("icon16/page_copy.png")
	
	self:AddEventListener ("Click",
		function (_)
			CAC.Clipboard:SetText (self:DispatchEvent ("GetText") or self:GetText ())
		end
	)
end

CAC.Register ("CACCopyButton", self, "CACImageButton")