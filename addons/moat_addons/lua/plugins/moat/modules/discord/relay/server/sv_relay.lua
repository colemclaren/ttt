include "_config.lua"

if not DiscordRelay then
    Error("Woah, we couldn't find ourselves a config file! If this happens, you should reinstall.")
end

SVDiscordRelay = SVDiscordRelay or {}
SVDiscordRelay.NextRunTime = SVDiscordRelay.NextRunTime or SysTime()
util.AddNetworkString("DiscordRelay_MessageReceived")
util.AddNetworkString("DiscordRelay_YouAreBlacklisted")
--[[Data file locations]]
DiscordRelay.FileLocations = DiscordRelay.FileLocations or {}
DiscordRelay.FileLocations.ReceivedMessages = "discord_relay/recieved_messages.txt"
DiscordRelay.FileLocations.MutedGmodUsers = "discord_relay/muted_gmod_users.txt"
DiscordRelay.FileLocations.MutedDiscordUsers = "discord_relay/muted_discord_users.txt"
DiscordRelay.Self = DiscordRelay.Self or nil

if not file.IsDir("discord_relay/", "DATA") then
    file.CreateDir("discord_relay")
end

for k, v in pairs(DiscordRelay.FileLocations) do
    if not file.Exists(v, "DATA") then
        file.Write(v, util.TableToJSON({}, true))
    end

    DiscordRelay[k] = util.JSONToTable(file.Read(v, "DATA") or "") or {}
end

local errcodes = {
    [50001] = "Your bot cannot read the channel! Please ensure the bot has 'Read Messages' permission for the channel.",
    [50010] = "Your bot hasn't got an account! Please go back and make one!"
}

function SVDiscordRelay.VerifyMessageSuccess(code, body, headers)
    body = util.JSONToTable(body)

    if body then
        if body.code then
            ErrorNoHalt("[ERROR] Discord returned error code " .. body.code .. ": " .. body.message .. "\n")

            if DiscordRelay.DEBUG_MODE then
                print("HTML Code", "Headers")
                print(code, headers)
            end

            if errcodes[body.code] then
                print(errcodes[body.code])
            end

            return false
        else
            return true
        end
    else
        return false
    end
end
/*
function SVDiscordRelay.PlayerSay(ply, text, teamchat)
    --if teamchat then return end -- Don't relay teamchat, as it provides a means of metagame or ghosting.
    if not ply then return end
    if not IsValid(ply) then return end
    if ply:IsBot() then return end

    if DiscordRelay.MutedGmodUsers[ply:SteamID()] then
        return
    end

    http.Fetch("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=" .. DiscordRelay.SteamWebAPIKey .. "&steamids=" .. ply:SteamID64() .. "&format=json", function(body, size, headers, code)
        local response = util.JSONToTable(body).response
        local plyInfo
        local image

        if not response.players[1] then
            image = false
        else
            plyInfo = response.players[1]
            image = plyInfo.avatarfull
        end

        SVDiscordRelay.SendToDiscord(ply, image, text, teamchat)
    end)
end*/

/*
WEAPON_MELEE  = 1
WEAPON_PISTOL = 2
WEAPON_HEAVY  = 3
WEAPON_NADE   = 4
WEAPON_CARRY  = 5
WEAPON_EQUIP1 = 6
WEAPON_EQUIP2 = 7
WEAPON_ROLE   = 8
*/

rarity_names = {
	[0] = { "Stock", Color():SetHex "#606e88", { min = 10, max = 20 } }, 
	[1] = { "Worn", Color():SetHex "#ccccff", { min = 10, max = 20 } }, 
	[2] = { "Standard",  Color():SetHex "#3976f4", { min = 20, max = 40 } }, 
	[3] = { "Specialized", Color():SetHex "#ba33ff", { min = 60, max = 120 } }, 
	[4] = { "Superior", Color():SetHex "#ff00e7", { min = 240, max = 480 } }, 
	[5] = { "High-End", Color():SetHex "#fd0b30", { min = 1200, max = 2400 } }, 
	[6] = { "Ascended", Color():SetHex "#ffe300", { min = 7200, max = 14400 } }, 
	[7] = { "Cosmic", Color():SetHex "#01ff1f", { min = 25200, max = 50400 } }, 
	[8] = { "Extinct", Color():SetHex "#ff8a00", { min = 2, max = 5000 } }, 
	[9] = { "Planetary", Color(0, 0, 0, 255), { min = 25200, max = 50400 } }
}

function m_GetStatMinMax(key, itemtbl)
    local stat_min, stat_max = 0, 0

    if (tostring(key) == "d") then
        stat_min, stat_max = itemtbl.item.Stats.Damage.min, itemtbl.item.Stats.Damage.max
    elseif (tostring(key) == "a") then
        stat_min, stat_max = itemtbl.item.Stats.Accuracy.min, itemtbl.item.Stats.Accuracy.max
    elseif (tostring(key) == "k") then
        stat_min, stat_max = itemtbl.item.Stats.Kick.min, itemtbl.item.Stats.Kick.max
    elseif (tostring(key) == "f") then
        stat_min, stat_max = itemtbl.item.Stats.Firerate.min, itemtbl.item.Stats.Firerate.max
    elseif (tostring(key) == "m") then
        stat_min, stat_max = itemtbl.item.Stats.Magazine.min, itemtbl.item.Stats.Magazine.max
    elseif (tostring(key) == "r") then
        stat_min, stat_max = itemtbl.item.Stats.Range.min, itemtbl.item.Stats.Range.max
    elseif (tostring(key) == "w") then
        stat_min, stat_max = itemtbl.item.Stats.Weight.min, itemtbl.item.Stats.Weight.max
    elseif (tostring(key) == "p") then
        stat_min, stat_max = itemtbl.item.Stats.Pushrate.min, itemtbl.item.Stats.Pushrate.max
    elseif (tostring(key) == "v") then
        stat_min, stat_max = itemtbl.item.Stats.Force.min, itemtbl.item.Stats.Force.max
    elseif (tostring(key) == "y") then
        stat_min, stat_max = itemtbl.item.Stats.Reloadrate.min, itemtbl.item.Stats.Reloadrate.max
    elseif (tostring(key) == "z") then
        stat_min, stat_max = itemtbl.item.Stats.Deployrate.min, itemtbl.item.Stats.Deployrate.max
    elseif (tostring(key) == "c") then
        stat_min, stat_max = itemtbl.item.Stats.Chargerate.min, itemtbl.item.Stats.Chargerate.max
    end

    return stat_min, stat_max
end

local stats_full = {}
stats_full["d"] = "DMG"
stats_full["f"] = "RPM"
stats_full["m"] = "MAG"
stats_full["a"] = "Accuracy"
stats_full["k"] = "Kick"
stats_full["r"] = "Range"
stats_full["w"] = "Weight"
stats_full["x"] = "XP"
stats_full["l"] = "Level"
stats_full["p"] = "Push Delay"
stats_full["v"] = "Push Force"
stats_full["y"] = "Reload"
stats_full["z"] = "Draw"
stats_full["c"] = "Charging Speed"
local m_color_green = Color(40, 255, 40)
local m_color_red = Color(255, 40, 40)
local talents_spacer = 25

function m_DrawItemStatsText(itemtbl)
    local wpntbl = weapons.Get(itemtbl.w)
    local stat_sign = "+"
    local stat_color = m_color_green
    local wpn_dmg = math.Round(wpntbl.Primary.Damage, 1)
    local wpn_rpm = math.Round(60 * (1 / wpntbl.Primary.Delay))
    local wpn_mag = math.Round(wpntbl.Primary.ClipSize)
    local stats_text = "```diff\n"

    if (itemtbl.s) then
        if (itemtbl.s.d) then
            wpn_dmg = math.Round(wpntbl.Primary.Damage * (1 + ((itemtbl.item.Stats.Damage.min + ((itemtbl.item.Stats.Damage.max - itemtbl.item.Stats.Damage.min) * itemtbl.s.d)) / 100)), 1)
        end

        if (itemtbl.s.f) then
            local firerate_mult = 1 - (itemtbl.item.Stats.Firerate.min + (itemtbl.item.Stats.Firerate.max - itemtbl.item.Stats.Firerate.min) * itemtbl.s.f) / 100
            wpn_rpm = math.Round(60 / (firerate_mult * wpntbl.Primary.Delay))
        end

        if (itemtbl.s.m) then
            wpn_mag = math.Round(wpntbl.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * itemtbl.s.m)) / 100)))
        end
    end

    local stat_num = 0
    local small_y = 0
    local stats_y_add = 40
    local stats_y_multi = 25

    if (wpntbl.Primary.NumShots and wpntbl.Primary.NumShots > 1) then
        wpn_dmg = wpn_dmg .. "*" .. wpntbl.Primary.NumShots -- ×
    end

    if (wpn_mag < 1) then
        wpn_mag = "∞"
    end

    if (itemtbl.item.Rarity == 0) then

        stats_text = stats_text .. "DMG: " .. wpn_dmg .. "\n"
        stats_text = stats_text .. "RPM: " .. wpn_rpm .. "\n"
        stats_text = stats_text .. "MAG: " .. wpn_mag .. "\n"

        return stats_text .. "```"
    end

    local default_stats = {"DMG", "RPM", "MAG"}
    local level_stats = {"XP", "Level"}

    for k, v in SortedPairs(default_stats) do
        if (v == "DMG") then
            stats_text = stats_text .. "DMG: " .. wpn_dmg .. "\n"

            if (itemtbl.s.d) then
                stat_min, stat_max = m_GetStatMinMax("d", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.d), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end

                if (stat_num ~= 0) then
                    stats_text = stats_text .. "" .. stat_sign .. stat_num .. "%\n"
                end
            end
        elseif (v == "RPM") then
            stats_text = stats_text .. "RPM: " .. wpn_rpm .. "\n"

            if (itemtbl.s.f) then
                stat_min, stat_max = m_GetStatMinMax("f", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.f), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end

                if (stat_num ~= 0) then
                    stats_text = stats_text .. "" .. stat_sign .. stat_num .. "%\n"
                end
            end
        elseif (v == "MAG") then
            stats_text = stats_text .. "MAG: " .. wpn_mag .. "\n"

            if (itemtbl.s.m) then
                stat_min, stat_max = m_GetStatMinMax("m", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.m), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end

                stat_num = wpn_mag - wpntbl.Primary.ClipSize

                if (stat_num ~= 0) then
                    stats_text = stats_text .. "" .. stat_sign .. stat_num .. "\n"
                end
            end
        end
    end

    local bar_stats = true
    
    for k, v in SortedPairs(itemtbl.s) do
        local stat_min, stat_max = m_GetStatMinMax(k, itemtbl)
        local stat_num = math.Round(stat_min + ((stat_max - stat_min) * v), 1)
        stat_sign = "+"

        if (string.StartWith(tostring(stat_num), "-")) then
            stat_sign = ""
        end

        local stat_str = stats_full[tostring(k)]

        if (not table.HasValue(default_stats, stat_str) and not table.HasValue(level_stats, stat_str)) then
            if (bar_stats) then
                stats_text = stats_text .. "----------" .. "\n"
                bar_stats = false
            end

            stats_text = stats_text .. stat_sign .. stat_num .. "% " .. stat_str .. "\n"
        end
    end

    if (itemtbl.t) then
        local talents_s = "s"
        local num_talents = table.Count(itemtbl.t)

        if (num_talents == 1) then
            talents_s = ""
        end

        stats_text = stats_text .. "----------" .. "\n"
        stats_text = stats_text .. "" .. num_talents .. " Talent" .. talents_s .. "\n"

        local talent_name = ""
        local talent_desc = ""
        local talent_level = 0

        for k, v in ipairs(itemtbl.t) do
            talent_name = itemtbl.Talents[k].Name
            talent_desc = itemtbl.Talents[k].Description
            talent_level = v.l

            stats_text = stats_text .. "----------\n"
            stats_text = stats_text .. talent_name .. " | Level " .. talent_level .. "\n"

            local talent_desctbl = string.Explode("^", talent_desc)

            for i = 1, table.Count(v.m) do
                local mod_num = math.Round(itemtbl.Talents[k].Modifications[i].min + ((itemtbl.Talents[k].Modifications[i].max - itemtbl.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)
                talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
            end

            talent_desc = string.Implode("", talent_desctbl)
            talent_desc = string.Replace(talent_desc, "_", "%")
            
            stats_text = stats_text .. talent_desc .. "." .. "\n"
        end
    end

    return stats_text .. "```"
end

function moat_GetItemStats(tbl, wpnstr)
    local itemtbl = tbl
    local item_str = "----------\n"
    local m_LoadoutTypes = {}
    m_LoadoutTypes[1] = "Melee"
    m_LoadoutTypes[2] = "Secondary"
    m_LoadoutTypes[3] = "Primary"
    
    local ITEM_HOVERED = itemtbl
    
    if (ITEM_HOVERED and ITEM_HOVERED.c) then
        local ITEM_NAME_FULL = GetItemName(tbl)


        item_str = item_str .. "**" .. ITEM_NAME_FULL .. "**"
    end

    if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
        item_str = item_str .. " - LVL **" .. ITEM_HOVERED.s.l .. "** - XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100)
    end

    local RARITY_TEXT = ""

    if (ITEM_HOVERED.item.Kind ~= "tier") then
        RARITY_TEXT = rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. ITEM_HOVERED.item.Kind
    else
        RARITY_TEXT = rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. m_LoadoutTypes[weapons.Get(ITEM_HOVERED.w).Kind]
    end

    item_str = item_str .. "\n"
    item_str = item_str .. "" .. RARITY_TEXT .. ""

    if (ITEM_HOVERED.s and (ITEM_HOVERED.item.Kind == "tier" or ITEM_HOVERED.item.Kind == "Unique" or ITEM_HOVERED.item.Kind == "Melee")) then
        local stat_text = m_DrawItemStatsText(ITEM_HOVERED) or ""
        item_str = item_str .. stat_text
    else
        local item_desc = ITEM_HOVERED.item.Description

        if (ITEM_HOVERED.s) then
            for i = 1, #ITEM_HOVERED.s do
                local item_stat = ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i]))
                item_desc = string.format(item_desc, math.Round(item_stat, 2))
            end
        end

        item_desc = string.Replace(item_desc, "_", "%")

        item_str = item_str .. "\n"
        item_str = item_str .. "```" .. item_desc .. "." .. "```"
    end

    item_str = item_str .. "\n"
    item_str = item_str .. "`From the " .. ITEM_HOVERED.item.Collection .. "`"

    item_str = item_str .. "\n------------------------------"
    return item_str
end

-- util.AddNetworkString("MOAT_CHAT_OBTAINED_VERIFY")

-- net.Receive("MOAT_CHAT_OBTAINED_VERIFY", function(l, pl)
--     if (not pl) then return end
--     if (not pl:IsValid()) then return end
-- 	local nochat = net.ReadBool()
-- 	if (nochat) then return end

--     local str = net.ReadString()
--     local tbl = net.ReadTable()
--     local wpnstr = net.ReadString()

--     SVDiscordRelay.LinkItem(pl, tbl, wpnstr, str)
-- end)

function SVDiscordRelay.LinkItem(ply, tbl, wpnstr, msg)
    if not tbl then return end
    if not ply then return end
    if not IsValid(ply) then return end
    if ply:IsBot() then return end

    if DiscordRelay.MutedGmodUsers[ply:SteamID()] then
        return
    end

    if (msg) then
        text = msg .. "\n"
    end

    text = text .. moat_GetItemStats(tbl, wpnstr) or "Unknown Item"

    discord.Send("Drop", text)
end

function SVDiscordRelay.SendToDiscord(ply, s_image, s_text, teamchat)
    if not ply then return end
    local blocked = false

    for _, v in pairs(DiscordRelay.BlockedCommands) do
        if string.StartWith(s_text, v) then
            blocked = true
        end
    end

    if not (DiscordRelay.WhitelistCommands == nil or DiscordRelay.WhitelistCommands == {} or DiscordRelay.EnableWhitelist == false) then
        blocked = true

        for _, v in pairs(DiscordRelay.WhitelistCommands) do
            if string.StartWith(s_text, v) then
                blocked = false
                s_text = string.TrimLeft(s_text, v)
            end
        end
    end

    if blocked then return end
    local nick = "MoatGaming Bot" --DiscordRelay.ServerPrefix .. " " .. (ply:Nick() or ply:SteamID())

    if string.len(nick) > 32 then
        nick = string.sub(nick, 1, 29) .. "..."
    end

    local t_post = {
        content = s_text,
        username = nick,
        avatar_url = s_image
    }

    local t_struct = {
        failed = function(err)
            MsgC(Color(255, 0, 0), "HTTP error in sending user message to discord: " .. err .. "\n")
        end,
        success = SVDiscordRelay.VerifyMessageSuccess,
        method = "post",
        url = DiscordRelay.WebhookURL,
        parameters = t_post,
        type = "application/json; charset=utf-8" --JSON Request type, because I'm a good boy.
    }

    HTTP(t_struct)
end

function SVDiscordRelay.SendToDiscordRaw(username, avatarurl, message, url)
    message = message:gsub("discord","")
    message = message:gsub("discord.gg","")

    local t_post = {
        content = message,
        username = username or "Unknown",
        avatar_url = s_image
    }

    local t_struct = {
        failed = function(err)
            MsgC(Color(255, 0, 0), "HTTP error in sending raw message to discord: " .. err .. "\n")
        end,
        success = SVDiscordRelay.VerifyMessageSuccess,
        method = "post",
        url = url or DiscordRelay.WebhookURL,
        parameters = t_post,
        type = "application/json; charset=utf-8" --JSON Request type, because I'm a good boy.
    }

    HTTP(t_struct)
end

function SVDiscordRelay.PrintToChat(code, body, headers)
    if not body then return end

    if body == nil then
        MsgC(Color(255, 255, 0), "Non fatal error: No messages retrieved from discord, perhaps a connectivity error is to blame?\n")

        return
    end

    if not SVDiscordRelay.VerifyMessageSuccess(code, body, headers) then return end
    body = util.JSONToTable(body)

    if body.message == "You are being rate limited." then
        SVDiscordRelay.NextRunTime = SysTime() + body.retry_after
        MsgC(Color(255, 0, 0), "Discord error: You are being rate limited. The relay will not check for messages again for another " .. body.retry_after .. " seconds.\n")
        ErrorNoHalt("Discord Rate Limiting Detected. Message retrieval will be disabled for approximately " .. body.retry_after .. " seconds.")
        SVDiscordRelay.SendToDiscord("MoatGaming Bot", false, "The bot is being rate limited! Players on the server will not see your messages for another " .. body.retry_after .. " seconds.")

        return
    end

    for i = DiscordRelay.MaxMessages, 1, -1 do
        local blocked = false
        local gotitalready = false
        if not body[i] then continue end
        if body[i].webhook_id then continue end

        for _, v in pairs(DiscordRelay.BlockedCommands) do
            if string.StartWith(body[i].content, v) then
                blocked = true
            end
        end

        for k, v in pairs(DiscordRelay.ReceivedMessages) do
            if (v.id == body[i].id) or (v.content == body[i].content) then
                gotitalready = true
            end
        end

        if string.len(body[i].content) > 126 then
            if not gotitalready then
                discord.Send("ttt", "Sorry " .. body[i].author.username .. ", but that message was too long and wasn't relayed.")
            end

            table.insert(DiscordRelay.ReceivedMessages, {
                id = body[i].id,
                content = body[i].content,
                author = {
                    id = body[i].author.id,
                    username = body[i].author.username
                }
            })

            file.Write(DiscordRelay.FileLocations.ReceivedMessages, util.TableToJSON(DiscordRelay.ReceivedMessages, true))
            continue
        end

        if body[i].mentions then
            for k, v in pairs(body[i].mentions) do
                local tofind = "(<@!" .. v.id .. ">)"
                local toreplace = "@" .. v.username
                body[i].content = string.gsub(body[i].content, tofind, toreplace, 1)
            end
        end

        if blocked == false and gotitalready == false then
            MsgC(COLOR_DISCORD, "[Discord] ", COLOR_USERNAME, body[i].author.username, COLOR_COLON, ": ", COLOR_MESSAGE, body[i].content, "\n")
            net.Start("DiscordRelay_MessageReceived")
            net.WriteString(body[i].author.username)
            net.WriteString(body[i].content)
            net.Broadcast()

            table.insert(DiscordRelay.ReceivedMessages, {
                id = body[i].id,
                content = body[i].content,
                author = {
                    id = body[i].author.id,
                    username = body[i].author.username
                }
            })

            file.Write(DiscordRelay.FileLocations.ReceivedMessages, util.TableToJSON(DiscordRelay.ReceivedMessages, true))
        end
    end
end

function SVDiscordRelay.GetMessages()
    if SysTime() < SVDiscordRelay.NextRunTime then return end

    if not DiscordRelay.BotToken or DiscordRelay.BotToken == "CHANGE ME" then
        Error("Invalid Bot Token!")
    end

    if not DiscordRelay.DiscordChannelID or DiscordRelay.DiscordChannelID == "CHANGE ME" then
        Error("Invalid Channel ID.")
    end

    local t_struct = {
        failed = function(err)
            MsgC(Color(255, 0, 0), "HTTP error at line 256: " .. err .. "\n")
        end,
        success = SVDiscordRelay.PrintToChat,
        url = "http://ptb.discordapp.com/api/channels/" .. DiscordRelay.DiscordChannelID .. "/messages",
        method = "get",
        headers = {
            Authorization = "Bot " .. DiscordRelay.BotToken
        }
    }

    HTTP(t_struct)
end
/*
function SVDiscordRelay.AnnounceConnect(ply)
    if not ply then return end
    if not IsValid(ply) then return end
    if ply:IsBot() then return end
    local name = ply:Name() or "Unknown player"
    local steamid = ply:SteamID() or "unknown"
    local msg = DiscordRelay.OverrideConnectMessage

    if not msg or msg == "" then
        msg = "{username} ({steamid}) has joined {hostname}! Join at {steamconnect}{ipaddress}"
    end

    msg = string.Replace(msg, "{username}", name)
    msg = string.Replace(msg, "{steamid}", steamid)
    msg = string.Replace(msg, "{hostname}", GetHostName())
    msg = string.Replace(msg, "{ipaddress}", game.GetIPAddress())
    msg = string.Replace(msg, "{steamconnect}", "steam://connect/")

    if DiscordRelay.AnnounceConnect then
        SVDiscordRelay.SendToDiscordRaw("MoatGaming Bot", false, msg)
    end
end

hook.Add("PlayerInitialSpawn", "Discord_Player_Connect", SVDiscordRelay.AnnounceConnect)*/
/*
function SVDiscordRelay.AnnounceDisconnect(ply)
    if not ply then return end
    if not IsValid(ply) then return end
    if ply:IsBot() then return end
    --local name = ply:Name() or "Unknown player"
    local name = ply.SteamName and ply:SteamName() or ply:Name() or "Unknown player"
    local steamid = ply:SteamID() or "unknown"
    local msg = DiscordRelay.OverrideDisconnectMessage

    if not msg or msg == "" then
        msg = "{username} ({steamid}) has left {hostname}! Join at {steamconnect}{ipaddress}"
    end

    msg = string.Replace(msg, "{username}", name)
    msg = string.Replace(msg, "{steamid}", steamid)
    msg = string.Replace(msg, "{hostname}", GetHostName())
    msg = string.Replace(msg, "{ipaddress}", game.GetIPAddress())
    msg = string.Replace(msg, "{steamconnect}", "steam://connect/")

    if DiscordRelay.AnnounceDisconnect then
        SVDiscordRelay.SendToDiscordRaw("MoatGaming Bot", false, msg)
    end
end

hook.Add("PlayerDisconnected", "Discord_Player_Disconnect", SVDiscordRelay.AnnounceDisconnect)*/

/*
hook.Add("Think", "Discord_Check_Messages", function()
    if SysTime() >= SVDiscordRelay.NextRunTime then
        SVDiscordRelay.GetMessages()
        SVDiscordRelay.NextRunTime = SysTime() + DiscordRelay.MessageDelay
    end
end)*/

hook.Add("InitPostEntity", "CreateAFuckingBot", function()
    if DiscordRelay.AvoidUsingBots == false then
        print("Adding a bot to kick things off")
        game.ConsoleCommand("bot\n")

        for k, v in pairs(player.GetBots()) do
            v:Kick("Thanks for helping us out bot!")
        end
    else
        print("Attempting to force sv_hibernate_think to 1. Don't blame me for this!")
        game.ConsoleCommand("sv_hibernate_think 1\n")
    end

    hook.Remove("CreateAFuckingBot")
end)
--This script is version 1.2.8 (Hotfix 3) and is free!