local bit_band     = bit.band
local bit_bxor     = bit.bxor
local math_floor   = math.floor
local math_random  = math.random
local string_byte  = string.byte
local string_char  = string.char
local string_gsub  = string.gsub
local string_rep   = string.rep
local table_concat = table.concat

local string_chars = {}
for i = 0, 255 do
	string_chars [i] = string_char (i)
end

local KeyBytes = {}

local function GetKeyBytes (key)
	if KeyBytes [key] then return KeyBytes [key] end
	
	local keyBytes = {}
	for i = 1, #key do
		keyBytes [i] = string_byte (key, i)
	end
	
	KeyBytes [key] = keyBytes
	
	return KeyBytes [key]
end

function CAC.GenerateRandomBytes (byteCount)
	local t = {}
	
	for i = 1, byteCount do
		t [#t + 1] = string_chars [math_random (0, 255)]
	end
	
	return table_concat (t)
end

function CAC.GenerateEncryptionKey (byteCount)
	return CAC.GenerateRandomBytes (byteCount)
end

function CAC.Encrypt (str, key)
	local output = {}
	
	local keyBytes = GetKeyBytes (key)
	
	local carry = 0
	for i = 1, #str do
		local c = string_byte (str, i)
		c = bit_bxor (c, keyBytes [(i - 1) % #key + 1])
		c = bit_bxor (c, (carry + i) % 256)
		
		output [#output + 1] = string_chars [c]
		
		carry = c
	end
	
	return table_concat (output)
end

function CAC.Decrypt (str, key)
	local output = {}
	
	local keyBytes = GetKeyBytes (key)
	
	local carry = 0
	for i = 1, #str do
		local c = string_byte (str, i)
		local nextCarry = c
		c = bit_bxor (c, string_byte (key, (i - 1) % #key + 1))
		c = bit_bxor (c, (carry + i) % 256)
		
		output [#output + 1] = string_chars [c]
		
		carry = nextCarry
	end
	
	return table_concat (output)
end

function CAC.EncryptPad (str, key)
	if #str % 32 ~= 0 then
		str = str .. string_rep ("\0", 32 - #str % 32)
	end
	
	return CAC.Encrypt (str, key)
end

function CAC.DecryptPad (str, key)
	local str = CAC.Decrypt (str, key)
	str = string_gsub (str, "%z+$", "")
	
	return str
end

function CAC.MultiplyMod (a, b, mod)
	return (a * b) % mod
end

function CAC.MultiplyMod32 (a, b, mod)
	local uint1600 = a % 0x00010000
	local uint1610 = b % 0x00010000
	local uint1601 = math_floor (a / 0x00010000)
	local uint1611 = math_floor (b / 0x00010000)
	
	-- (a1 k + a0) (b1 k + b0)
	-- a1 b1 k k + a0 b1 k + a1 b0 k + a0 b0
	local result = CAC.MultiplyMod (CAC.MultiplyMod (uint1601, uint1611, mod), CAC.MultiplyMod (0x00010000, 0x00010000, mod), mod)
	result = result + CAC.MultiplyMod (CAC.MultiplyMod (uint1600, uint1611, mod), 0x00010000, mod)
	result = result + CAC.MultiplyMod (CAC.MultiplyMod (uint1601, uint1610, mod), 0x00010000, mod)
	result = result + CAC.MultiplyMod (uint1600, uint1610, mod)
	result = result % mod
	
	return result
end

function CAC.ExponentiateMod (base, exponent, mod)
	if exponent < 0 then return 0 end
	
	local result = 1
	
	local n = base
	local i = 1
	while i <= exponent do
		if bit_band (exponent, i) ~= 0 then
			result = CAC.MultiplyMod32 (result, n, mod)
		end
	
		n = CAC.MultiplyMod32 (n, n, mod)
		i = i * 2
	end
	
	return result
end
