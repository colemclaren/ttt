-- todo replace relay
moat.c.webhook = "http://208.103.169.40:5069/"
moat.c.oldwebhook = "http://208.103.169.40:5069/"
moat.c.discord = {primarywebhook = "https://discordapp.com/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX"}

-- for discord webhooks
/*
local discord = {}
discord.webhook = "http://208.103.169.40:5069/"
discord.oldwebhook = "http://107.191.51.43:3000/"
discord.primarywebhook = "https://discordapp.com/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX"
discord.webhooks = {
	["ttt"] = discord.primarywebhook, -- #ttt-bot
	["nsa"] = "https://discordapp.com/api/webhooks/381964496136306688/d-s9h8MLL6Xbxa7XLdh9q1I1IAcJ3cniQAXnZczqFT0wLsc3PypyO6fMNlrtxV3C4hUK", -- #nsa-logs
	["logs"] = "https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn", -- #ttt-logs
	["challenges"] = "https://discordapp.com/api/webhooks/406539243909939200/6Uhyh9_8adif0a5G-Yp06I-SLhIjd3gUzFA_QHzCViBlrLYcoqi4XpFIstLaQSal93OD", -- #ttt-challenges
	["general"] = "https://discordapp.com/api/webhooks/426168857531777032/eYz9auMRlmVfdKtXvlHJnjx3wY5KwHaLJ5TkwBF31jeuCgtn3DQb_DNw7yMeaXBZ2J7x", -- #general
	["staff"] = "https://discordapp.com/api/webhooks/443280941037912064/HrTLiALn7ggtDSomZA45VlxbQsxiZsx2Wazs7qqofHc77DLIQSe-CE40F4ai4qLGvhS7", -- #staff-logs
	["lua"] = "https://discordapp.com/api/webhooks/464333222315032577/Au20fuJo83deASrUO5kj2wbmiVqoAsqPA6iA-fAFSsHf2NV-oICJ5xRCc7I0USUtdeWI", -- #lua_run
}
*/

discord.AddChannels {
	["general"] = "https://discordapp.com/api/webhooks/426168857531777032/eYz9auMRlmVfdKtXvlHJnjx3wY5KwHaLJ5TkwBF31jeuCgtn3DQb_DNw7yMeaXBZ2J7x",
	["ttt-bot"] = "https://discordapp.com/api/webhooks/310440549654069248/JlhLxYdayoyABvMCPjhIjChdws99ca1kBn55wPJ58_2p92QNzB53PQImeEONgt0R5FCX",
	["ttt-challenges"] = "https://discordapp.com/api/webhooks/406539243909939200/6Uhyh9_8adif0a5G-Yp06I-SLhIjd3gUzFA_QHzCViBlrLYcoqi4XpFIstLaQSal93OD",
	["ttt-logs"] = "https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn",
	["staff-logs"] = "https://discordapp.com/api/webhooks/443280941037912064/HrTLiALn7ggtDSomZA45VlxbQsxiZsx2Wazs7qqofHc77DLIQSe-CE40F4ai4qLGvhS7",
	["nsa-logs"] = "https://discordapp.com/api/webhooks/381964496136306688/d-s9h8MLL6Xbxa7XLdh9q1I1IAcJ3cniQAXnZczqFT0wLsc3PypyO6fMNlrtxV3C4hUK",
	["administration-logs"] = "https://discordapp.com/api/webhooks/473586905334808589/4-LQG19idQj4M99_s-goUyFOrGvXJKvTAabEjGdQw8nR5qunDz-7k1ST3y-fv5vwoSIR",
	["testing"] = "https://discordapp.com/api/webhooks/473470257940529164/yfdjULAY0_5_fyLODicLr89ICPFoJ3hRT9U3jqt5AvbMN-_ffnwUUiV5OwY6KUeHXcsX"
}

discord.AddUsers("general", {
	"Moat TTT Announcement",
	"Lottery Announcement"
}, true)

discord.AddUsers("ttt-bot", {
	"Event",
	"Drop"
})

discord.AddUsers("ttt-challenges", {
	"Contracts",
	"Bounties",
	"Lottery"
})

discord.AddUsers("ttt-logs", {
	"Player Unbanned",
	"Player Banned",
	"Lottery Win",
	"Gamble Win"
}, true)

discord.AddUsers("staff-logs", {
	"Anti Cheat",
	"Past Offences",
	"Gamble Chat",
	"Gamble",
	"Server",
	"TTS"
})

discord.AddUsers("nsa-logs", {
	"Snap",
	"Skid",
	"Gamble Log",
	"Trade",
	"Bad Map"
})

discord.AddUsers("administration-logs", {
	"Player Log",
	"Staff Log"
})