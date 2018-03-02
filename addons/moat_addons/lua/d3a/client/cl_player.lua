D3A.Player = {}

function D3A.Player.PlayerNoClip(pl)
	return false
end
hook.Add("PlayerNoClip", "D3A.Player.PlayerNoClip", D3A.Player.PlayerNoClip)

function D3A.Player.LuaRunCL()
	RunString(net.ReadString(), "MGA LuaRun", false)
end
net.Receive("D3A.LuaRunCL", D3A.Player.LuaRunCL)