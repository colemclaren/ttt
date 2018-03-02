-- Generated from: glib/lua/glib/enumeration/enumerators.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/enumeration/enumerators.lua
-- Timestamp:      2016-02-22 19:22:23
function CAC.Enumerator.ArrayEnumerator (tbl, maxIndex)
	maxIndex = maxIndex or math.huge
	
	if maxIndex == math.huge then
		local i = 0
		return function ()
			i = i + 1
			if i > maxIndex then return nil end
			return tbl [i]
		end
	else
		local i = 0
		return function ()
			i = i + 1
			return tbl [i]
		end
	end
end

function CAC.Enumerator.KeyEnumerator (tbl)
	local next, tbl, key = pairs (tbl)
	return function ()
		key = next (tbl, key)
		return key
	end
end

function CAC.Enumerator.ValueEnumerator (tbl)
	local next, tbl, key = pairs (tbl)
	return function ()
		key = next (tbl, key)
		return tbl [key]
	end
end

function CAC.Enumerator.KeyValueEnumerator (tbl)
	local next, tbl, key = pairs (tbl)
	return function ()
		key = next (tbl, key)
		return key, tbl [key]
	end
end

function CAC.Enumerator.ValueKeyEnumerator (tbl)
	local next, tbl, key = pairs (tbl)
	return function ()
		key = next (tbl, key)
		return tbl [key], key
	end
end

function CAC.Enumerator.NullEnumerator ()
	return CAC.NullCallback
end

function CAC.Enumerator.SingleValueEnumerator (v)
	local done = false
	return function ()
		if done then return nil end
		done = true
		return v
	end
end

function CAC.Enumerator.YieldEnumerator (f)
	local thread = coroutine.create (f)
	return function (...)
		if coroutine.status (thread) == "dead" then return nil end
		local success, a, b, c, d, e, f = coroutine.resume (thread, ...)
		if not success then
			CAC.Error (a)
			return nil
		end
		return a, b, c, d, e, f
	end
end

function CAC.Enumerator.YieldEnumeratorFactory (f)
	return function (...)
		local arguments = {...}
		local argumentCount = table.maxn (arguments)
		
		return CAC.Enumerator.YieldEnumerator (
			function ()
				return f (unpack (arguments, 1, argumentCount))
			end
		)
	end
end

CAC.ArrayEnumerator        = CAC.Enumerator.ArrayEnumerator
CAC.KeyEnumerator          = CAC.Enumerator.KeyEnumerator
CAC.ValueEnumerator        = CAC.Enumerator.ValueEnumerator
CAC.KeyValueEnumerator     = CAC.Enumerator.KeyValueEnumerator
CAC.ValueKeyEnumerator     = CAC.Enumerator.ValueKeyEnumerator
CAC.NullEnumerator         = CAC.Enumerator.NullEnumerator
CAC.SingleValueEnumerator  = CAC.Enumerator.SingleValueEnumerator
CAC.YieldEnumerator        = CAC.Enumerator.YieldEnumerator
CAC.YieldEnumeratorFactory = CAC.Enumerator.YieldEnumeratorFactory