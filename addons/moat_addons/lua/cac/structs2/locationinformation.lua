if not SERVER then return end

function CAC.LocationInformation.FromPlayer (player, locationInformation)
	locationInformation = locationInformation or CAC.LocationInformation ()
	
	return CAC.LocationInformation.FromIPAndPort (player:IPAddress (), locationInformation)
end

function CAC.LocationInformation.FromIPAndPort (ipPort, locationInformation)
	locationInformation = locationInformation or CAC.LocationInformation ()
	
	local ip   = CAC.StringToIP (ipPort)
	local port = tonumber (string.match (ipPort, ":([0-9]+)$") or 0)
	
	locationInformation:SetIP   (ip)
	locationInformation:SetPort (port)
	
	return locationInformation
end