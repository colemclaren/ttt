-- Generated from: glib/lua/glib/lua/decompiler/garbagecollectedconstant.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/garbagecollectedconstant.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.GarbageCollectedConstant = CAC.MakeConstructor (self)

function self:ctor ()
	self.Index = 1
	
	self.Type  = nil
	self.Value = nil
end

function self:GetIndex ()
	return self.Index
end

function self:GetType ()
	return self.Type
end

function self:GetLuaString ()
	return tostring (self:GetValue ())
end

function self:GetValue ()
	return self.Value
end

function self:Deserialize (type, inBuffer)
	CAC.Error ("GarbageCollectedConstant:Deserialize : Not implemented.")
end

function self:SetIndex (index)
	self.Index = index
end

function self:SetType (type)
	self.Type = type
end

function self:SetValue (value)
	self.Value = value
end

function self:ToString ()
	return "{ " .. (CAC.Lua.GarbageCollectedConstantType [self:GetType ()] or "InvalidConstant") .. " }"
end