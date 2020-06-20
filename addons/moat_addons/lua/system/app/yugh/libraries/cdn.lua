cdn = cdn or {}
cdn.Cache = {}
cdn.Objects = cdn.Objects or {}
cdn.URL = "https://static.moat.gg/"
cdn.Folder = "ttt"
cdn.FolderCheck = function(path)
	path = cdn.Folder .. "/" .. path

	if (not file.IsDir(path, "DATA")) then
		file.CreateDir(path)
		return
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
	local hashy = util.CRC(key)
	local object = cdn.Folder .. "/" .. folder .. "/" .. hashy .. ext

	if (file.Exists(object, "DATA")) then
		cdn.Cache[key] = cache and cache(object) or ("data/" .. object)

		return cdn.Cache[key]
	elseif (file.Exists('moat_cache'..(ext=='.txt' and '/2/' or '/1/')..hashy..ext, "DATA")) then
		object = 'moat_cache'..(ext=='.txt' and '/2/' or '/1/')..hashy..ext
		cdn.Cache[key] = cache and cache(object) or ("data/" .. object)

		return cdn.Cache[key]
	elseif (not http or not http.Loaded) then
		return false
	end

	if (not cdn.Working) then
		cdn.Cache[key] = false
		cdn.Working = true

		http.Fetch(key, function(data)
			cdn.Cache[key] = cache and cache(object) or ("data/" .. object)

			if (write) then
				write(object, data, ext)
			end

			if (callback) then
				callback(cdn.Cache[key])
			end

			cdn.Working = false
		end, function(err)
			cdn.Working = false
		end)
	end

	return false
end

if (SERVER) then
	local PLAYER = FindMetaTable "Player"
	util.AddNetworkString "cdn.PlayURL"

	function cdn.PlayURL(key, volume, cb, flags)
		net.Start "cdn.PlayURL"
			net.WriteString(key)
			net.WriteFloat(volume or 1)
			net.WriteString(flags or "")
		net.Broadcast()
	end

	function PLAYER:PlayURL(key, volume, cb, flags)
		net.Start "cdn.PlayURL"
			net.WriteString(key)
			net.WriteFloat(volume or 1)
			net.WriteString(flags or "")
		net.Send(self)
	end
else
	function cdn.Sound(key, cb)
		if (cdn.Cache[key] == nil) then
			return cdn.Fetch(key, "sound", ".txt", function(object)
				return "../data/" .. object
			end, function(object, data)
				return file.Write(object, data)
			end, cb)
		end

		return cdn.Cache[key]
	end

	if (not _sound_PlayURL) then
		_sound_PlayURL = sound.PlayURL
	end

	local sound_PlayFile = sound.PlayFile
	function cdn.PlayURL(key, volume, cb, flags)
		flags = flags or ""

		local cache = false
		if (not flags:find "stream") then
			cache = cdn.Sound(key)
		end

		if (cache) then
			sound_PlayFile(cache, flags, function(s)
				if (IsValid(s)) then
					if (volume) then
						s:SetVolume(volume)
					end

					if (not flags:find "noplay") then
						s:Play()
					end

					if (cb) then
						cb(s)
					end
				end
			end)
		else
			_sound_PlayURL(key, flags, function(s)
				if (IsValid(s)) then
					if (volume) then
						s:SetVolume(volume)
					end

					if (not flags:find "noplay") then
						s:Play()
					end

					if (cb) then
						cb(s)
					end
				end
			end)
		end
	end

	function cdn.Image(key, cb, params)
		if (type(cb) == "string") then
			params = cb
			cb = nil 
		end

		if (not IsValid(cdn.Cache[key])) then
			return cdn.Fetch(key, "materials", key:match"(%.[^%.]+)$", function(object)
				return (not key:match "vtf$") and Material("../data/" .. object, (type(cb) == "string") and cb or params) or "../data/" .. object
			end, function(object, data)
				return file.Write(object, data)
			end, cb)
		end

		return cdn.Cache[key]
	end

	local white = Color(255, 255, 255)
	function cdn.DrawImage(key, x, y, w, h, color, params)
		key = cdn.Image(key, nil, params)
		if (not key) then return end

		color = color or white

		surface.SetDrawColor(color.r, color.g, color.b, color.a)
		surface.SetMaterial(key)
		surface.DrawTexturedRect(x, y, w, h)
	end

	function cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, params)
		key = cdn.Image(key, nil, params)
		if (not key) then return end

		color = color or white

		surface.SetDrawColor(color.r, color.g, color.b, color.a)
		surface.SetMaterial(key)
		
		if (origin) then
			surface.DrawTexturedRectRotated(x + w/2, y + h/2, w, h, ang)
		else
			surface.DrawTexturedRectRotated(x, y, w, h, ang)
		end
	end

	function cdn.SmoothImage(key, x, y, w, h, color)
		return cdn.DrawImage(key, x, y, w, h, color, "noclamp smooth")
	end

	function cdn.SmoothImageRotated(key, x, y, w, h, color, ang, origin)
		return cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, "noclamp smooth")
	end

	function cdn.Texture(key, cb, params)
		if (type(cb) == "string") then
			params = cb
			cb = nil 
		end

		if (cdn.Cache[key] == nil) then
			return cdn.Fetch(key, "materials", ".vtf", function(object)
				return "../data/" .. object
			end, function(object, data)
				return file.Write(object, data)
			end, cb)
		end

		return cdn.Cache[key]
	end

	function cdn.TextureMaterial(key, cb, params)
		if (type(cb) == "string") then
			params = cb
			cb = nil 
		end

		if ((cdn.Cache[key] and type(key) ~= "IMaterial") or (type(cdn.Cache[key]) == "IMaterial" and cdn.Cache[key]:GetTexture("$basetexture"):IsErrorTexture())) then
			cdn.Cache[key] = nil
		end

		if (cdn.Cache[key] == nil) then
			return cdn.Fetch(key, "materials", ".vtf", function(object)
				local new_mat = CreateMaterial('cdn_' .. object, "UnlitGeneric", {
					-- ["$ignorez"] = 1,
					["$vertexalpha"] = 1,
					-- ["$vertexcolor"] = 1,
					-- ["$translucent"] = 1,
					["$smooth"] = 1,
					-- ["$alphatest"] = 0,
					["$basetexture"] = "error"
				})

				if (key:match "vtf$") then
					local function set(m)
						cdn.Cache[key] = nil
						if (type(m) == "string") then
							new_mat:SetTexture("$basetexture", m)
							cdn.Cache[key] = nil
						end
					end

					local m = cdn.Texture(key, set)
					if (m) then
						set(m)
					end
				else
					local function set(m)
						cdn.Cache[key] = nil
						new_mat:SetTexture("$basetexture", m:GetTexture("$basetexture"))
					end

					local m = cdn.Image(key, set)
					if (m) then
						set(m)
					end
				end

				return new_mat
			end, function(object, data)
				return file.Write(object, data)
			end, cb)
		end

		return cdn.Cache[key]
	end

	function cdn.DrawTexture(key, x, y, w, h, color, params)
		key = cdn.TextureMaterial(key, nil, params)
		if (not key or type(key) ~= "IMaterial") then
			cdn.Cache[key] = nil
			return
		end

		color = color or white

		surface.SetDrawColor(color.r, color.g, color.b, color.a)
		surface.SetMaterial(key)
		surface.DrawTexturedRect(x, y, w, h)
	end

	function cdn.DrawTextureRotated(key, x, y, w, h, color, ang, origin, params)
		key = cdn.Texture(key, nil, params)
		if (not key) then return end

		color = color or white

		surface.SetDrawColor(color.r, color.g, color.b, color.a)
		surface.SetMaterial(key)
		
		if (origin) then
			surface.DrawTexturedRectRotated(x + w/2, y + h/2, w, h, ang)
		else
			surface.DrawTexturedRectRotated(x, y, w, h, ang)
		end
	end

	function cdn.Model(mdl, pnl)
		pnl.ModelPanel = vgui.Create("DButton", pnl)
		pnl.ModelPanel:SetPos(0, 0)
		pnl.ModelPanel:SetSize(64, 64)
		pnl.ModelPanel:SetText ""
		pnl.ModelPanel.Paint = function() end

		cdn.ModelIcon(mdl, function(img)
			if (IsValid(pnl.ModelPanel)) then
				pnl.ModelPanel:SetImage(img)
				pnl.ModelPanel:SetVisible(true)
			end
		end)
	end

	function cdn.Data(key, cb)
		if (cdn.Cache[key] == nil) then
			return cdn.Fetch(key, "data", ".txt", function(object)
				local data = file.Read(object, "DATA")
				return data
			end, function(object, data)
				return file.Write(object, data)
			end, cb)
		end

		return cdn.Cache[key]
	end
end