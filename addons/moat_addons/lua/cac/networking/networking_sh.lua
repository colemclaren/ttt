CAC.Identifiers = CAC.Identifiers or {}

net.Receive (CAC.Identifiers.AdminChannelName,
	function (bitCount, ply)
		if SERVER then
			if not CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then return end
			
			if CAC.IsDebug then
				CAC.Logger:Message ("Received admin UI data (" .. CAC.FormatFileSize (bitCount / 8) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via AdminChannel.")
			end
		end
		
		xpcall (
			function ()
				local dataLength = net.ReadUInt (16)
				local data       = net.ReadData (dataLength)
				
				local inBuffer   = CAC.StringInBuffer (data)
				
				if SERVER then
					local networkingHost = CAC.Networker:GetNetworkingHost (ply)
					networkingHost:HandlePacket (inBuffer)
				else
					CAC.NetworkingClient:HandlePacket (inBuffer)
				end
			end,
			CAC.Error
		)
	end
)
