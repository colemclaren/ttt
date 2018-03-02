
if ( SERVER ) then

	AddCSLuaFile( "althitreg/config.lua" )
	AddCSLuaFile( "althitreg/hitregclient.lua" )

	include( "althitreg/config.lua" )
	include( "althitreg/hitregserver.lua" )

else

	include( "althitreg/config.lua" )
	include( "althitreg/hitregclient.lua" )

end

MsgC( Color( 255, 0, 0 ), "Alternative Hit Registration by Moat Initiated\n" )