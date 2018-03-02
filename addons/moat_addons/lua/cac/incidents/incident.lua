local self = {}
CAC.Incident = CAC.MakeConstructor (self, CAC.Incident)

function CAC.Incident.QualifiedIncidentIdFromSteamIdAndIncidentId (steamId, incidentId)
	return steamId .. "/" .. incidentId
end

function CAC.Incident.SteamIdAndIncidentIdFromQualifiedIncidentId (qualifiedIncidentId)
	local steamId, incidentId = string.match (qualifiedIncidentId, "(STEAM_0:%d+:%d+)/(%d+)")
	incidentId = tonumber (incidentId)
	
	return steamId, incidentId
end

function CAC.Incident.IsQualifiedIncidentId (str)
	return string.match (str, "STEAM_0:%d+:%d+/%d+") ~= nil
end

function CAC.Incident.GenerateSelectQuery (id, database)
	return "SELECT * FROM cac_incidents WHERE id = " .. tostring (id)
end

function CAC.Incident.GenerateMultipleSelectQuery (steamId, limit, database)
	return "SELECT * FROM cac_incidents WHERE playerSteamId = '" .. database:EscapeString (steamId) .. "' ORDER BY id DESC LIMIT " .. tostring (limit)
end

function CAC.Incident.GenerateRangeSelectQuery (steamId, nameSearchTerm, dataRange, database)
	local query = "SELECT * FROM cac_incidents WHERE "
	
	if steamId then
		query = query .. "playerSteamId = '" .. database:EscapeString (steamId) .. "' AND "
	end
	
	if nameSearchTerm then
		nameSearchTerm = string.gsub (nameSearchTerm, "\\", "\\\\")
		nameSearchTerm = string.gsub (nameSearchTerm, "%%", "\\%")
		query = query .. "playerName LIKE '%" .. database:EscapeString (nameSearchTerm) .. "%' ESCAPE '\\' AND "
	end
	
	-- anchor
	query = query .. "id "
	query = query .. (dataRange:GetDirection () == CAC.PageDirection.Previous and ">" or "<")
	if dataRange:GetIncludeAnchor () then query = query .. "=" end
	query = query .. " "
	
	if dataRange:GetAnchorId () == math.huge then query = query .. "1e9000"
	elseif dataRange:GetAnchorId () == -math.huge then query = query .. "-1e9000"
	else query = query .. tostring (dataRange:GetAnchorId ()) end
	query = query .. " "
	
	-- direction
	query = query .. "ORDER BY id " .. (dataRange:GetDirection () == CAC.PageDirection.Previous and "ASC" or "DESC") .. " "
	
	-- limit
	query = query .. "LIMIT " .. tostring (dataRange:GetLimit ()) .. " "
	
	-- offset
	query = query .. "OFFSET " .. tostring (dataRange:GetSkipCount ()) .. " "
	
	return query
end

function CAC.Incident.GenerateTableCreationQuery (database)
	local query = "CREATE TABLE IF NOT EXISTS cac_incidents (" ..
		"id                        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT," ..
		"timestamp                 INTEGER NOT NULL," ..
		"playerSteamId             TEXT    NOT NULL," ..
		"playerName                TEXT    NOT NULL," ..
		"sessionId                 INTEGER NOT NULL," ..
		"response                  INTEGER NOT NULL," ..
		"responseExecuted          INTEGER NOT NULL," ..
		"responseSuppressed        INTEGER NOT NULL," ..
		"responseSuppressorSteamId TEXT    NOT NULL," ..
		"responseSuppressorName    TEXT    NOT NULL," ..
		"responseApproved          INTEGER NOT NULL," ..
		"responseApproverSteamId   TEXT    NOT NULL," ..
		"responseApproverName      TEXT    NOT NULL" ..
	");"
	
	query = string.gsub (query, " +", " ")
	
	return query
end

function CAC.Incident.FromDatabaseRow (row, incident)
	incident = incident or CAC.Incident ()
	
	incident:SetId                        (tonumber (row.id))
	
	incident:SetTimestamp                 (tonumber (row.timestamp))
	incident:SetPlayerSteamId             (row.playerSteamId)
	incident:SetPlayerName                (row.playerName)
	incident:SetSessionId                 (tonumber (row.sessionId))
	
	incident:SetResponse                  (tostring (row.response))
	incident:SetResponseExecuted          (tonumber (row.responseExecuted) ~= 0)
	
	incident:SetResponseSuppressed        (tonumber (row.responseSuppressed) ~= 0)
	incident:SetResponseSuppressorSteamId (row.responseSuppressorSteamId)
	incident:SetResponseSuppressorName    (row.responseSuppressorSteamName)
	
	incident:SetResponseApproved          (tonumber (row.responseApproved) ~= 0)
	incident:SetResponseApproverSteamId   (row.responseApproverSteamId)
	incident:SetResponseApproverName      (row.responseApproverSteamName)
	
	return incident
end

function CAC.Incident.FromPlayerSession (playerSession, timestamp, incident)
	incident = incident or CAC.Incident ()
	
	incident:SetTimestamp                 (timestamp)
	incident:SetPlayerSteamId             (playerSession:GetAccountInformation ():GetSteamId     ())
	incident:SetPlayerName                (playerSession:GetAccountInformation ():GetDisplayName ())
	incident:SetSessionId                 (playerSession:GetSessionId ())
	
	incident:SetResponse                  (CAC.DetectionResponse.Ignore)
	incident:SetResponseExecuted          (false)
	
	incident:SetResponseSuppressed        (false)
	incident:SetResponseSuppressorSteamId ("")
	incident:SetResponseSuppressorName    ("")
	
	incident:SetResponseApproved          (false)
	incident:SetResponseApproverSteamId   ("")
	incident:SetResponseApproverName      ("")
	
	return incident
end

function self:ctor ()
end

function self:GetQualifiedIncidentId ()
	return self:GetPlayerSteamId () .. "/" .. tostring (self:GetId ())
end

function self:GetPlayerSession ()
	local playerInformation = CAC.PlayerInformationManager:GetPlayerInformation (self:GetPlayerSteamId ())
	if not playerInformation then return nil end
	
	return playerInformation:GetSession (self.SessionId)
end

function self:GenerateUpdateQuery (database)
	return "UPDATE cac_incidents SET " ..
		"timestamp                 = " .. tostring (self:GetTimestamp ()) .. "," ..
		"playerSteamId             = '" .. database:EscapeString (self:GetPlayerSteamId ()) .. "'," ..
		"playerName                = '" .. database:EscapeString (self:GetPlayerName    ()) .. "'," ..
		"sessionId                 = " .. tostring (self:GetSessionId ()) .. "," ..
		"response                  = " .. tostring (self:GetResponse ()) .. "," ..
		"responseExecuted          = " .. (self:GetResponseExecuted   () and "1" or "0") .. "," ..
		"responseSuppressed        = " .. (self:GetResponseSuppressed () and "1" or "0") .. "," ..
		"responseSuppressorSteamId = '" .. database:EscapeString (self:GetResponseSuppressorSteamId ()) .. "'," ..
		"responseSuppressorName    = '" .. database:EscapeString (self:GetResponseSuppressorName   ()) .. "'," ..
		"responseApproved          = " .. (self:GetResponseSuppressed () and "1" or "0") .. "," ..
		"responseApproverSteamId   = '" .. database:EscapeString (self:GetResponseSuppressorSteamId ()) .. "'," ..
		"responseApproverName      = '" .. database:EscapeString (self:GetResponseSuppressorName   ()) .. "' " ..
	"WHERE id = " .. tostring (self:GetId ())
end

function self:GenerateInsertQuery (database)
	return "INSERT INTO cac_incidents (" ..
		"timestamp," ..
		"playerSteamId," ..
		"playerName," ..
		"sessionId," ..
		"response," ..
		"responseExecuted," ..
		"responseSuppressed," ..
		"responseSuppressorSteamId," ..
		"responseSuppressorName," ..
		"responseApproved," ..
		"responseApproverSteamId," ..
		"responseApproverName" ..
	") VALUES (" ..
		tostring (self:GetTimestamp ()) .. "," ..
		"'" .. database:EscapeString (self:GetPlayerSteamId ()) .. "'," ..
		"'" .. database:EscapeString (self:GetPlayerName    ()) .. "'," ..
		tostring (self:GetSessionId ()) .. "," ..
		tostring (self:GetResponse ()) .. "," ..
		(self:GetResponseExecuted   () and "1" or "0") .. "," ..
		(self:GetResponseSuppressed () and "1" or "0") .. "," ..
		"'" .. database:EscapeString (self:GetResponseSuppressorSteamId ()) .. "'," ..
		"'" .. database:EscapeString (self:GetResponseSuppressorName    ()) .. "'," ..
		(self:GetResponseApproved () and "1" or "0") .. "," ..
		"'" .. database:EscapeString (self:GetResponseApproverSteamId ()) .. "'," ..
		"'" .. database:EscapeString (self:GetResponseApproverName    ()) .. "'" ..
	")"
end

function self:Suppress (steamId, name)
	self:SetResponseSuppressed        (true)
	self:SetResponseSuppressorSteamId (steamId)
	self:SetResponseSuppressorName    (name)
end

function self:Unsuppress ()
	self:SetResponseSuppressed        (false)
	self:SetResponseSuppressorSteamId ("")
	self:SetResponseSuppressorName    ("")
end