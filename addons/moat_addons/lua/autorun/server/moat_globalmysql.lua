require "mysqloo"

MOATSQL = MOATSQL or {}
MOATSQL.Config = {
	host = "gamedb.moat.gg",
	database = "forum",
	username = "moat",
	password = "Cox81#iVdeyiL#uH#4N8k^Q!Tk0TNYtY",
	port = 3306
}

MOATSQL = mysqloo.connect(MOATSQL.Config.host, MOATSQL.Config.username, MOATSQL.Config.password, MOATSQL.Config.database, MOATSQL.Config.port)
MOATSQL.onConnected = function(db) hook.Run("SQLConnected", db) end
MOATSQL.onConnectionFailed = function(db, err) hook.Run("SQLConnectionFailed", db, err) end
MOATSQL:connect()

