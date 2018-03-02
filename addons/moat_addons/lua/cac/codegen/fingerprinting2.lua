CAC.CodeGen = CAC.CodeGen or {}

CAC.CodeGen.Key2 = "\xfbXJ\xce\x10\x0e\xb2\xfd@\xaa\x0f+*Z\x05\x9dQ\xe6/\xd4PA=\xd0f\xa6\xd7\x06*\xeaO\x81\x89\x80\xdb\xd8\xde\"r\xfa\x06\xf4\x81=\xf0\x0fS9B\x90\x86vdI\x81\x839l\x89`\x0f\xcd\r=\xbd6]g\xa0\x82!v\x1a\xe0\xbccg\xfbn\r\xbb@M\xe5\xc9\x01\xb7\x04\xa6\x90O\xc8\xac\xd7z\xb9\x0f\x84\xacS\x18p-)\xe0j\xe7\xf8\x84\xe0\x96H\xfe\xac\xe7?\xee\x1b\xce\xbc\xc01?\xf7\x149D\xdf"

local hostip   = GetConVar ("hostip")
local hostname = GetConVar ("hostname")

local tonumber      = tonumber

local math_random   = math.random
local string_byte   = string.byte
local string_char   = string.char
local string_format = string.format
local string_gmatch = string.gmatch
local string_gsub   = string.gsub
local table_concat  = table.concat

local string_chars = {}
for i = 0, 255 do
	string_chars [i] = string_char (i)
end

function CAC.CodeGen.GeneratePath (livePlayerSession, code, payloadId)
	if Profiler then Profiler:Begin ("CAC.CodeGen.GeneratePath") end
	
	local fileName = nil
	
	if payloadId then
		fileName = CAC.CodeGen.StringToHex (CAC.EncryptPad (string.char (math.random (0, 255), math.random (0, 255), math.random (0, 255), math.random (0, 255)) .. payloadId, CAC.CodeGen.Key2))
	else
		error ("CAC.CodeGen.GeneratePath : No payload ID!")
	end
	
	local path = string.format ("lua/.dragondildos/rc1/../nul/%s.lua", fileName)
	
	if Profiler then Profiler:End () end
	
	return path
end

if Profiler then
	CAC.CodeGen.GeneratePath = Profiler:Wrap (CAC.CodeGen.GeneratePath, "CAC.CodeGen.GeneratePath")
end

function CAC.CodeGen.DecodePath (livePlayerSession, path)
	if not path then return nil end
	
	local fileName = string.match (path, "lua/%.dragondildos/rc1/%.%./nul/([0-9a-fA-F]+).lua")
	if not fileName then return path end
	
	local payloadId = CAC.DecryptPad (CAC.CodeGen.HexToString (fileName), CAC.CodeGen.Key2)
	payloadId = string.sub (payloadId, 5)
	local payloadInformation = CAC.Payloads:GetPayload (payloadId)
	
	if not payloadInformation then return path end
	
	return payloadInformation:GetLuaPath ()
end

function CAC.CodeGen.GenerateRandomString (length)
	local output = {}
	
	for i = 1, length do
		output [#output + 1] = string_chars [math_random (0, 255)]
	end
	
	return table_concat (output)
end

function CAC.CodeGen.GetFingerprint (fingerprintType, livePlayerSession)
	local fingerprint = nil
	
	if fingerprintType == CAC.Identifiers.EncryptionKey then
		fingerprint = livePlayerSession:GetDataEncryptionKey ()
		return CAC.String.EscapeNonprintable (fingerprint)
	end
	
	fingerprintType = CAC.CodeGen.HexToString (fingerprintType)
	fingerprintType = CAC.Decrypt (fingerprintType, CAC.CodeGen.Key2)
	fingerprintType = string.Trim (fingerprintType)
	
	if fingerprintType == "ANTICHEAT_EDITION" then
		fingerprint = CAC.Edition
	elseif fingerprintType == "SERVER_IP" then
		local ip = tonumber (hostip:GetString ()) or 0
		
		fingerprint = CAC.IPToString (ip)
	elseif fingerprintType == "SERVER_HOSTNAME" then
		fingerprint = hostname:GetString ()
	elseif fingerprintType == "TIMESTAMP" then
		fingerprint = tostring (os.time ())
	elseif fingerprintType == "FORMATTED_TIMESTAMP" then
		fingerprint = os.date ("!%Y-%m-%d %H:%M:%S UTC+0000")
	elseif fingerprintType == "PLAYER_STEAM_ID" then
		fingerprint = livePlayerSession:GetPlayer ():SteamID ()
	elseif fingerprintType == "PLAYER_PROFILE_URL" then
		fingerprint = "https://steamcommunity.com/profiles/" .. (livePlayerSession:GetPlayer ():SteamID64 () or "UNKNOWN")
	elseif fingerprintType == "PLAYER_NAME" then
		fingerprint = livePlayerSession:GetPlayer ():Name ()
	elseif fingerprintType == "PLAYER_IP" then
		fingerprint = livePlayerSession:GetPlayer ():IPAddress ()
	end
		
	if fingerprint then
		return CAC.CodeGen.StringToHex (CAC.Encrypt (CAC.CodeGen.GenerateRandomString (8) .. fingerprint, CAC.CodeGen.Key2))
	else
		return "[[[" .. fingerprintType .. "]]]"
	end
end

function CAC.CodeGen.FinalizeCode (code, livePlayerSession)
	code = string.gsub (code, "%[%[%[([^\r\n%]]+)%]%]%]",
		function (fingerprintType)
			return CAC.CodeGen.GetFingerprint (fingerprintType, livePlayerSession)
		end
	)
	
	return code
end

function CAC.CodeGen.StringToHex (str)
	local output = {}
	for i = 1, #str do
		output [#output + 1] = string_format ("%02x", string_byte (str, i))
	end
	
	return table_concat (output)
end

local hexToStringCache = {}
function CAC.CodeGen.HexToString (hexString)
	if hexToStringCache [hexString] then
		return hexToStringCache [hexString]
	end
	
	local output = {}
	
	for hex in string_gmatch (hexString, "[a-zA-Z0-9][a-zA-Z0-9]") do
		output [#output + 1] = string_chars [tonumber (hex, 16)]
	end
	
	hexToStringCache [hexString] = table_concat (output)
	
	return hexToStringCache [hexString]
end