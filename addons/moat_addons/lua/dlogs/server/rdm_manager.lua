local util, net, player, pairs, ipairs, IsValid, table, string, CurTime, file = util, net, player, pairs, ipairs, IsValid, table, string, CurTime, file
local hook = hook
local hook_Call, hook_Add = hook.Call, hook.Add
local util_JSONToTable, util_TableToJSON = util.JSONToTable, util.TableToJSON
local player_GetHumans = player.GetHumans
local table_Copy, table_Empty, table_insert, table_HasValue = table.Copy, table.Empty, table.insert, table.HasValue
local string_Left, string_lower, string_gsub, string_format = string.Left, string.lower, string.gsub, string.format

util.AddNetworkString("dlogs.AllowReport")
util.AddNetworkString("dlogs.AllowMReports")
util.AddNetworkString("dlogs.ReportPlayer")
util.AddNetworkString("dlogs.UpdateReports")
util.AddNetworkString("dlogs.UpdateReport")
util.AddNetworkString("dlogs.NewReport")
util.AddNetworkString("dlogs.UpdateStatus")
util.AddNetworkString("dlogs.SendReport")
util.AddNetworkString("dlogs.SendAnswer")
util.AddNetworkString("dlogs.SendForgive")
util.AddNetworkString("dlogs.GetForgive")
util.AddNetworkString("dlogs.Death")
util.AddNetworkString("dlogs.Answering")
util.AddNetworkString("dlogs.Answering_global")
util.AddNetworkString("dlogs.ForceRespond")
util.AddNetworkString("dlogs.StartReport")
util.AddNetworkString("dlogs.Conclusion")
util.AddNetworkString("dlogs.AskOwnReportInfo")
util.AddNetworkString("dlogs.SendOwnReportInfo")

dlogs.Reports = dlogs.Reports or {
	Current = {}
}

dlogs.getmreports = {
	id = {
		index,
		victim,
		message
	}
}

if not dlogs.Reports.Previous then
	if file.Exists("damagelog/prevreports.txt", "DATA") then
		dlogs.Reports.Previous = util_JSONToTable(file.Read("damagelog/prevreports.txt", "DATA"))
		file.Delete("damagelog/prevreports.txt")
	else
		dlogs.Reports.Previous = {}
	end
end

local function GetBySteamID(steamid)
	for k, v in ipairs(player_GetHumans()) do
		if v:SteamID() == steamid then return v end
	end
end

local function UpdatePreviousReports()
	local tbl = table_Copy(dlogs.Reports.Current)

	for k, v in pairs(tbl) do
		v.previous = true
	end

	file.Write("damagelog/prevreports.txt", util_TableToJSON(tbl))
end

local Player = FindMetaTable("Player")

function Player:RemainingReports()
	return 2 - #self.Reported
end

function Player:UpdateReports()
	if not self:CanUseRDMManager() then return end
	local tbl = util_TableToJSON(dlogs.Reports)
	if not tbl then return end
	local compressed = util.Compress(tbl)
	if not compressed then return end
	net.Start("dlogs.UpdateReports")
	net.WriteUInt(#compressed, 32)
	net.WriteData(compressed, #compressed)
	net.Send(self)
end

function Player:NewReport(report)
	if not self:CanUseRDMManager() then return end
	net.Start("dlogs.NewReport")
	net.WriteTable(report)
	net.Send(self)
end

function Player:UpdateReport(previous, index)
	if not self:CanUseRDMManager() then return end
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if not tbl then return end
	net.Start("dlogs.UpdateReport")
	net.WriteUInt(previous and 1 or 0, 1)
	net.WriteUInt(index, 8)
	net.WriteTable(tbl)
	net.Send(self)
end

function Player:SendReport(tbl)
	if tbl.chat_opened then return end
	net.Start("dlogs.SendReport")
	net.WriteTable(tbl)
	net.Send(self)
end

hook_Add("PlayerSay", "dlogs_RDMManager", function(ply, text, teamOnly)
	if (text == "!report" or text == "/report") then
		dlogs:StartReport(ply)

		return false
	elseif (text == "!respond" or text == "/respond") then
		net.Start("dlogs.Death")
		net.Send(ply)

		return false
	end
end)

hook_Add("TTTBeginRound", "dlogs_RDMManger", function()
	for k, v in ipairs(player_GetHumans()) do
		if not v.CanReport then
			v.CanReport = true
		end

		table_Empty(v.Reported)
	end
end)

net.Receive("dlogs.StartReport", function(length, ply)
	dlogs:StartReport(ply)
end)

function dlogs:SendLogToVictim(tbl)
	local victim = player.GetBySteamID(tbl.victim)
	if not IsValid(victim) then return end
	net.Start("dlogs.SendOwnReportInfo")
	net.WriteTable(tbl)
	net.Send(victim)
end

function dlogs:GetMReports(ply)
	if not IsValid(ply) then return end
	local found = false

	if not ply.CanReport then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "NeedToPlay"), 4, "weapon_cant_buy.wav")
	else
		for k, v in pairs(dlogs.Reports.Current) do
			if #v.victim > 0 then
				if v.victim ~= ply:SteamID() then return end
				found = true
				net.Start("dlogs.AllowMReports")
				net.WriteTable(v)
				net.Send(ply)
			end
		end
		if not found then
			ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "HaventReported"), 4, "weapon_cant_buy.wav")
		end
	end
end

net.Receive("dlogs.AskOwnReportInfo", function(length, ply)
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if tbl.victim != ply:SteamID() then return end
	net.Start("dlogs.SendOwnReportInfo")
	net.WriteTable(tbl)
	net.Send(ply)
end)

function dlogs:GetPlayerReportsList(ply)
	local steamid = ply:SteamID()

	local previous = {}
	for k,v in pairs(dlogs.Reports.Previous) do
		if v.victim == steamid then
			table_insert(previous, {
				index = v.index,
				attackerName = v.attacker_nick,
				attackerID = v.attacker
			})
		end
	end

	local current = {}
	for k,v in pairs(dlogs.Reports.Current) do
		if v.victim == steamid then
			local tbl = {
				index = v.index,
				attackerName = v.attacker_nick,
				attackerID = v.attacker
			}
			if not current[v.round] then
				current[v.round] = { tbl }
			else
				table_insert(current[v.round], tbl)
			end
		end
	end

	return previous, current
end

function dlogs:StartReport(ply)
	if not IsValid(ply) then return end

	net.Start("dlogs.AllowReport")
	local found = false
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			found = true
			break
		end
	end
	net.WriteBool(found)
	if ply.DeathDmgLog then
		net.WriteUInt(1, 1)
		net.WriteTable(ply.DeathDmgLog)
	else
		net.WriteUInt(0, 1)
	end

	local previousReports, currentReports = dlogs:GetPlayerReportsList(ply)
	net.WriteTable(previousReports)
	net.WriteTable(currentReports)

	local tbl = player_GetHumans()
	net.WriteUInt(#tbl, 8)
	for k,v in ipairs(tbl) do
		net.WriteEntity(v)
		if v.DmgLog_DNA and v.DmgLog_DNA[dlogs.CurrentRound] and v.DmgLog_DNA[dlogs.CurrentRound][ply] then
			net.WriteUInt(1, 1)
		else
			net.WriteUInt(0, 1)
		end
	end

	net.Send(ply)
end
concommand.Add("dmglogs_startreport", function(ply, cmd, args)
	dlogs:StartReport(ply)
end)

local function OnDNAFound(ply, killer, corpse)
	if not ply.DmgLog_DNA then
		ply.DmgLog_DNA = {}
	end
	if not ply.DmgLog_DNA[dlogs.CurrentRound] then
		ply.DmgLog_DNA[dlogs.CurrentRound] = {}
	end
	ply.DmgLog_DNA[dlogs.CurrentRound][killer] = true
end
hook_Add("TTTFoundDNA", "dlogs", OnDNAFound)

net.Receive("dlogs.ReportPlayer", function(_len, ply)
	local attacker = net.ReadEntity()
	local message = net.ReadString()
	local reportType = net.ReadUInt(3)
	if not ply:CanUseRDMManager() then
		reportType = DAMAGELOG_REPORT_STANDARD
	end

	message = string_gsub(string_gsub(message, "[^%g\128-\191\194-\197\208-\210 ]+", ""), "%s+", " ")

	local adminOnline = true

	if not ply:CanUseRDMManager() then
		adminOnline = false

		for k, v in ipairs(player_GetHumans()) do
			if v:CanUseRDMManager() then
				adminOnline = true
				break
			end
		end

		if not dlogs.NoStaffReports then
			if not adminOnline then
				ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "NoAdmins"), 4, "weapon_cant_buy.wav")
				return
			end
		end

		if not ply.CanReport then
			if not dlogs.MoreReportsPerRound then
				ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "NeedToPlay"), 4, "weapon_cant_buy.wav")
				return
			end
		else
			if not dlogs.ReportsBeforePlaying then
				local remaining_reports = ply:RemainingReports()

				if remaining_reports <= 0 then
					ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "OnlyReportTwice"), 4, "weapon_cant_buy.wav")
					return
				end
			end
		end

		if not dlogs.MoreReportsPerRound then
			if ply:RemainingReports() <= 0 then return end
		end
		if not dlogs.ReportsBeforePlaying then
			if not ply.CanReport then return end
		end

		if not attacker:GetNWBool("PlayedSRound", true) then
			ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "ReportSpectator"), 5, "weapon_cant_buy.wav")
			return
		end

	end

	if attacker == ply then return end

	if not IsValid(attacker) then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "InvalidAttacker"), 5, "weapon_cant_buy.wav")
		return
	end

	if table_HasValue(ply.Reported, attacker) then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(ply.DMGLogLang, "AlreadyReported"), 5, "weapon_cant_buy.wav")
		return
	end

	table_insert(ply.Reported, attacker)

	local newReport = {
		victim = ply:SteamID(),
		victim_nick = ply:Nick(),
		attacker = attacker:SteamID(),
		attacker_nick = attacker:Nick(),
		message = message,
		response = false,
		status = RDM_MANAGER_WAITING,
		admin = false,
		round = dlogs.CurrentRound or 0,
		chat_open = false,
		logs = ply.DeathDmgLog or false,
		conclusion = false,
		adminReport = reportType != DAMAGELOG_REPORT_STANDARD,
		chatReport = reportType == DAMAGELOG_REPORT_CHAT
	}

	local index = table_insert(dlogs.Reports.Current, newReport)

	dlogs.getmreports.id[1] = {}
	dlogs.getmreports.id[1].victim = ply:SteamID()
	dlogs.getmreports.id[1].index = index

	dlogs.Reports.Current[index].index = index

	if reportType != DAMAGELOG_REPORT_STANDARD then
		dlogs.Reports.Current[index].status = RDM_MANAGER_PROGRESS
		dlogs.Reports.Current[index].admin = ply:Nick()
	end

	for k, v in ipairs(player_GetHumans()) do
		if v:CanUseRDMManager() then
			if v:IsActive() then
				v:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, TTTLogTranslate(v.DMGLogLang, "ReportCreated") .. " (#" .. index .. ") !", 5, "vote_failure.wav")
			else
				if reportType != DAMAGELOG_REPORT_STANDARD then
					v:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(v.DMGLogLang, "HasAdminReported"), ply:Nick(), attacker:Nick(), index), 5, "vote_failure.wav")
				else
					v:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(v.DMGLogLang, "HasReported"), ply:Nick(), attacker:Nick(), index), 5, "vote_failure.wav")
				end
			end
			v:NewReport(dlogs.Reports.Current[index])
		end
	end

	if reportType != DAMAGELOG_REPORT_CHAT then
		attacker:SendReport(dlogs.Reports.Current[index])
	end

	if not attacker:CanUseRDMManager() then
		if reportType != DAMAGELOG_REPORT_STANDARD then
			attacker:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(attacker.DMGLogLang, "HasAdminReportedYou"), ply:Nick()), 5, "vote_failure.wav")
		else
			attacker:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(attacker.DMGLogLang, "HasReportedYou"), ply:Nick()), 5, "vote_failure.wav")
		end
	end

	if reportType != DAMAGELOG_REPORT_STANDARD then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(ply.DMGLogLang, "YouHaveAdminReported"), attacker:Nick()), 5, "")
	else
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_ALERT, string_format(TTTLogTranslate(ply.DMGLogLang, "YouHaveReported"), attacker:Nick()), 5, "")
	end

	if reportType == DAMAGELOG_REPORT_FORCE and attacker:IsActive() then
		net.Start("dlogs.Death")
		net.Send(attacker)
	end

	if reportType == DAMAGELOG_REPORT_CHAT then

		local report = dlogs.Reports.Current[index]

		report.chat_open = {
			admins = { ply },
			victim = ply,
			attacker = attacker,
			players = {}
		}
		report.chat_opened = true

		dlogs.ChatHistory[index] = {}

		net.Start("dlogs.OpenChat")
		net.WriteUInt(index, 32)
		net.WriteUInt(1, 1)
		net.WriteEntity(ply)
		net.WriteEntity(ply)
		net.WriteEntity(attacker)
		net.WriteTable(report.chat_open.players)
		net.WriteUInt(0, 1)
		net.Send({ ply, attacker })

		for k,v in ipairs(player_GetHumans()) do
			if v:CanUseRDMManager() then
				v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(v.DMGLogLang, "OpenChatNotification"), ply:Nick(), index), 5, "")
				v:UpdateReport(false, index)
			end
		end

	end

	local syncEnt = dlogs:GetSyncEnt()
	if not adminReport and IsValid(syncEnt) then
		syncEnt:SetPendingReports(syncEnt:GetPendingReports() + 1)
	end

	UpdatePreviousReports()

end)

net.Receive("dlogs.UpdateStatus", function(_len, ply)
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local status = net.ReadUInt(4)
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if not tbl then return end
	if tbl.status == status then return end
	local previousStatus = tbl.status
	tbl.status = status
	tbl.admin = status == RDM_MANAGER_WAITING and false or ply:Nick()
	local msg

	if status == RDM_MANAGER_WAITING then

		msg = string_format(TTTLogTranslate(ply.DMGLogLang, "HasSetReport"), ply:Nick(), index, TTTLogTranslate(ply.DMGLogLang, "RDMWaiting"))
		local syncEnt = dlogs:GetSyncEnt()
		if IsValid(syncEnt)then
			syncEnt:SetPendingReports(syncEnt:GetPendingReports() + 1)
		end
	elseif status == RDM_MANAGER_PROGRESS then

		msg = ply:Nick() .. " " .. TTTLogTranslate(ply.DMGLogLang, "DealingReport") .. " #" .. index .. "."

		for k, v in ipairs(player_GetHumans()) do
			if v:SteamID() == tbl.victim then
				v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick() .. " " .. TTTLogTranslate(ply.DMGLogLang, "HandlingYourReport"), 5, "vote_yes.wav")
			end
		end

		local syncEnt = dlogs:GetSyncEnt()
		if IsValid(syncEnt) and previousStatus == RDM_MANAGER_WAITING then
			syncEnt:SetPendingReports(syncEnt:GetPendingReports() - 1)
		end

	elseif status == RDM_MANAGER_FINISHED then
		msg = string_format(TTTLogTranslate(ply.DMGLogLang, "HasSetReport"), ply:Nick(), index, TTTLogTranslate(ply.DMGLogLang, "Finished"))
		local syncEnt = dlogs:GetSyncEnt()
		if IsValid(syncEnt) and previousStatus == RDM_MANAGER_WAITING then
			syncEnt:SetPendingReports(syncEnt:GetPendingReports() - 1)
		end
	end

	tbl.autoStatus = false

	for k, v in ipairs(player_GetHumans()) do
		if v:CanUseRDMManager() then
			v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, msg, 5, "")
			v:UpdateReport(previous, index)
		end
	end

	-- No Bots would use RDM Manager
	dlogs:SendLogToVictim(tbl)
	UpdatePreviousReports()
end)

net.Receive("dlogs.Conclusion", function(_len, ply)
	local notify = net.ReadUInt(1) == 0
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local conclusion = net.ReadString()
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if not tbl then return end

	tbl.conclusion = conclusion

	for k, v in ipairs(player_GetHumans()) do
		if v:CanUseRDMManager() then
			if notify then
				v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick() .. " " .. TTTLogTranslate(v.DMGLogLang, "HasSetConclusion") .. " #" .. index .. ".", 5, "")
			end
			v:UpdateReport(previous, index)
		end
	end

	dlogs:SendLogToVictim(tbl)
	UpdatePreviousReports()

	hook.Run("dlogs_Discord", ply, IsValid(attacker) and attacker or tbl.attacker, forgive, index)
end)

hook_Add("PlayerAuthed", "RDM_Manager", function(ply)
	ply.Reported = {}
	ply:UpdateReports()

	for _, tbl in pairs(dlogs.Reports) do
		for k, v in pairs(tbl) do
			if v.attacker == ply:SteamID() and not v.response and not v.chat_opened then
				ply:SendReport(v)
			end
		end
	end
end)

hook_Add("PlayerDeath", "RDM_Manager", function(ply)
	net.Start("dlogs.Death")
	net.Send(ply)
end)

hook_Add("TTTEndRound", "RDM_Manager", function()
	net.Start("dlogs.Death")
	net.Broadcast()
end)

net.Receive("dlogs.SendAnswer", function(_, ply)
	local previous = net.ReadUInt(1) ~= 1
	local text = net.ReadString()
	local index = net.ReadUInt(16)
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if not tbl then return end
	if ply:SteamID() != tbl.attacker then return end
	if tbl.response then return end

	text = string_gsub(string_gsub(text, "[^%g\128-\191\194-\197\208-\210 ]+", ""), "%s+", " ")
	tbl.response = text

	for k, v in ipairs(player_GetHumans()) do
		if v:CanUseRDMManager() then
			v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(v.DMGLogLang, "HasAnsweredReport"), (v:IsActive() and TTTLogTranslate(v.DMGLogLang, "TheReportedPlayer") or ply:Nick()), index), 5, "vote_yes.wav")
			v:UpdateReport(previous, index)
		end
	end

	local victim = GetBySteamID(tbl.victim)

	if IsValid(victim) then
		net.Start("dlogs.SendForgive")
		net.WriteUInt(previous and 1 or 0, 1)
		net.WriteUInt(tbl.canceled and 1 or 0, 1)
		net.WriteUInt(index, 16)
		net.WriteString(tbl.attacker_nick)
		net.WriteString(text)
		net.Send(victim)
	end

	dlogs:SendLogToVictim(tbl)
	UpdatePreviousReports()
end)

net.Receive("dlogs.GetForgive", function(_, ply)
	local forgive = net.ReadUInt(1) == 1
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if tbl.chat_opened then return end
	if not tbl then return end
	if ply:SteamID() != tbl.victim then return end

	if forgive then
		tbl.canceled = true
		if tbl.status == RDM_MANAGER_WAITING then
			tbl.status = RDM_MANAGER_FINISHED
			tbl.conclusion = TTTLogTranslate(_, "RDMManagerAuto").." "..TTTLogTranslate(_, "RDMCanceled")
			tbl.autoStatus = true
			tbl.admin = nil
			local syncEnt = dlogs:GetSyncEnt()
			if IsValid(syncEnt) then
				syncEnt:SetPendingReports(syncEnt:GetPendingReports() - 1)
			end
		end
	end

	for k, v in ipairs(player_GetHumans()) do
		if v:CanUseRDMManager() then
			if forgive then
				if v:IsActive() then
					v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, TTTLogTranslate(v.DMGLogLang, "TheReport") .. " #" .. index .. " " .. TTTLogTranslate(v.DMGLogLang, "HasCanceledByVictim"), 5, "vote_yes.wav")
				else
					v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(v.DMGLogLang, "HasCanceledReport"), ply:Nick(), index), 5, "vote_yes.wav")
				end
			else
				if v:IsActive() then
					v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, TTTLogTranslate(v.DMGLogLang, "NoMercy") .. " #" .. index .. " !", 5, "vote_yes.wav")
				else
					v:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(v.DMGLogLang, "DidNotForgive"), ply:Nick(), tbl.attacker_nick, index), 5, "vote_yes.wav")
				end
			end

			v:UpdateReport(previous, index)
		end
	end

	if forgive then
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(ply.DMGLogLang, "YouDecidedForgive"), tbl.attacker_nick), 5, "vote_yes.wav")
	else
		ply:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(ply.DMGLogLang, "YouDecidedNotForgive"), tbl.attacker_nick), 5, "vote_no.wav")
	end

	local attacker = GetBySteamID(tbl.attacker)

	if IsValid(attacker) then
		if forgive then
			attacker:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(attacker.DMGLogLang, "DecidedToForgiveYou"), ply:Nick()), 5, "vote_yes.wav")
		else
			attacker:dlogs_Notify(DAMAGELOG_NOTIFY_INFO, string_format(TTTLogTranslate(attacker.DMGLogLang, "DecidedNotToForgiveYou"), ply:Nick()), 5, "vote_no.wav")
		end
	end

	dlogs:SendLogToVictim(tbl)
	UpdatePreviousReports()

	hook.Run("dlogs_Discord", ply, IsValid(attacker) and attacker or tbl.attacker, forgive, index)
end)

net.Receive("dlogs.Answering", function(_len, ply)
	if IsValid(ply) and ply:IsPlayer() and (ply.lastAnswer == nil or (CurTime() - ply.lastAnswer) > 15) then
		net.Start("dlogs.Answering_global")
		net.WriteString(ply:Nick())
		net.Broadcast()
	end
	ply.lastAnswer = CurTime()
end)

net.Receive("dlogs.ForceRespond", function(_len, ply)
	local index = net.ReadUInt(16)
	local previous = net.ReadUInt(1) == 1
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and dlogs.Reports.Previous[index] or dlogs.Reports.Current[index]
	if not tbl then return end

	if not tbl.response then
		local attacker = GetBySteamID(tbl.attacker)

		if IsValid(attacker) then
			net.Start("dlogs.Death")
			net.Send(attacker)
		end
	end
end)
