-- Generated from: glib/lua/glib/lua/decompiler/stringconstant.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/stringconstant.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.StringConstant = CAC.MakeConstructor (self, CAC.Lua.GarbageCollectedConstant)

function self:ctor (str)
	self.Type = CAC.Lua.GarbageCollectedConstantType.String
	self.Length = 0
	self.Value = str or ""
end

function self:Deserialize (type, inBuffer)
	self.Length = type - CAC.Lua.GarbageCollectedConstantType.String
	self.Value = inBuffer:Bytes (self.Length)
end

function self:GetLuaString ()
	return "\"" .. CAC.String.EscapeNonprintable (self.Value) .. "\""
end

function self:ToString ()
	return "{ String: " .. self:GetLuaString () .. " }"
end