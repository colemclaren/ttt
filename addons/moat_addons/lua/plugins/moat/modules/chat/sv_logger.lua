CHAT_LOGGER = CHAT_LOGGER or {}
CHAT_LOGGER.SQL = CHAT_LOGGER.SQL or {}
CHAT_LOGGER.Backups = CHAT_LOGGER.Backups or {}
local SQL = CHAT_LOGGER.SQL
local function Query_Error(q, err, sql)
    print("error on query `"..sql.."`: "..err)
end

local function Insert(log)
    if (SQL.connected) then
        local db = CHAT_LOGGER.DB
        local q = db:query("INSERT INTO server_site_data.chat_log (time, steam_id, message, server) VALUES ("..log.time..", "..db:escape(log.authorid64)..", \""..db:escape(log.message).."\", \""..db:escape(game.GetIP()).."\");");
        q.onError = Query_Error
        q:start()
    else
        table.insert(CHAT_LOGGER.Backups, log)
    end
end

hook("SQLConnected", function(db)
	CHAT_LOGGER.DB = db
	SERVER_SITE_DATA = db

	SQL.connected = true
	for _, log in ipairs(CHAT_LOGGER.Backups) do
		Insert(log)
    end

	CHAT_LOGGER.Backups = {}
end)

hook("SQLConnectionFailed", function(db, err)
	SQL.connected = false
end)

hook.Add("PlayerSay", "chat.log", function(author, text, teamchat)
    Insert {
        time = os.time(),
        authorid64 = author:SteamID64(),
        message = (teamchat and "(TEAM) " or "")..text,
        name = author:Nick()
    }
end)