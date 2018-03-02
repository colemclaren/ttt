-- Generated from: glib/lua/glib/lua/decompiler/tableconstant.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/decompiler/tableconstant.lua
-- Timestamp:      2015-08-02 20:22:05
local self = {}
CAC.Lua.TableConstant = CAC.MakeConstructor (self, CAC.Lua.GarbageCollectedConstant)

function self:ctor (str)
	self.Type = CAC.Lua.GarbageCollectedConstantType.Table
	
	self.ArrayCount = 0
	self.HashCount = 0
	self.ArrayElements = {}
	self.HashKeys = {}
	self.HashValues = {}
	
	self.Value = {}
end

function self:Deserialize (type, inBuffer)
	self.ArrayCount = inBuffer:ULEB128 ()
	self.HashCount  = inBuffer:ULEB128 ()
	self.Value = {}
	
	for i = 0, self.ArrayCount - 1 do
		self.ArrayElements [i] = self:DeserializeElement (inBuffer)
		self.Value [i] = self.ArrayElements [i]
	end
	
	for i = 1, self.HashCount do
		self.HashKeys [i] = self:DeserializeElement (inBuffer)
		self.HashValues [i] = self:DeserializeElement (inBuffer)
		self.Value [self.HashKeys [i]] = self.HashValues [i]
	end
end

function self:DeserializeElement (inBuffer)
	local elementType = inBuffer:ULEB128 ()
	if elementType == CAC.Lua.TableKeyValueType.Nil then
		return nil
	elseif elementType == CAC.Lua.TableKeyValueType.False then
		return false
	elseif elementType == CAC.Lua.TableKeyValueType.True then
		return true
	elseif elementType == CAC.Lua.TableKeyValueType.Integer then
		return inBuffer:ULEB128 ()
	elseif elementType == CAC.Lua.TableKeyValueType.Double then
		local low32 = inBuffer:ULEB128 ()
		local high32 = inBuffer:ULEB128 ()
		return CAC.BitConverter.UInt32sToDouble (low32, high32)
	elseif elementType >= CAC.Lua.TableKeyValueType.String then
		local length = elementType - CAC.Lua.TableKeyValueType.String
		return inBuffer:Bytes (length)
	end
	
	return nil
end

function self:GetLuaString ()
	if self.ArrayCount == 0 and self.HashCount == 0 then
		return "{}"
	end
	
	local luaString = CAC.StringBuilder ()
	luaString:Append ("{")
	
	local first = true
	for i = 0, self.ArrayCount - 1 do
		if not first then
			luaString:Append (",")
		end
		
		local element = self.ArrayElements [i]
		if i == 0 then
			if element ~= nil then
				first = false
				luaString:Append ("\n\t")
				
				element = CAC.Lua.ToLuaString (element)
				luaString:Append ("[0] = ")
				luaString:Append (element)
			end
		else
			first = false
			luaString:Append ("\n\t")
			
			element = CAC.Lua.ToLuaString (element)
			luaString:Append (element)
		end
	end
	
	for i = 1, self.HashCount do
		if not first then
			luaString:Append (",")
		end
		first = false
		luaString:Append ("\n\t")
		
		local key = self.HashKeys [i]
		if type (key) ~= "string" or not CAC.Lua.IsValidVariableName (key) then
			key = CAC.Lua.ToLuaString (key)
		end
		
		luaString:Append (key)
		luaString:Append (" = ")
		
		local value = self.HashValues [i]
		value = CAC.Lua.ToLuaString (value)
		
		luaString:Append (value)
	end
	
	luaString:Append ("\n}")
	return luaString:ToString ()
end

function self:ToString ()
	return "{ Table: " .. self:GetLuaString () .. " }"
end