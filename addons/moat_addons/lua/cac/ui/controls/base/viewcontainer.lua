local self = {}

--[[
	Events:
		ActiveViewChanged (Panel lastActiveView, Panel activeView)
			Fired when the active view has changed.
]]

function self:Init ()
	self.ViewsById = {}
	
	self.ActiveView = nil
	self.ActiveViewXInterpolator = CAC.SigmoidStepResponseInterpolator ()
	self.ActiveViewYInterpolator = CAC.SigmoidStepResponseInterpolator ()
	
	self.PreviousActiveView = nil
	self.PreviousActiveViewXInterpolator = CAC.SigmoidStepResponseInterpolator ()
	self.PreviousActiveViewYInterpolator = CAC.SigmoidStepResponseInterpolator ()
	
	self.AnimationExitDirection = nil
end

function self:PerformLayout (w, h)
	for _, control in pairs (self.ViewsById) do
		control:SetSize (w, h)
	end
end

function self:Paint (w, h)
end

function self:Think ()
	local t = SysTime ()
	
	if self.ActiveView then
		local x = math.floor (self.ActiveViewXInterpolator:Run (t) + 0.5)
		local y = math.floor (self.ActiveViewYInterpolator:Run (t) + 0.5)
		self.ActiveView:SetPos (x, y)
	end
	
	if self.PreviousActiveView then
		local x = math.floor (self.PreviousActiveViewXInterpolator:Run (t) + 0.5)
		local y = math.floor (self.PreviousActiveViewYInterpolator:Run (t) + 0.5)
		self.PreviousActiveView:SetPos (x, y)
		
		if math.abs (self.PreviousActiveViewXInterpolator:GetError ()) < 0.5 and
		   math.abs (self.PreviousActiveViewYInterpolator:GetError ()) < 0.5 then
			self.PreviousActiveView:SetVisible (false)
		end
	end
end

-- View
function self:AddView (control, id)
	control:SetParent (self)
	control:SetSize (self:GetWidth (), self:GetHeight ())
	control:SetVisible (false)
	
	self.ViewsById [id] = control
	
	-- Active view
	if not self:GetActiveView () then
		self:SetActiveView (control, "None")
	end
end

function self:GetViewById (id)
	return self.ViewsById [id]
end

-- Active view
function self:GetActiveView ()
	return self.ActiveView
end

local directionOpposites =
{
	["Left" ] = "Right",
	["Right"] = "Left",
	["Down" ] = "Up",
	["Up"   ] = "Down"
}

function self:SetActiveView (activeView, exitDirection)
	if isstring (activeView) then activeView = self:GetViewById (activeView) end
	
	if self.ActiveView == activeView then return self end
	
	exitDirection = exitDirection or "Down"
	
	local lastActiveView    = self.ActiveView
	local lastExitDirection = self.AnimationExitDirection
	self.ActiveView    = activeView
	self.AnimationExitDirection = exitDirection
	self.ActiveViewXInterpolator, self.PreviousActiveViewXInterpolator = self.PreviousActiveViewXInterpolator, self.ActiveViewXInterpolator
	self.ActiveViewYInterpolator, self.PreviousActiveViewYInterpolator = self.PreviousActiveViewYInterpolator, self.ActiveViewYInterpolator
	
	if self.ActiveView then
		self.ActiveView:SetVisible (true)
	end
	self.ActiveViewXInterpolator:SetTargetValue (0)
	self.ActiveViewYInterpolator:SetTargetValue (0)
	
	-- Animation control
	if self.PreviousActiveView == self.ActiveView and
	   lastExitDirection == directionOpposites [exitDirection] then
		self.PreviousActiveView    = lastActiveView
		-- Don't flush, we're undoing the previous active view change
	else
		-- Update the exiting view
		if self.PreviousActiveView and
		   self.PreviousActiveView ~= lastActiveView and
		   self.PreviousActiveView ~= self.ActiveView then
			-- Force invisible, in case we're still in an animation
			self.PreviousActiveView:SetVisible (false)
		end
		self.PreviousActiveView    = lastActiveView
		
		if     exitDirection == "Left"  then
			self.ActiveViewXInterpolator:Flush (self:GetWidth ())
			self.ActiveViewYInterpolator:Flush (0)
		elseif exitDirection == "Right" then
			self.ActiveViewXInterpolator:Flush (-self:GetWidth ())
			self.ActiveViewYInterpolator:Flush (0)
		elseif exitDirection == "Up"    then
			self.ActiveViewXInterpolator:Flush (0)
			self.ActiveViewYInterpolator:Flush (self:GetHeight ())
		elseif exitDirection == "Down"  then
			self.ActiveViewXInterpolator:Flush (0)
			self.ActiveViewYInterpolator:Flush (-self:GetHeight ())
		elseif exitDirection == "None"  then
		end
	end
	
	if     exitDirection == "Left"  then
		self.PreviousActiveViewXInterpolator:SetTargetValue (-self:GetWidth ())
		self.PreviousActiveViewYInterpolator:SetTargetValue (0)
	elseif exitDirection == "Right" then
		self.PreviousActiveViewXInterpolator:SetTargetValue (self:GetWidth ())
		self.PreviousActiveViewYInterpolator:SetTargetValue (0)
	elseif exitDirection == "Up"    then
		self.PreviousActiveViewXInterpolator:SetTargetValue (0)
		self.PreviousActiveViewYInterpolator:SetTargetValue (-self:GetHeight ())
	elseif exitDirection == "Down"  then
		self.PreviousActiveViewXInterpolator:SetTargetValue (0)
		self.PreviousActiveViewYInterpolator:SetTargetValue (self:GetHeight ())
	end
	
	-- Synchronize interpolators
	local t = SysTime ()
	self.ActiveViewXInterpolator:Skip (t)
	self.ActiveViewYInterpolator:Skip (t)
	self.PreviousActiveViewXInterpolator:Skip (t)
	self.PreviousActiveViewYInterpolator:Skip (t)
	
	self:DispatchEvent ("ActiveViewChanged", lastActiveView, self.ActiveView)
	
	return self
end

-- Animation
function self:GetAnimationExitDirection ()
	return self.AnimationExitDirection
end

function self:IsInAnimation ()
	return math.abs (self.PreviousActiveViewXInterpolator:GetError ()) > 0.5 or
	       math.abs (self.PreviousActiveViewYInterpolator:GetError ()) > 0.5 or
	       math.abs (self.ActiveViewYInterpolator        :GetError ()) > 0.5 or
	       math.abs (self.ActiveViewYInterpolator        :GetError ()) > 0.5
end

CAC.Register ("CACViewContainer", self, "CACPanel")