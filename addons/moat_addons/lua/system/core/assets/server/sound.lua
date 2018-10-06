util.AddNetworkString "cdn.PlayURL"

function cdn.PlayURL(key, volume, cb)
	net.Start "cdn.PlayURL"
		net.WriteString(key)
		net.WriteFloat(volume or 1)
	net.Broadcast()
end