-- Generated from: glib/lua/glib/oop/enum.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/oop/enum.lua
-- Timestamp:      2016-02-22 19:22:23
function CAC.Enum (enum)
	if not next (enum) then
		CAC.Error ("CAC.Enum : This enum appears to be empty!")
	end
	
	CAC.InvertTable (enum, enum)
	return enum
end