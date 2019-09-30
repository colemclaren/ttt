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
    ["ttt-logs"] = "https://discord.moat.gg/api/webhooks/485986045117202451/sTPNhnVFDKsR7JMZrH2ItOTkowzAAGFmOG9OW_vGY3tZhCEUU3C6OFTgslVHDiVDI1xl",
    ["staff-logs"] = "https://discord.moat.gg/api/webhooks/485986045117202451/sTPNhnVFDKsR7JMZrH2ItOTkowzAAGFmOG9OW_vGY3tZhCEUU3C6OFTgslVHDiVDI1xl",
    ["boss-logs"] = "https://discord.moat.gg/api/webhooks/485986362751975424/0Wz9xsI3mBDsE1XvE-r0MlmHOrxSUBPxERXoEJpZoQOr-eSgFKhc2Z10f5CsO67Trm1w",
    ["error-logs"] = "https://discord.moat.gg/api/webhooks/485986697906094090/ZEkaEa4Pedyys8UPgm5UIbEy6WqMR_MuSxiCKj0xs6dFSYW_jJp188_Y-VhiiQOgGRnw",
    ["testing"] = "https://discord.moat.gg/api/webhooks/473470257940529164/yfdjULAY0_5_fyLODicLr89ICPFoJ3hRT9U3jqt5AvbMN-_ffnwUUiV5OwY6KUeHXcsX",
    ["dev-logs"] = "https://discord.moat.gg/api/webhooks/489951089588699136/PUhbSqO9nTOeDj__f3bBTQlTesFVKHjxdpVGFC-OB2dUx1_zyjiuBTZekBlMpIC191xD",
    ["old-staff"] = "https://discord.moat.gg/api/webhooks/490027008752091156/kR9l43iXJDfO0E_WPJ0BqRuj2xS-vPD8hmjmfH8--kO9goiBnO430Pmzu3dJ-xqjLmJD",
	["mga-logs"] = "https://discord.moat.gg/api/webhooks/490002648917999637/ZyTVsaXcgh4bp6i4OPK6SRQiCuTuHrvLjNyexfUEDEcWD4oA0WQEtI2VGTk39_k86olR",
	["toxic-logs"] = "https://discord.moat.gg/api/webhooks/577591732972027904/-3KGtxLn8keIloPSOnBThBM4Ry2XO5EoVZwFwpdf8uw3r2sdCJZV8LaGXNq09-Jb_g9p",
    ["error-logs-sv"] = "https://discord.moat.gg/api/webhooks/502947110736625676/LzY80EGeb_sBfrlUpC8rWkm0H4Btzi7JOr3GhKqImQMoFIEP_beF7BeUHrxQ47RVVNhN",
    ["server-list"] = "https://discord.moat.gg/api/webhooks/568878605028032544/aFMT607kx1rCTElMFc7Cq0LlsWci1STxxWnOTS8QEY6rz2w76fSzGlvPbRI9nmfs7gKK",
    ["enhanced-boss-logs"] = "https://canary.discordapp.com/api/webhooks/600692601909280778/m4SxcsyZN8OBX-J20CrC-d3Xf9CpgyO4zDipV7Ih50iHLzc8dhLxC8tC2PAgzWl1coLZ",
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