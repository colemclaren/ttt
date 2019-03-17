function ux.s(num, large)
	return ux.cache.scale[num] or ux.scale(num, large)
end

function ux.v(id, def)
	return ux.cache.view[id] and ux.cache.view[id].cached or def
end


ux.w, ux.h = ScrW(), ScrH()
hook.Add("Think", function()
	if (ScrH() == ux.h) then
		return
	end
	
	local ow, oh = ux.w, ux.h
	ux.cache.scale = {}

	ux.w, ux.h = ScrW(), ScrH()
	ux.cache.view.reset(ow, oh)
	ux.w, ux.h = ow, oh

	hook.Run("ScreenSizeChanged", ux.w, ux.h)
	ux.w, ux.h = ScrW(), ScrH()
end)

ux.cache.scale = ux.cache.scale or {}
function ux.scale(num, from, to, dont_scale_even, dont_round)
	from = from and (isbool(from) and (from and 1768 or 992) or from) or 992
	to = to and (isbool(from) and (from and ux.w or ux.h) or to) or ux.h

	local n = dont_round and num or math.Round(to * (num/from))
	ux.cache.scale[num] = dont_scale_even and n or (num % 2 == 0 and (n % 2 == 0 and n or n - 1) or (n % 2 ~= 0 and n or n - 1))

	return ux.cache.scale[num]
end

function ux.canview(min_width, max_width, min_height, max_height)
	if (istable(min_width)) then
		min_width = min_width.min_width
		max_width = min_width.max_width
		min_height = min_width.min_height
		max_height = min_width.max_height
	end

	if (min_width and ux.w < min_width) then
		return false
	end

	if (max_width and ux.w > max_width) then
		return false
	end

	if (min_height and ux.h < min_height) then
		return false
	end

	if (max_height and ux.h > max_height) then
		return false
	end

	return true
end

ux.cache.view = ux.cache.view or {}
function ux.cache.view.reset(w, h)
	for k, v in ipairs(ux.cache.view) do
		ux.cache.view[k].cached = ux.cache.view.check(unpack(v.check))
	end
end

function ux.cache.view.set(data, cacheid, obj, args)
	if (cacheid) then
		ux.cache.view.n = ux.cache.view.n + 1
		local id = ux.cache.view.n

		table.insert(args, 1, istable(obj) and obj or {obj})
		ux.cache.view[id] = {
			cached = data,
			check = args
		}

		return id, ux.cache.view[id]
	else
		return data
	end
end

function ux.cache.view.check(object, args)
	if (not args.n) then
		return object
	end

	if (ux.canview(unpack(args))) then
		return isfunction(object) and object() or object
	end

	for i = 1, args.n do
		local a = args[i]
		if (not istable(a)) then
			continue
		end

		if (a[1] and isnumber(a[1]) and a[2] and ux.canview(unpack(a[2]))) then
			if (isfunction(object)) then
				return object(a[1])
			else
				return a[1]
			end
		end
	end

	return object
end

function ux.view(object, ...)
	local args = {n = select("#", ...), ...}
	local obj = ux.cache.view.check(object, args)

	return ux.cache.view.set(obj, istable(object), object, args)
end

/*
function ux.view(object, ...)
	local object, args = {n = select("#", ...), ...}
	if (not args.n) then
		return object
	end

	if (ux.canview(unpack({...}))) then
		return isfunction(object) and object() or ux.cache.view.set(object, istable(object), object, args)
	end

	for i = 1, args.n do
		local a = args[i]
		if (not istable(a)) then
			continue
		end

		if (a[1] and isnumber(a[1]) and a[2] and ux.canview(unpack(a[2]))) then
			if (isfunction(object)) then
				return object(a[1])
			else
				return ux.cache.view.set(a[1], istable(object), object, args)
			end
		end
	end

	return ux.cache.view.set(object, istable(object), object, args)
end
*/