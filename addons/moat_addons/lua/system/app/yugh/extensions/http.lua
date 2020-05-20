
local timer_Create = timer.Create
local timer_Remove = timer.Remove
local timer_Simple = timer.Simple
local Loaded = http.Loaded
local Haste = http.Haste
local Struct = http.Structure

function http.UrlEncode(data, body)
	body = body or {}

	for k, v in pairs(data) do
		table.insert(body, string.gsub(k, "[^%w%-_%.%!%~%*%'%(%)]", function(c)
			return string.format("%%%02X", string.byte(c, 1, 1))
		end) .. "=" .. string.gsub(v, "[^%w%-_%.%!%~%*%'%(%)]", function(c)
			return string.format("%%%02X", string.byte(c, 1, 1))
		end))
	end

	body = table.concat(body, "&")

	return body
end

local function HTTPLoad(num)
	num = num or 1

	if (not Haste(num)) then
		return
	end

	local struct, request = Haste(num), Haste(num)
	struct.success = function(code, body, headers)
		timer_Simple(1, function() HTTPLoad(num + 1) end)
		request.success(code, body, headers)
	end
	struct.failed = function(err)
		timer_Simple(1, function() HTTPLoad(num + 1) end)
		request.failed(err)
	end

	HTTP(struct)
end

local function HTTPInit(msg)
	http.Loaded = true
	Loaded = true
	hook.Run "HTTPLoaded"
	-- MsgC(Color(255, 255, 255), "HTTP Initialized\n")
end

timer_Create("HTTPLoadedCheck", 2, 0, function()
	if (Loaded) then
		timer_Remove "HTTPLoadedCheck"
		return
	end

	HTTP(Struct("post", "https://google.com/", HTTPInit, HTTPInit, nil, {}))
end)