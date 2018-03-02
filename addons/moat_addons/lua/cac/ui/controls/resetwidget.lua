local self = {}

function self:Init ()
	self.TargetObject = nil
	self.ResetCommand = nil
	
	self.HelpTextLabelAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self.HelpTextLabel = self:Create ("CACLabel")
	self.HelpTextLabel:SetTextColor (CAC.Colors.Firebrick)
	self.HelpTextLabel:SetContentAlignment (6)
	
	self.ResetButton = self:Create ("CACButton")
	self.ResetButton:SetText ("Reset")
	
	self.ResetButton:AddEventListener ("Click",
		function (_)
			if not self.TargetObject then return end
			
			self.HelpTextLabelAlphaFilter:Impulse (SysTime () + 0.5)
			self.HelpTextLabel:SetText ("Double click to reset")
		end
	)
	
	self.ResetButton:AddEventListener ("DoubleClick",
		function ()
			if not self.TargetObject then return end
			
			self.HelpTextLabelAlphaFilter:Impulse (SysTime () + 0.5)
			self.HelpTextLabel:SetText ("Settings reset!")
			
			self.TargetObject:DispatchEvent (self.ResetCommand)
		end
	)
	
	self:AddEventListener ("FontChanged",
		function (_, _)
			self.HelpTextLabel:SetFont (self:GetFont ())
			self.ResetButton  :SetFont (self:GetFont ())
		end
	)
	
	self:SetFont (CAC.Font ("Roboto", 16))
end

function self:PerformLayout (w, h)
	self.ResetButton:SetHeight (h)
	self.ResetButton:SetPos (w - self.ResetButton:GetWidth (), 0)
	
	self.HelpTextLabel:SetSize (w - self.ResetButton:GetWidth () - 4, h)
	self.HelpTextLabel:SetPos (0, 0)
end

function self:Think ()
	self.HelpTextLabel:SetAlpha (255 * self.HelpTextLabelAlphaFilter:Evaluate ())
end

function self:GetTargetObject ()
	return self.TargetObject
end

function self:GetResetCommand ()
	return self.ResetCommand
end

function self:SetTargetObject (targetObject)
	self.TargetObject = targetObject
	return self
end

function self:SetResetCommand (resetCommand)
	self.ResetCommand = resetCommand
	return self
end

CAC.Register ("CACResetWidget", self, "GContainer")