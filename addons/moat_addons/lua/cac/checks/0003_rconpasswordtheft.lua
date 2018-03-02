local self, info = CAC.Checks:RegisterCheck ("RconPasswordTheft", CAC.Check)

info:SetName ("RCON Password Theft")
info:SetDescription ("Detects when a client steals the server's RCON password.")

function self:ctor (livePlayerSession)
end

function self:OnStarted ()
	self:SetStatus ("Sending RCON password theft detector...")
	
	self:SendPayload ("RconPasswordTheftDetector",
		function (inBuffer)
			return self:DispatchCall ("OnResponse", inBuffer)
		end,
		function ()
			self:DispatchCall ("OnTimedOut")
		end
	)
	
	self:Finish ()
end

function self:OnResponse (inBuffer)
	self:ProcessReports (inBuffer)
	
	return true
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for RCON password theft detector timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "RCON password theft detector report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReports (inBuffer, returnValues)
	local reportCount = inBuffer:UInt16 ()
	
	if CAC.IsDebug then
		CAC.Logger:Message ("Received " .. tostring (reportCount) .. " " .. self:GetName () .. " report entr".. (reportCount == 1 and "y" or "ies") .. ".")
	end
	
	for i = 1, reportCount do
		local ret = self:ProcessReportEntry (inBuffer)
		
		if returnValues then
			returnValues [i] = ret
		end
	end
	
	local duration = inBuffer:Double ()
end

function self:ProcessReportEntry (inBuffer)
	local fileName = inBuffer:StringN16 ()
	local hash     = inBuffer:UInt32    ()
	
	if CAC.ConfigMonitor:ContainsFileHash (fileName, hash) then
		local ipAddress = self:GetLivePlayerSession ():GetPlayerSession ():GetLocationInformation ():GetIP ()
		ipAddress = CAC.IPToString (ipAddress)
		
		self:AddDetectionReasonFiltered ("RconPasswordTheft", "Detected theft of " .. CAC.String.EscapeNonprintable (string.lower (fileName)) .. "! IP banning " .. ipAddress .. ". To unban, use \"removeip " .. ipAddress .. "\".")
		
		-- Ban immediately.
		RunConsoleCommand ("addip", "0", ipAddress)
		
		-- Tell admins to change rcon password
		local displayName = self:GetLivePlayerSession ():GetPlayerSession ():GetAccountInformation ():GetDisplayName ()
		local steamId     = self:GetLivePlayerSession ():GetSteamId ()
		
		local message = displayName .. " (" .. steamId .. ", " .. ipAddress .. ") has stolen the server's RCON password (" .. CAC.String.EscapeNonprintable (string.lower (fileName)) .. "). Please ensure that it is changed as soon as possible."
		for _, ply in ipairs (player.GetAll ()) do
			if CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then
				ply:ChatPrint (message)
			end
		end
		
		MsgC (CAC.Colors.Red, message .. "\n")
	end
end