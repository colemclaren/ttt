local mt, app = {}, {}
mt.__index = mt
mt.__newindex = mt

function moat.app(n)
	app[n] = setmetatable({
		name = n,
		credits = {"Team Moat"},
		canload = true,
		static = false,
		loaded = function(s)
			-- print("| | Loaded Lib: " .. s.name)
			
			/*if (s.desc) then
				print(" | Description: " .. s.desc)
			end

			print(" | Credits: " .. s.desc)
			for i = 1, #s.credits do
				print(" |   ", s.credits[i])
			end*/
		end
	}, mt)

	return app[n]
end

function mt:Desc(d)
	self.desc = d
	return self
end

function mt:Credits(a)
	self.credits = istable(a) and a or {a}
	return self
end

function mt:Disabled(b)
	self.canload = not b
	return self
end

function mt:Path(s)
	self.path = s
	return self
end

function mt:Static(b)
	self.static = b
	return self
end

function mt:Loaded(f)
	self.loaded = f
	return self
end

function mt:Setup(dp)
	if (not self.canload) then return end
	self.path = self.path or moat.apps.temp

	if (dp) then
		db = istable(db) and db or {db}

		for i = 1, #db do
			moat.apps.load(db[i])
		end
	end

	if (not self.static) then
		moat.apps.include(moat.apps.temp)
	end

	self.loaded(self)
end