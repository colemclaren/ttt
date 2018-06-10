mlogs.weps = mlogs.weps or {}
mlogs.weps.save = mlogs.weps.save or {num = 1}

function mlogs:saveweps(t)
	for i = 2, t.num do t[1] = t[1] .. "INSERT INTO {database}.mlogs_weapons (class) VALUES (?);" end
	t[t.num + 1] = function() mlogs:weps() end
	t.num = nil

	self:q(unpack(t))
end

function mlogs:weps()
	local wl = weapons.GetList()

	self:q("SELECT wid, class FROM {database}.mlogs_weapons", function(r)
		if (not r or not next(r)) then mlogs:saveweps() return end

		for i = 1, #r do
			local w = r[i]
			mlogs.weps[w.wid] = w.class
			mlogs.weps[w.class] = w.wid
		end

		for i = 1, #wl do
			local class = wl[i].ClassName
			if (not class) then continue end
			if (not mlogs.weps[class]) then
				mlogs.weps.save.num = mlogs.weps.save.num + 1
				mlogs.weps.save[mlogs.weps.save.num] = class
			end
		end

		if (mlogs.weps.save.num > 0) then
			mlogs.weps.save[1] = ""
			mlogs:saveweps(mlogs.weps.save)
		end
	end)
end

mlogs:hook("mlogs.sql", function()
	mlogs:weps()
end)