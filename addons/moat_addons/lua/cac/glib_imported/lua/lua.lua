-- Generated from: glib/lua/glib/lua/lua.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/lua/lua.lua
-- Timestamp:      2016-02-22 19:22:23
function CAC.Lua.AddressOf (object)
	local addressString = string.format ("%p", object)
	if addressString == "NULL" then return 0 end
	return tonumber (addressString)
end

function CAC.Lua.CreateShadowGlobalTable ()
	local globalShadowTable = CAC.Lua.CreateShadowTable (_G)
	
	globalShadowTable.timer.Adjust  = CAC.NullCallback
	globalShadowTable.timer.Create  = CAC.NullCallback
	globalShadowTable.timer.Destroy = CAC.NullCallback
	globalShadowTable.timer.Pause   = CAC.NullCallback
	globalShadowTable.timer.Stop    = CAC.NullCallback
	globalShadowTable.timer.Simple  = CAC.NullCallback
	globalShadowTable.timer.Toggle  = CAC.NullCallback
	globalShadowTable.timer.UnPause = CAC.NullCallback
	
	globalShadowTable.hook.Add    = CAC.NullCallback
	globalShadowTable.hook.GetTable = function ()
		return CAC.Lua.CreateShadowTable (hook.GetTable ())
	end
	globalShadowTable.hook.Remove = CAC.NullCallback
	
	return globalShadowTable
end

function CAC.Lua.CreateShadowTable (t)
	local shadowTable = {}
	local metatable = {}
	local nils = {}
	
	metatable.__index = function (self, key)
		if rawget (self, key) ~= nil then
			return rawget (self, key)
		end
		
		if nils [key] then
			return nil
		end
		
		if t [key] ~= nil then
			if type (t [key]) == "table" then
				rawset (self, key, CAC.Lua.CreateShadowTable (t [key]))
				return rawget (self, key)
			end
			return t [key]
		end
	end
	
	metatable.__newindex = function (self, key, value)
		rawset (self, key, value)
		nils [key] = value == nil
	end
	
	setmetatable (shadowTable, metatable)
	
	return shadowTable
end

function CAC.Lua.GetFunctionName (func)
	if not CAC.Lua.NameCache               then return nil end
	if not CAC.Lua.NameCache.GetObjectName then return nil end
	
	return CAC.Lua.NameCache:GetFunctionName (func)
end

function CAC.Lua.GetObjectName (object)
	if not CAC.Lua.NameCache               then return nil end
	if not CAC.Lua.NameCache.GetObjectName then return nil end
	
	return CAC.Lua.NameCache:GetObjectName (object)
end

function CAC.Lua.GetTable (tableName)
	local parts = string.Split (tableName, ".")
	
	local t = _G
	for i = 1, #parts do
		if i == 1 and parts [i] == "_R" then
			t = debug.getregistry ()
		else
			t = t [parts [i]]
		end
		
		if not t then break end
	end
	
	if not t then
		CAC.Error ("CAC.Lua.GetTable : Table " .. tableName .. " does not exist.")
		return nil
	end
	
	return t
end

function CAC.Lua.GetTableName (table)
	return CAC.Lua.NameCache:GetTableName (table)
end

function CAC.Lua.GetTableValue (valueName)
	local parts = string.Split (valueName, ".")
	local valueName = parts [#parts]
	parts [#parts] = nil
	
	local tableName = #parts > 0 and table.concat (parts, ".") or "_G"
	
	local t = _G
	for i = 1, #parts do
		if i == 1 and parts [i] == "_R" then
			t = debug.getregistry ()
		else
			t = t [parts [i]]
		end
		
		if not t then break end
	end
	
	if not t then
		CAC.Error ("CAC.Lua.GetTableValue : Table " .. tostring (tableName) .. " does not exist.")
		return nil
	end
	
	return t [valueName], t, tableName, valueName
end

function CAC.Lua.IsNativeFunction (f)
	return debug.getinfo (f).what == "C"
end

local keywords =
{
	["if"]       = true,
	["then"]     = true,
	["elseif"]   = true,
	["else"]     = true,
	["for"]      = true,
	["while"]    = true,
	["do"]       = true,
	["repeat"]   = true,
	["until"]    = true,
	["end"]      = true,
	["return"]   = true,
	["break"]    = true,
	["continue"] = true,
	["function"] = true,
	["not"]      = true,
	["and"]      = true,
	["or"]       = true,
	["true"]     = true,
	["false"]    = true,
	["nil"]      = true
}

function CAC.Lua.IsValidVariableName (name)
	if not isstring (name) then return false end
	if not keywords [name] and string.match (name, "^[_a-zA-Z][_a-zA-Z0-9]*$") then return true end
	return false
end

local ToCompactLuaString
local ToLuaString

local TypeFormatters =
{
	["nil"] = tostring,
	["boolean"] = tostring,
	["number"] = function (value)
		if value == math.huge then return "math.huge"
		elseif value == -math.huge then return "-math.huge" end
		
		if value >= 65536 and
		   value < 4294967296 and
		   math.floor (value) == value then
			return string.format ("0x%08x", value)
		end
		
		return tostring (value)
	end,
	["string"] = function (value)
		return "\"" .. CAC.String.EscapeNonprintable (value) .. "\""
	end,
	["table"] = function (value)
		local name = CAC.Lua.GetTableName (value)
		if name then return name end
		
		local valueType = type (value)
		local metatable = debug.getmetatable (value)
		if metatable then
			valueType = CAC.Lua.GetTableName (metatable) or valueType
		end
		return string.format ("{ %s: %p }", valueType, value)
	end,
	["Panel"] = function (value)
		return string.format ("{ Panel: %s %p }", value.ClassName or "", value)
	end,
	["Entity"] = function (value)
		if not value:IsValid () then return "NULL" end
		
		-- Serverside entity
		local entityIndex = value:EntIndex ()
		if entityIndex >= 0 then
			local entityInfo = value:GetClass ()
			
			if value:IsPlayer () then
				entityInfo = value:SteamID () .. ", " .. value:GetName ()
			end
			
			return "Entity (" .. entityIndex .. ") --[[ " .. entityInfo .. " ]]"
		end
		
		-- Clientside model
		local model = value:GetModel ()
		return "ClientsideModel (" .. ToCompactLuaString (model) .. ")"
	end,
	["function"] = function (value)
		local name = CAC.Lua.GetFunctionName (value)
		return name or CAC.Lua.FunctionCache:GetFunction (value):GetPrototype ()
	end
}

TypeFormatters ["Player"] = TypeFormatters ["Entity"]
TypeFormatters ["Weapon"] = TypeFormatters ["Entity"]
TypeFormatters ["NPC"]    = TypeFormatters ["Entity"]

function ToCompactLuaString (value, stringBuilder)
	local typeFormatter = TypeFormatters [type (value)] or tostring
	return typeFormatter (value)
end

function ToLuaString (value, stringBuilder)
	local valueType = type (value)
	
	local name = CAC.Lua.GetObjectName (value)
	
	-- TODO: Handle tables and functions
	if type (value) == "function" then
		local functionInfo = CAC.Lua.Function (value)
		if functionInfo:IsNative () then
			if name then return name end
		else
			local sourceFile = functionInfo:GetFilePath ()
			local data = file.Read (sourceFile, "GAME")
			data = data or file.Read (sourceFile, "LUA")
			data = data or file.Read (sourceFile, SERVER and "LSV" or "LCL")
			
			if data then
				-- Normalize line endings
				data = string.gsub (data, "\r\n", "\n")
				data = string.gsub (data, "\r", "\n")
				
				local startLine = functionInfo:GetStartLine ()
				local endLine   = functionInfo:GetEndLine ()
				
				local lines = string.Split (data, "\n")
				if endLine <= #lines then
					local code = {}
					for i = startLine, endLine do
						code [#code + 1] = lines [i]
					end
					code = table.concat (code, "\n")
					return code
				end
			end
			
			return CAC.Lua.BytecodeReader (value):ToString ()
		end
	else
		if name then return name end
	end
	
	return ToCompactLuaString (value, stringBuilder)
end

function CAC.Lua.ToLuaString (value)
	local luaString = ToLuaString (value, stringBuilder)
	
	-- Collapse any StringBuilder objects
	if type (luaString) == "table" then
		luaString = luaString:ToString ()
	end
	
	return luaString
end

function CAC.Lua.ToCompactLuaString (value)
	local luaString = ToCompactLuaString (value, stringBuilder)
	
	-- Collapse any StringBuilder objects
	if type (luaString) == "table" then
		luaString = luaString:ToString ()
	end
	
	return luaString
end