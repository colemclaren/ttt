-- Generated from: glib/lua/glib/lua/decompiler/opcodeinfo.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/opcodeinfo.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.OpcodeInfo = CAC.MakeConstructor (self)

function self:ctor (opcode, name)
	self.Opcode = opcode
	self.Name = name
	
	self.OperandAType = CAC.Lua.OperandType.None
	self.OperandBType = CAC.Lua.OperandType.None
	self.OperandCType = CAC.Lua.OperandType.None
	self.OperandDType = CAC.Lua.OperandType.None
	
	self.FunctionName = nil
end

function self:GetFunctionName ()
	return self.FunctionName
end

function self:GetName ()
	return self.Name
end

function self:GetOpcode ()
	return self.Opcode
end

function self:GetOperandAType ()
	return self.OperandAType
end

function self:GetOperandBType ()
	return self.OperandBType
end

function self:GetOperandCType ()
	return self.OperandCType
end

function self:GetOperandDType ()
	return self.OperandDType
end

function self:SetFunctionName (functionName)
	self.FunctionName = functionName
end

function self:SetName (name)
	self.Name = name
end

function self:SetOperandAType (operandAType)
	self.OperandAType = operandAType
end

function self:SetOperandBType (operandBType)
	self.OperandBType = operandBType
end

function self:SetOperandCType (operandCType)
	self.OperandCType = operandCType
end

function self:SetOperandDType (operandDType)
	self.OperandDType = operandDType
end