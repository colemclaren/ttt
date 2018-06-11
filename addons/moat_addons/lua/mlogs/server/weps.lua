mlogs.weps = mlogs.weps or {}

mlogs.weps.save = mlogs.weps.save or {}
mlogs.weps.save.num = mlogs.weps.save.num or 1

function mlogs:saveweps(t)
	for i = 2, t.num do t[1] = t[1] .. "INSERT INTO {database}.mlogs_weapons (class) VALUES (?);" end
	t[t.num + 1] = function() mlogs:getweps() end
	t.num = nil

	self:q(unpack(t))
end

function mlogs:getweps()
	local wl = weapons.GetList()
	self.weps.save.num = self.weps.save.num or 1

	self:q("SELECT wid, class FROM {database}.mlogs_weapons", function(r)
		if (not r) then return end

		for i = 1, #r do
			local w = r[i]
			self.weps[w.wid] = w.class
			self.weps[w.class] = w.wid
		end

		for i = 1, #wl do
			local class = wl[i].ClassName
			if (not class) then continue end
			if (not self.weps[class]) then
				self.weps.save.num = self.weps.save.num + 1
				self.weps.save[self.weps.save.num] = class
			end
		end

		if (self.weps.save.num > 1) then
			self.weps.save[1] = ""
			self:saveweps(self.weps.save)
		else
			self.wepsloaded = true
			self:loaded()
		end
	end)
end

mlogs:hook("mlogs.sql", function(s)
	s:getweps()
end)