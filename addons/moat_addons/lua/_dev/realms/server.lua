-- dev realms for code testing
-- called after realm config is loaded

/*
failed = function(err)
            MsgC(Color(255, 0, 0), "HTTP error in sending raw message to discord: " .. err .. "\n")
        end,
        success = SVDiscordRelay.VerifyMessageSuccess,
        method = "post",
        url = url or DiscordRelay.WebhookURL,
        parameters = t_post,
        type = "application/json; charset=utf-8"

Entity(1):NameID() .. " started map event '" .. ("Quadra XP"):Bold() .. "' on server: " .. string.Extra(SERVER_NICK, SERVER_IP)

str = "Daily Contract for " .. (util.NiceDate():Bold()) str = str:Title() str = str .. ("Global M16 Killer" .. (("Get as many kills as you can with an M16, rightfully."):Topic()) .. markdown.Line):Code() print(str) discord.Send("testing", str)

function fst() return string("Lottery number of " .. markdown.Bold(util.NiceDate(-1)), " was " .. markdown.Bold(32), " with " .. markdown.BoldUnderline(string.Comma(500000) .. " IC")) end
function scn() return markdown.WrapBoldLine(string(fst(), markdown.NewLine("There was ", markdown.Bold("no"), " winner!"))) end
function trd() return scn() .. markdown.BoldEnd(string (markdown.Bold(string.Comma(500000 * 0.75) .. " IC"), " has rolled over to today's pot!")) end

discord.Send("testing", markdown.WrapBoldLine(string ("Lottery number of " .. markdown.Bold(util.NiceDate(-1)), " was " .. markdown.Bold(32), " with " .. markdown.BoldUnderline(string.Comma(500000) .. " IC"), markdown.NewLine("There was ", markdown.Bold("no"), " winner!"))) .. markdown.BoldEnd(string (markdown.Bold(string.Comma(500000 * 0.75) .. " IC"), " has rolled over to today's pot!")))

*/

-- concommand.Add("test_discord", function()
-- 	local bstr, medals = "", {":third_place:", ":second_place:", ":first_place:"}
-- 	for i = 1, 3 do
-- 		local bounty = MOAT_BOUNTIES.ActiveBounties[i].bnty
-- 		local mods = MOAT_BOUNTIES.ActiveBounties[i].mods
-- 		local bounty_desc = bounty.desc

-- 		local n = 0
-- 		for _ = 1, #mods do
-- 			bounty_desc = bounty_desc:gsub("#", function() n = n + 1 return markdown.Bold(mods[n]) end)
-- 		end

-- 		bstr = string (bstr, medals[i],
-- 			" " .. markdown.Bold(bounty.name) .. " | " .. markdown.EndLine(bounty_desc),
-- 			markdown.Highlight("Rewards: " .. bounty.rewards)
-- 		)

-- 		if (i < 3) then
-- 			bstr = markdown.EndLine(
-- 				markdown.EndLine(bstr)
-- 			)
-- 		end
-- 	end

-- 	discord.Send("testing", markdown.Code(" ") .. markdown.WrapBold(
-- 			string (":calendar_spiral: ",
-- 				"Daily Bounties on " .. markdown.Bold(Server and Server.Name or GetHostName()),
-- 				" for " .. string.Extra(util.NiceDate(), Server and Server.ConnectURL or (Servers.SteamURL .. GetServerIP())),
-- 				markdown.LineStart(bstr)
-- 			)
-- 		)
-- 	)
-- end)