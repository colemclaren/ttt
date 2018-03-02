-- Generated from: glib/lua/glib/lua/decompiler/operandtype.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/operandtype.lua
-- Timestamp:      2015-08-02 20:22:05
CAC.Lua.OperandType = CAC.Enum (
	{
		None                =  0,
		Variable            =  1,
		DestinationVariable =  2,
		WritableBase        =  3,
		ReadOnlyBase        =  4,
		UpvalueId           =  5,
		Literal             =  6,
		SignedLiteral       =  7,
		Primitive           =  8,
		NumericConstantId   =  9,
		StringConstantId    = 10,
		TableConstantId     = 11,
		FunctionConstantId  = 12,
		CDataConstantId     = 13,
		RelativeJump        = 14
	}
)