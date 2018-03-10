require("mysqloo")

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
    if (not DBD.onConnected) then return end
    
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

MOAT_TITLES.InitializeMySQL()


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