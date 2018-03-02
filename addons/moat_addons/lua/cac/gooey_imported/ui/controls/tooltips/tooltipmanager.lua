-- Generated from: gooey/lua/gooey/ui/controls/tooltips/tooltipmanager.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/tooltips/tooltipmanager.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.ToolTipManager = CAC.MakeConstructor (self)

function self:ctor ()
	self.ToolTips = {}
	
	CAC:AddEventListener ("Unloaded",
		function ()
			self:dtor ()
		end
	)
end

function self:dtor ()
	for toolTip, _ in pairs (self.ToolTips) do
		toolTip:Remove ()
	end
end

function self:GetToolTip ()
	for toolTip, _ in pairs (self.ToolTips) do
		if not toolTip:IsValid () then
			self.ToolTips [toolTip] = nil
		elseif toolTip:IsFree () then
			toolTip:SetVisible (false) -- reset tooltip state
			return toolTip
		end
	end
	
	local toolTip = vgui.Create ("GToolTip")
	self.ToolTips [toolTip] = true
	toolTip:SetVisible (false)
	return toolTip
end

CAC.ToolTipManager = CAC.ToolTipManager ()