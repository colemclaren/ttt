mlogs.HookQuery = mlogs.HookQuery or ""

function mlogs:hookquery(str)
	timer.Simple(0, function() self:qq(str) end)
end

function mlogs.addq(str, ...)
	mlogs.HookQuery = mlogs.HookQuery .. tostring(mlogs.sql.CreateQuery(str, ...))
end

function mlogs.hookplayers(state, r)
	local pls = player.GetAll()
	for i = 1, #pls do
		if (not IsValid(pls[i])) then continue end
		if (r) then
			hook.Run("mlogs.ply." .. state, pls[i], r, mlogs)
		else
			hook.Run("mlogs.ply." .. state, pls[i], mlogs)
		end
	end
end

mlogs:hook("TTTBeginRound", function()
	mlogs.HookQuery = ""
	mlogs.round.start()

	hook.Run("mlogs.begin", mlogs)
	mlogs.hookplayers("begin")

	if (mlogs.HookQuery ~= "") then
		mlogs:hookquery(mlogs.HookQuery)
	end

	mlogs.HookQuery = ""
end)

mlogs:hook("TTTPrepRound", function()
	mlogs.HookQuery = ""

	hook.Run("mlogs.prep", mlogs)
	mlogs.hookplayers("prep")

	if (mlogs.HookQuery ~= "") then
		mlogs:hookquery(mlogs.HookQuery)
	end

	mlogs.HookQuery = ""
end)

mlogs:hook("TTTEndRound", function(r)
	mlogs.HookQuery = ""
	mlogs.round.stop()

	hook.Run("mlogs.end", r, mlogs)
	mlogs.hookplayers("end", r)

	if (mlogs.HookQuery ~= "") then
		mlogs:hookquery(mlogs.HookQuery)
	end

	mlogs.HookQuery = ""
end)