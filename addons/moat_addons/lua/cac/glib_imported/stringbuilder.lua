-- Generated from: glib/lua/glib/stringbuilder.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/stringbuilder.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.StringBuilder = CAC.MakeConstructor (self)

function self:ctor ()
	self.Buffer = { "" }
	self.Length = 0
end

function self:Append (str)
	str = tostring (str)
	if #self.Buffer [#self.Buffer] >= 1024 then
		self.Buffer [#self.Buffer + 1] = ""
	end
	self.Buffer [#self.Buffer] = self.Buffer [#self.Buffer] .. str
	self.Length = self.Length + #str
	
	return self
end

function self:Clear ()
	self.Buffer = { "" }
	self.Length = 0
end

function self:GetLength ()
	return self.Length
end

function self:ToString ()
	return table.concat (self.Buffer)
end

self.__concat   = function (a, b)
	if type (b) == "string" then
		return a:Append (b)
	end
	return tostring (a) .. tostring (b)
end

self.__len      = self.GetLength
self.__tostring = self.ToString