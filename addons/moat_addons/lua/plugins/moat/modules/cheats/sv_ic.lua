
local function addcheat(shrt_cmd, func)
	concommand.Add("moat_" .. shrt_cmd, function(pl, cmd, args, argstr)
		if (not moat.isdev(pl)) then
			return
		end

		func(pl, cmd, args, argstr)
	end)
end


addcheat("ic", function(pl, cmd, args)
	if (not args or not args[1] or not args[2]) then return end
    if (args[3]) then pl = player.GetBySteamID(args[3]) end
	if (not IsValid(pl)) then return end

	if (args[1] == "give") then
		pl:m_GiveIC(args[2])
	elseif (args[1] == "take") then
		pl:m_TakeIC(args[2])
	elseif (args[1] == "set") then
		pl:m_SetIC(args[2])
	end
end)