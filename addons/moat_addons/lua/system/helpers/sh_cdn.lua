cdn = cdn or {}
cdn.Cache = {}
cdn.Objects = cdn.Objects or {}
cdn.URL = "https://cdn.moat.gg/"
cdn.Folder = "ttt"
cdn.FolderCheck = function(path)
	path = cdn.Folder .. "/" .. path

	if (not file.IsDir(path, "DATA")) then
		file.CreateDir(path)
		return
	end

	local objects = file.Find(path .. "/*", "DATA")
	if (objects and #objects > 5000) then
		for k, v in ipairs(objects) do
			file.Delete(path .. "/" .. v)
		end
	end
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

cdn.FolderCheck "cache"
cdn.FolderCheck "cache/data"
cdn.FolderCheck "cache/materials"
cdn.FolderCheck "cache/models"
cdn.FolderCheck "cache/sound"
cdn.Folder = "ttt/cache"

function cdn.Fetch(key, folder, ext, cache, write, callback)
	local hashy = hash.MD5(key)
	local object = cdn.Folder .. "/" .. folder .. "/" .. hashy .. ext
	
	if (file.Exists(object, "DATA")) then
		cdn.Cache[key] = cache and cache(object) or "data/" .. object

		return cdn.Cache[key]
	elseif (file.Exists('moat_cache'..(ext=='.txt' and '/2/' or '/1/')..hashy..ext, "DATA")) then
		object = 'moat_cache'..(ext=='.txt' and '/2/' or '/1/')..hashy..ext
		cdn.Cache[key] = cache and cache(object) or "data/" .. object

		return cdn.Cache[key]
	elseif (not http or not http.Loaded) then
		return false
	end

	cdn.Cache[key] = false

	http.Fetch(key, function(data)
		cdn.Cache[key] = cache and cache(object) or "data/" .. object

		if (write) then
			write(object, data, ext)
		end

		if (callback) then
			callback(cdn.Cache[key])
		end
	end)

	return false
end