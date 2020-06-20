AddCSLuaFile()

TOTAL_INCLUDES = {}
if (not _include) then _include = include end
function include(str)
	table.insert(TOTAL_INCLUDES, str)
	return _include(str)
end

include "include.lua"

yugh.ish "utils.lua"

local yughs_dir = "system/app/yugh/libraries/"
yugh.apps = yugh.apps or {
	sh = yughs_dir,
	sv = yughs_dir .. "server/",
	cl = yughs_dir .. "client/",
	exists = {},
	ran = {},
	bad = {}
}

local includes = {{
	"system/app/yugh/libraries/hook.lua",
	"system/app/yugh/libraries/http.lua",
	"system/app/yugh/extensions/entity.lua",
	"system/app/yugh/extensions/http.lua",
	"system/app/yugh/extensions/net.lua",
	"system/app/yugh/extensions/player.lua",
	"system/app/yugh/extensions/string.lua",
	"system/app/yugh/extensions/table.lua",
	"system/app/yugh/extensions/timer.lua",
	"system/app/yugh/extensions/type.lua",
	"system/app/yugh/extensions/util.lua",
	"system/app/yugh/libraries/hash.lua",
	"system/app/yugh/libraries/lang.lua",
	"system/app/yugh/libraries/usermessage.lua",
	"system/app/yugh/libraries/bon.lua",
}, {
	"system/app/yugh/extensions/client/derma.lua",
	"system/app/yugh/extensions/client/globals.lua",
	"system/app/yugh/extensions/client/player.lua",
	"system/app/yugh/extensions/client/surface.lua",
}, {
	"system/app/yugh/extensions/server/slack.lua",
	"system/app/yugh/extensions/server/discord.lua",
	"system/app/yugh/extensions/server/player.lua",
}}

for i = 1, 3 do
	for k, v in ipairs(includes[i]) do
		local fn = v:match "[\\/]([^/\\]+)%.lua$"
		yugh.apps.exists[fn] = v
		if (SERVER and i ~= 3) then
			AddCSLuaFile(v)
		end

		if (i == 1 or (i == 3 and SERVER) or (i == 2 and CLIENT)) then
			yugh.apps.ran[fn] = true

			include(v)
		end
	end
end

if (not _require) then _require = require end
function require(str)
	if (yugh.apps.exists[str] and not yugh.apps.ran[str]) then
		yugh.apps.ran[str] = true
		return include(yugh.apps.exists[str])
	elseif (not yugh.apps.ran[str] and (not yugh.apps.bad[str])) then
		return _require(str)
	end
end

yugh.ish "includes/_init.lua"
yugh.ish "system/app/yugh/libraries/cdn.lua"
yugh.icl "system/app/yugh/extensions/color.lua"
yugh.i "/system/app/yugh/" {
	"extensions/",
	"modules/"
}

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
	net.Receive("cdn.PlayURL", function()
		local key = net.ReadString()
		local vol = net.ReadFloat()
		local flags = net.ReadString()

		cdn.PlayURL(key, vol, function() end, flags)
	end)
end