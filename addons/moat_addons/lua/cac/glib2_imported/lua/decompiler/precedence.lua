-- Generated from: glib/lua/glib/lua/decompiler/precedence.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/precedence.lua
-- Timestamp:      2015-08-02 20:22:05
CAC.Lua.Precedence = CAC.Enum (
	{
		Lowest            = 0,
        Addition          = 1,
        Subtraction       = 2,
        Multiplication    = 3,
        Division          = 4,
		Modulo            = 5,
        Exponentiation    = 6,
		LeftUnaryOperator = 7,
        Atom              = 8
	}
)

local associativePrecedences =
{
	[CAC.Lua.Precedence.Addition] = true,
	[CAC.Lua.Precedence.Multiplication] = true,
	[CAC.Lua.Precedence.LeftUnaryOperator] = true
}

function CAC.Lua.IsPrecedenceAssociative (precedence)
	return associativePrecedences [precedence] or false
end