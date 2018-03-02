function Prometheus.RunAction(Ply, ActionName, Values, TT)

	local UpdateActions = false

	if !table.HasValue(Prometheus.SkipActions, ActionName) then

		local Action = Prometheus.Actions[ActionName]

		if !Prometheus.Valid(Action) then Prometheus.Error("Trying to run an action which has an invalid action! Action id: " .. TT.id or "Unknown") return end

		if TT == true then
			Action.runfunc(Ply, Values, TT)
			return
		end

		if TT.type == 1 || TT.type == 4 then
			if Values.delivered == true && TT.delivered == 1 then
				if isstring(Ply) then
					Prometheus.Debug("RUN action '" .. Action.name .. "' on SteamID{" .. Ply .. "} has already been run previously.")
				else
					Prometheus.Debug("RUN action '" .. Action.name .. "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} has already been run previously.")
				end
			else
				if isstring(Ply) then
					Prometheus.Debug("Running RUN action '" .. Action.name .. "' on SteamID{" .. Ply .. "}")
				else
					Prometheus.Debug("Running RUN action '" .. Action.name .. "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")
				end

				if Action.runfunc(Ply, Values, TT) then
					UpdateActions = true
				end
			end
		elseif TT.type == 2 || TT.type == 3 then
			if isstring(Ply) then
				Prometheus.Debug("Running END action '" .. Action.name .. "' on SteamID{" .. Ply .. "}")
			else
				Prometheus.Debug("Running END action '" .. Action.name .. "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")
			end
			Action.endfunc(Ply, Values, TT)

		end
	end
	return UpdateActions
end

function Prometheus.AddAction(Action)

	if !Prometheus.Valid(Action.name) then
		Action.name = "unknown"
		Prometheus.Error("There is an action that doesn't have a name, which is necessary!")
	end

	if !Prometheus.Valid(Action.runfunc) then
		Action.runfunc = function() end
		Prometheus.Error("There is an action that doesn't have a run function, which is necessary or else it will do nothing!")
	end

	if !Prometheus.Valid(Action.endfunc) then
		Action.endfunc = function() end
	end

	Prometheus.Actions[Action.name] = Action
end

function Prometheus.SetActions()
	Prometheus.Actions = {}

	Prometheus.AddAction({
		name = "rank",
		runfunc = function(Ply, Values, TT)
			local CurrentRank = false
			local UsePrefix = true
			local SetRank = Values.rank_when

			if Values.rank_prefix == "" || !Values.rank_prefix then
				UsePrefix = false
			end

			if (SetRank == "" ||  SetRank == nil) && !UsePrefix then
				Prometheus.Error("'rank' RUN action wasn't run, because there isn't a rank set to promote to! Player SteamID: " .. Ply:SteamID() )
				return
			end

			if ULib || maestro then
				CurrentRank = Ply:GetUserGroup() or ""
			elseif evolve then
				CurrentRank = Ply:EV_GetRank() or ""
			elseif moderator then
				CurrentRank = moderator.GetGroup(Ply) or ""
			elseif ASS_VERSION then
				CurrentRank = Ply:GetLevel() or 0
			elseif serverguard then
				CurrentRank = serverguard.player:GetRank(Ply) or ""
			else
				Prometheus.Error("'rank' RUN action couldn't get current rank, because there are no compatible admin mods present! Player SteamID: " .. Ply:SteamID() )
			end

			if UsePrefix && CurrentRank != "" && !ASS_VERSION then
				SetRank = Values.rank_prefix .. CurrentRank
			end

			Prometheus.Debug("Setting rank '" .. SetRank ..  "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")

			if SetRank == CurrentRank then
				Prometheus.Info("'rank' RUN action will not run, because their current rank is the same as the new rank. " .. Ply:SteamID() )
			else
				local Succ, Err

				if ULib then
					Succ, Err = pcall(ULib.ucl.addUser, Ply:SteamID(), nil, nil, SetRank)
				elseif evolve then
					Succ, Err = pcall(Ply.EV_SetRank, Ply, SetRank)
				elseif moderator then
					Succ, Err = pcall(moderator.SetGroup, Ply, SetRank)
				elseif ASS_VERSION then
					Succ, Err = pcall(Ply.SetLevel, Ply, tonumber(SetRank) )
					ASS_SaveRankings()
				elseif serverguard then
					Succ, Err = pcall(serverguard.player.SetRank, serverguard.player, Ply, SetRank, false)
				elseif maestro then
					Succ, Err = pcall(Ply.SetUserGroup, Ply, SetRank)
				else
					Err = "No compatible admin mods present!"
				end

				if !Succ then
					Prometheus.Error("Error while adding player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} to rank: " .. SetRank .. " Error info: " .. Err)
				end
			end

			if tonumber(Values.rank_before) == 1 then
				if CurrentRank == "" then
					CurrentRank = false
					Prometheus.Error("'rank' RUN actions current rank couldn't be properly fetched, after this players package runs out, they will not be demoted! " .. Ply:SteamID() )
				end
				Values.rank_after = CurrentRank
			end
			return true
		end,
		endfunc = function(Ply, Values)
			local CurrentRank = false
			local Prefix = Values.rank_prefix or ""

			Prometheus.Debug("Setting rank '" .. Values.rank_after ..  "' on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")

			if Values.rank_after == "" ||  Values.rank_after == nil then
				Prometheus.Error("'rank' END action wasn't run, because there isn't a rank set to promote to! Player SteamID: " .. Ply:SteamID() )
				return
			end

			if Values.rank_after == false then
				Prometheus.Error("'rank' END action couldn't be run, because the after rank couldn't be found, this could be because when their new rank was set, their old rank couldn't be fetched.")
				return
			end

			if ULib || maestro then
				CurrentRank = Ply:GetUserGroup() or ""
			elseif evolve then
				CurrentRank = Ply:EV_GetRank() or ""
			elseif moderator then
				CurrentRank = moderator.GetGroup(Ply) or ""
			elseif ASS_VERSION then
				CurrentRank = Ply:GetLevel() or 0
			elseif serverguard then
				CurrentRank = serverguard.player:GetRank(Ply) or ""
			else
				Prometheus.Error("'rank' END action couldn't get players current rank, which means that if their rank was changed while they had the action active it will now be overwritten. " .. Ply:SteamID() )
			end

			if Values.rank_prefix == "" || !Values.rank_prefix then
				if Values.rank_when != CurrentRank then
					Prometheus.Info("'rank' END action will not run, because the rank they were set to and their current rank don't match, which means their rank was changed while the action was active. " .. Ply:SteamID() )
					return
				end
			else
				if Prefix .. Values.rank_after != CurrentRank then
					Prometheus.Info("'rank' END action will not run, because the rank they were set to and their current rank don't match, which means their rank was changed while the action was active. " .. Ply:SteamID() )
					return
				end
			end


			if Values.rank_after == CurrentRank then
				Prometheus.Info("'rank' END action will not run, because their current rank is the same as the new rank. " .. Ply:SteamID() )
			else
				local Succ, Err

				if ULib then
					Succ, Err = pcall(ULib.ucl.addUser, Ply:SteamID(), nil, nil, Values.rank_after)
				elseif evolve then
					Succ, Err = pcall(Ply.EV_SetRank, Ply, Values.rank_after)
				elseif moderator then
					Succ, Err = pcall(moderator.SetGroup, Ply, Values.rank_after)
				elseif ASS_VERSION then
					Succ, Err = pcall(Ply.SetLevel, Ply, tonumber(Values.rank_after) )
					ASS_SaveRankings()
				elseif serverguard then
					Succ, Err = pcall(serverguard.player.SetRank, serverguard.player, Ply, Values.rank_after, false)
				elseif maestro then
					Succ, Err = pcall(Ply.SetUserGroup, Ply, SetRank)
				else
					Prometheus.Error("'rank' END action couldn't set players rank, because there are no compatible admin mods present! Player SteamID: " .. Ply:SteamID() )
				end

				if !Succ then
					Prometheus.Error("Error while adding player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} to rank: " .. Values.rank_after .. " Error info: " .. Err)
				end
			end
		end
	})


	Prometheus.AddAction({
		name = "pointshop1",
		runfunc = function(Ply, Values)
			if Ply.PS_GivePoints == nil then
				Prometheus.Error("Can't give " .. (Values.points or 0) .. " PS1 points to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because PS1 is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.points or 0) .. " PS1 points.")
				timer.Simple(1.5, function()
					Ply:PS_GivePoints(tonumber(Values.points) or 0)
				end)
			end
		end
	})


	Prometheus.AddAction({
		name = "pointshop2",
		runfunc = function(Ply, Values)
			if Ply.PS2_AddStandardPoints == nil then
				Prometheus.Error("Can't give " .. (Values.points or 0) .. " PS2 standard points to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because PS2 is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.points or 0) .. " PS2 standard points.")
				if !Ply.PS2_Wallet then
					Ply.PrometheusPS2SPoints = (Ply.PrometheusPS2SPoints or 0) + (tonumber(Values.points) or 0)
				else
					Ply:PS2_AddStandardPoints(tonumber(Values.points) or 0)
				end
			end

			if Ply.PS2_AddPremiumPoints == nil then
				Prometheus.Error("Can't give " .. (Values.premium_points or 0) .. " PS2 premium points to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because PS2 is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.premium_points or 0) .. " PS2 premium points.")
				if !Ply.PS2_Wallet then
					Ply.PrometheusPS2PPoints = (Ply.PrometheusPS2PPoints or 0) + (tonumber(Values.premium_points) or 0)
				else
					Ply:PS2_AddPremiumPoints(tonumber(Values.premium_points) or 0)
				end
			end
		end
	})


	Prometheus.AddAction({
		name = "weapons",
		runfunc = function(Ply, Values)
			if Values.string == "" then return end

			Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} weapons: " .. Values.string)

			local WepTable = string.Split(Values.string, ",")
			if table.Count(WepTable) > 0 then
				for n, j in pairs(WepTable) do
					if !Ply:HasWeapon(j) && !(DarkRP && Ply:isArrested() ) then
						local Wep = Ply:Give(j)
						if !Wep:IsWeapon() then
							Prometheus.Error("Can't give weapon '" .. (j or "Unknown") .. "' to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because it doesn't exist.")
						else
							Wep.PrometheusGiven = true
							Wep:SetNWBool("PrometheusGiven", true)
							if Prometheus.DropPermaWeaponOnDeath != nil && !Prometheus.DropPermaWeaponOnDeath then
								Wep.ShouldDropOnDie = function() return false end
							end
							if Prometheus.CanDropPermaWeapon != nil && !Prometheus.CanDropPermaWeapon then
								local OldOnDrop = Wep.OnDrop
								Wep.OnDrop = function(self)
									OldOnDrop(self)
									if IsValid(self) then
										self:Remove()
									end
								end
							end
						end
					else
						Prometheus.Info("Not giving weapon '" .. (j or "Unknown") .. "' to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because they already have it.")
					end
				end
			end
		end,
		endfunc = function(Ply, Values)
			Prometheus.Weapons.Remove(Ply, Values.string)
		end
	})


	Prometheus.AddAction({
		name = "darkrpMoney",
		runfunc = function(Ply, Values)
			if Ply.addMoney == nil then
				Prometheus.Error("Can't give " .. (Values.money or 0) .. " DarkRP money to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because DarkRP is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.money or 0) .. " DarkRP money.")
				Ply:addMoney(tonumber(Values.money) or 0)
			end
		end
	})


	Prometheus.AddAction({
		name = "darkrpLevels",
		runfunc = function(Ply, Values)
			if Ply.addLevels == nil then
				Prometheus.Error("Can't give " .. (Values.lvl or 0) .. " DarkRP levels to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because DarkRP levels is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. Values.lvl or 0 .. " DarkRP levels.")
				Ply:addLevels(tonumber(Values.lvl) or 0)
			end
		end
	})


	Prometheus.AddAction({
		name = "darkrpScale",
		runfunc = function(Ply, Values)
			if LevelSystemConfiguration == nil then
				Prometheus.Error("DarkRP levels system was not found, but still setting scale, make sure level system is installed and working.")
			end

			Prometheus.Debug("Setting players: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} scale to " .. Values.scale or 1 .. ".")
			Ply.VXScaleXP = tonumber(Values.scale) or 1
		end
	})


	Prometheus.AddAction({
		name = "dayzItem",
		runfunc = function(Ply, Values)
			if Ply.GiveItem == nil then
				Prometheus.Error("Can't give " .. (Values.item or "Unknown") .. "(" .. (Values.amount or 1) .. ") DayZ item to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because DayZ is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.item) or "Unknown" .. " DayZ item.")
				Ply:GiveItem(Values.item, tonumber(Values.amount) or 1)
			end
		end
	})

	Prometheus.AddAction({
		name = "dayzCredits",
		runfunc = function(Ply, Values)
			if Ply.GiveCredits == nil then
				Prometheus.Error("Can't give " .. (Values.amount or 0) .. " DayZ credits to player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} because DayZ is not available.")
			else
				Prometheus.Debug("Giving player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} " .. (Values.amount) or 0 .. " DayZ credits.")
				Ply:GiveCredits(tonumber(Values.amount) or 0)
			end
		end
	})


	Prometheus.AddAction({
		name = "custom_action",
		runfunc = function(Ply, Values, TT)
			if Prometheus.Valid(Values.code_when) then
				if isstring(Ply) then
					Prometheus.Temp.Ply = nil
					Prometheus.Temp.SteamID = Ply
					Prometheus.Temp.Steam64 = util.SteamIDTo64(Ply)
					Prometheus.Temp.Nick = "Not connected"
				else
					Prometheus.Temp.Ply = Ply
					Prometheus.Temp.SteamID = Ply:SteamID()
					Prometheus.Temp.Steam64 = Ply:SteamID64()
					Prometheus.Temp.Nick = Ply:Nick()
				end

				Prometheus.Debug("Running custom action '" .. Values.code_when .. "' on player: " .. Prometheus.Temp.Nick .. "{" .. Prometheus.Temp.SteamID .. "}")

				local Func = CompileString(Values.code_when, "Custom_action_" .. TT.id .. "_for_" .. Prometheus.Temp.Nick)
				local Succ, Err = pcall(Func)
				if !Succ then
					Prometheus.Error("Error while running RUN custom action for player: " .. Prometheus.Temp.Nick .. "{" .. Prometheus.Temp.SteamID .. "} Error message: " .. Err)
				end
			end
		end,
		endfunc = function(Ply, Values, TT)
			if Prometheus.Valid(Values.code_after) then
				if isstring(Ply) then
					Prometheus.Temp.Ply = nil
					Prometheus.Temp.SteamID = Ply
					Prometheus.Temp.Steam64 = util.SteamIDTo64(Ply)
					Prometheus.Temp.Nick = "Not connected"
				else
					Prometheus.Temp.Ply = Ply
					Prometheus.Temp.SteamID = Ply:SteamID()
					Prometheus.Temp.Steam64 = Ply:SteamID64()
					Prometheus.Temp.Nick = Ply:Nick()
				end
				Prometheus.Debug("Running custom action '" .. Values.code_after .. "' on player: " .. Prometheus.Temp.Nick .. "{" .. Prometheus.Temp.SteamID .. "}")

				local Func = CompileString(Values.code_after, "Custom_action_" .. TT.id .. "_for_" .. Prometheus.Temp.Nick)
				local Succ, Err = pcall(Func)
				if !Succ then
					Prometheus.Error("Error while running END custom action for player: " .. Prometheus.Temp.Nick .. "{" .. Prometheus.Temp.SteamID .. "} Error message: " .. Err)
				end
			end
		end
	})


	Prometheus.AddAction({
		name = "console",
		runfunc = function(Ply, Values)
			local SteamID = ""
			local Nick = ""
			local SteamID64 = ""

			if isstring(Ply) then
				SteamID = Ply
				Nick = "Not connected"
				SteamID64 = util.SteamIDTo64(Ply)
			else
				SteamID = Ply:SteamID()
				Nick = Ply:Nick()
				SteamID64 = Ply:SteamID64()
			end

			local ComString = string.gsub(Values.cmd_when, "{Name}", '"' .. Nick .. '"')
				ComString = string.gsub(ComString, "{SteamID}", SteamID )
				ComString = string.gsub(ComString, "{Steam64}", SteamID64 )

			Prometheus.Debug("Running console command '" .. ComString .. "' on player: " .. Nick .. "{" .. SteamID .. "}")
			game.ConsoleCommand(ComString .. "\n")
		end,
		endfunc = function(Ply, Values)
			local SteamID = ""
			local Nick = ""
			local SteamID64 = ""

			if isstring(Ply) then
				SteamID = Ply
				Nick = "Not connected"
				SteamID64 = util.SteamIDTo64(Ply)
			else
				SteamID = Ply:SteamID()
				Nick = Ply:Nick()
				SteamID64 = Ply:SteamID64()
			end

			local ComString = string.gsub(Values.cmd_after, "{Name}", '"' .. Nick .. '"')
				ComString = string.gsub(ComString, "{SteamID}", SteamID )
				ComString = string.gsub(ComString, "{Steam64}", SteamID64 )

			Prometheus.Debug("Running console command '" .. ComString .. "' on player: " .. Nick .. "{" .. SteamID .. "}")
			game.ConsoleCommand(ComString .. "\n")
		end
	})


	Prometheus.AddAction({
		name = "message",
		runfunc = function(Ply, Values, TT)
			if tonumber(Values.type) == 2 then
				Prometheus.Notify(Ply, 6, false, {amount = Values.text})
			elseif tonumber(Values.type) == 3 then
				Prometheus.Notify(Ply, 1, false, {text = Values.text})
			elseif TT.type == 1 then
				if TT.perma then
					Prometheus.Notify(Ply, 2, false, {package = Values.text})
				else
					Prometheus.Notify(Ply, 3, false, {package = Values.text, expire = TT.expiretime})
				end
			end
		end,
		endfunc = function(Ply, Values, TT)
			if TT.type == 2 then
				Prometheus.Notify(Ply, 4, false, {package = Values.text})
			elseif TT.type == 3 then
				Prometheus.Notify(Ply, 5, false, {package = Values.text})
			end
		end
	})



	Prometheus.AddAction({
		name = "customjob",
		runfunc = function(Ply, Values, TT)
			if !DarkRP then
				Prometheus.Error("Cannot add custom job if gamemode is not DarkRP!")
			else
				Prometheus.Debug("Running custom job on player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "}")
				Prometheus.Temp.Ply = Ply

				for n, j in ipairs(Prometheus.CustomJobPool) do
					if j.ID == TT.id then
						return
					end
				end

				if !Prometheus.DarkRPJobNum then
					Prometheus.DarkRPJobNum = #RPExtraTeams
				end

				Prometheus.DarkRPJobNum = Prometheus.DarkRPJobNum + 1
				while #RPExtraTeams + 1 < Prometheus.DarkRPJobNum do
					table.insert(RPExtraTeams, "Temp value for Prometheus")
				end

				local Func = CompileString(Values.code, "Custom_job_" .. TT.id .. "_for_" .. Ply:Nick() )
				local Succ, Err = pcall(Func)

				table.insert(Prometheus.CustomJobPool, {Code = Values.code, ID = TT.id, Num = Prometheus.DarkRPJobNum})

				for n, j in pairs(RPExtraTeams) do
					if j == "Temp value for Prometheus" then
						RPExtraTeams[n] = nil
					end
				end

				if !Succ then
					Prometheus.Error("Error while adding custom job for player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} Error message: " .. Err)
				else
					net.Start("PrometheusCustomJob")
						net.WriteUInt(1, 1)
						net.WriteString(Values.code)
						net.WriteUInt(Prometheus.DarkRPJobNum, 8)
					net.Broadcast()
				end
		end
		end,
		endfunc = function(Ply, Values, TT)
			if !DarkRP then
				Prometheus.Error("Cannot remove custom job if gamemode is not DarkRP!")
			else
				Prometheus.Temp.Ply = Ply
				local Func = CompileString(Values.code_end, "Custom_job_" .. TT.id .. "_for_" .. Ply:Nick() )
				local Succ, Err = pcall(Func)
				if !Succ then
					Prometheus.Error("Error while removing custom job for player: " .. Ply:Nick() .. "{" .. Ply:SteamID() .. "} Error message: " .. Err)
				else
					net.Start("PrometheusCustomJob")
						net.WriteUInt(0, 1)
						net.WriteString(Values.code_end)
						net.WriteUInt(0, 8)
					net.Broadcast()

					for n, j in ipairs(Prometheus.CustomJobPool) do
						if j.ID == TT.id then
							table.remove(Prometheus.CustomJobPool, n)
						end
					end
				end
			end
		end
	})

end


hook.Add("PS2_PlayerFullyLoaded", "PrometheusGivePS2Points", function(Ply)
	if Ply.PrometheusPS2SPoints then
		Ply:PS2_AddStandardPoints(Ply.PrometheusPS2SPoints)
		Ply.PrometheusPS2SPoints = nil
	end

	if Ply.PrometheusPS2PPoints then
		Ply:PS2_AddPremiumPoints(Ply.PrometheusPS2PPoints)
		Ply.PrometheusPS2PPoints = nil
	end
end)