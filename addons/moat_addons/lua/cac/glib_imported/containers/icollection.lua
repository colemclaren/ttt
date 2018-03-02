-- Generated from: glib/lua/glib/containers/icollection.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/containers/icollection.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.Containers.ICollection = CAC.MakeConstructor (self, CAC.IEnumerable)

function self:ctor ()
end

function self:Add (item)
	CAC.Error ("ICollection:Add : Not implemented.")
end

function self:AddRange (enumerable)
	for item in enumerable:GetEnumerator () do
		self:Add (item)
	end
end

function self:Clear ()
	CAC.Error ("ICollection:Clear : Not implemented.")
end

function self:Contains (item)
	CAC.Error ("ICollection:Contains : Not implemented.")
end

function self:GetCount ()
	CAC.Error ("ICollection:GetCount : Not implemented.")
end

function self:IsEmpty ()
	CAC.Error ("ICollection:IsEmpty : Not implemented.")
end

function self:Remove (item)
	CAC.Error ("ICollection:Remove : Not implemented.")
end