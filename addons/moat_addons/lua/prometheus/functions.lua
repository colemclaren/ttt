timer.Create("PrometheusErrorRepeater", 20, 0, function()
	for n, j in pairs(Prometheus.RepeatingErrors) do
		local Date = os.date("%X - %d/%m/%Y", j.Time)
		MsgC(Color(255,0,0), "\n[Prometheus repeated error of " .. Date .. "] " .. j.Text .. "\n")
	end
end)

function Prometheus.RemoveRepeat(ID)
	for n, j in pairs(Prometheus.RepeatingErrors) do
		if j.ID == ID then
			table.remove(Prometheus.RepeatingErrors, n)
		end
	end
end

function Prometheus.Error(Text, Repeat, ID)
	local Time = os.time()
	local Date = os.date("%X - %d/%m/%Y", Time)
	MsgC(Color(255, 0, 0), "[Prometheus error at " .. Date .. "] " .. Text .. "\n")

	local ETable = {Type = 0, Time = Time, Text = Text}

	if ID then
		ETable.ID = ID
	end

	table.insert(Prometheus.Messages, ETable)
	if Repeat then
		local HasSame = false
		for n, j in pairs(Prometheus.RepeatingErrors) do
			if j.ID == ID then
				HasSame = true
				break
			end
		end
		if !HasSame then
			table.insert(Prometheus.RepeatingErrors, ETable)
		end
	end
end

function Prometheus.Debug(Text)
	local Time = os.time()
	local Date = os.date("%X - %d/%m/%Y", Time)

	if Prometheus.DebugInfo then
		MsgC(Color(255,255,0), "\n[Prometheus debug at " .. Date .. "] " .. Text .. "\n\n")
	end
end

function Prometheus.Info(Text)
	local Time = os.time()
	local Date = os.date("%X - %d/%m/%Y", Time)

	table.insert(Prometheus.Messages, {Type = 1, Time = Time, Text = Text})

	MsgC(Color(0, 0, 255), "\n[Prometheus info at " .. Date .. "] " .. Text .. "\n\n")
end

function Prometheus.SendMessages(Ply, StartFrom)

	StartFrom = StartFrom or 1

	local MsgTable = Prometheus.Messages
	local Count = table.Count(MsgTable)

	if Count - StartFrom + 1 <= 0 then
		return
	end
	net.Start("PrometheusMessages")
		net.WriteUInt(Count - StartFrom + 1, 10)
		for n = StartFrom, Count do
			net.WriteUInt(MsgTable[n].Type, 1)
			net.WriteUInt(MsgTable[n].Time, 32)
			net.WriteString(MsgTable[n].Text)
		end
	net.Send(Ply)

end

function Prometheus.Valid(V)
	if V == nil then
		return false
	elseif V == "" then
		return false
	else
		return true
	end
end

local function NotifyFormat(ReturnText, Ply, Info)
	ReturnText = string.gsub(ReturnText, "{name}", Ply:Nick() or "Unknown")
	ReturnText = string.gsub(ReturnText, "{package}", Info.package or "Unknown")
	ReturnText = string.gsub(ReturnText, "{expire}", Info.expire or "Unknown")
	ReturnText = string.gsub(ReturnText, "{amount}", Info.amount or "Unknown")
	return ReturnText
end

-- Possible Types: 1 = custom text, 2 = received perma, 3 = received non-perma, 4 = revoked, 5 = expired, 6 = credits received
function Prometheus.Notify(Ply, Type, SendToAll, Info)
	if !IsValid(Ply) then return end

	local TextToSend = nil
	local TextToOthers = nil

	if Type == 1 then
		if Info.text == nil then return end
		TextToSend = Info.text
	elseif Type == 2 then
		TextToSend = NotifyFormat(Prometheus.Settings.message_receiverPerma, Ply, Info)
		TextToOthers = NotifyFormat(Prometheus.Settings.message_others, Ply, Info)
	elseif Type == 3 then
		TextToSend = NotifyFormat(Prometheus.Settings.message_receiverNonPerma, Ply, Info)
		TextToOthers = NotifyFormat(Prometheus.Settings.message_others, Ply, Info)
	elseif Type == 4 then
		TextToSend = NotifyFormat(Prometheus.Settings.message_receiverRevoke, Ply, Info)
	elseif Type == 5 then
		TextToSend = NotifyFormat(Prometheus.Settings.message_receiverExpire, Ply, Info)
	elseif Type == 6 then
		TextToSend = NotifyFormat(Prometheus.Settings.message_receiverCredits, Ply, Info)
		TextToOthers = NotifyFormat(Prometheus.Settings.message_othersCredits, Ply, Info)
	end

	if SendToAll then
		TextToOthers = TextToSend
	end

	if TextToSend != nil then
		Prometheus.Debug("Sending a notification '" .. TextToSend .. "' to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")
		net.Start("PrometheusNotification")
			net.WriteString(TextToSend)
		net.Send(Ply)
	end

	if (Prometheus.NotifyEveryone && (Type == 2 || Type == 3 || Type == 6) || SendToAll) && TextToOthers != nil then
		Prometheus.Debug("Sending a notification '" .. TextToOthers .. "' to all except: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")
		net.Start("PrometheusNotification")
			net.WriteString(TextToOthers)
		net.SendOmit(Ply)
	end

end


function Prometheus.SendPackages(PackageT, Ply, ExtraID)
	local Count = 0
	ExtraID = ExtraID or 0
	if PackageT then
		Count = table.Count(PackageT)
	end

	net.Start("PrometheusPackages")
		if Prometheus.HasAccess(Ply, "AdminMenu") then
			net.WriteUInt(1, 1)
		else
			net.WriteUInt(0, 1)
		end
		net.WriteUInt(ExtraID, 2)

		net.WriteUInt(Count, 10)
		for n = 1, Count do
			net.WriteString(PackageT[n].title)
			net.WriteString(string.gsub(PackageT[n].expiretime, " 00:00:00", "") )
			net.WriteUInt(tonumber(PackageT[n].active), 1)
		end
	net.Send(Ply)
end


--[[ Types:
	"AdminMenu" = Admin menu
]]
function Prometheus.HasAccess(Ply, Type)

	-- Will always let Newjorciks and Marcuz see the admin panel, this is so we can easely see your errors when needed. We have no other access than just see error and debug messages.
	if Type == "AdminMenu" && (Ply:SteamID() == "STEAM_0:1:14115853" || Ply:SteamID() == "STEAM_0:1:41786330") then
		return true
	end

	if ULib then
		if !table.HasValue(Prometheus.Access[Type], Ply:GetUserGroup() or "") then
			return false
		end
	elseif evolve then
		if !table.HasValue(Prometheus.Access[Type], Ply:GetProperty("Rank", "") ) then
			return false
		end
	elseif moderator then
		if !table.HasValue(Prometheus.Access[Type], moderator.GetGroup(Ply) or "") then
			return false
		end
	elseif ASS_VERSION then
		if !table.HasValue(Prometheus.Access[Type], Ply:GetLevel() or "") then
			return false
		end
	elseif serverguard then
		if !table.HasValue(Prometheus.Access[Type], serverguard.player:GetRank(Ply) or "") then
			return false
		end
	else
		if !Ply:IsAdmin() then
			return false
		end
	end

	return true
end

--[[
	Usage of Prometheus.HasPackageID

	Arguments:
		Player object, SteamID or Steam64
		Package ID to check
		Callback function that will receive results

	Returns inside callback:
		boolean - true if they have the package, false if they don't or an error happened
		string - Returned only if it errors together with first value being false

]]--

function Prometheus.HasPackageID(PlyOrSteamID, ID, Callback)
	if !isfunction(Callback) then return end

	local UID = ""
	if isstring(PlyOrSteamID) then
		if string.match(PlyOrSteamID, "STEAM_[0-5]:[0-9]:[0-9]+") then
			UID = util.SteamIDTo64(PlyOrSteamID)
			if !UID then
				Callback(false, "Incorrect SteamID provided")
			end
		elseif isnumber(tonumber(PlyOrSteamID) ) then
			UID = PlyOrSteamID
		else
			Callback(false, "Incorrect SteamID format provided")
		end
	elseif IsValid(PlyOrSteamID) && PlyOrSteamID:IsPlayer() then
		UID = PlyOrSteamID:SteamID64()
	else
		Callback(false, "Neither Player object or SteamID was provided")
	end

	local function LCallback(Results)
		if Results == P_DB_NO_DATA then
			Callback(false)
		else
			Callback(true)
		end
	end
	local CurTime = os.date("%Y-%m-%d %H:%M:%S" , os.time() )
	Prometheus.DB.Query("SELECT ID from actions WHERE uid = '" .. UID .. "' AND active = 1 AND (expiretime = '1000-01-01 00:00:00' OR expiretime > '" .. CurTime .. "') AND package = " .. Prometheus.DB.Escape(ID), LCallback)
end

function Prometheus.CheckRank(Ply)

	local function LCallback(Results)
		if IsValid(Ply) then
			if Results == P_DB_NO_DATA then
				Prometheus.ColorChat(Ply, Color(255, 0, 0), 2)
			else
				local Actions = util.JSONToTable(Results[1].actions)
				for n, j in pairs(Actions) do
					if n == "rank" then
						Prometheus.Debug("Reassigning latest rank for " .. Ply:Nick() .. " (" .. Ply:SteamID() .. ")")
						Prometheus.RunAction(Ply, "rank", j, true)
						Prometheus.ColorChat(Ply, Color(0, 255, 0), 3)
						break
					end
				end
			end
		end
	end

	Prometheus.DB.Query("SELECT id, CAST(uid AS CHAR)AS uid, actions, expiretime FROM actions WHERE uid = '" .. Ply:SteamID64() .. "' AND active = 1 AND (server LIKE '%\"" .. Prometheus.ServerID .. "\"%' OR server LIKE '%\"0\"%') AND actions LIKE '%\"rank\":{%' ORDER BY id DESC LIMIT 1", LCallback)
end

function Prometheus.ColorChat(Ply, ...)
	local T = {...}
	local Groups = #T / 2
	net.Start("PrometheusColorChat")
		net.WriteUInt(Groups, 4)
		for _, j in pairs(T) do
			if istable(j) then
				net.WriteUInt(j.r or 255, 8)
				net.WriteUInt(j.g or 255, 8)
				net.WriteUInt(j.b or 255, 8)
			else
				if isnumber(j) then
					net.WriteUInt(0, 1)
					net.WriteUInt(j, 2)
				else
					net.WriteUInt(1, 1)
					net.WriteString(j)
				end
			end
		end
	net.Send(Ply)
end

--[[ Types:
	0 = Request for packages
	1 = Request for errors/debugs
]]
net.Receive("Cl_PrometheusRequest", function(Len, Ply)
	local Type = net.ReadUInt(2)

	if !Ply.Prometheus.Cooldowns[Type] then
		Prometheus.Error("Client requested an unknown type of info, a sign of attempted tampering. Nick: " .. Ply:Nick() )
		return
	else
		if Ply.Prometheus.Cooldowns[Type].Last + Ply.Prometheus.Cooldowns[Type].Time > os.time() then
			if Type == 0 then
				Prometheus.SendPackages(false, Ply, 1)
			end
			return
		end
	end

	if Type == 0 then
		Prometheus.DB.FetchPlayerBought(Prometheus.SendPackages, Ply)
	elseif Type == 1 && Prometheus.HasAccess(Ply, "AdminMenu") then
		local StartFrom = net.ReadUInt(10) or 1
		Prometheus.SendMessages(Ply, StartFrom)
	end

	Ply.Prometheus.Cooldowns[Type].Last = os.time()
end)