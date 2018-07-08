require "mysqloo"

MOATSQL = MOATSQL or {}
MOATSQL = mysqloo.connect(moat.cfg.sql.host, moat.cfg.sql.username, moat.cfg.sql.password, moat.cfg.sql.database, moat.cfg.sql.port)
MOATSQL.onConnected = function(db)
	if (db.setCharacterSet) then
		db:setCharacterSet "utf8mb4"
	end

	hook.Run("SQLConnected", db)
end
MOATSQL.onConnectionFailed = function(db, err) hook.Run("SQLConnectionFailed", db, err) end
MOATSQL:connect()

timer.Create("moat_sql_no_disconnecto", 180, 0, function()
    local q = MOATSQL:query("SELECT max_slots FROM moat_inventory WHERE steamid = 'STEAM_0:0:46558052'")
    q:start()
end)