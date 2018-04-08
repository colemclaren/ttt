require("mysqloo")

util.AddNetworkString("discord.OAuth")

discord = {}
discord.clientID = "430843529510649897"
discord.clientSecret = "RGv7dtTRQt0TJAeBuy4GmE6IMH2oM5aQ"
discord.botToken = "NDMyMjg2MjU3NTMyNjMzMDk5.DarFxg.0BQ-eCKMMHnAXv2iTDMu03wCrQw"
discord.botClientID = "432286257532633099"
discord.botClientSecret = "i696pb2jZgFGY5ZhJ_-CkO0qs86BPeb_"
discord.users = {}

/*
[3:02 PM] meharryp: then get an access token
[3:02 PM] meharryp: for the client you want to invite
[3:02 PM] meharryp: put it in the body of the request
[3:02 PM] meharryp: and itll force them in
*/
local function AuthedGet(bearer,url,succ,fail)
    HTTP({
        method = "GET",
        url = "http://discordapp.com/api/v6" .. url,
        headers = {
            ["Authorization"] = "Bearer " .. bearer
        },
        
        success = function(status, body,headers)
            succ(status,body)
            
        end,
        failed = function(err)
            print("Failed api",err)
        end,
    })
end
util.AddNetworkString("AmIDiscord")

function discord_()

    local db = MINVENTORY_MYSQL

    net.Receive("AmIDiscord",function(l,ply)
        if ply.Discorded then return end
        ply.Discorded = true
        local sid = ply:SteamID64()
        local q = db:query("SELECT * FROM moat_discord WHERE steamid = '" .. sid .. "';")
        function q:onSuccess(d)
            if #d < 1 then
                net.Start("AmIDiscord")
                net.WriteBool(false)
                net.Send(ply)
            else
                net.Start("AmIDiscord")
                net.WriteBool(true)
                net.Send(ply)
            end
        end
        q:start()
    end)

    local q = db:query("CREATE TABLE IF NOT EXISTS `moat_discord` ( `steamid` varchar(255) NOT NULL, `oauth` TEXT NOT NULL, PRIMARY KEY (steamid) ) ENGINE=MyISAM DEFAULT CHARSET=latin1;")
    q:start()

    net.Receive("discord.OAuth",function(l,ply)
        if (ply.DiscordCool or 0) > CurTime() then return end
        ply.DiscordCool = CurTime() + 10
        local sid = ply:SteamID64()
        local oauth = net.ReadString()
        discord.users[sid] = {
            oauth = oauth
        }
        HTTP({
            method = "POST",
            url = "https://discordapp.com/api/v6/oauth2/token",
            parameters = {
                client_id = discord.botClientID,
                client_secret = discord.botClientSecret,
                code = oauth,
                grant_type = "authorization_code",
                redirect_uri = "http://localhost/"
            },

            success = function(s,body)
                print("Succ",s,body)
                if s == 200 then
                    body = util.JSONToTable(body)
                    discord.users[ply:SteamID64()].bearer = body.access_token
                    print("Got bearer token for " .. ply:Nick() .. ": " .. body.access_token)
                    local token = body.access_token
                    AuthedGet(token,"/users/@me",function(code,body)
                        if code == 200 then
                            body = util.JSONToTable(body)
                            discord.users[sid].user = body
                            print("Got user info for " .. ply:Nick() .. " :: " .. body.username .. "#" .. body.discriminator)
                            --/guilds/{guild.id}/members/{user.id}
                            local id = body.id
                            HTTP({
                                method = "PUT",
                                url = "https://discordapp.com/api/v6/guilds/256324969842081793/members/" .. body.id,
                                headers = {
                                    ["Authorization"] = "Bot " .. discord.botToken
                                },
                                type = "application/json",
                                body = util.TableToJSON({
                                    ["access_token"] = token
                                }),

                                success = function(s,body)
                                    local sid = ply:SteamID64()
                                    local q = db:query("SELECT * FROM moat_discord WHERE steamid = '" .. sid .. "';")
                                    function q:onSuccess(d)
                                        if #d < 1 then
                                            local b = db:query("INSERT INTO moat_discord (steamid,oauth) VALUES ('" .. sid .. "', '" .. db:escape(oauth) .. "');")
                                            b:start()
                                            if IsValid(ply) then
                                                net.Start("discord.OAuth")
                                                net.WriteEntity(ply)
                                                net.Broadcast()
                                            end
                                            if s == 201 then
                                                print(ply:Nick() .. " Joined discord ")
                                            elseif s == 204 then
                                                print(ply:Nick() .. " was already in the discord")
                                            end
                                            ply:m_GiveIC(3000)
                                        else
                                            ply:SendLua([[chat.AddText(Color(255,0,0),"You already got a reward for joining the discord!")]]);
                                        end
                                    end
                                    q:start()

                                end,
                                failed = print,
                            })
                        end
                    end)
                end
            end,
            failed = function(...)
                print("Failed",...)
            end,
        })
    end)
end

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        discord_()
    end
end

hook.Add("InitPostEntity","Discord",function()
    if not c() then 
        timer.Create("CheckDiscord",1,0,function()
            if c() then
                discord_()
                timer.Destroy("CheckDiscord")
            end
        end)
    else
        discord_()
    end

end)


local DBD = {
    host = "mgweb.site.nfoservers.com",
    port = 3306,
    name = "mgweb_inv",
    user = "mgweb",
    pass = "mpWaeSEauo",
    connected = false
}

MOAT_TITLES = MOAT_TITLES or {}
local mdb

function MOAT_TITLES.Escape(str)

    return mdb:escape(tostring(str))
end

function MOAT_TITLES.Query(str, suc, err)
    if (not DBD.connected) then return end
  
    local dbq = mdb:query(str)

    if (suc) then
        function dbq:onSuccess(data)
            suc(data)
        end
    end

    function dbq:onError(er)
        ServerLog(er)
    end

    dbq:start()
end
/*
function MOAT_TITLES.InitializeMySQL()
    mdb = mysqloo.connect(DBD.host, DBD.user, DBD.pass, DBD.name, DBD.port)

    mdb.onConnected = function()
        DBD.connected = true
        print("Titles connected to database.")
        MOAT_TITLES.Query("CREATE TABLE IF NOT EXISTS titles (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, title TEXT NOT NULL, color TEXT NOT NULL, changerid VARCHAR(30) NOT NULL)")
	end

    mdb.onConnectionFailed = function()
        print("Titles failed to connect to the database.")
        DBD.connected = false
    end

    mdb:connect()
end
*/
hook.Add("SQLConnected", "TitlesSQL", function(db)
    mdb = db
    DBD.connected = true
    print("Titles connected to database.")
    MOAT_TITLES.Query("CREATE TABLE IF NOT EXISTS titles (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, title TEXT NOT NULL, color TEXT NOT NULL, changerid VARCHAR(30) NOT NULL)")
end)

hook.Add("SQLConnectionFailed", "TitlesSQL", function(db, err)
    print("Titles failed to connect to the database.")
    DBD.connected = false
end)

--MOAT_TITLES.InitializeMySQL()


util.AddNetworkString("MoatTitlesChange")
util.AddNetworkString("MoatTitleChatPrint")
util.AddNetworkString("MoatLoadTitle")

function MOAT_TITLES.ChatPrint(failure, ply, str)
	net.Start("MoatTitleChatPrint")
	net.WriteBool(failure)
	net.WriteString(str)
	net.Send(ply)
end

MOAT_TITLES.Players = {}

function MOAT_TITLES.LoadTitle(ply, str, clr, chngr)
	local colr = util.JSONToTable(clr)
	local dacolor = Color(colr[1], colr[2], colr[3])

	MOAT_TITLES.Players[ply] = {
		title = str,
		color = dacolor,
		changer = chngr
	}

	ply:SetNW2String("MoatTitlesTitle", MOAT_TITLES.Players[ply].title)
	ply:SetNW2Int("MoatTitlesTitleR", tonumber(colr[1]))
	ply:SetNW2Int("MoatTitlesTitleG", tonumber(colr[2]))
	ply:SetNW2Int("MoatTitlesTitleB", tonumber(colr[3]))
end

function MOAT_TITLES.LoadAllTitles(ply)
	for k, v in pairs(MOAT_TITLES.Players) do
		if (not k:IsValid()) then continue end

		net.Start("MoatLoadTitle")
		net.WriteEntity(k)
		net.WriteString(v.title)
		net.WriteColor(v.color)
		net.WriteString(v.changer)
		net.Send(ply)
	end
end

function MOAT_TITLES.UpdateTitle(ply, otherply, steamid, title, color, titleprice)
	local col = {math.Clamp(math.Round(color.r, 0), 0, 255), math.Clamp(math.Round(color.g, 0), 0, 255), math.Clamp(math.Round(color.b, 0), 0, 255)}

    MOAT_TITLES.Query(string.format("UPDATE titles SET title = '%s', color = '%s', changerid = %s WHERE steamid = %s", MOAT_TITLES.Escape(title), MOAT_TITLES.Escape(util.TableToJSON(col)), ply:SteamID64(), steamid))

	otherply:SetNW2String("MoatTitlesTitle", title)
	otherply:SetNW2Int("MoatTitlesTitleR", tonumber(color.r))
	otherply:SetNW2Int("MoatTitlesTitleG", tonumber(color.g))
	otherply:SetNW2Int("MoatTitlesTitleB", tonumber(color.b))

	MOAT_TITLES.ChatPrint(false, ply, "Successfully changed " .. otherply:Nick() .. "'s title!")

	ply:m_TakeIC(titleprice)
end

net.Receive("MoatTitlesChange", function(len, ply)
	local id = net.ReadString()
	local title = net.ReadString()
	local col = net.ReadColor()

	local titleprice = 15000
	local otherply = player.GetBySteamID64(id)

	if (id ~= ply:SteamID64()) then
		titleprice = 50000
	end

	if (not otherply) then
		MOAT_TITLES.ChatPrint(true, ply, "Unable to find other player to change title for.")

		return
	end

    if (not ply:m_HasIC(titleprice) or (id == "76561198053381832" and ply ~= otherply) or title:len() > 30) then
    	if (title:len() > 30) then
    		MOAT_TITLES.ChatPrint(true, ply, "That title is too long! Max characters allowed is 30.")
    	elseif (id == "76561198053381832" and ply ~= otherply) then
    		MOAT_TITLES.ChatPrint(true, ply, "You're not allowed to change Moat's title.")
    	elseif (titleprice == 50000) then
    		MOAT_TITLES.ChatPrint(true, ply, "You don't have enough IC to change " .. otherply:Nick() .."'s' title!")
    	else
    		MOAT_TITLES.ChatPrint(true, ply, "You don't have enough IC to change your own title!")
        end

        return
    end

    MOAT_TITLES.UpdateTitle(ply, otherply, id, title, col, titleprice)
end)


function MOAT_TITLES.InitializePlayer(ply)
    if (not ply:SteamID64()) then return end
    
    MOAT_TITLES.Query(string.format("SELECT * FROM titles WHERE steamid = %s", ply:SteamID64()), function(data)
        if (#data > 0) then
            local row = data[1]
            local str = row["title"]
            if (#str > 1) then
            	MOAT_TITLES.LoadTitle(ply, str, row["color"], row["changerid"])
            end
        else
        	MOAT_TITLES.Query(string.format("INSERT INTO titles (steamid, title, color, changerid) VALUES(%s, '%s', '%s', %s)", ply:SteamID64(), MOAT_TITLES.Escape(""), MOAT_TITLES.Escape(""), ply:SteamID64()))
        end
    end)
end
hook.Add("PlayerInitialSpawn", "MoatTitles Initialize Player", MOAT_TITLES.InitializePlayer)


-- TTS By velkon (Autorefresh)

util.AddNetworkString("Moat.TTS")
local price = 100
local function send(txt,alive)
    if not alive then
        net.Start("Moat.TTS")
        net.WriteString(txt)
        net.Broadcast()
		BroadcastLua([[chat.AddText(Color(255,0,0),"You can disable TTS in the inventory settings!")]])
    else
        for k,v in pairs(player.GetAll()) do
            if (v:IsSpec() == alive) then

                net.Start("Moat.TTS")
                net.WriteString(txt)
                net.Send(v)
				v:SendLua([[chat.AddText(Color(255,0,0),"You can disable TTS in the inventory settings!")]])
            end
        end
    end
end
function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) if c == "&" then return "&" end return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end
function annoyingchar(s)
    return not s:lower():match("[abcdefghijklmnopqrstuvwxyz1234567890%!%?%.%,]")
end

function noncancer(str)
	local s = ""
	local r = 0
	local last_c = ""
	for i = 1,#str do
		local c = string.GetChar(str, i):lower()
        if (c == " ") then s = s .. c continue end
		if (c == last_c) or annoyingchar(c) then
			r = r + 1
		elseif (c ~= last_c) or (not annoyingchar(c)) then 
			r = 1
		end
		last_c = c
		if r < 4 then
			s = s .. c
		end
	end
	return s
end

local cool = {}--s
net.Receive("Moat.TTS",function(l,ply)
    if (cool[ply] or 0) > CurTime() then
        ply:SendLua([[chat.AddText(Color(255,0,0),"You are on cooldown from TTS! ]] .. string.NiceTime(cool[ply] - CurTime()) .. [[ left.")]])
    return end
    cool[ply] = CurTime() + 60
    local txt = net.ReadString()
    if #txt < 1 then return end
    local otxt = txt
    local ic = #txt * price
    txt = noncancer(txt) -- PepeLaugh
    if not ply:m_HasIC(ic) then ply:SendLua([[chat.AddText(Color(255,0,0),"You do not have enough IC!")]]) return end
    ply:m_TakeIC(ic)
    local alive = ply:IsSpec()
    http.Fetch("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=" .. urlencode(txt) .. "&tl=en",function(_,_,_,c)
        if tostring(c):match("^2") then -- 200 OK
            send(urlencode(txt),alive)
            ply:ConCommand("say [TTS] " .. otxt)
			local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") Used TTS Success: " .. otxt
			SVDiscordRelay.SendToDiscordRaw("Generic bot",false,msg,"https://discordapp.com/api/webhooks/381964496136306688/d-s9h8MLL6Xbxa7XLdh9q1I1IAcJ3cniQAXnZczqFT0wLsc3PypyO6fMNlrtxV3C4hUK")
        else
           ply:SendLua([[chat.AddText(Color(255,0,0),"There was an error with the TTS and your IC was returned. (]] .. c .. [[)")]]) 
           ply:m_GiveIC(ic)
        end
    end,function(err)
        ply:SendLua([[chat.AddText(Color(255,0,0),"There was an error with the TTS and your IC was returned.")]]) 
        ply:m_GiveIC(ic)
    end)
end)