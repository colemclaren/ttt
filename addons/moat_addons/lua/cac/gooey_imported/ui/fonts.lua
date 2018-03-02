-- Generated from: gooey/lua/gooey/ui/fonts.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/fonts.lua
-- Timestamp:      2016-04-28 19:58:52
surface.CreateFont ("DermaDefaultItalic",
	{
		font      = not system.IsOSX () and "Tahoma" or "Helvetica",
		size      = 13, 
		weight    = 500, 
		blursize  = 0, 
		scanlines = 0, 
		antialias = true, 
		underline = false, 
		italic    = true, 
		strikeout = false, 
		symbol    = false, 
		rotary    = false, 
		shadow    = false, 
		additive  = false, 
		outline   = false, 
	}
)