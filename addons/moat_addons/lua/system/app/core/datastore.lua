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

local function ReplaceQuery(db)
	if (not db.query_internal) then
		db.query_internal = db.query
	end

	function db:query(sql)
		moat.sql.db.query_queued = true
		return self:query_internal(sql)
	end
end

moat.sql.db.onConnected = function(db)
	ReplaceQuery(db)

	if (not moat.sql.db.query_queued and db.setCharacterSet) then
		db:setCharacterSet "utf8mb4"
	else
		moat.print "sql query queued before charset" 
	end

	moat.print("sql connected")
	hook.Run("SQLConnected", db)
end
moat.sql.db.onConnectionFailed = function(db, err)
	moat.sql.db.query_queued = false
	moat.print("sql failed", db, err)
	hook.Run("SQLConnectionFailed", db, err)
end

if (not moat.sql.db.status or (moat.sql.db.status and moat.sql.db:status() == mysqloo.DATABASE_NOT_CONNECTED)) then
	ReplaceQuery(moat.sql.db)
	moat.sql.db:connect()
end

hook("InitPostEntity", function()
	timer.Create("moat.sql.reconnect", 5, 0, function()
		if (not moat.sql.db.status or (moat.sql.db.status and moat.sql.db:status() == mysqloo.DATABASE_NOT_CONNECTED)) then
			ReplaceQuery(moat.sql.db)
			moat.sql.db:connect()

			return
		end
	end)

	timer.Create("moat.sql.no.disconnecto", 60, 0, function()
		moat.sql.db:query "SELECT active FROM `moat_mapvote_prevent`"
			:start()
	end)
end)

moat.sql.mysql = moat.apps.sql "mysqloo.lua" (moat.sql.db)
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

function Db(str, ...) moat:sqlquery(str, ...) end
function MySQL(str, ...) moat:sqlquery(str, ...) end
function moat.sql:q(str, ...) moat:sqlquery(str, ...) end
function moat.mysql(str, ...) moat:sqlquery(str, ...) end
function moat:sqlquery(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

	self.sql.mysql:Query(self.sql.mysql:CreateQuery(str, unpack(args, 1, args.n)), succ, err or function(er)
		moat.print("Query Error: " .. er .. " | With Query: " .. str, true)
    end)
end

MOATSQL = moat.sql