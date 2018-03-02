Prometheus.DB.ModuleFail = false
Prometheus.DB.Connected = false

P_DB_NO_DATA = false


-- WaitFor types:
P_DB_CONNECTED = 10
P_DB_INITIALIZED = 11

Prometheus.DB.WaitFor = {}



Prometheus.DB.Module = {}
Prometheus.DB.QueueList = {}
Prometheus.DB.QueueListStack = {}

local tmysqlSucc = pcall(require, "tmysql4")
local mysqlooSucc = nil

if tmysqlSucc then
	include("prometheus/tmysql.lua")
else
	mysqlooSucc = pcall(require, "mysqloo")
end

if mysqlooSucc then
	include("prometheus/mysqloo.lua")
end

if !tmysqlSucc && !mysqlooSucc then
	Prometheus.DB.ModuleFail = true
	Prometheus.Error("Neither MySQLoo or tmysql4 module could be loaded! Please go to  http://wiki.prometheusipn.com/index.php?title=Installation:lua_prerequisites  and follow the instructions on how to install MySQLoo or tmysql4!", true)
end

function Prometheus.DB.Error(Err, QueryS)
	Debug = debug.getinfo(2)
	if !Debug then
		Debug = debug.getinfo(1)
	end
	local File = string.Explode("lua/prometheus/", Debug.source)[2] or Debug.source

	Prometheus.Error("Failed interacting with DB, FILE " .. File .. ", LINE " .. Debug.currentline .. ", QUERY \"" .. QueryS .. "\" error: " .. (Err or "You have old version of tmysql4 or mysqloo, download latest, both files for the appropriate module! http://wiki.prometheusipn.com/index.php?title=Installation:lua_prerequisites") )

	if Prometheus.DB.Module.Name == "MySQLoo" && Err == "MySQL server has gone away" then
		Prometheus.DB.StopQueue(P_DB_CONNECTED)
		Prometheus.DB.Connect()
	end
end

function Prometheus.DB.Connect()
	Prometheus.Debug("Connecting to database.")

	if Prometheus.DB.ModuleFail then return end

	local function LCallback(Err)
		if Err then
			Prometheus.DB.StopQueue(P_DB_CONNECTED)
			Prometheus.Error("DB Connection failed! Error msg: " .. Err, true, "DBConnect")
		else
			Prometheus.DB.StartQueue(P_DB_CONNECTED)
			Msg("[Prometheus] DB Connection succesful\n")
			Prometheus.Debug("Connected to database successfully.")
			Prometheus.RemoveRepeat("DBConnect")
			hook.Run("PrometheusDBConnected")
			if tmysqlSucc then
				Prometheus.DB.Module.DB:SetCharacterSet("utf8")
				Prometheus.DB.GetSettings()
			else
				Prometheus.DB.Query("SET NAMES utf8", function() Prometheus.DB.GetSettings() end)
			end
		end

	end

	Prometheus.DB.Module.Connect(LCallback)
end

function Prometheus.DB.Query(QueryS, Callback, BypassWaitFor)
	if Prometheus.DB.Module.DB == nil then return end
	if !Prometheus.DB.WaitFor[P_DB_INITIALIZED] && !Prometheus.DB.WaitFor[P_DB_CONNECTED] then
		if ByPassWaitFor != P_DB_INITIALIZED then
			Prometheus.DB.Queue(QueryS, P_DB_INITIALIZED, Callback)
			return
		end
	end

	Prometheus.DB.Module.Query(QueryS, Callback or function() end)
end

function Prometheus.DB.StopQueue(WaitFor)
	Prometheus.DB.WaitFor[WaitFor] = nil
end

function Prometheus.DB.StartQueue(WaitFor, SkipSet)
	if !SkipSet then
		Prometheus.DB.WaitFor[WaitFor] = true
	end

	if Prometheus.DB.QueueListStack[WaitFor] then
		Prometheus.DB.Query(Prometheus.DB.QueueListStack[WaitFor])
		Prometheus.DB.QueueListStack[WaitFor] = nil
	end

	for n, j in pairs(Prometheus.DB.QueueList) do
		if j.WaitFor == WaitFor then
			Prometheus.DB.Query(j.QueryS, j.Callback)
			table.remove(Prometheus.DB.QueueList, n)
		end
	end
end

function Prometheus.DB.Escape(String, Quotes)
	if isstring(String) then
		if Prometheus.DB.WaitFor[P_DB_CONNECTED] then
			String = Prometheus.DB.Module.Escape(String)
		else
			String = SQLStr(String, true)
		end
	else
		String = tostring(String)
	end

	if Quotes == false then
		return String
	else
		return "'" .. String .. "'"
	end
end

function Prometheus.DB.Queue(QueryS, WaitFor, Callback)

	if Prometheus.DB.WaitFor[WaitFor] then
		Prometheus.DB.Query(QueryS, Callback)
		return
	end

	local Stack = false
	if !Callback then
		Stack = true
	end

	if Stack then
		local CurrStack = Prometheus.DB.QueueListStack[WaitFor]
		if !Currstack then
			Prometheus.DB.QueueListStack[WaitFor] = QueryS
		else
			Prometheus.DB.QueueListStack[WaitFor] = CurrStack .. ";" .. QueryS
		end
	else
		table.insert(Prometheus.DB.QueueList, {QueryS = QueryS, Callback = Callback, WaitFor = WaitFor})
	end
end

function Prometheus.DB.GetSettings()
	Prometheus.Debug("Fetching settings(When first person joins).")

	if !Prometheus.LoadSettingsFromDB then
		Prometheus.Debug("Using FallBackSettings because DB setting loading is disabled.")
		Prometheus.Settings = Prometheus.FallbackSettings
		hook.Run("PrometheusDBInitialized")
		return
	end

	local function LCallback(Results)
		if Results == P_DB_NO_DATA then
			Prometheus.Error("Failed fetching settings from database! Changing to fallback settings!")
			Prometheus.Settings = Prometheus.FallbackSettings
		else
			Prometheus.Debug("Settings loaded successfully.")
			for n, j in ipairs(Results) do
				Prometheus.Settings[j.name] = j.value
			end
			hook.Run("PrometheusDBInitialized")
		end
	end

	Prometheus.DB.Query("SELECT name, value FROM settings WHERE name LIKE '%message_%'", LCallback, P_DB_INITIALIZED)
end

function Prometheus.DB.FetchPlayerBought(Callback, Ply)
	if !Prometheus.DB.WaitFor[P_DB_INITIALIZED] then Callback(false, Ply, 2) return false end

	Prometheus.Debug("Fetching " .. Ply:Nick() .. "(" .. Ply:SteamID() .. ") bought packages.")

	local function LCallback(Results)
		Callback(Results, Ply)
	end

	Prometheus.DB.Query("SELECT actions.active, actions.expiretime, packages.title FROM actions INNER JOIN packages ON actions.package = packages.ID WHERE actions.uid = '" .. Ply:SteamID64() .. "' AND (actions.server LIKE '%\"" .. Prometheus.ServerID .. "\"%' OR actions.server LIKE '%\"0\"%') GROUP BY actions.timestamp DESC", LCallback)
end

function Prometheus.DB.FetchPlayerActions(Callback, Ply)
	if !Prometheus.DB.WaitFor[P_DB_INITIALIZED] then return false end

	Prometheus.Debug("Fetching " .. Ply:Nick() .. "(" .. Ply:SteamID() .. ") actions.")

	local CurTime = os.date("%Y-%m-%d %H:%M:%S" , os.time() )

	local function LCallback(Results)
		Callback(Results, Ply)
	end

	Prometheus.DB.Query("SELECT id, CAST(uid AS CHAR)AS uid, server, buyer_name, actions, delivered, expiretime, active, runonce FROM actions WHERE uid = '" .. Ply:SteamID64() .. "' AND ( (delivered = 0 AND active = 1) OR (delivered = 1 AND active = 1 AND runonce = 0) OR (delivered = 0 AND active = 0) OR (expiretime < '" .. CurTime .. "' AND expiretime != '1000-01-01 00:00:00' AND active = '1') ) AND (server LIKE '%\"" .. Prometheus.ServerID .. "\"%' OR server LIKE '%\"0\"%')", LCallback)
end

function Prometheus.DB.FetchActions(Callback)
	if !Prometheus.DB.WaitFor[P_DB_INITIALIZED] then return false end

	Prometheus.Debug("Fetching actions.")

	local CurTime = os.date("%Y-%m-%d %H:%M:%S" , os.time() )

	local function LCallback(Results)
		Callback(Results)
	end

	Prometheus.DB.Query("SELECT id, CAST(uid AS CHAR)AS uid, buyer_name, actions, delivered, expiretime, active, runonce FROM actions WHERE (delivered = '0' OR (expiretime < '" .. CurTime .. "' AND expiretime != '1000-01-01 00:00:00' AND active = '1')) AND (server LIKE '%\"" .. Prometheus.ServerID .. "\"%' OR server LIKE '%\"0\"%')", LCallback)
end

function Prometheus.DB.FetchIfUpdated()
	if !Prometheus.DB.WaitFor[P_DB_INITIALIZED] then return false end

	Prometheus.Debug("Fetching if any action have been updated.")

	local function LCallback(Results)
		if Results == P_DB_NO_DATA then
			Prometheus.Error("There seems to be no 'actions_lastupdated' in your database 'settings' table, make sure it's therem if not you need to re-run web side installation. If it is there make support ticket on nmscripts.com")
			return
		end
		for n, j in pairs(Results) do
			if j.value3 != Prometheus.LastActionUpdate then
				Prometheus.Debug("Actions HAVE been updated.")
				Prometheus.LastActionUpdate = j.value3
				Prometheus.Transactions.Get()
			else
				Prometheus.Debug("Actions have NOT been updated. Last update: " .. j.value3)
			end
		end
	end

	Prometheus.DB.Query("SELECT value3 FROM settings WHERE name = 'actions_lastupdated'", LCallback)
end

function Prometheus.DB.UpdateAction(ID, UT)
	if !istable(UT) || table.Count(UT) < 1 then
		Prometheus.Error("Trying to update an action without any updating values")
		return
	end

	local UpdateTable = {}

	for n, j in pairs(UT) do
		if istable(j) then
			j = util.TableToJSON(j)
			j = Prometheus.DB.Escape(j)
		end
		table.insert(UpdateTable, n .. " = " .. j)
	end

	local UpdateString = table.concat(UpdateTable, ", ")

	Prometheus.Debug("Updating action, ID = " .. ID .. "\n" .. UpdateString)

	local function LCallback(Results)
		Prometheus.Debug("Updating successful on ID " .. ID .. "!")
	end

	Prometheus.DB.Query("Update actions SET " .. UpdateString .. " WHERE id = '" .. ID .. "'", LCallback)
end

hook.Add("PrometheusDBInitialized","PrometheusDBInitializedDatabaseHook", function() Prometheus.DB.StartQueue(P_DB_INITIALIZED) end)