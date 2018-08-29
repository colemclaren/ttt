ux.queue = ux.queue or {
	tb = {}, c = 0,
	Add = function(...)
		ux.queue.c = ux.queue.c + 1
		ux.queue.tb[ux.queue.c] = {...}
	end,
	Run = function()
		if (ux.queue.c == 0) then return end

		for i = 1, ux.queue.c do
			if (not ux.queue.tb[i]) then continue end
			ux.Create(unpack(ux.queue.tb[i]))
		end

		ux.queue.tb = {}
		ux.queue.c = 0
	end
}