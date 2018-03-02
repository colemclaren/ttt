-- Made by ikefi - http://steamcommunity.com/id/ikefi/ --

aCrashScreen = aCrashScreen or {}
local _this = aCrashScreen
_this.config = _this.config or {}

-- Change this to false if you want to see proper error messages
-- and or if you're editing files with it automaticaly refreshing
-- If you're not or finished doing so change it back to true
local pinclude = true

if pinclude then
	
	if SERVER then
		
		AddCSLuaFile( 'lib/cl_protected_include.lua' )
		
		include( 'lib/sv_protected_include.lua' )
		
		AddCSLuaFile('cl_config.lua')
		
		_this.include.includeFile( 'acrashscreen/incl/sv_main.lua' )
		
		_this.include.includeFile( 'acrashscreen/incl/cl_menu.lua' )
		_this.include.includeFile( 'acrashscreen/incl/cl_chat.lua' )
		_this.include.includeFile( 'acrashscreen/incl/cl_main.lua' )
		_this.include.includeFile( 'acrashscreen/incl/cl_web.lua' )
		_this.include.includeFile( 'acrashscreen/incl/cl_misc.lua' )
		
	else
		
		include( 'lib/cl_protected_include.lua' )
		
		include( 'cl_config.lua' )
		
	end
	
else
	
	if SERVER then
		
		AddCSLuaFile( 'cl_config.lua' )
		AddCSLuaFile( 'incl/cl_menu.lua' )
		AddCSLuaFile( 'incl/cl_chat.lua' )
		AddCSLuaFile( 'incl/cl_main.lua' )
		AddCSLuaFile( 'incl/cl_web.lua' )
		AddCSLuaFile( 'incl/cl_misc.lua' )
		
		include( 'incl/sv_main.lua' )
		
	else
		
		include( 'cl_config.lua' )
		include( 'incl/cl_menu.lua' )
		include( 'incl/cl_chat.lua' )
		include( 'incl/cl_main.lua' )
		include( 'incl/cl_web.lua' )
		include( 'incl/cl_misc.lua' )
		
	end
	
end