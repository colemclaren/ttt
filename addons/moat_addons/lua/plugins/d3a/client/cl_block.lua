function D3A.Block()
	local id = net.ReadString()

	cookie.Set("moat_block" .. id, "1")
	
	local pl = player.GetBySteamID(id)

	if (pl) then
		pl:SetMuted(true)
	end
end

function D3A.Unblock()
	local id = net.ReadString()

	cookie.Set("moat_block" .. id, "0")

	local pl = player.GetBySteamID(id)

	if (pl) then
		pl:SetMuted(false)
	end
end

net.Receive("moat_block", D3A.Block)
net.Receive("moat_unblock", D3A.Unblock)

hook.Add("PrePlayerChat", "D3A.Chat.Block", function(pl, txt)
	if (IsValid(pl) and cookie.GetNumber("moat_block" .. pl:SteamID(), 0) == 1) then
		return true
	end
end)

hook.Add("PlayerStartVoice", "D3A.Voice.Block", function(pl)
	if (IsValid(pl) and (cookie.GetNumber("moat_block" .. pl:SteamID(), 0) == 1 or cookie.GetNumber("moat_mute" .. pl:SteamID(), 0) == 1)) then
		pl:SetMuted(true)
	end
end)

function D3A.Mute(pl)
	cookie.Set("moat_mute" .. pl:SteamID(), "1")
	pl:SetMuted(true)
end

function D3A.Unmute(pl)
	cookie.Set("moat_mute" .. pl:SteamID(), "0")
	pl:SetMuted(false)
end