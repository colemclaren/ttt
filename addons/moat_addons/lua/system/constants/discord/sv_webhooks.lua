-- todo replace relay
moat.c.webhook = "http://208.103.169.40:5069/"
moat.c.oldwebhook = "http://107.191.51.43:3000/"

moat.c.discord = {
    primarywebhook = "https://discordapp.com/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX"
}

discord.AddChannels{
    ["general"] = "https://discordapp.com/api/webhooks/426168857531777032/eYz9auMRlmVfdKtXvlHJnjx3wY5KwHaLJ5TkwBF31jeuCgtn3DQb_DNw7yMeaXBZ2J7x",
    ["ttt-bot"] = "https://discordapp.com/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX",
    ["ttt-challenges"] = "https://discordapp.com/api/webhooks/406539243909939200/6Uhyh9_8adif0a5G-Yp06I-SLhIjd3gUzFA_QHzCViBlrLYcoqi4XpFIstLaQSal93OD",
    ["ttt-logs"] = "https://discordapp.com/api/webhooks/485986045117202451/sTPNhnVFDKsR7JMZrH2ItOTkowzAAGFmOG9OW_vGY3tZhCEUU3C6OFTgslVHDiVDI1xl",
    ["staff-logs"] = "https://discordapp.com/api/webhooks/485986045117202451/sTPNhnVFDKsR7JMZrH2ItOTkowzAAGFmOG9OW_vGY3tZhCEUU3C6OFTgslVHDiVDI1xl",
    ["boss-logs"] = "https://discordapp.com/api/webhooks/485986362751975424/0Wz9xsI3mBDsE1XvE-r0MlmHOrxSUBPxERXoEJpZoQOr-eSgFKhc2Z10f5CsO67Trm1w",
    ["duty-logs"] = "https://discordapp.com/api/webhooks/485986697906094090/ZEkaEa4Pedyys8UPgm5UIbEy6WqMR_MuSxiCKj0xs6dFSYW_jJp188_Y-VhiiQOgGRnw",
    ["testing"] = "https://discordapp.com/api/webhooks/473470257940529164/yfdjULAY0_5_fyLODicLr89ICPFoJ3hRT9U3jqt5AvbMN-_ffnwUUiV5OwY6KUeHXcsX",
    ["dev-server-logs"] = "https://discordapp.com/api/webhooks/489951089588699136/PUhbSqO9nTOeDj__f3bBTQlTesFVKHjxdpVGFC-OB2dUx1_zyjiuBTZekBlMpIC191xD",
    ["old-staff"] = "https://discordapp.com/api/webhooks/490027008752091156/kR9l43iXJDfO0E_WPJ0BqRuj2xS-vPD8hmjmfH8--kO9goiBnO430Pmzu3dJ-xqjLmJD"
}

discord.AddUsers("general", {"Moat TTT Announcement", "Lottery Announcement"}, true)
discord.AddUsers("ttt-bot", {"Event", "Drop"})
discord.AddUsers("ttt-challenges", {"Contracts", "Bounties", "Lottery"})
discord.AddUsers("ttt-logs", {"Player Unbanned", "Player Banned", "Lottery Win", "Gamble Win"}, true)
discord.AddUsers("staff-logs", {"Anti Cheat", "Past Offences", "Gamble Chat", "Gamble", "Server", "TTS"})
discord.AddUsers("boss-logs", {"Snap", "Skid", "Gamble Log", "Trade", "Bad Map"})
discord.AddUsers("duty-logs", {"Command Log"}, true)
discord.AddUsers("dev-server-logs",{"Developer"})
discord.AddUsers("old-staff",{"Toxic"})