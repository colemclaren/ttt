require "mysqloo"
if (not moat.cfg or not moat.cfg.sql) then return end

moat.sql = moat.sql or {}
if (not moat.sql.db) then
	moat.sql.db = mysqloo.connect(
		moat.cfg.sql.host,
		moat.cfg.sql.username,
		moat.cfg.sql.password,
		moat.cfg.sql.database,
		moat.cfg.sql.port
	)
end

moat.sql.db.onConnected = function(db)
	if (db.setCharacterSet) then
		db:setCharacterSet "utf8mb4"
	end

	moat.print("sql connected")
	hook.Run("SQLConnected", db)
end
moat.sql.db.onConnectionFailed = function(db, err)
	moat.print("sql failed", db, err)
	hook.Run("SQLConnectionFailed", db, err)
end
if (not moat.sql.db.status or (moat.sql.db.status and moat.sql.db:status() == mysqloo.DATABASE_NOT_CONNECTED)) then
	moat.sql.db:connect()
end

timer.Create("moat.sql.no.disconnecto", 180, 0, function()
    moat.sql.db:query "SELECT max_slots FROM moat_inventory WHERE steamid = 'STEAM_0:0:46558052'"
		:start()
end)

moat.sql.mysql = include "system/libs/meepen/sql/sql_mysqloo.lua" (moat.sql.db)
function moat.sql:LastInsertID()
    return "LAST_INSERT_ID()"
end

function moat.sql:qq(str, succ, err)
	self:query(str, false, false)
end

function moat.sql:qf(str, ...)
	local args = {n = select("#", ...), ...}
	return self.mysql:CreateQuery(str, unpack(args, 1, args.n))
end

function moat.sql:query(str, succ, err)
	self.mysql:Query(str, succ, err or function(q, er)
		moat.print("Query Error: " .. tostring(q) .. " | With Query: " .. tostring(str))
    end)
end

function moat.sql:q(str, ...) moat:sqlquery(str, ...) end
function moat:sqlquery(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

	self.mysql:Query(self.mysql:CreateQuery(str, unpack(args, 1, args.n)), succ, err or function(er)
		MOAT_INV.Print("Query Error: " .. er .. " | With Query: " .. str, true)
    end)
end

MOATSQL = moat.sql