-- dev realms for code testing
-- called after realm config is loaded

-- just useful for running lua
function me()
	return CLIENT and LocalPlayer() or player.GetHumans()[1]
end