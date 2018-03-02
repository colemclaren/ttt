-- This file is computer-generated.
CAC.BitConverter       = CAC.BitConverter       or {}
CAC.Color              = CAC.Color              or {}
CAC.Colors             = CAC.Colors             or {}
CAC.Containers         = CAC.Containers         or {}
CAC.Databases          = CAC.Databases          or {}
CAC.DurationParser     = CAC.DurationParser     or {}
CAC.Enumerator         = CAC.Enumerator         or {}
CAC.Lua                = CAC.Lua                or {}
CAC.Resources          = CAC.Resources          or {}
CAC.Serialization      = CAC.Serialization      or {}
CAC.String             = CAC.String             or {}
CAC.UTF8               = CAC.UTF8               or {}
CAC.Unicode            = CAC.Unicode            or {}
CAC.Unicode.Characters = CAC.Unicode.Characters or {}

-- Timestamp: 2016-02-22 19:22:24
function CAC.Debug (message)
	-- ErrorNoHalt (message .. "\n")
end

-- Timestamp: 2016-02-22 19:22:24
function CAC.InvertTable (tbl, out)
	out = out or {}
	
	local keys = {}
	for key, _ in pairs (tbl) do
		keys [#keys + 1] = key
	end
	for i = 1, #keys do
		out [tbl [keys [i]]] = keys [i]
	end
	
	return out
end

-- Timestamp: 2016-02-22 19:22:24
function CAC.Initialize (systemName, systemTable)
	if not systemTable then
		CAC.Error ("CAC.Initialize : Called incorrectly.")
	end
	
	setmetatable (systemTable, getmetatable (systemTable) or {})
	if systemTable ~= CAC then
		getmetatable (systemTable).__index = CAC
		
		for k, v in pairs (CAC) do
			if type (v) == "table" then
				-- Object static tables
				local metatable = debug.getmetatable (v)
				local ictorInvoker = metatable and metatable.__call or nil
				
				systemTable [k] = {}
				if v.__static then systemTable [k].__static = true end
				setmetatable (systemTable [k],
					{
						__index = v,
						__call = ictorInvoker
					}
				)
			end
		end
	end
	
	CAC.EventProvider (systemTable)
	systemTable:AddEventListener ("Unloaded", "CAC.Unloader",
		function ()
			if not istable (ULib) then
				hook.Remove ("ShutDown", tostring (systemName))
			end
		end
	)
	
	hook.Add ("ShutDown", tostring (systemName),
		function ()
			CAC.Debug ("Unloading " .. systemName .. "...")
			systemTable:DispatchEvent ("Unloaded")
		end
	)
	
	CAC.CallDelayed (
		function ()
			hook.Call ("CACSystemLoaded", GAMEMODE or GM, tostring (systemName))
			hook.Call (tostring (systemName) .. "Loaded", GAMEMODE or GM)
		end
	)
end

-- Timestamp: 2016-02-22 19:22:24
	function CAC.WaitForLocalPlayer (callback)
		if not LocalPlayer or
		   not LocalPlayer () or
		   not LocalPlayer ():IsValid () then
			CAC.CallDelayed (
				function ()
					CAC.WaitForLocalPlayer (callback)
				end
			)
			return
		end
		callback ()
	end

-- Timestamp: 2016-02-22 19:22:24
function CAC.WeakKeyTable ()
	local tbl = {}
	setmetatable (tbl, { __mode = "k" })
	return tbl
end

-- Timestamp: 2016-02-22 19:22:24
function CAC.WeakValueTable ()
	local tbl = {}
	setmetatable (tbl, { __mode = "v" })
	return tbl
end

-- Timestamp: 2016-02-22 19:22:24
function CAC.NullCallback ()
end



CAC.Error = function (msg)
				if GLib and GLib.Error then
					return GLib.Error (msg)
				end
				
				ErrorNoHalt (tostring (msg) .. "\n" .. debug.traceback ())
			end
			
			CAC.Lua = CAC.Lua or {}
			CAC.Lua.NameCache = CAC.Lua.NameCache or {}
			CAC.Lua.NameCache.Index = function () end
			
			local string_format = string.format
			local timeUnits = { "ns", "µs", "ms", "s", "ks", "Ms", "Gs", "Ts", "Ps", "Es", "Zs", "Ys" }
			function CAC.FormatDuration (duration)
				duration = duration * 1000000000
				
				local unitIndex = 1
				while duration >= 1000 and timeUnits [unitIndex + 1] do
					duration = duration / 1000
					unitIndex = unitIndex + 1
				end
				return string_format ("%.2f %s", duration, timeUnits [unitIndex])
			end
			
			local sizeUnits = { "B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB" }
			function CAC.FormatFileSize (size)
				local unitIndex = 1
				while size >= 1024 and sizeUnits [unitIndex + 1] do
					size = size / 1024
					unitIndex = unitIndex + 1
				end
				return string_format ("%.2f %s", size, sizeUnits [unitIndex])
			end
include ("glib_imported/oop/enum.lua")
include ("glib_imported/oop/oop.lua")
include ("glib_imported/timers.lua")
include ("glib_imported/stringbuilder.lua")
include ("glib_imported/glue.lua")
include ("glib_imported/events/eventprovider.lua")
include ("glib_imported/colors/colors.lua")
include ("glib_imported/colors/color.lua")
include ("glib_imported/string/escaping.lua")
include ("glib_imported/bitconverter.lua")
include ("glib_imported/io/inbuffer.lua")
include ("glib_imported/io/outbuffer.lua")
include ("glib_imported/io/stringinbuffer.lua")
include ("glib_imported/io/stringoutbuffer.lua")
include ("glib_imported/serialization/iserializable.lua")
include ("glib_imported/enumeration/enumerators.lua")
include ("glib_imported/enumeration/composition.lua")
include ("glib_imported/userid.lua")
include ("glib_imported/garrysmod/servers/playermonitorentry.lua")
include ("glib_imported/servers/iplayermonitor.lua")
include ("glib_imported/garrysmod/servers/playermonitor.lua")
include ("glib_imported/containers/icollection.lua")
include ("glib_imported/containers/orderedset.lua")
include ("glib_imported/unicode/unicodecategory.lua")
include ("glib_imported/unicode/wordtype.lua")
include ("glib_imported/unicode/utf8.lua")
include ("glib_imported/unicode/unicode.lua")
include ("glib_imported/unicode/unicodecategorytable.lua")
include ("glib_imported/unicode/transliteration.lua")
include ("glib_imported/lua/lua.lua")
include ("glib_imported/databases/idatabase.lua")
include ("glib_imported/databases/sqlitedatabase.lua")
include ("glib_imported/databases/mysqldatabase.lua")
include ("glib_imported/databases/mysqloodatabase.lua")
include ("glib_imported/parsing/stringparser.lua")
include ("glib_imported/parsing/durationparser.lua")
include ("glib_imported/resources/unicodedata_00.lua")
include ("glib_imported/resources/unicodedata_01.lua")
include ("glib_imported/resources/unicodedata_02.lua")
include ("glib_imported/resources/unicodedata_03.lua")
include ("glib_imported/resources/unicodedata_04.lua")
include ("glib_imported/resources/unicodedata_05.lua")
include ("glib_imported/resources/unicodedata_06.lua")
include ("glib_imported/resources/unicodedata_07.lua")
include ("glib_imported/resources/unicodedata_08.lua")
include ("glib_imported/resources/unicodedata_09.lua")
include ("glib_imported/resources/unicodedata_final.lua")

