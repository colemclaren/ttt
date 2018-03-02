-- Generated from: glib/lua/glib/databases/sqlitedatabase.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/databases/sqlitedatabase.lua
-- Timestamp:      2016-02-22 19:22:23
-- SQLite
local self = {}
CAC.Databases.SqliteDatabase = CAC.MakeConstructor (self, CAC.Databases.IDatabase)

function self:ctor ()
end

function self:Connect (server, port, username, password, databaseName, callback)
	if callback then CAC.CallSelfAsSync () return end
	
	return true
end

function self:Disconnect (callback)
	if callback then CAC.CallSelfAsSync () return end
	
	return true
end

function self:EscapeString (string)
	return sql.SQLStr (string, true)
end

function self:GetDatabaseListQuery ()
	return ""
end

function self:GetTableListQuery (database)
	return "SELECT * FROM sqlite_master WHERE type = \"table\""
end

function self:IsConnected ()
	return true
end

function self:Query (query, callback)
	if callback then CAC.CallSelfAsSync () return end
	
	local result = sql.Query (query)
	if result == false then
		return false, sql.LastError ()
	else
		return true, result
	end
end