local tonumber        = tonumber

local bit_band        = bit.band

local jit_util_funcbc = jit.util.funcbc

local util_CRC        = util.CRC

local opcodeMap =
{
	[0x46] = 0x51, -- RET    -> LOOP
	[0x47] = 0x51, -- RET0   -> LOOP
	[0x48] = 0x51, -- RET1   -> LOOP
	[0x49] = 0x49, -- FORI   -> FORI
	[0x4A] = 0x49, -- JFORI  -> FORI
	[0x4B] = 0x4B, -- FORL   -> FORL
	[0x4C] = 0x4B, -- IFORL  -> FORL
	[0x4D] = 0x4B, -- JFORL  -> FORL
	[0x4E] = 0x4E, -- ITERL  -> ITERL
	[0x4F] = 0x4E, -- IITERL -> ITERL
	[0x50] = 0x4E, -- JITERL -> ITERL
	[0x51] = 0x51, -- LOOP   -> LOOP
	[0x52] = 0x51, -- ILOOP  -> LOOP
	[0x53] = 0x51, -- JLOOP  -> LOOP
}

local opcodeMap2 =
{
	[0x44] = 0x54, -- ISNEXT -> JMP
	[0x42] = 0x41, -- ITERN  -> ITERC
}

function CAC.CalculateBytecodeHashFromFunctionDump (inBuffer)
	if isstring (inBuffer) then
		inBuffer = CAC.StringInBuffer (inBuffer)
	end
	
	inBuffer:UInt8   () -- Flags
	inBuffer:UInt8   () -- Fixed parameter count
	inBuffer:UInt8   () -- Frame size
	inBuffer:UInt8   () -- Upvalue count
	inBuffer:ULEB128 () -- Garbage collected constant count
	inBuffer:ULEB128 () -- Numeric constant count
	local instructionCount = inBuffer:ULEB128 () -- Instruction count
	
	inBuffer:ULEB128 () -- Debug data length
	
	inBuffer:ULEB128 () -- Start line
	inBuffer:ULEB128 () -- Line count
	
	return CAC.CalculateBytecodeHashFromBytecodeDump (inBuffer, instructionCount)
end

function CAC.CalculateBytecodeHashFromBytecodeDump (inBuffer, instructionCount)
	if isstring (inBuffer) then
		inBuffer = CAC.StringInBuffer (inBuffer)
	end
	
	local outBuffer = CAC.StringOutBuffer ()
	for i = 1, instructionCount do
		local instruction = inBuffer:UInt32 ()
		local opcode      = bit_band (instruction, 0xFF)
		
		if opcodeMap [opcode] then
			-- Strip off operands
			instruction = opcodeMap [opcode]
		end
		
		if opcodeMap2 [opcode] then
			-- Remap opcode only
			instruction = instruction - opcode
			instruction = instruction + opcodeMap2 [opcode]
		end
		
		outBuffer:UInt32 (instruction)
	end
	
	return tonumber (util_CRC (outBuffer:GetString ()))
end

function CAC.CalculateBytecodeHashFromFunction (f, instructionCount)
	local outBuffer = CAC.StringOutBuffer ()
	
	-- Skip the function header pseudo-instruction
	instructionCount = instructionCount - 1
	for i = 1, instructionCount do
		local instruction = jit_util_funcbc (f, i)
		local opcode      = bit_band (instruction, 0xFF)
		
		if opcodeMap [opcode] then
			-- Strip off operands
			instruction = opcodeMap [opcode]
		end
		
		if opcodeMap2 [opcode] then
			-- Remap opcode only
			instruction = instruction - opcode
			instruction = instruction + opcodeMap2 [opcode]
		end
		
		outBuffer:UInt32 (instruction)
	end
	
	return tonumber (util_CRC (outBuffer:GetString ()))
end