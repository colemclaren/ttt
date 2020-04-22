local lt = {
	Available = {},
	Strings = {}
}

function lt.Get()

end

function lt.Add(k, ...)

end

function lt.Exists(k)

end

function lt.Remove(k)

end

function lt.Render(k, ...)

end

Lang = setmetatable(lt, {
	__call = function(s, ...) return s.Render(...) end
})