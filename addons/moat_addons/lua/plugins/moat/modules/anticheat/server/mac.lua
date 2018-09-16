util.AddNetworkString "moat.verify"

local hate_list = {
    "nigger",
    "faggot"
}

local replace_list = {}

function contains_hateful(s)
    for k,v in ipairs(hate_list) do
        if s:lower():match(v:lower()) then
            return true, k
        end
    end
    return false
end

local cached_toxic = {}
local cached_err = {}
function perspective_post(nick,sid,message,ply)
    -- testing if this gets rate limited or something since it doesn't even seem to check sessionID (?)
    -- I applied for api key anyways
    if #message < 10 then return end
    if cached_toxic[message] then return end -- avoid short term spam
    cached_toxic[message] = true
    if message:match("^[!/]") then return end -- comman d
    HTTP({
        method = "POST",
        url = "https://www.perspectiveapi.com/check",
        headers = {
            ["path"]="/check",
            ["origin"]="https://www.perspectiveapi.com",
            ["accept-encoding"]="gzip, deflate, br",
            ["accept-language"]="en-GB,en-US;q=0.9,en;q=0.8",
            ["user-agent"]="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36",
            ["accept"]="application/json, text/plain, */*",
            ["referer"]="https://www.perspectiveapi.com/",
            ["authority"]="www.perspectiveapi.com",
            ["scheme"]="https",
            ["method"]="POST"
        },
        body = util.TableToJSON({
            comment = message,
            sessionId = "",
            languages = {"en"}
        }),
        type = "application/json",
        success = function (code,body)
            message = message:gsub("*","\\*")
            if code == 200 then
                local t = (util.JSONToTable(body))
                local v = t.attributeScores.TOXICITY.summaryScore.value
                if v > 0.95 then
                    discord.Send("Toxic","**[" .. math.Round(v * 100, 2) .. "%]** {" .. (Server and Server.Name or GetHostName()) .. "} (" .. sid .. ") " .. nick .. ": **" .. message .. "**")
                elseif v > 0.875 then
                    discord.Send("Toxic","**[" .. math.Round(v * 100, 2) .. "%]** {" .. (Server and Server.Name or GetHostName()) .. "} (" .. sid .. ") " .. nick .. ": " .. message)
                else
                    if (Server and Server.IsDev) then
                        print("[" .. math.Round(v * 100, 2) .. "% toxic] (" .. sid .. ") " .. nick .. ": " .. message)
                    end
                end
            elseif (not body:match("does not support request languages")) then
                discord.Send("Developer","[Error] (" .. sid .. ") `" .. GetHostName() .. "`: Got other code: `" .. code .. "," .. body .. ",(" .. message ..")`")
            end
        end,
        failed = function(s)
            if cached_err[s] then return end
            cached_err[s] = true
            discord.Send("Developer","[Error] (" .. sid .. ") `" .. GetHostName() .. "`: Got error: `" .. s .. "`")
        end
    })
end

hook.Add("PlayerInitialSpawn","Automatic Hate kicking",function(ply)
    local h, i = contains_hateful(ply:Nick())
    if h then
        RunConsoleCommand("mga","kick",ply:SteamID(),"Change your name to be more friendly [" .. i .. "]")
    end
end)

hook.Add("PlayerSay","Automatic Hateful Conduct Ban",function(ply,txt)
    local h,i = contains_hateful(txt)
    perspective_post(ply:Nick(),ply:SteamID(),txt,ply)
end)


local detection_reasons = {
    [1] = "Aimware",
    [2] = "Scripthook",
    [3] = "Lua Detours",
    [4] = "sv_allowcslua",
    [5] = "sv_cheats",
    [6] = "Scripthook",
    [7] = "Lenny Scripts",
    [8] = "host_timescale",
    [9] = "mat_wireframe",
    [10] = "mat_fullbright",
    [11] = "pHack",
    [12] = "mApex",
    [13] = "Sasha Hack",
    [14] = "snixzz",
    [15] = "gmcl_external",
    [16] = "Aspire Menu",
    [17] = "cdriza scripts",
    [18] = "xHack",
    [19] = "Invalid Commands",
    [20] = "Invalid Hooks",
    [21] = "gDaap",
    [22] = "SmegHack"
}

local detections_ac = {}

local function discordLog(sid, mouse)
	local msg = "[Anti Cheat] Detected: `" .. mouse[1] .. " (" .. sid .. ") [" .. mouse[2] .. "] lvl(" .. mouse[3] .. ")` { http://steamcommunity.com/profiles/" .. mouse[4] .. " } Server: " .. game.GetIP() .. " Detections: `" .. mouse[5] .. "`"
	discord.Send("Skid", msg)
end

hook.Add("TTTEndRound","anti.cheat.end.round",function()
    local i = 0
    for k, v in pairs(detections_ac) do
        i = i + 1
        timer.Simple(i, function() discordLog(k, v) end)
        RunConsoleCommand("mga","perma",k,"Cheating")
    end
    detections_ac = {}
end)

local function detect(pl, reason)
    if (pl.Detected) then return end
    pl.Detected = true

    if (not detections_ac[pl:SteamID()]) then
        detections_ac[pl:SteamID()] = {
            pl:Nick(),
            pl:IPAddress(),
            pl:GetNWInt("MOAT_STATS_LVL", -1),
            pl:SteamID64(),
            reason
        }
    end
end

local dev_server = GetHostName():lower():find("dev")
net.Receive("moat.verify", function(_, pl)
    if (dev_server or pl:IsUserGroup("communitylead")) then return end

    local dets = net.ReadTable()
    local reason = "Cheating: "
    local steamid = pl:SteamID()

    for k, v in pairs(dets) do
        if (not detection_reasons[v]) then
            RunConsoleCommand("mga", "perma", steamid, "Cheating")

            return
        else
            reason = reason .. detection_reasons[v] .. (k == #dets and " " or ", ")
        end
    end

    if (not pl.v_snapped) then
        net.Start "moat-ab"
		net.Send(pl)
        pl.snapper = "clua"
        pl.v_snapped = true
    end

    detect(pl, reason)
end)

ents.Created({["lua_run"] = true}, false, false, function(ent, class)
	function ent:AcceptInput() return true end
	timer.Tick(function()
		ent:Remove()
	end)
end)