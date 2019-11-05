-- todo replace relay
moat.cfg.webhook = "http://208.103.169.40:5069/"
moat.cfg.oldwebhook = "http://107.191.51.43:3000/"

moat.cfg.discord = {
    primarywebhook = "https://discord.moat.gg/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX"
}

discord.AddChannels {
	["ttt-tv"] = "https://discord.moat.gg/api/webhooks/628066763120312330/PuDhImUK45r2_-Tz_xPFLezjr_gbLhzvxYWNTMVno9xDSORlaD1qy7f6HRst9XWscM1l",
	["general"] = "https://discord.moat.gg/api/webhooks/628066763120312330/PuDhImUK45r2_-Tz_xPFLezjr_gbLhzvxYWNTMVno9xDSORlaD1qy7f6HRst9XWscM1l",
	["ttt-bot"] = "https://discord.moat.gg/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX",
	["ttt-challenges"] = "https://discord.moat.gg/api/webhooks/406539243909939200/6Uhyh9_8adif0a5G-Yp06I-SLhIjd3gUzFA_QHzCViBlrLYcoqi4XpFIstLaQSal93OD",
	["ttt-logs"] = "https://discord.moat.gg/api/webhooks/636315826747736072/8bTGqROpkRkOKVcmWq9WuqUZngjiHHURgb8CZbn48vG942_lL3ZFOxXkpeK-9HMhdn0T",
    ["staff-logs"] = "https://discord.moat.gg/api/webhooks/636315826747736072/8bTGqROpkRkOKVcmWq9WuqUZngjiHHURgb8CZbn48vG942_lL3ZFOxXkpeK-9HMhdn0T",
    ["boss-logs"] = "https://discord.moat.gg/api/webhooks/636321510767984650/AwZU8BYMhpmpRZjLN7qHCTaIYJeHtSeLmVpb9ELlyPxmdFLI2ZI0Gg4kdUlgCFuLjRsA",
    ["error-logs"] = "https://discord.moat.gg/api/webhooks/636321827505045504/SHp4d17SAAYBei1yBFSCQMBD9ILn4o5DL2bcegqRCFoXtY7avK8Ble9Au-c0tRWDEWOj",
    ["testing"] = "https://discord.moat.gg/api/webhooks/473470257940529164/yfdjULAY0_5_fyLODicLr89ICPFoJ3hRT9U3jqt5AvbMN-_ffnwUUiV5OwY6KUeHXcsX",
    ["dev-logs"] = "https://discord.moat.gg/api/webhooks/636321510767984650/AwZU8BYMhpmpRZjLN7qHCTaIYJeHtSeLmVpb9ELlyPxmdFLI2ZI0Gg4kdUlgCFuLjRsA",
    ["old-staff"] = "https://discord.moat.gg/api/webhooks/490027008752091156/kR9l43iXJDfO0E_WPJ0BqRuj2xS-vPD8hmjmfH8--kO9goiBnO430Pmzu3dJ-xqjLmJD",
	["mga-logs"] = "https://discord.moat.gg/api/webhooks/636523537305174037/WYYl81aJRnggRD7UIgWa_I00GOduF3c2eR38McnFrkgiSQQswAZQ1b3BzFzpbWp6hZF4",
	["toxic-logs"] = "https://discord.moat.gg/api/webhooks/636321752406032405/AEip4WNm-2b25Rb2G2K-azi5wXHzULSgFqZmzECPK7Wnm5f5EGaXlswi89f1j7bdsHg7",
    ["error-logs-sv"] = "https://discord.moat.gg/api/webhooks/636322774029434880/E5Fcigi7mdpTmWO8ANhXHci_ftVJNZsCwtuWTRlMzII5iIPEFpesAVTUdZ_PvicUmi4v",
    ["server-list"] = "https://discord.moat.gg/api/webhooks/568878605028032544/aFMT607kx1rCTElMFc7Cq0LlsWci1STxxWnOTS8QEY6rz2w76fSzGlvPbRI9nmfs7gKK",
    ["enhanced-boss-logs"] = "https://discord.moat.gg/api/webhooks/636321510767984650/AwZU8BYMhpmpRZjLN7qHCTaIYJeHtSeLmVpb9ELlyPxmdFLI2ZI0Gg4kdUlgCFuLjRsA",
}

discord.AddUsers("ttt-tv", {"Moat TTT Announcements", "Lottery Announcements"}, true)
discord.AddUsers("general", {"Moat TTT Announcement", "Lottery Announcement"}, true)
discord.AddUsers("enhanced-boss-logs", {"AntiCheat - Lua"}, true)
discord.AddUsers("ttt-bot", {"Event", "Drop"})
discord.AddUsers("ttt-challenges", {"Contracts", "Bounties", "Lottery"})
discord.AddUsers("ttt-logs", {"Lottery Win", "Gamble Win"}, true)
discord.AddUsers("staff-logs", {"Anti Cheat", "Past Offences", "Gamble Chat", "Gamble", "Server", "TTS"})
discord.AddUsers("boss-logs", {"Snap", "Skid", "Gamble Log", "Trade", "Bad Map", "ASN Check"})
discord.AddUsers("mga-logs", {"MGA Log"}, true)
discord.AddUsers("dev-logs", {"Developer"})
discord.AddUsers("toxic-logs", {"Toxic"})
discord.AddUsers("error-logs", {"Error Report"}, true)
discord.AddUsers("error-logs-sv", {"Error Report SV"}, true)
discord.AddUsers("server-list", {"Servers"})

function post_discord_server_list()
    Server.IsDev = false
    for k,v in pairs(Servers.Roster) do
        timer.Simple(0.5 * k,function()
            discord.Embed("Servers",{
                author = {
                    name = "moat.gg | ".. v.Name,
                    icon_url = "https://cdn.discordapp.com/avatars/406539243909939200/5a6db1904883070e0f896f3fb0275a2e.webp"
                },
                description = "Click here to connect: " .. v.ConnectURL,
            })
            if k == #Servers.Roster then
                Server.IsDev = true
            end
        end)
    end
end