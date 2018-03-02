local self = {}

function self:Init ()
	self.IncidentManager    = CAC.Incidents
	
	self.PageController     = nil
	self.ItemsPerPage       = 8
	
	self.SearchTextEntry    = self:Create ("CACSearchTextEntry")
	
	self.IncidentListBox1   = self:Create ("CACIncidentListBox")
	self.IncidentListBox2   = self:Create ("CACIncidentListBox")
	
	self.ContentPanel = self:Create ("CACViewContainer")
	self.ContentPanel:AddView (self.IncidentListBox1, "IncidentListBox1")
	self.ContentPanel:AddView (self.IncidentListBox2, "IncidentListBox2")
	
	-- Front buffer
	self.IncidentListBox    = self.IncidentListBox1
	self.IncidentListBoxId  = "IncidentListBox1"
	
	-- Back buffer
	self.OtherIncidentListBox   = self.IncidentListBox2
	self.OtherIncidentListBoxId = "IncidentListBox2"
	
	self.FirstPageButton    = self:Create ("CACImageButton")
	self.PreviousPageButton = self:Create ("CACImageButton")
	self.NextPageButton     = self:Create ("CACImageButton")
	self.LastPageButton     = self:Create ("CACImageButton")
	
	self.FirstPageButton   :SetIcon ("icon16/resultset_first.png")
	self.PreviousPageButton:SetIcon ("icon16/resultset_previous.png")
	self.NextPageButton    :SetIcon ("icon16/resultset_next.png")
	self.LastPageButton    :SetIcon ("icon16/resultset_last.png")
	
	self.FirstPageButton   :AddEventListener ("Click",       function (_) if not self.FirstPageButton   :IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Right") then return end self:NavigateToFirstPage    () end)
	self.PreviousPageButton:AddEventListener ("Click",       function (_) if not self.PreviousPageButton:IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Right") then return end self:NavigateToPreviousPage () end)
	self.PreviousPageButton:AddEventListener ("DoubleClick", function (_) if not self.PreviousPageButton:IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Right") then return end self:NavigateToPreviousPage () end)
	self.NextPageButton    :AddEventListener ("Click",       function (_) if not self.NextPageButton    :IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Left" ) then return end self:NavigateToNextPage     () end)
	self.NextPageButton    :AddEventListener ("DoubleClick", function (_) if not self.NextPageButton    :IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Left" ) then return end self:NavigateToNextPage     () end)
	self.LastPageButton    :AddEventListener ("Click",       function (_) if not self.LastPageButton    :IsEnabled () or (self.ContentPanel:IsInAnimation () and self.ContentPanel:GetAnimationExitDirection () == "Left" ) then return end self:NavigateToLastPage     () end)
	
	self.SearchTextEntry:SetHelpText ("Name or Incident ID")
	self.SearchTextEntry:AddEventListener ("TextChanged",
		function (_, text)
			self.IncidentListBox1:SetSearchFilter (string.Trim (text))
			self.IncidentListBox2:SetSearchFilter (string.Trim (text))
			
			if CAC.Incident.IsQualifiedIncidentId (text) then
				local steamId, incidentId = CAC.Incident.SteamIdAndIncidentIdFromQualifiedIncidentId (text)
				self:SendIncidentRequest (steamId, incidentId, self.IncidentListBox)
			else
				-- Reset to first page
				self.PageController:NavigateToFirstPage ()
				self:SendIncidentRangeRequest (self.IncidentListBox)
			end
		end
	)
	
	self.IncidentManager:AddIncidentExistenceListener ("CAC.IncidentListBox." .. self:GetHashCode (),
		function (_, incident)
			if not self.PageController                then return end
			if not self.PageController:IsFirstPage () then return end
			
			if not self:PassesSearchFilter (incident) then return end
			
			self:AddIncident (incident, self.IncidentListBox)
			self:CullItems (self.IncidentListBox)
		end
	)
	
	self.IncidentManager:AddEventListener ("IncidentDestroyed", "CAC.IncidentListBox." .. self:GetHashCode (),
		function (_, incident)
			self:RemoveIncident (incident)
		end
	)
	
	self.IncidentManager:AddLiveIncidentExistenceListener ("CAC.IncidentListBox." .. self:GetHashCode (),
		function (_, liveIncident)
			if not self.PageController                then return end
			if not self.PageController:IsFirstPage () then return end
			
			if not self:PassesSearchFilter (liveIncident:GetIncident ()) then return end
			
			self:AddLiveIncident (liveIncident, self.IncidentListBox)
			self:CullItems (self.IncidentListBox)
		end
	)
	
	self.IncidentManager:AddEventListener ("LiveIncidentDestroyed", "CAC.IncidentListBox." .. self:GetHashCode (),
		function (_, liveIncident)
			self:RemoveLiveIncident (liveIncident)
		end
	)
	
	self.PageController = nil
end

function self:Paint (w, h)
	if not self.PageController then
		self.PageController = CAC.PageController (self.ItemsPerPage)
		self:UpdateNavigationButtons ()
		
		self:SendIncidentRangeRequest ()
	end
end

function self:PerformLayout (w, h)
	local y = 4
	
	-- Search box
	self.SearchTextEntry:SetPos (4, y)
	self.SearchTextEntry:SetWidth (0.25 * w)
	y = y + self.SearchTextEntry:GetHeight ()
	y = y + 4
	
	-- Pagination controls
	x = w * 0.5
	self.FirstPageButton   :SetPos (x - 2 - self.PreviousPageButton:GetWidth () - 4 - self.FirstPageButton:GetWidth (), h - 4 - self.FirstPageButton   :GetHeight ())
	self.PreviousPageButton:SetPos (x - 2 - self.PreviousPageButton:GetWidth (),                                        h - 4 - self.PreviousPageButton:GetHeight ())
	self.NextPageButton    :SetPos (x + 2,                                                                              h - 4 - self.NextPageButton    :GetHeight ())
	self.LastPageButton    :SetPos (x + 2 + self.NextPageButton    :GetWidth () + 4,                                    h - 4 - self.LastPageButton    :GetHeight ())
	
	-- Content
	self.ContentPanel:SetPos (4, y)
	self.ContentPanel:SetSize (w - 8, h - 4 - y - self.FirstPageButton:GetHeight () - 4)
end

function self:OnRemoved ()
	self.IncidentManager:RemoveIncidentExistenceListener ("CAC.IncidentListView." .. self:GetHashCode ())
	self.IncidentManager:RemoveEventListener ("IncidentDestroyed", "CAC.IncidentListView." .. self:GetHashCode ())
	
	self.IncidentManager:RemoveLiveIncidentExistenceListener ("CAC.IncidentListView." .. self:GetHashCode ())
	self.IncidentManager:RemoveEventListener ("LiveIncidentDestroyed", "CAC.IncidentListView." .. self:GetHashCode ())
end

-- Internal, do not call
function self:AddLiveIncident (liveIncident, incidentListBox)
	incidentListBox = incidentListBox or self.IncidentListBox
	incidentListBox:AddLiveIncident (liveIncident)
end

function self:AddIncident (incident, incidentListBox)
	incidentListBox = incidentListBox or self.IncidentListBox
	incidentListBox:AddIncident (incident)
end

function self:RemoveLiveIncident (liveIncident)
	self.IncidentListBox:RemoveLiveIncident (liveIncident)
end

function self:RemoveIncident (incident)
	self.IncidentListBox:RemoveIncident (incident)
end

function self:CullItems (incidentListBox)
	incidentListBox = incidentListBox or self.IncidentListBox
	
	local visibleItemCount = 0
	
	local toRemove = {}
	for listBoxItem in incidentListBox:GetItems ():GetEnumerator () do
		if listBoxItem:IsVisible () and
		   listBoxItem:GetControl ():PassesSearchFilter (self.SearchTextEntry:GetText ()) then
			if visibleItemCount >= self.ItemsPerPage then
				toRemove [listBoxItem] = true
			end
			visibleItemCount = visibleItemCount + 1
		end
	end
	
	for listBoxItem, _ in pairs (toRemove) do
		listBoxItem:Remove ()
	end
end

function self:SwapBuffers (exitDirection)
	self.IncidentListBox,   self.OtherIncidentListBox   = self.OtherIncidentListBox,   self.IncidentListBox
	self.IncidentListBoxId, self.OtherIncidentListBoxId = self.OtherIncidentListBoxId, self.IncidentListBoxId
	
	self.IncidentListBox:Clear ()
	for i = 1, self.ItemsPerPage do
		self.IncidentListBox:AddItem ()
	end
	
	self.ContentPanel:SetActiveView (self.IncidentListBoxId, exitDirection)
end

function self:NavigateToFirstPage ()
	if self.PageController:IsFirstPage () then return end
	
	self:SwapBuffers ("Right")
	
	self.PageController:NavigateToFirstPage ()
	self:SendIncidentRangeRequest (self.IncidentListBox)
	
	self.FirstPageButton   :SetEnabled (false)
	self.PreviousPageButton:SetEnabled (false)
end

function self:NavigateToLastPage ()
	if self.PageController:IsLastPage () then return end
	
	self:SwapBuffers ("Left")
	
	self.PageController:NavigateToLastPage ()
	self:SendIncidentRangeRequest (self.IncidentListBox)
	
	self.LastPageButton:SetEnabled (false)
	self.NextPageButton:SetEnabled (false)
end

function self:NavigateToPreviousPage ()
	if not self.PageController:HasPreviousPage () then return end
	
	self:SwapBuffers ("Right")
	
	self.PageController:NavigateToPreviousPage ()
	self:SendIncidentRangeRequest (self.IncidentListBox)
end

function self:NavigateToNextPage ()
	if not self.PageController:HasNextPage () then return end
	
	self:SwapBuffers ("Left")
	
	self.PageController:NavigateToNextPage ()
	self:SendIncidentRangeRequest (self.IncidentListBox)
end

function self:SendIncidentRangeRequest (incidentListBox)
	incidentListBox = incidentListBox or self.IncidentListBox
	
	local searchText = self.SearchTextEntry:GetText ()
	
	local steamId        = nil
	local nameSearchTerm = nil
	if string.match (searchText, "^STEAM_%d+:%d+:%d+$") then
		steamId = searchText
	else
		nameSearchTerm = searchText
	end
	
	CAC.NetworkingClient:GetIncidentManagerClient ():SendIncidentRangeRequest (steamId, nameSearchTerm, self.PageController:GetCurrentDataRange (),
		function (incidents, hasPrevious, hasNext)
			if #incidents == 0 then
				self:ReplaceIncidents (incidentListBox, {})
				
				self.PageController:NavigateToFirstPage ()
				return
			end
			
			local firstId = incidents [1]:GetId ()
			local lastId  = incidents [#incidents]:GetId ()
			self.PageController:SetCurrentDataRange (firstId, lastId, hasPrevious, hasNext)
			self:UpdateNavigationButtons ()
			
			self:ReplaceIncidents (incidentListBox, incidents)
		end
	)
end

function self:SendIncidentRequest (steamId, incidentId, incidentListBox)
	incidentListBox = incidentListBox or self.IncidentListBox
	
	CAC.NetworkingClient:GetIncidentManagerClient ():SendIncidentRequest (steamId, incidentId,
		function (incident)
			incidentListBox:Clear ()
			
			self.PageController:NavigateToFirstPage ()
			
			local firstId = incident and incident:GetId () or 0
			local lastId  = incident and incident:GetId () or 0
			self.PageController:SetCurrentDataRange (firstId, lastId, false, false)
			self:UpdateNavigationButtons ()
			
			self:ReplaceIncidents (incidentListBox, { incident })
		end
	)
end

function self:ReplaceIncidents (incidentListBox, incidents)
	local incidentSet = {}
	for i = 1, #incidents do
		incidentSet [incidents [i]:GetId ()] = incidents [i]
	end
	
	-- Existing incidents and deleted incidents
	local toRemove = {}
	for listBoxItem in incidentListBox:GetItems ():GetEnumerator () do
		local incidentId = listBoxItem:GetControl ():GetIncident () and listBoxItem:GetControl ():GetIncident ():GetId ()
		if incidentSet [incidentId] then
			incidentSet [incidentId] = nil
		else
			toRemove [listBoxItem] = true
		end
	end
	
	-- Deletions
	for listBoxItem, _ in pairs (toRemove) do
		listBoxItem:Remove ()
	end
	
	-- New incidents
	for _, incident in pairs (incidentSet) do
		self:AddIncident (incident, incidentListBox)
	end
end

function self:UpdateNavigationButtons ()
	self.FirstPageButton   :SetEnabled (not self.PageController:IsFirstPage ())
	self.PreviousPageButton:SetEnabled (self.PageController:HasPreviousPage ())
	self.NextPageButton    :SetEnabled (self.PageController:HasNextPage     ())
	self.LastPageButton    :SetEnabled (not self.PageController:IsLastPage  ())
end

function self:PassesSearchFilter (incident)
	local searchFilter = self.SearchTextEntry:GetText ()
	
	if string.find (incident:GetQualifiedIncidentId (), searchFilter, 1, true) then return true end
	return CAC.UTF8.MatchTransliteration (incident:GetPlayerName (), searchFilter)
end

CAC.Register ("CACIncidentListView", self, "CACPanel")