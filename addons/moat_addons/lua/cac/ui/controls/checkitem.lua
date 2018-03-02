local self = {}

function self:Init ()
	self.Check                = nil
	self.CheckFinishTime      = math.huge
	
	self.CheckStatus          = ""
	self.LastStatusUpdateTime = 0
	self.CheckStatusQueue     = {}
	
	self:SetFont (CAC.Font ("Roboto", 13))
	self:SetHeight (13)
	
	self:AddEventListener ("MouseDown",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMousePressed (mouseCode)
		end
	)
	self:AddEventListener ("MouseMove",
		function (_, mouseCode, x, y)
			self:GetParent ():DispatchEvent ("MouseMove", mouseCode, self:GetParent ():CursorPos ())
		end
	)
	self:AddEventListener ("MouseUp",
		function (_, mouseCode, x, y)
			self:GetParent ():OnMouseReleased (mouseCode)
		end
	)
end

function self:Think ()
end

function self:Paint (w, h)
	if not self.Check then return end
	
	surface.SetFont (self:GetFont ())
	surface.SetTextColor (CAC.Colors.Black)
	
	surface.SetTextPos (40, 0)
	surface.DrawText (self.CheckStatus)
	
	local timeoutEntry = self.Check:GetTimeout ()
	if timeoutEntry then
		local timeRemaining = timeoutEntry:GetProjectedTimeRemaining ()
		timeRemaining = CAC.FormatTimeRemaining (timeRemaining)
		
		local textWidth, textHeight = surface.GetTextSize (timeRemaining)
		surface.SetTextPos (0, 0)
		surface.DrawText (timeRemaining)
	end
	
	self:ProcessStatusQueue ()
end

function self:GetCheck ()
	return self.Check
end

function self:SetCheck (check)
	if self.Check == check then return self end
	
	self:UnhookCheck (self.Check)
	
	self.Check = check
	self.CheckFinishTime = self.Check and self.Check:IsFinished () and SysTime () or math.huge
	
	self.CheckStatus = ""
	self:ClearStatusQueue ()
	
	if self.Check then
		self:QueueStatus (self.Check:GetStatus () or self.Check:GetName ())
	end
	
	self:HookCheck (self.Check)
	
	return self
end

function self:ShouldRemove ()
	return SysTime () - self.CheckFinishTime > 2
end

-- Internal, do not call
function self:OnRemoved ()
	self:SetCheck (nil)
end

function self:ClearStatusQueue ()
	self.LastStatusUpdateTime = 0
	self.CheckStatusQueue     = {}
end

function self:ProcessStatusQueue ()
	if #self.CheckStatusQueue == 0 then return end
	if SysTime () - self.LastStatusUpdateTime < 0.5 then return end
	
	self.LastStatusUpdateTime = SysTime ()
	self.CheckStatus = self.CheckStatusQueue [1]
	table.remove (self.CheckStatusQueue, 1)
end

function self:QueueStatus (status)
	self.CheckStatusQueue [#self.CheckStatusQueue + 1] = status
	self:ProcessStatusQueue ()
end

function self:HookCheck (check)
	if not check then return end
	
	check:AddEventListener ("Finished", "CAC.CheckItem." .. self:GetHashCode (),
		function (_)
			self.CheckFinishTime = SysTime ()
		end
	)
	
	check:AddEventListener ("StatusChanged", "CAC.CheckItem." .. self:GetHashCode (),
		function (_, status)
			self.CheckStatusQueue [#self.CheckStatusQueue + 1] = status or check:GetName ()
			
			self:ProcessStatusQueue ()
		end
	)
end

function self:UnhookCheck (check)
	if not check then return end
	
	check:RemoveEventListener ("Finished",      "CAC.CheckItem." .. self:GetHashCode ())
	check:RemoveEventListener ("StatusChanged", "CAC.CheckItem." .. self:GetHashCode ())
end

CAC.Register ("CACCheckItem", self, "CACPanel")