local self = {}

local views =
{
	{ ControlName = "CACDetectorSettingsView",          Id = "DetectorSettings",          Title = "Detectors",      GroupName = "DetectorSettings"          },
	{ ControlName = "CACDetectionResponseSettingsView", Id = "DetectionResponseSettings", Title = "Detections",     GroupName = "DetectionResponseSettings" },
	{ ControlName = "CACResponseSettingsView",          Id = "ResponseSettings",          Title = "Responses",      GroupName = "ResponseSettings"          },
	{ ControlName = "CACLuaWhitelistSettingsView",      Id = "LuaWhitelistSettings",      Title = "Lua Whitelist",  GroupName = "LuaWhitelistSettings"      },
	{ ControlName = "CACUserWhitelistSettingsView",     Id = "UserWhitelistSettings",     Title = "User Whitelist", GroupName = "UserWhitelistSettings"     },
	{ ControlName = "CACUnimplementedView",             Id = "PermissionSettings",        Title = "Permissions",    GroupName = nil                         },
	{ ControlName = "CACUnimplementedView",             Id = "LoggingSettings",           Title = "Logging",        GroupName = nil                         }
}

function self:Init ()
	self.Settings = CAC.Settings
	
	self.TabControl = self:Create ("CACTabControl")
	
	for _, viewData in ipairs (views) do
		local view = self:Create (viewData.ControlName)
		self.TabControl:AddTab (view, viewData.Id, viewData.Title)
		
		if viewData.GroupName then
			view ["Set" .. viewData.GroupName] (view, self.Settings:GetSettingsGroup (viewData.GroupName))
		end
	end
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.TabControl:SetPos (4, 4)
	self.TabControl:SetSize (w - 8, h - 8)
end

CAC.Register ("CACSettingsView", self, "CACPanel")