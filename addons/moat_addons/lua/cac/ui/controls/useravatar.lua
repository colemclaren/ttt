local self = {}

function self:Init ()
	self.SteamId       = nil
	self.Player        = nil
	
	self.AvatarControl = nil
	self.UrlImage      = nil
	
	self:SetSize (48, 48)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	if self.AvatarControl and
	   self.AvatarControl:IsValid () then
		self.AvatarControl:SetPos (0, 0)
		self.AvatarControl:SetSize (w, h)
	end
	
	if self.UrlImage and
	   self.UrlImage:IsValid () then
		self.UrlImage:SetPos (0, 0)
		self.UrlImage:SetSize (w, h)
	end
end

function self:GetSteamId ()
	return self.SteamId
end

function self:SetSteamId (steamId)
	if self.SteamId == steamId then return self end
	
	if self.AvatarControl and self.AvatarControl:IsValid () then self.AvatarControl:Remove () end
	if self.UrlImage      and self.UrlImage     :IsValid () then self.UrlImage     :Remove () end
	
	self.SteamId = steamId
	self.Player  = CAC.PlayerMonitor:GetUserEntity (self.SteamId)
	
	if self.SteamId then
		self.AvatarControl = self:Create ("AvatarImage")
		if self.Player then
			self.AvatarControl:SetPlayer (self.Player, 48)
		else
			CAC.UserAvatarUrlCache:GetUserAvatarUrl (self.SteamId,
				function (steamId, url)
					if not self                then return end
					if not self:IsValid ()     then return end
					
					if self.SteamId ~= steamId then return end
					
					if not url                 then return end
					
					self.UrlImage = self:Create ("CACUrlImage")
					self.UrlImage:SetUrl (url)
				end
			)
		end
	end
	
	return self
end

CAC.Register ("CACUserAvatar", self, "CACPanel")