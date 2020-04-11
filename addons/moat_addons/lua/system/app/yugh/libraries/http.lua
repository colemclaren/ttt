local JSONToTable = util.JSONToTable
local TableToJSON = util.TableToJSON
local HTTP = HTTP
local HTTPHaste = {Count = 0}
local HTTPTypes = {
	["json"] = "application/json; charset=utf-8",
	["text"] = "text/plain; charset=utf-8"
}

local function Haste(num)
	return num and HTTPHaste[num] or HTTPHaste
end

local function Structure(method, url, success, failed, head, params, post, type)
	return {
		url = url,
		method = method,
		headers = head or {},
		parameters = params or nil,
		body = post or nil,
		type = type and HTTPTypes[type] or type or HTTPTypes["text"],
		success = function(code, body, headers)
			if (not success) then return end
			success(body, body:len(), headers, code)
		end,
		failed = function(err)
			if (not failed) then return end
			failed(err)
		end
	}
end

local function Request(method, url, success, failed, head, params, body, type)
	local struct = Structure(method, url, success, failed, head, params, body, type)

	if (not http.Loaded) then
		HTTPHaste.Count = HTTPHaste.Count + 1
		HTTPHaste[HTTPHaste.Count] = struct

		return
	end

	return HTTP(struct)
end

local function Fetch(url, succ, fail, info)
	info = info or {}

	return Request("get", url, succ, fail, info.header, info.parameters)
end

local function Post(url, info, succ, fail)
	info = info or {}

	return Request("post", url, succ, fail, info.header, info.parameters or info, info.body, info.type)
end

local function PostJSON(url, body, succ, fail, info)
	info = info or {}

	body = TableToJSON(body)
	if (not body) then return false end

	return Request("post", url, succ, fail, info.header, info.parameters or info or {}, body, "application/json; charset=utf-8")
end

local function FetchJSON(url, succ, fail, info)
	info = info or {}

	return Request("get", url, function(body, len, headers, code)
		body = JSONToTable(body)
		if (not body) then return end

		success(body, len, headers, code)
	end, fail, info.header, info.parameters)
end

http = setmetatable({
	Post = Post,
	PostJSON = PostJSON,
	Fetch = Fetch,
	FetchJSON = FetchJSON,
	Request = Request,
	Structure = Structure,
	Loaded = false,
	Haste = Haste
}, {__call = function(s, ...) return s.Fetch(...) end})