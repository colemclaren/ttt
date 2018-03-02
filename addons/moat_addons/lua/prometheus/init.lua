if !Prometheus then

	-- Create all the tables
	Prometheus = {}
	Prometheus.DB = {}
	Prometheus.Mysql = {}
	Prometheus.Packages = {}
	Prometheus.Actions = {}
	Prometheus.Transactions = {}
	Prometheus.Transactions.Fetched = {}
	Prometheus.Weapons = {}
	Prometheus.Temp = {}
	Prometheus.Settings = {}
	Prometheus.FallbackSettings = {}
	Prometheus.Messages = {}
	Prometheus.RepeatingErrors = {}
	Prometheus.Access = {}
	Prometheus.CustomJobPool = {}

	Prometheus.PlayerTable = {}
		Prometheus.PlayerTable.Spawn = {}
		Prometheus.PlayerTable.PlayerLoadout = {}
		Prometheus.PlayerTable.Cooldowns = {}


	Prometheus.LuaVersion = "1.6.3.11" -- This is different from the website version, they don't have to be same
	Prometheus.ModuleFail = false

	Prometheus.LastActionUpdate = "1000-01-01 00:00:00"

	-- Create all the net messages
	util.AddNetworkString("PrometheusNotification")
	util.AddNetworkString("PrometheusMessages")
	util.AddNetworkString("PrometheusPackages")
	util.AddNetworkString("Cl_PrometheusRequest")
	util.AddNetworkString("PrometheusCustomJob")
	util.AddNetworkString("PrometheusColorChat")


	include("prometheus/functions.lua")

	include("prometheus/database.lua")

	Msg("||||||||||||||||||||||||||||||||||\n")
	Msg("||				||\n")
	Msg("||	Loading  Prometheus	||\n" )
	Msg("||				||\n")
	Msg("||||||||||||||||||||||||||||||||||\n")


	AddCSLuaFile("prometheus_client_config.lua")
	AddCSLuaFile("prometheus/cl_init.lua")
	AddCSLuaFile("prometheus/cl_notifications.lua")
	AddCSLuaFile("prometheus/cl_menu.lua")


	include("prometheus_config.lua")

	Prometheus.PlayerTable.Cooldowns[0] = {Time = Prometheus.PlayerPackageCooldown or 10, Last = 0}
	Prometheus.PlayerTable.Cooldowns[1] = {Time = 0, Last = 0}


	include("prometheus/transactions.lua")


	include("prometheus/actions.lua")
	Prometheus.SetActions()


	include("prometheus/weapons.lua")


	timer.Create("PrometheusActionRefreshTimer", Prometheus.RefreshTime, 0, Prometheus.DB.FetchIfUpdated)


	Prometheus.SkipActions = {"xenforo", "teamspeak"}


	if Prometheus.DB.ModuleFail then
		MsgC( Color( 255, 0, 0 ), "||				||\n")
		MsgC( Color( 255, 0, 0 ), "||	Couldn't load DB module	||\n")
		MsgC( Color( 255, 0, 0 ), "||	Add-on will not work	||\n")
		MsgC( Color( 255, 0, 0 ), "||				||\n")
		MsgC( Color( 255, 0, 0 ), "||||||||||||||||||||||||||||||||||\n")
	else
		Msg("||				||\n")
		Msg("||	" .. Prometheus.DB.Module.Name .. " " .. Prometheus.DB.Module.Version .. " loaded	||\n")
		Msg("||				||\n")
		Msg("||	loaded succesfully	||\n")
		Msg("||				||\n")
		Msg("||||||||||||||||||||||||||||||||||\n")
	end

	hook.Run("PrometheusInitialized")
end

local function SetPlayerTable(Ply)
	if !Ply.Prometheus then
		Ply.Prometheus = {}
		Ply.Prometheus = table.Copy(Prometheus.PlayerTable)
	end
end

hook.Add("PlayerInitialSpawn", "PrometheusPlayerInitialSpawnHook", function(Ply)
	if !Ply:IsBot() then
		SetPlayerTable(Ply)
		timer.Simple(0, function()
			if IsValid(Ply) then
				Prometheus.Transactions.Get(Ply)
			end
		end)

		for n, j in ipairs(Prometheus.CustomJobPool) do
			net.Start("PrometheusCustomJob")
				net.WriteUInt(1, 1)
				net.WriteString(j.Code)
				net.WriteUInt(j.Num, 8)
			net.Send(Ply)
		end
	end
end)

hook.Add("PlayerSpawn", "PrometheusPlayerSpawnHook", function(Ply)
	if !Ply:IsBot() then
		SetPlayerTable(Ply)
		if table.Count(Ply.Prometheus.Spawn) > 0 then
			for n, j in ipairs(Ply.Prometheus.Spawn) do
				Prometheus.RunAction(Ply, j.actionname, j.values, {id = j.id, type = 1})
			end
		end
	end
end)

hook.Add("PlayerLoadout", "PrometheusPlayerLoadoutHook", function(Ply)
	if !Ply:IsBot() then
		SetPlayerTable(Ply)
		if table.Count(Ply.Prometheus.PlayerLoadout) > 0 then
			for n, j in ipairs(Ply.Prometheus.PlayerLoadout) do
				Prometheus.RunAction(Ply, j.actionname, j.values, {id = j.id, type = 1})
			end
		end
	end
end)

hook.Add( "PlayerSay", "PrometheusChatHook", function (Ply, Text, Public)
	local Cmd
	if Prometheus.WebsiteEnabled || Prometheus.WebsiteEnabled == nil then
		Cmd = (Prometheus.WebsiteCmd or "!donatemenu") .. " "
		if (string.sub(Text:lower() .. " ", 1, Cmd:len() ) == Cmd) then
			Ply:ConCommand("Prometheus")
			return false
		end
	end

	Cmd = (Prometheus.OpenDonationCmd or "!donate") .. " "
	if (string.sub(Text:lower() .. " ", 1, Cmd:len() ) == Cmd) then
		Ply:ConCommand("PrometheusSite")
		return false
	end

	if Prometheus.CanCheckRankCmd || Prometheus.CanCheckRankCmd == nil then
		Cmd = (Prometheus.CheckRankCmd or "!checkrank") .. " "
		if (string.sub(Text:lower() .. " ", 1, Cmd:len() ) == Cmd) then
			if Ply.PromCheckRankTimeout && Ply.PromCheckRankTimeout > os.time() then
				Prometheus.ColorChat(Ply, Color(255, 0, 0), 1)
			else
				Prometheus.CheckRank(Ply)
				Ply.PromCheckRankTimeout = os.time() + 60
			end
			return false
		end
	end
end)

local Times = 0

hook.Add("Think", "PrometheusConnectToDatabaseHook", function()
	if !Prometheus.DB.WaitFor[P_DB_CONNECTED] && Times > 4 then
		hook.Remove("Think", "PrometheusConnectToDatabaseHook")
		if !Prometheus.ModuleFail then
			Prometheus.DB.Connect()
		end
		if DarkRP && DarkRP.createCategory then
			DarkRP.createCategory{
				name = "Donator Jobs",
				categorises = "jobs",
				startExpanded = true,
				color = Color(193, 0, 0, 255),
			}
		end
	end
	Times = Times + 1
end)

concommand.Add("PrometheusDebug", function(Ply)
	if IsValid(Ply) then return end

	Prometheus.DebugInfo = true

	MsgC(Color(255,255,0), "\nPrometheus debug enabled for the next 5 minutes.\n\n")

	timer.Simple(300, function() Prometheus.DebugInfo = false end)
end)