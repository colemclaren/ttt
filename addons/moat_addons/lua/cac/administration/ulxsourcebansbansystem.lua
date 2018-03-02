local self = {}
CAC.ULXSourceBansBanSystem = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ULXSourceBansBanSystem"
end

function self:GetName ()
	return "ULX SourceBans"
end

function self:IsAvailable ()
	return istable (SBAN)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then
		banner =
		{
			IsValid = function () return false end,
			SteamID = function () return "Server" end
		}
	end
	
	local SBAN_Admin_GetID = SBAN.Admin_GetID
	
	SBAN.Admin_GetID = function (steamId, callback)
		callback (0)
	end
	
	xpcall (ulx.sbanid,
		function (message)
			ErrorNoHalt (tostring (message) .. "\n" .. debug.traceback () .. "\n")
		end,
		banner, userId, duration / 60, reason
	)
	SBAN.Admin_GetID = SBAN_Admin_GetID or SBAN.Admin_GetID
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ULXSourceBansBanSystem ())