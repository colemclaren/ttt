local TestSkinSyncNewPlayers = false
local function SetTestSkin(url, who, cl)
	who = IsValid(who) and who:Nick() or "Console"

	MOAT_PAINT.Skins[6119][2] = url
	TestSkinSyncNewPlayers = {url, who}
	timer.Simple(0, function() cdn.Cache = {} end)

	if (SERVER) then
		net.Start "SetTestSkin"
			net.WriteString(url)
			net.WriteString(who)
		net.Broadcast()
	end

	MsgC(Color(255, 165, 0), "[Test Skin] ", Color(255, 255, 0), (cl and "You" or who) .. " set the test skin" .. (cl and " clientside" or "") .. " to:        \n", Color(255, 0, 0), url .. "\n")

	if (url:GetExtensionFromFilename() ~= ".vtf") then
		MsgC(Color(255, 165, 0), "[Test Skin] ", Color(255, 255, 255), "WARNING: This image won't work on some guns, remember to convert it to .vtf file for final.\n")
	end

	if (cl and moat.isdev(LocalPlayer())) then
		MsgC(Color(255, 165, 0), "[Test Skin] ", Color(255, 255, 255), "If you have proper access, use 'skin_url_sv' to set it for everyone connected to the server.\n")
	end
end

if (SERVER) then
	util.AddNetworkString "SetTestSkin"

	concommand.Add("skin_url_sv", function(pl, cmd, args)
		if (not args or not args[1] or not moat.isdev(pl)) then
			return
		end

		SetTestSkin(args[1], pl)
	end)

	hook("PlayerInitialSpawn", function(pl)
		if (TestSkinSyncNewPlayers) then
			net.Start "SetTestSkin"
				net.WriteString(TestSkinSyncNewPlayers[1])
				net.WriteString(TestSkinSyncNewPlayers[2])
			net.Send(pl)
		end
	end)
else
	concommand.Add("skin_url", function(pl, cmd, args)
		if (not args or not args[1]) then
			return
		end

		SetTestSkin(args[1], pl, true)
	end)

	net.Receive("SetTestSkin", function()
		local url = net.ReadString()
		local who = net.ReadString()

		SetTestSkin(url, who)
	end)
end