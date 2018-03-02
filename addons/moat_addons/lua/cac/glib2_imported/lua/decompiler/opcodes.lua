-- Generated from: glib/lua/glib/lua/decompiler/opcodes.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/opcodes.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.Opcodes = CAC.MakeConstructor (self)

function self:ctor ()
	self.Opcodes = {}
end

function self:AddOpcode (opcode, name)
	self.Opcodes [opcode] = CAC.Lua.OpcodeInfo (opcode, name)
	return self.Opcodes [opcode]
end

function self:GetOpcode (opcode)
	if type (opcode) == "string" then
		opcode = CAC.Lua.Opcode [opcode]
	end
	
	if type (opcode) ~= "number" then return nil end
	
	return self.Opcodes [opcode]
end

CAC.Lua.Opcodes = CAC.Lua.Opcodes ()