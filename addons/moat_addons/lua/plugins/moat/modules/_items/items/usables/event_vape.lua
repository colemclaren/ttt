ITEM.ID = 75
ITEM.Name = "Vape Event Token"
ITEM.Description = "Using this will drop every player on the server a Random Vape Item!"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://static.moat.gg/ttt/vape_event128.png"
ITEM.Active = false

ITEM.ItemUsed = function(pl, slot, item)
	for k, v in ipairs(player.GetAll()) do
		v:m_DropInventoryItem(randomvape(), "hide_chat_obtained", false, false)
	end

	local msg = string(":gift: " .. style.Bold(pl:Nick()) .. style.Dot(style.Code(pl:SteamID())) .. style.Dot(pl:SteamURL()), style.NewLine(":tada: Just dropped everybody a ") .. style.BoldUnderline("Random Vape") .. " on " .. string.Extra(GetServerName(), GetServerURL()))
	discord.Send("Moat TTT Announcement", markdown.WrapBold(string(":satellite_orbital::satellite: ", markdown.Bold"Global TTT Announcement", " :satellite::satellite_orbital:", markdown.LineStart(msg))))
	discord.Send("Events", msg)
	discord.Send("Event", msg)

	net.Start "D3A.Chat2"
		net.WriteBool(false)
		net.WriteTable({Color(0, 255, 0), pl:Nick(), Color(255, 255, 255), " just dropped everybody a ", Color(0, 255, 0), "Random Vape", Color(255, 255, 255), "!"})
	net.Broadcast()
end