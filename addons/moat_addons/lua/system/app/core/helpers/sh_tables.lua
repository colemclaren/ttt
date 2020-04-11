function moat.iterate(tb, func, num)
	if (not tb) then return end
	num = num or #tb

	for i = 1, num do
		if (not tb[i]) then
			continue
		end

		func(i)
	end
end

function moat.find(p, f, d)
	p = p:match "/$" and p or p .. "/"

	local fs, ds = file.Find(p .. "*", "LUA")
	if (not fs and not ds) then return end

	moat.iterate(fs, function(n)
		f(n, p)
	end)

	if (not f) then d = f end
	moat.iterate(ds, function(n)
		d(n, p)
	end)
end