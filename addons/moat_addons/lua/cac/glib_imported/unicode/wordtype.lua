-- Generated from: glib/lua/glib/unicode/wordtype.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/unicode/wordtype.lua
-- Timestamp:      2016-02-22 19:22:23
CAC.WordType = CAC.Enum (
	{
		None         = 0,
		Alphanumeric = 1,
		Whitespace   = 2,
		LineBreak    = 3,
		Other        = 4,
	}
)