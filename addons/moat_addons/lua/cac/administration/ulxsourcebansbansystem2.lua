local self = {}
CAC.ULXSourceBansBanSystem2 = CAC.MakeConstructor (self, CAC.BanSystem)

function self:ctor ()
end

-- IReadOnlyBanSystem
function self:GetId ()
	return "ULXSourceBansBanSystem2"
end

function self:GetName ()
	return "ULX SourceBans (Blasteh)"
end

function self:IsAvailable ()
	return isfunction (SBAN_banplayer)
end

-- IBanSystem
function self:Ban (userId, duration, reason, bannerId)
	if duration == math.huge then duration = 0 end
	
	local banner = CAC.PlayerMonitor:GetUserEntity (bannerId) or NULL
	if not banner:IsValid () then
		banner =
		{
			IsValid  = function () return false end,
			IsPlayer = function () return true end,
			SteamID  = function () return "Server" end
		}
	end
	
	xpcall (ulx.sbanid,
		function (message)
			ErrorNoHalt (tostring (message) .. "\n" .. debug.traceback () .. "\n")
		end,
		banner, userId, duration / 60, reason
	)
end

function self:CanBanOfflineUsers ()
	return true
end

CAC.SystemRegistry:RegisterSystem ("BanSystem", CAC.ULXSourceBansBanSystem2 ())