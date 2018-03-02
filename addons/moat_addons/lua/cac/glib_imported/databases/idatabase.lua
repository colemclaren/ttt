-- Generated from: glib/lua/glib/databases/idatabase.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/databases/idatabase.lua
-- Timestamp:      2016-02-22 19:22:23
local self = {}
CAC.Databases.IDatabase = CAC.MakeConstructor (self)

function self:ctor ()
end

function self:Connect (hostname, port, username, password, databaseName, callback)
	CAC.Error ("IDatabase:Connect : Not implemented.")
end

function self:Disconnect (callback)
	CAC.Error ("IDatabase:Connect : Not implemented.")
end

function self:EscapeString (str)
	CAC.Error ("IDatabase:EscapeString : Not implemented.")
end

function self:GetDatabaseListQuery ()
	CAC.Error ("IDatabase:GetDatabaseListQuery : Not implemented.")
end

function self:GetTableListQuery ()
	CAC.Error ("IDatabase:GetDatabaseListQuery : Not implemented.")
end

function self:IsConnected ()
	CAC.Error ("IDatabase:IsConnected : Not implemented.")
end

function self:Query (query, callback)
	CAC.Error ("IDatabase:Query : Not implemented.")
end