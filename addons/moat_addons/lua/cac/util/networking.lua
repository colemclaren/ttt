function CAC.IPToString (ip)
	if ip < 0 then ip = ip + 4294967296 end
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:UInt32 (ip)
	
	local inBuffer = CAC.StringInBuffer (string.reverse (outBuffer:GetString ()))
	ip = tostring (inBuffer:UInt8 ())
	ip = ip .. "." .. tostring (inBuffer:UInt8 ())
	ip = ip .. "." .. tostring (inBuffer:UInt8 ())
	ip = ip .. "." .. tostring (inBuffer:UInt8 ())
	
	return ip
end

function CAC.StringToIP (str)
	if str == "loopback" then str = "127.0.0.1" end
	
	local b1, b2, b3, b4 = string.match (str, "([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	b1 = tonumber (b1) or 0
	b2 = tonumber (b2) or 0
	b3 = tonumber (b3) or 0
	b4 = tonumber (b4) or 0
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:UInt8 (b4)
	outBuffer:UInt8 (b3)
	outBuffer:UInt8 (b2)
	outBuffer:UInt8 (b1)
	
	local inBuffer = CAC.StringInBuffer (outBuffer:GetString ())
	return inBuffer:UInt32 ()
end