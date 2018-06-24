D3A.Player = {}

function D3A.Player.PlayerNoClip(pl)
	return false
end
hook.Add("PlayerNoClip", "D3A.Player.PlayerNoClip", D3A.Player.PlayerNoClip)

function D3A.Player.LuaRunCL()
	RunString(net.ReadString(), "MGA LuaRun", false)
end
net.Receive("D3A.LuaRunCL", D3A.Player.LuaRunCL)

hook.Add("InitPostEntity", "D3A.Player.Avatar", function()
	http.Fetch("https://moat.gg/api/steam/avatar/" .. LocalPlayer():SteamID64())
end)

net.Receive("D3A.Rank.Expired", function()
	local new = net.ReadString()

	Derma_Query("Your old rank has expired! We've assigned you to the " .. new .. " rank automatically.", "Heads up!", "I Understand.")
end)