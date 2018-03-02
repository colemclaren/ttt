-- Generated from: gnative/lua/gnative/alignment.lua
-- Original:       https://github.com/notcake/gnative/blob/master/lua/gnative/alignment.lua
-- Timestamp:      2017-06-26 21:46:49
CAC.ModuleAlignment =
{
	Windows = 0x00010000,
	Linux   = 0x00001000,
	OSX     = 0x00001000
}

CAC.PageAlignment   = 4096
CAC.PageSize        = 4096

function CAC.AlignAddress (address, alignment)
	return math.floor (address / alignment) * alignment
end

function CAC.GetModuleAlignment (operatingSystem)
	return CAC.ModuleAlignment [operatingSystem]
end

function CAC.GetPageAlignment ()
	return CAC.PageAlignment
end

function CAC.GetPageSize ()
	return CAC.PageSize
end

function CAC.IsAligned (address, alignment)
	return address % alignment == 0
end