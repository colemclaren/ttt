function includeData( data, path )
	RunStringEx( util.Decompress( data ), path )
end

net.Receive( "acrashscreen_alt", function()
	
	local dataCount = net.ReadInt( 10 )
	for i=1, dataCount do
		local size = net.ReadUInt( 32 )
		local data = net.ReadData( size )
		local path = net.ReadString()
		includeData( data, path )
	end
	
end)