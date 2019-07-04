if (SERVER) then
	util.AddNetworkString "cdn.PlayURL"

	function cdn.PlayURL(key, volume, cb)
		net.Start "cdn.PlayURL"
			net.WriteString(key)
			net.WriteFloat(volume or 1)
		net.Broadcast()
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
		local cache = cdn.Sound(key)
		flags = flags or ""
		
		if (cache) then
			return sound_PlayFile(cache, flags, function(s)
				if (IsValid(s)) then
					if (not flags:find "noplay") then
						s:Play()
					end

					if (volume) then
						s:SetVolume(volume)
					end

					if (cb) then
						cb(s)
					end
				end
			end)
		else
			return _sound_PlayURL(key, flags, function(s)
				if (IsValid(s)) then
					if (not flags:find "noplay") then
						s:Play()
					end

					if (volume) then
						s:SetVolume(volume)
					end

					if (cb) then
						cb(s)
					end
				end
			end)
		end
	end

	net.Receive("cdn.PlayURL", function()
		local key = net.ReadString()
		local vol = net.ReadFloat()

		cdn.PlayURL(key, vol)
	end)
end