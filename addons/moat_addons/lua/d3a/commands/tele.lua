COMMAND.Name = "Tele"

COMMAND.Flag = D3A.Config.Commands.Tele
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.CheckArgs = function(pl, cmd, args)
	local margs = cmd.Args
	local err
	local supp = false
	
	if (pl:IsPlayer() and !pl:HasAccess(cmd.Flag)) then
		err = "'" .. cmd.Flag .. "' access required!"
	end
	
	if (!err) then
		for k, v in pairs(args) do
			if (!args[k]) then
				err = "_"
				break
			end
			
			local targ = D3A.FindPlayer(v)
			if (targ) then
				if (cmd.CheckRankWeight) then
					if (!D3A.Ranks.CheckWeight(pl, targ)) then
						D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
						D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " (" .. pl:SteamID() .. ") attempted to use " .. cmd.Name .. " on you.")
						continue
					end
				end
				supp = supp or {}
				table.insert(supp, targ)
			else D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown player " .. v .. ".") end
		end
	end
	
	if (!err and (!supp or #supp == 0)) then
		err = "_"
	end
	
	if (err) then
		if (err == "_") then
			err = "Usage: " .. cmd.Name .. " "
			for k, v in pairs(margs) do
				err = err .. "[" .. v[1] .. ":" .. v[2] .. "] "
			end
		end
		D3A.Chat.SendToPlayer2(pl, moat_red, err)
		return false
	end
	
	return supp
end

COMMAND.Run = function(pl, args, supp)
	trace = pl.GetEyeTrace(pl)
	
	if (trace.HitSky) then return end
	
	local str = pl:Name() .. " has teleported "
	
	for k, targ in ipairs(supp) do
		local pos = D3A.FindEmptyPos(trace.HitPos, {targ}, 600, 30, Vector(16, 16, 64))
		
		if not targ:Alive() then 
		if targ:IsFrozen() then targ:Spawn() targ:Freeze(true)
		else
		targ:Spawn() end
		end
		
		if targ:InVehicle() then
			targ:ExitVehicle()	
		end

		targ.LastPos = targ:GetPos()
		targ:SetPos(pos)
		
		if (supp[k+2]) then
			str = str .. targ:Name() .. ", "
		elseif (supp[k+1]) then
			str = str .. targ:Name() .. " and "
		else
			str = str .. targ:Name() .. "."
		end
		
		D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " has teleported you.")
	end
	
	local rf = {}
	for _, v in pairs(player.GetAll()) do if (v:HasAccess("M")) then table.insert(rf, v) end end
	D3A.Chat.SendToPlayer2(rf, moat_red, str)
end