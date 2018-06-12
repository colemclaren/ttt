mlogs.round = mlogs.round or {}
mlogs.time = 0

function mlogs.round.start()
	mlogs.time = 0

	timer.Remove "mlogs.round.time"
	timer.Create("mlogs.round.time", 1, 0, function()
		if (mlogs.DontLog()) then mlogs.round.stop() return end

		mlogs.time = mlogs.time + 1
	end)
end

function mlogs.round.stop()
	mlogs.time = 0
	timer.Remove "mlogs.round.time"
end