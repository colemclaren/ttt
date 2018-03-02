if !Prometheus then
	Prometheus = {}
	Prometheus.Notify = {}
	Prometheus.Notifications = {}
	Prometheus.Menu = {}
	Prometheus.Menu.Base = {}
	Prometheus.Lang = {}

	include("prometheus_client_config.lua")
	include("prometheus/cl_notifications.lua")
	include("prometheus/cl_menu.lua")

	surface.CreateFont("PrometheusTitle", {
		font = "verdana",
		size = 26,
		weight = 700
	})

	surface.CreateFont("PrometheusText", {
		font = "verdana",
		size = 15,
		weight = 700
	})

end

hook.Add("PostGamemodeLoaded", "PrometheusPostGamemodeLoadedInit", function()
	if DarkRP && DarkRP.createCategory then
		DarkRP.createCategory{
			name = "Donator Jobs",
			categorises = "jobs",
			startExpanded = true,
			color = Color(193, 0, 0, 255),
		}
	end
end)

net.Receive("PrometheusAction", function()
	local Type = net.ReadUInt(1)

	if Type == 0 then
		Prometheus.Menu.Open()
		Prometheus.Website = net.ReadString()
	end
end)

net.Receive("PrometheusCustomJob", function()
	local Creating = net.ReadUInt(1) == 1
	local Code = net.ReadString()
	local ID = net.ReadUInt(8)

	if Creating then
		while #RPExtraTeams + 1 < ID do
			table.insert(RPExtraTeams, "Temp value for Prometheus")
		end
	end

	local Func = CompileString(Code, "Custom_job")
	local Succ, Err = pcall(Func)
	if !Succ then
		MsgC(Color(255, 0, 0), "Error while adding custom job for you error message: " .. Err)
	end

	if Creating then
		for n, j in pairs(RPExtraTeams) do
			if j == "Temp value for Prometheus" then
				RPExtraTeams[n] = nil
			end
		end
	end
end)

net.Receive("PrometheusColorChat", function()
	local Groups = net.ReadUInt(4)
	local Chat = {}
	for i = 1, Groups do
		local R = net.ReadUInt(8)
		local G = net.ReadUInt(8)
		local B = net.ReadUInt(8)
		local Type = net.ReadUInt(1)
		local Text
		if Type == 0 then
			local Num = net.ReadUInt(2)
			Text = Prometheus.Lang[Num] or "Missing language value for Nr " .. Num .. " in prometheus_client_config.lua"
		else
			Text = net.ReadString()
	end
		table.insert(Chat, Color(R, G, B) )
		table.insert(Chat, Text)
	end

	if #Chat != 0 then
		chat.AddText(unpack(Chat) )
	end
end)