local self = {}

function self:Init ()
	self.ContentPanel = self:Create ("CACViewContainer")
	self.ContentPanel:AddView (self:Create ("CACIncidentListView"), "IncidentList")
	
	self.DisclaimerContainer = self:Create ("CACPanel")
	self.DisclaimerContainer:SetHeight (32)
	self.DisclaimerContainer:SetBackgroundColor (CAC.Colors.Wheat)
	
	self.DisclaimerLabel = self:Create ("CACLabel", self.DisclaimerContainer)
	self.DisclaimerLabel:SetWrap (true)
	self.DisclaimerLabel:SetFont (CAC.Font ("Roboto", 14))
	self.DisclaimerLabel:SetTextColor (CAC.Colors.Firebrick)
	self.DisclaimerLabel:SetText ("Very few automatic classification systems are correct 100% of the time (think of YouTube's automatic subtitles), but they can get pretty close.\nIf you're uncertain about an incident, it's best to assume the anticheat made a mistake.")
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.ContentPanel:SetPos (0, 0)
	self.ContentPanel:SetSize (w, h - 4 - self.DisclaimerLabel:GetHeight ())
	
	self.DisclaimerContainer:SetPos (4, h - 4 - self.DisclaimerContainer:GetHeight ())
	self.DisclaimerContainer:SetWidth (w - 8)
	
	self.DisclaimerLabel:SetPos (4, 0)
	self.DisclaimerLabel:SetSize (self.DisclaimerContainer:GetWidth () - 8, self.DisclaimerContainer:GetHeight ())
end

CAC.Register ("CACIncidentsView", self, "CACPanel")