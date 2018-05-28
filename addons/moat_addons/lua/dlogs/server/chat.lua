util.AddNetworkString("dlogs.StartChat")
util.AddNetworkString("dlogs.OpenChat")
util.AddNetworkString("dlogs.JoinChat")
util.AddNetworkString("dlogs.SendChatMessage")
util.AddNetworkString("dlogs.BroadcastMessage")
util.AddNetworkString("dlogs.JoinChatCL")
util.AddNetworkString("dlogs.StopChat")
util.AddNetworkString("dlogs.AddChatPlayer")
util.AddNetworkString("dlogs.CloseChat")
util.AddNetworkString("dlogs.LeaveChat")
util.AddNetworkString("dlogs.LeaveChatCL")
util.AddNetworkString("dlogs.ForceStay")
util.AddNetworkString("dlogs.ForcePlayerStay")
util.AddNetworkString("dlogs.ForceStayNotification")
util.AddNetworkString("dlogs.Release")
util.AddNetworkString("dlogs.ReleaseCL")
util.AddNetworkString("dlogs.ViewChat")
util.AddNetworkString("dlogs.ViewChatCL")

local COLOR_VICTIM = Color(18, 190, 29)
local COLOR_ATTACKER = Color(190, 18, 29)
local COLOR_ADMIN = Color(160, 160, 0)
local COLOR_OTHER = Color(29, 18, 190)

dlogs.ChatHistory = dlogs.ChatHistory or {}

local function GetFilter(chat, block)
	local filter = {}
	if IsValid(chat.victim) and chat.victim != block then
		table.insert(filter, chat.victim)
	end
	if IsValid(chat.attacker) and chat.attacker != block then
		table.insert(filter, chat.attacker)
	end
	local function process(tbl)
		for k,v in pairs(tbl) do
			if v != block and IsValid(v) then
				table.insert(filter, v)
			end
		end
	end
	process(chat.players)
	process(chat.admins)
	return filter
end

local function IsAllowed(ply, chat)
	if chat.victim == ply then
		return true, COLOR_VICTIM
	elseif chat.attacker == ply then
		return true, COLOR_ATTACKER
	elseif table.HasValue(chat.admins, ply) then
		return true, COLOR_ADMIN
	elseif table.HasValue(chat.players, ply) then
		return true, COLOR_OTHER
	end
	return false
end

net.Receive("dlogs.StartChat", function(_len, ply)

	local report_index = net.ReadUInt(32)

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[report_index]

	if not report then return end

	local victim
	local attacker

	for k,v in ipairs(player.GetHumans()) do
		if v:SteamID() == report.victim then
			victim = v
		elseif v:SteamID() == report.attacker then
			attacker = v
		elseif attacker and victim then
			break
		end
	end

	if not IsValid(victim) or not IsValid(attacker) then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "VictimReportedDisconnected"), 5, "weapon_cant_buy.wav")
		return
	end

	for k,v in pairs(dlogs.Reports.Current) do
		if v.chat_open and k == report_index then
			ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "ChatAlready"), 5, "weapon_cant_buy.wav")
			return
		end
	end

	report.chat_open = {
		admins = { ply },
		victim = victim,
		attacker = attacker,
		players = {}
	}

	local history = false

	if report.chat_opened then
		history = dlogs.ChatHistory[report_index] or {}
		report.chat_open.players = report.chat_previousPlayers or {}
	else
		report.chat_opened = true
		dlogs.ChatHistory[report_index] = {}
	end

	net.Start("dlogs.OpenChat")
	net.WriteUInt(report_index, 32)
	net.WriteUInt(report.adminReport and 1 or 0, 1)
	net.WriteEntity(ply)
	net.WriteEntity(victim)
	net.WriteEntity(attacker)
	net.WriteTable(report.chat_open.players)
	if history then
		net.WriteUInt(1, 1)
		local json = util.TableToJSON(history)
		local compressed = util.Compress(json)
		net.WriteUInt(#compressed, 32)
		net.WriteData(compressed, #compressed)
	else
		net.WriteUInt(0, 1)
	end
	net.Send(GetFilter(report.chat_open))

	for k,v in ipairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string.format(TTTLogTranslate(ply.DMGLogLang, "OpenChatNotification"), ply:Nick(), report_index), 5, "")
			v:UpdateReport(false, report_index)
		end
	end

end)

local function AddToChat(id, report, ply)

	if not report.chat_open then return end

	local history = dlogs.ChatHistory[id] or {}
	local json = util.TableToJSON(history)
	local compressed = util.Compress(json)

	local category = DAMAGELOG_OTHER

	if ply:CanUseRDMManager() and not table.HasValue(report.chat_open.admins, ply) then
		table.insert(report.chat_open.admins, ply)
		category = DAMAGELOG_ADMIN
	end
	if ply:SteamID() == report.victim then
		report.chat_open.victim = ply
		category = DAMAGELOG_VICTIM
	elseif ply:SteamID() == report.attacker then
		report.chat_open.attacker = ply
		category = DAMAGELOG_REPORTED
	elseif not table.HasValue(report.chat_open.admins, ply) and not table.HasValue(report.chat_open.players, ply) then
		table.insert(report.chat_open.players, ply)
		category = DAMAGELOG_OTHER
	end

	net.Start("dlogs.JoinChatCL")
	net.WriteUInt(1, 1)
	net.WriteUInt(id, 32)
	net.WriteUInt(#compressed, 32)
	net.WriteData(compressed, #compressed)
	net.WriteTable(report.chat_open)
	net.Send(ply)

	net.Start("dlogs.JoinChatCL")
	net.WriteUInt(0, 1)
	net.WriteUInt(id, 32)
	net.WriteEntity(ply)
	net.WriteUInt(category, 32)
	net.Send(GetFilter(report.chat_open, ply))

	for k,v in ipairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			v:UpdateReport(false, id)
		end
	end
end

net.Receive("dlogs.JoinChat", function(_len, ply)

	local id = net.ReadUInt(32)

	local report = dlogs.Reports.Current[id]
	if not report or not report.chat_open then return end

	if not ply:CanUseRDMManager() then return end

	AddToChat(id, report, ply)

end)

net.Receive("dlogs.SendChatMessage", function(_len, ply)

	local id = net.ReadUInt(32)
	local message = net.ReadString()

	if #message == 0 or #message > 200 then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end

	local chat = report.chat_open
	if not chat then return end

	local allowed, color = IsAllowed(ply, chat)
	if not allowed then return end

	table.insert(dlogs.ChatHistory[id], {
		nick = ply:Nick(),
		color = { r = color.r, g = color.g, b = color.b, a = color.a },
		msg = message
	})

	net.Start("dlogs.BroadcastMessage")
	net.WriteUInt(id, 32)
	net.WriteEntity(ply)
	net.WriteColor(color)
	net.WriteString(message)
	net.Send(GetFilter(chat))

end)

hook.Add("PlayerDisconnected", "dlogs_Chat", function(ply)

	for k,v in pairs(dlogs.Reports.Current) do

		if v.chat_open then

			if table.HasValue(v.admins, ply) then
				table.RemoveByValue(v.admins, ply)
				if #v.admins == 1 then
					net.Start("dlogs.StopChat")
					net.WriteUInt(k, 32)
					net.WriteUInt(0, 1)
					net.Send(GetFilter(v.chat_open))
					v.chat_open = false
					for k,v in ipairs(player.GetHumans()) do
						if v:CanUseRDMManager() then
							v:UpdateReport(false, id)
						end
					end
				end
			end
			if table.HasValue(v.players, ply) then
				table.RemoveByValue(v.players, ply)
			end
		end

	end
end)

net.Receive("dlogs.AddChatPlayer", function(_len, ply)

	local id = net.ReadUInt(32)
	local to_add = net.ReadEntity()

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end

	AddToChat(id, report, to_add)

	to_add:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, TTTLogTranslate(ply.DMGLogLang, "AddedChatAdmin"), 5, "")

end)

net.Receive("dlogs.CloseChat", function(_len, ply)

	local id = net.ReadUInt(32)
	local to_add = net.ReadEntity()

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end

	if report.chat_open then
		net.Start("dlogs.StopChat")
		net.WriteUInt(id, 32)
		net.WriteUInt(1, 1)
		net.WriteEntity(ply)
		net.Send(GetFilter(report.chat_open))
		report.chat_previousPlayers = table.Copy(report.players)
		report.chat_open = false
	end

	for k,v in ipairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string.format(TTTLogTranslate(ply.DMGLogLang, "ChatClosed"), ply:Nick(), id), 5, "")
			v:UpdateReport(false, id)
		end
	end

end)

net.Receive("dlogs.LeaveChat", function(_len, ply)

	local id = net.ReadUInt(32)

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end


	if report.chat_open then

		if #report.chat_open.admins <= 1 then return end
		for k,v in pairs(report.chat_open.admins) do
			if v == ply then
				table.remove(report.chat_open.admins, k)
				break
			end
		end

		net.Start("dlogs.LeaveChatCL")
		net.WriteUInt(id, 32)
		net.WriteEntity(ply)
		net.Send(GetFilter(report.chat_open))

	end

end)

net.Receive("dlogs.ForceStay", function(_len, ply)

	local id = net.ReadUInt(32)

	local allPlayers = net.ReadUInt(1) == 1
	local players
	if not allPlayers then
		players = { net.ReadEntity() }
	end

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end

	if allPlayers then
		players = report.chat_open.players
	end

	for k,v in pairs(players) do
		v:SetNWInt("dlogs.ForcedStay", id)
		net.Start("dlogs.ForcePlayerStay")
		net.WriteUInt(id, 32)
		net.Send(v)
	end

	net.Start("dlogs.ForceStayNotification")
	net.WriteUInt(id, 32)
	net.WriteUInt(allPlayers and 1 or 0, 1)
	if not allPlayers then
		net.WriteEntity(players[1])
	end
	net.WriteUInt(1, 1)
	net.WriteEntity(ply)
	net.Send(GetFilter(report.chat_open))

end)

net.Receive("dlogs.Release", function(_len, ply)

	local id = net.ReadUInt(32)

	local allPlayers = net.ReadUInt(1) == 1
	local players
	if not allPlayers then
		players = { net.ReadEntity() }
	end

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report then return end

	if allPlayers then
		players = report.chat_open.players
	end

	for k,v in pairs(players) do
		v:SetNWInt("dlogs.ForcedStay", -1)
		net.Start("dlogs.ReleaseCL")
		net.WriteUInt(id, 32)
		net.Send(v)
	end

	net.Start("dlogs.ForceStayNotification")
	net.WriteUInt(id, 32)
	net.WriteUInt(allPlayers and 1 or 0, 1)
	if not allPlayers then
		net.WriteEntity(players[1])
	end
	net.WriteUInt(0, 1)
	net.WriteEntity(ply)
	net.Send(GetFilter(report.chat_open))

end)

net.Receive("dlogs.ViewChat", function(_len, ply)

	local id = net.ReadUInt(32)

	if not ply:CanUseRDMManager() then return end

	local report = dlogs.Reports.Current[id]
	if not report or report.chat_open then return end

	local history = dlogs.ChatHistory[id] or {}

	net.Start("dlogs.ViewChatCL")
	net.WriteUInt(id, 32)
	local json = util.TableToJSON(history)
	local compressed = util.Compress(json)
	net.WriteUInt(#compressed, 32)
	net.WriteData(compressed, #compressed)
	net.Send(ply)

end)