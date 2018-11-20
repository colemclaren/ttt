require "mysqloo"

CHAT_LOGGER = CHAT_LOGGER or {
    Backups = {}
}
CHAT_LOGGER.SQL = CHAT_LOGGER.SQL or {
    Config = {
        database = "server_site_data",
        host = "gamedb.moat.gg",
        port = 3306,
        user = "ttt",
        pass = "wP$EDteT2U0akLV0Jf%&"
    }
}

local SQL = CHAT_LOGGER.SQL

local function Query_Error(q, err, sql)
    print("error on query `"..sql.."`: "..err)
end

local function Insert(log)
    if (SQL.connected) then
        local db = CHAT_LOGGER.DB
        local q = db:query("INSERT INTO `chat_log` (`time`, `steam_id`, `message`, `server`) VALUES ("..log.time..", "..db:escape(log.authorid64)..", \""..db:escape(log.message).."\", \""..db:escape(game.GetIP()).."\");");
        q.onError = Query_Error
        q:start()
    else
        table.insert(CHAT_LOGGER.Backups, log)
    end
end

if (not CHAT_LOGGER.DB) then
    local db = mysqloo.connect(SQL.Config.host, SQL.Config.user, SQL.Config.pass, SQL.Config.database, SQL.Config.port)

    CHAT_LOGGER.DB = db

    SERVER_SITE_DATA = db

    db:connect()

    function db:onConnectionFailed(err)
        SQL.connected = false
        print("Lost connection to chat logger database: "..err)
        timer.Simple(1, function()
            print "Reconnecting chat logger..."
            db:connect()
        end)
    end

    function db:onConnected()
        SQL.connected = true
        for _, log in ipairs(CHAT_LOGGER.Backups) do
            Insert(log);
        end
        CHAT_LOGGER.Backups = {}
    end
end

hook.Add("PlayerSay", "chat.log", function(author, text, teamchat)
    Insert {
        time = os.time(),
        authorid64 = author:SteamID64(),
        message = (teamchat and "(TEAM) " or "")..text,
        name = author:Nick()
    }
end)