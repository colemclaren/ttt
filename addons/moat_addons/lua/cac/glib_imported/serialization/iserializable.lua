-- Generated from: glib/lua/glib/serialization/iserializable.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/serialization/iserializable.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.Serialization.ISerializable = CAC.MakeConstructor (self)

function self:ctor ()
end

function self:Deserialize (inBuffer)
	CAC.Error ("ISerializable:Deserialize : Not implemented.")
end

function self:Serialize (outBuffer)
	CAC.Error ("ISerializable:Serialize : Not implemented.")
end