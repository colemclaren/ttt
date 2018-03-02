-- Generated from: glib/lua/glib/lua/decompiler/functionconstant.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/functionconstant.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.FunctionConstant = CAC.MakeConstructor (self, CAC.Lua.GarbageCollectedConstant)

function self:ctor ()
	self.Function = nil
	self.Type = CAC.Lua.GarbageCollectedConstantType.Function
end

function self:GetFunction ()
	return self.Function
end

function self:Deserialize (type, inBuffer)
end

function self:GetLuaString ()
	if self.Function then
		return self.Function:ToString ()
	end
	return "function () --[[ Closure ]] end"
end

function self:SetFunction (functionBytecodeReader)
	self.Function = functionBytecodeReader
end

function self:ToString ()
	return "{ Function: " .. self:GetLuaString () .. " }"
end