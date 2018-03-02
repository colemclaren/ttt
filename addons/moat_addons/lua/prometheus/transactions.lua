function Prometheus.Transactions.Run(TT)

	if !istable(TT.actions) then
		TT.actions = util.JSONToTable(TT.actions)
	end

	if TT.uid == nil || TT.delivered == nil || TT.active == nil || TT.id == nil || TT.actions == nil then
		Prometheus.Error("Received a transaction that has missing vital parts! Action id: " .. TT.id)
		return
	end

	local UID = TT.uid
	local SteamID = util.SteamIDFrom64(UID)
	local Plys = {}

	if TT.runonce == 2 then
		table.insert(Plys, SteamID)
	else
		for n, j in ipairs(player.GetAll() ) do
			if j:SteamID() == SteamID then
				table.insert(Plys, j)
			end
		end
	end

	if UID == "0" then
		Plys = player.GetAll()
	end

	if table.Count(Plys) <= 0 then
		Prometheus.Debug("Player of this action is not online.")
		return
	end

	TT.expiretime = string.gsub(TT.expiretime, " 00:00:00", "")

	if TT.expiretime == "1000-01-01" then
		TT.perma = true
	else
		TT.perma = false
	end

	if TT.delivered == 0 && TT.active == 1 && (TT.runonce == 1 || TT.runonce == 2) then -- Needs to be run once, has been just purchased
		TT.type = 1
	elseif TT.delivered == 0 && TT.active == 0 then -- Needs to be revoked
		TT.type = 2
	elseif TT.expiretime < os.date( "%Y-%m-%d" , os.time() ) && !TT.perma then -- It has expired
		TT.type = 3
	elseif TT.active == 1 && TT.runonce == 0 then -- It's an action that runs all the time
		TT.type = 4
	else
		Prometheus.Error("Somehow an action that doesn't need editing has gotten to editing")
		return
	end

	local UpdateActions = false


	if table.Count(TT.actions) > 0 then
		for n, j in pairs(TT.actions) do
			for _, Ply in pairs(Plys) do
				if TT.type == 4 then
					if j.runtype == "1" then
						if n == "weapons" && (!Ply:Alive() || (Ply.IsSpec && Ply:IsSpec() ) ) then else
							Prometheus.RunAction(Ply, n, j, TT)
						end
					elseif j.runtype == "2" then
						if n == "weapons" && (!Ply:Alive() || (Ply.IsSpec && Ply:IsSpec() ) ) then else
							Prometheus.RunAction(Ply, n, j, TT)
						end

						if n == "weapons" then
							table.insert(Ply.Prometheus.PlayerLoadout, {actionname = n, values = j, id = TT.id} )
						else
							table.insert(Ply.Prometheus.Spawn, {actionname = n, values = j, id = TT.id} )
						end
					else
						if TT.delivered == 0 then
							if n == "weapons" then
								if !Ply:Alive() || (Ply.IsSpec && Ply:IsSpec() ) then else
									Prometheus.RunAction(Ply, n, j, TT)
								end
							else
								if Prometheus.RunAction(Ply, n, j, TT) then
									UpdateActions = true
								end
							end
						else
							Prometheus.Debug("RUN action '" .. n .. "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} has already been run previously.")
						end
					end
				else
					if j.runtype == "2" then
						for n, j in ipairs(Ply.Prometheus.PlayerLoadout) do
							if j.id == TT.id then
								table.remove(Ply.Prometheus.PlayerLoadout, n)
							end
						end
						for n, j in ipairs(Ply.Prometheus.Spawn) do
							if j.id == TT.id then
								table.remove(Ply.Prometheus.Spawn, n)
							end
						end
					end
					if n == "weapons" then
						if !Ply:Alive() || (Ply.IsSpec && Ply:IsSpec() ) then else
							Prometheus.RunAction(Ply, n, j, TT)
						end
					else
						if Prometheus.RunAction(Ply, n, j, TT) then
							UpdateActions = true
						end
					end
				end
			end
		end
	else
		Prometheus.Error("There is an action without any actions assigned to it! ID: " .. TT.id)
	end

	if TT.type == 4 && TT.delivered == 1 && !UpdateActions then
		return
	end

	UpdateTable = {}

	if UpdateActions then
		UpdateTable.actions = TT.actions
	end

	if TT.type == 2 || TT.type == 3 then
		UpdateTable.active = 0
	end

	UpdateTable.delivered = 1


	Prometheus.DB.UpdateAction(TT.id, UpdateTable)
end


local function ProcessFetched(Transactions, Ply)

	if !Transactions then Prometheus.Debug("No new actions.") return end

	for n, j in ipairs(Transactions) do
		if !j.expiretime then
			Prometheus.Error("Action has missing expiretime! ID: " .. j.id)
			return
		end
		if IsValid(Ply) then
			Prometheus.Debug("Got player " .. Ply:Nick() .. "(" .. Ply:SteamID() .. ") action, ID = " .. j.id .. ":\nActions = " .. j.actions .. "\nUID = " .. j.uid .. "\nExpire time = " .. j.expiretime .. "\nDelivered, Active = " .. j.delivered .. ", " .. j.active)
		else
			Prometheus.Debug("Got action, ID = " .. j.id .. ":\nActions = " .. j.actions .. "\nUID = " .. j.uid .. "\nExpire time = " .. j.expiretime .. "\nDelivered, Active = " .. j.delivered .. ", " .. j.active)
		end

		Prometheus.Transactions.Run(j)
	end

end

function Prometheus.Transactions.Get(Ply) -- Ply is optional, if it's not valid, will fetch actions for everyone

	if IsValid(Ply) then
		Prometheus.DB.FetchPlayerActions(ProcessFetched, Ply)
	else
		Prometheus.DB.FetchActions(ProcessFetched)
	end

end