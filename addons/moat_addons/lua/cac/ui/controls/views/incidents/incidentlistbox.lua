local self = {}

function self:Init ()
	self:SetMenu (CAC.IncidentListBoxMenu (self))
	
	self:SetComparator (
		function (a, b)
			local incidentA = a:GetControl ():GetIncident ()
			local incidentB = b:GetControl ():GetIncident ()
			
			if incidentA == nil and incidentB ~= nil then return false end
			if incidentA ~= nil and incidentB == nil then return true  end
			
			if incidentA == nil and incidentB == nil then return false end
			
			if incidentA:GetTimestamp () > incidentB:GetTimestamp () then return true  end
			if incidentA:GetTimestamp () < incidentB:GetTimestamp () then return false end
			
			return incidentA:GetId () >= incidentB:GetId ()
		end
	)
end

-- Factories
self.ListBoxItemControlClassName = "CACIncidentListBoxItem"

function self:Paint (w, h)
	if not self.Items:IsEmpty () then return end
	
	surface.SetDrawColor (CAC.Colors.Gainsboro)
	surface.DrawRect (0, 0, w, h)
	
	surface.SetFont (CAC.Font ("Roboto", 20))
	local textWidth, textHeight = surface.GetTextSize ("No incidents to display.")
	surface.SetTextPos (0.5 * (w - textWidth), 4)
	surface.SetTextColor (CAC.Colors.Firebrick)
	surface.DrawText ("No incidents to display.")
end

function self:OnRemoved ()
end

-- Internal, do not call
function self:AddLiveIncident (liveIncident)
	local listBoxItem = self:GetItemById (liveIncident:GetId ()) or self:AddItem (liveIncident:GetId ())
	listBoxItem:GetControl ():SetLiveIncident (liveIncident)
	
	self:Sort ()
end

function self:AddIncident (incident)
	local listBoxItem = self:GetItemById (incident:GetId ()) or self:AddItem (incident:GetId ())
	listBoxItem:GetControl ():SetIncident (incident)
	
	self:Sort ()
end

function self:RemoveLiveIncident (liveIncident)
	self:RemoveIncident (liveIncident:GetIncident ())
end

function self:RemoveIncident (incident)
	if not self:GetItemById (incident:GetId ()) then return end
	
	local listBoxItem = self:GetItemById (incident:GetId ())
	self:RemoveItem (listBoxItem)
end

CAC.Register ("CACIncidentListBox", self, "CACListBox")