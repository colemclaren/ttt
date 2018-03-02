local self = {}

function self:Init ()
	self.SearchTextEntry = self:Create ("CACSearchTextEntry")
	self.PlayerListBox   = self:Create ("CACPlayerListBox")
	
	self.SearchTextEntry:AddEventListener ("TextChanged",
		function (_, text)
			self.PlayerListBox:SetSearchFilter (string.Trim (text))
		end
	)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	local y = 4
	self.SearchTextEntry:SetPos (4, y)
	self.SearchTextEntry:SetWidth (0.25 * w)
	y = y + self.SearchTextEntry:GetHeight ()
	y = y + 4
	
	self.PlayerListBox:SetPos (4, y)
	self.PlayerListBox:SetSize (w - 8, h - 4 - y)
end

CAC.Register ("CACPlayerView", self, "CACPanel")