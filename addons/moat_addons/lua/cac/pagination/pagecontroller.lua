local self = {}
CAC.PageController = CAC.MakeConstructor (self)

function self:ctor (itemsPerPage)
	self.DataRange = CAC.DataRange
	
	self.ItemsPerPage = itemsPerPage
	
	self.CurrentDataRange    = self.DataRange.FirstPage (self.ItemsPerPage)
	self.CurrentPageNumber   = 1
	
	self.CurrentPreviousDataRange = self.DataRange.FirstPage (self.ItemsPerPage):MovePreviousPage ()
	self.CurrentNextDataRange     = self.DataRange.FirstPage (self.ItemsPerPage):MoveNextPage ()
	
	self.PreviousPage = false
	self.NextPage     = false
end

function self:NavigateToFirstPage ()
	self.CurrentDataRange         = self.DataRange.FirstPage (self.ItemsPerPage)
	self.CurrentPageNumber        = 1
	
	self.CurrentPreviousDataRange = self.DataRange.FirstPage (self.ItemsPerPage):MovePreviousPage ()
	self.CurrentNextDataRange     = self.DataRange.FirstPage (self.ItemsPerPage):MoveNextPage ()
end

function self:NavigateToLastPage ()
	self.CurrentDataRange         = self.DataRange.LastPage (self.ItemsPerPage)
	self.CurrentPageNumber        = math.huge
	
	self.CurrentPreviousDataRange = self.DataRange.LastPage (self.ItemsPerPage):MovePreviousPage ()
	self.CurrentNextDataRange     = self.DataRange.LastPage (self.ItemsPerPage):MoveNextPage ()
end

function self:NavigateToNextPage ()
	if not self:HasNextPage () then return end
	
	self.CurrentDataRange         = self.CurrentNextDataRange:Clone (self.CurrentDataRange)
	self.CurrentPageNumber        = self.CurrentPageNumber + 1
	
	self.CurrentPreviousDataRange:MoveNextPage ()
	self.CurrentNextDataRange    :MoveNextPage ()
end

function self:NavigateToPreviousPage ()
	if not self:HasPreviousPage () then return end
	
	self.CurrentDataRange         = self.CurrentPreviousDataRange:Clone (self.CurrentDataRange)
	self.CurrentPageNumber        = self.CurrentPageNumber - 1
	
	self.CurrentPreviousDataRange:MovePreviousPage ()
	self.CurrentNextDataRange    :MovePreviousPage ()
end

function self:GetCurrentDataRange ()
	return self.CurrentDataRange
end

function self:GetCurrentPage ()
	return self.CurrentPageNumber
end

function self:HasPreviousPage ()
	return self.PreviousPage
end

function self:HasNextPage ()
	return self.NextPage
end

function self:IsFirstPage ()
	return not self:HasPreviousPage ()
end

function self:IsLastPage ()
	return not self:HasNextPage ()
end

function self:SetCurrentDataRange (firstId, lastId, hasPreviousPage, hasNextPage)
	-- Reset
	if not hasPreviousPage then
		-- First page
		self:NavigateToFirstPage ()
	else
		self.CurrentPreviousDataRange = CAC.DataRange.PreviousPage (firstId, self.ItemsPerPage, self.CurrentPreviousDataRange)
		self.CurrentNextDataRange     = CAC.DataRange.NextPage     (lastId,  self.ItemsPerPage, self.CurrentNextDataRange    )
	end
	
	self.PreviousPage = hasPreviousPage
	self.NextPage     = hasNextPage
end