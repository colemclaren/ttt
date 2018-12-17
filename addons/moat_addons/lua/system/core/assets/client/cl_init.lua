
local fetch = http.Fetch
local write = file.Write
local exists = file.Exists
local delete = file.Delete

cdn.Cache = cdn.Cache or {}
cdn.Objects = cdn.Objects or {}
cdn.URL = "https://cdn.moat.gg/"
cdn.Folder = "moat_cache"
cdn.FolderCheck = function(path)
	path = cdn.Folder .. "/" .. path

	if (not file.IsDir(path, "DATA")) then
		file.CreateDir(path)
		return
	end

	local objects = file.Find(path .. "/*", "DATA")
	if (#objects < 1500) then return end
	
	for k, v in ipairs(objects) do
		delete(path .. "/" .. v)
	end
end

for i = 1, 5 do
	cdn.FolderCheck(i)
end

function cdn.Add(key, val, params)
	assert(cdn.Objects[key] == nil, "Storage object with provided key already exists!")
	cdn.Objects[key] = {Key = key, Object = val, Params = params, URL = (parent or cdn.URL) .. val}
end

function cdn.Get(key)
	return cdn.Objects[key] and cdn.Objects[key].URL or (cdn.URL .. key)
end

function cdn.Object(key)
	return cdn.Objects[key].Object
end

function cdn.Params(key)
	return cdn.Objects[key] and cdn.Objects[key].Params
end

function cdn.Fetch(id, ext, key, params, cache, save)
	local object = cdn.Folder .. "/" .. id .. "/" .. hash.MD5(key) .. ext
	--print(object, ext, key, cache, save)

	if (exists(object, "DATA")) then
		if (id == 1) then
			cdn.Cache[key] = ext ~= ".vtf" and Material("../data/" .. object, params) or "../data/" .. object
		else
			cdn.Cache[key] = "data/" .. object
		end

		return cdn.Cache[key]
	end

	if (not http or not http.Loaded) then
		return false
	end

	cdn.Cache[key] = false

	fetch(key, function(data)
		save(object, data)
		cache(object)
	end)

	return false
end

function cdn.Image(key, cb, params)
	if (cdn.Cache[key] ~= nil) then
		return cdn.Cache[key]
	end

	if (type(cb) == "string") then
		params = cb
		cb = nil
	end

	return cdn.Fetch(1, string(".", key:GetExtensionFromFilename()), key, params, function(object)
		cdn.Cache[key] = Material("../data/" .. object, params)
		if (cb) then cb(cdn.Cache[key]) end
	end, function(object, data) write(object, data) end)
end

function cdn.Sound(key, cb, params)
	if (cdn.Cache[key] ~= nil) then
		return cdn.Cache[key]
	end

	if (type(cb) == "string") then
		params = cb
		cb = nil
	end

	return cdn.Fetch(2, ".txt", key, params, function(object)
		cdn.Cache[key] = "data/" .. object
		if (cb) then cb(cdn.Cache[key]) end
	end, function(object, data) write(object, data) end)
end

function cdn.ModelIcon(key, cb)
	if (cdn.Cache[key] ~= nil) then
		return cb(cdn.Cache[key])
	end

	key = "ttt/spawnicons/" .. (string.StripExtension(key)) .. ".png"
	cdn.Fetch(3, ".png", key, key, function(object)
		cdn.Cache[key] = "data/" .. object
		if (cb) then cb(cdn.Cache[key]) end
	end, function(object, data) write(object, data) end)

	if (cdn.Cache[key] and cb) then
		return cb(cdn.Cache[key])
	end
end

function cdn.Texture(key, cb)
	if (cdn.Cache[key] ~= nil) then
		return cdn.Cache[key]
	end

	return cdn.Fetch(1, ".vtf", key, nil, function(object)
		cdn.Cache[key] = "../data/" .. object
		if (cb) then cb(cdn.Cache[key]) end
	end, function(object, data) write(object, data) end)
end