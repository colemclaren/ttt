local self = {}
CAC.UserAvatarUrlCache = CAC.MakeConstructor (self)

function self:ctor ()
	self.Cache = {}
	
	self.Queue = {}
	
	self.CurrentQueueItem = nil
	self.ProcessingQueue  = false
end

function self:dtor ()
	self:StopProcessingQueue ()
end

function self:GetUserAvatarUrl (steamId, callback)
	-- Reject invalid steam IDs
	if not CAC.IsSteamId (steamId) then
		callback (steamId, nil)
		return
	end
	
	-- Check for cache hit
	if self.Cache [steamId] then
		callback (steamId, self.Cache [steamId])
		return
	end
	
	-- Merge with existing queue item
	if self.Queue [steamId] then
		self.Queue [steamId].Callbacks [#self.Queue [steamId].Callbacks + 1] = callback
		return
	end
	
	local queueItem =
	{
		ProfileUrl = "http://www.steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (steamId),
		Callbacks  = { callback }
	}
	
	-- Single player steam id correction
	if game.SinglePlayer () and steamId == "STEAM_0:0:0" then
		queueItem.ProfileUrl = "http://www.steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (LocalPlayer ():SteamID ())
	end
	
	self.Queue [steamId] = queueItem
	
	self:StartProcessingQueue ()
end

-- Internal, do not call
function self:StartProcessingQueue ()
	if self.ProcessingQueue then return end
	if not next (self.Queue) then return end
	
	self.ProcessingQueue = true
	
	self:ProcessQueueItem ()
end

function self:StopProcessingQueue ()
	if not self.ProcessingQueue then return end
	
	self.ProcessingQueue = false
end

function self:ProcessQueueItem ()
	if not next (self.Queue) then
		self:StopProcessingQueue ()
		return
	end
	
	local steamId = next (self.Queue)
	
	self.CurrentQueueItem = self.Queue [steamId]
	
	http.Fetch (self.Queue [steamId].ProfileUrl,
		function (response, contentLength, headers, statusCode)
			local url = string.match (response, "<img src=\"(https?://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/%x+/%x+_full.jpg)\">")
			if url then
				self.Cache [steamId] = url
			end
			
			for _, callback in ipairs (self.Queue [steamId].Callbacks) do
				callback (steamId, self.Cache [steamId])
			end
			
			self.Queue [steamId] = nil
			self.CurrentQueueItem = nil
			
			self:ProcessQueueItem ()
		end,
		function ()
			-- Failure
			for _, callback in ipairs (self.Queue [steamId].Callbacks) do
				callback (steamId, nil)
			end
			
			self.Queue [steamId] = nil
			self.CurrentQueueItem = nil
			
			self:ProcessQueueItem ()
		end
	)
end

CAC.UserAvatarUrlCache = CAC.UserAvatarUrlCache ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.UserAvatarUrlCache:dtor ()
	end
)