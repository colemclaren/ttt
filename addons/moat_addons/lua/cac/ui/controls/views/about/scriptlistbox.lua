local self = {}

function self:Init ()
	self:SetItemSpacing (8)
	
	http.Fetch ("https://scriptfodder.net/users/view/76561197998805249",
		function (response, contentLength, headers, statusCode)
			if not self            then return end
			if not self:IsValid () then return end
			
			local scriptIds   = {}
			local scriptNames = {}
			for scriptId, scriptName in string.gmatch (response, "<a href=\"/scripts/view/([0-9]+)\">([^<]*)</a>") do
				scriptIds   [#scriptIds   + 1] = scriptId
				scriptNames [#scriptNames + 1] = scriptName
			end
			
			-- Add from newest scripts to oldest scripts
			for i = #scriptIds, 1, -1 do
				self:AddScript (scriptIds [i], scriptNames [i])
			end
		end,
		function ()
			if not self            then return end
			if not self:IsValid () then return end
		end
	)
end

-- Factories
self.ListBoxItemControlClassName = "CACScriptListBoxItem"

-- Layout
function self:GetContentBoundsWithScrollbars ()
	local scrollBarWidth  = 0
	local scrollBarHeight = 0
	if self.VScroll then
		scrollBarWidth  = self.VScroll:GetWidth  () + 8
	end
	if self.HScroll then
		scrollBarHeight = self.HScroll:GetHeight () + 8
	end
	return 0, 0, self:GetWidth () - scrollBarWidth, self:GetHeight () - scrollBarHeight
end

-- Internal, do not call
function self:AddScript (scriptId, scriptName)
	local listBoxItem = self:GetItemById (scriptId) or self:AddItem (scriptId, scriptName)
	listBoxItem:GetControl ():SetScriptId (scriptId)
	listBoxItem:GetControl ():SetScriptName (scriptName)
end

function self:RemoveScript (scriptId, scriptName)
	if not self:GetItemById (scriptId) then return end
	
	local listBoxItem = self:GetItemById (scriptId)
	self:RemoveItem (listBoxItem)
end

CAC.Register ("CACScriptListBox", self, "CACListBox")