-- Generated from: gnative/lua/gnative/garrysmod/modules.lua
-- Original:       https://github.com/notcake/gnative/blob/master/lua/gnative/garrysmod/modules.lua
-- Timestamp:      2017-06-26 21:46:49
CAC.Modules = CAC.Modules or {}

CAC.Modules.ClientDllOffsets =
{
	Windows =
	{
		[0x0000bfb0] = 0x000abfb0, -- Live
		[0x00001c80] = 0x000b1c80, -- Dev  (14-03-04)
		[0x000023c0] = 0x000b23c0, -- Dev  (14-03-28)
		[0x00002020] = 0x000b2020, -- Live (14-04-03)
		[0x00002220] = 0x000b2220, -- Live (14-04-04)
		[0x00002220] = 0x000b2220, -- Live (14-04-19)
		[0x00002540] = 0x000b2540, -- Live (14-07-08)
		[0x00002430] = 0x000b2430, -- Live (14-07-13)
		[0x00002f40] = 0x000b2f40, -- Dev  (15-01-31)
		[0x00002f00] = 0x000b2f00, -- Live (15-03-05)
		[0x00002d00] = 0x000b2d00, -- Live (15-03-12)
		[0x00003410] = 0x000b3410, -- Live (15-03-25)
		[0x00003580] = 0x000b3580, -- Live (15-06-01)
		[0x00003ba0] = 0x000b3ba0, -- Live (15-06-28)
		[0x00003b10] = 0x000b3b10, -- Live (15-08-12)
		[0x00003da0] = 0x000b3da0, -- Live (15-09-11)
		[0x00003da0] = 0x000b3da0, -- Live (15-09-13)
		[0x0000ade0] = 0x0003ade0, -- Live (15-12-16)
		[0x0000c590] = 0x0003c590, -- Live (16-01-18)
		[0x0000c860] = 0x0003c860, -- Live (16-02-02)
		[0x0000c860] = 0x0003c860, -- Live (16-02-03)
		[0x0000d140] = 0x0003d140, -- Live (16-02-22)
		[0x0000d140] = 0x0003d140, -- Live (16-02-23)
		[0x0000d3c0] = 0x0003d3c0, -- Live (16-03-30)
		[0x0000dfe0] = 0x0003dfe0, -- Live (16-04-28)
		[0x0000dfe0] = 0x0003dfe0, -- Live (16-04-28)
		[0x0000ecf0] = 0x0003ecf0, -- Live (16-07-06)
		[0x0000e7d0] = 0x0003e7d0, -- Live (16-10-09)
		[0x0000e870] = 0x0003e870, -- Live (16-10-29)
		[0x0000e3b0] = 0x0003e3b0, -- Live (16-12-16)
		[0x0000e2d0] = 0x0003e2d0, -- Live (16-12-20)
		[0x0000e540] = 0x0003e540, -- Live (17-02-16)
		[0x0000e670] = 0x0003e670, -- Live (17-02-20)
		[0x0000ecf0] = 0x0003ecf0, -- Live (17-04-17)
		[0x0000ed70] = 0x0003ed70, -- Live (17-04-22)
		[0x0000ed70] = 0x0003ed70, -- Live (17-04-29)
		[0x0000ed70] = 0x0003ed70, -- Live (17-06-26)
	},
	Linux = {},
	OSX   = {},
	Other = {}
}

CAC.Modules.ClientDllGuessOffsets =
{
	Windows = 0x00000003,
	Linux   = 0x00000000,
	OSX     = 0x00000000,
	Other   = 0x00000000
}

function CAC.Modules.GetClientDllBaseAddress (systemBatteryPowerAddr, operatingSystem, gameVersion)
	local moduleAlignment = CAC.GetModuleAlignment (operatingSystem)
	if not moduleAlignment then return nil, false end
	
	local remainder = systemBatteryPowerAddr % moduleAlignment
	local offset = CAC.Modules.ClientDllOffsets [operatingSystem] and CAC.Modules.ClientDllOffsets [operatingSystem] [remainder]
	if offset then
		return systemBatteryPowerAddr - offset, true
	else
		-- Make a guess
		return CAC.AlignAddress (systemBatteryPowerAddr, CAC.GetModuleAlignment (operatingSystem)) - CAC.Modules.ClientDllGuessOffsets [operatingSystem] * CAC.GetModuleAlignment (operatingSystem), false
	end
end

CAC.Modules.ServerDllOffsets =
{
	Windows =
	{
		[0x00002440] = 0x000b2440, -- Live (14-07-13)
		[0x00001400] = 0x000b1400, -- Dev  (15-01-31)
		[0x000012b0] = 0x000b12b0, -- Live (15-03-05)
		[0x00001270] = 0x000b1270, -- Live (15-03-12)
		[0x00002720] = 0x000b2720, -- Live (15-03-25)
		[0x000040d0] = 0x000b40d0, -- Live (15-06-01)
		[0x00005510] = 0x000b5510, -- Live (15-06-28)
		[0x00005770] = 0x000b5770, -- Live (15-08-12)
		[0x00005880] = 0x000b5880, -- Live (15-09-11)
		[0x00005880] = 0x000b5880, -- Live (15-09-13)
		[0x00002ed0] = 0x00042ed0, -- Live (15-12-16)
		[0x0000be30] = 0x0004be30, -- Live (16-01-18)
		[0x0000d3a0] = 0x0004d3a0, -- Live (16-02-02)
		[0x0000e5f0] = 0x0004e5f0, -- Live (16-02-03)
		[0x0000d340] = 0x0004d340, -- Live (16-02-22)
		[0x0000d380] = 0x0004d380, -- Live (16-02-23)
		[0x0000d720] = 0x0004d720, -- Live (16-03-30)
		[0x0000e730] = 0x0004e730, -- Live (16-04-28)
		[0x0000e9a0] = 0x0004e9a0, -- Live (16-07-06)
		[0x0000d960] = 0x0004d960, -- Live (16-10-09)
		[0x0000d350] = 0x0004d350, -- Live (16-10-29)
		[0x0000e0c0] = 0x0004e0c0, -- Live (16-12-16)
		[0x0000e0c0] = 0x0004e0c0, -- Live (16-12-20)
		[0x0000d830] = 0x0004d830, -- Live (17-02-16)
		[0x0000d830] = 0x0004d830, -- Live (17-02-20)
		[0x0000f3c0] = 0x0004f3c0, -- Live (17-04-17)
		[0x0000dfe0] = 0x0004dfe0, -- Live (17-04-22)
		[0x0000dfe0] = 0x0004dfe0, -- Live (17-04-29)
		[0x0000dfe0] = 0x0004dfe0, -- Live (17-06-26)
	},
	Linux =
	{
		[0x00000290] = 0x005cc290, -- Live (15-06-28)
		[0x00000720] = 0x005cf720, -- Live (15-08-12)
		[0x00000880] = 0x005d0880, -- Live (15-09-11)
		[0x00000880] = 0x005d0880, -- Live (15-09-13)
		[0x00000a00] = 0x005d5a00, -- Live (15-12-16)
		[0x000000e0] = 0x005d70e0, -- Live (16-01-18)
		[0x00000e60] = 0x005d9e60, -- Live (16-02-02)
		[0x00000e60] = 0x005d9e60, -- Live (16-02-03)
		[0x000003e0] = 0x005dc3e0, -- Live (16-02-22)
		[0x000003e0] = 0x005dc3e0, -- Live (16-02-23)
		[0x00000520] = 0x005dc520, -- Live (16-03-30)
		[0x00000320] = 0x005de320, -- Live (16-04-28)
		[0x00000300] = 0x005de300, -- Live (16-07-06)
		[0x00000ad0] = 0x005e4ad0, -- Live (16-10-09)
		[0x00000bf0] = 0x005e4bf0, -- Live (16-10-29)
		[0x00000180] = 0x005e5180, -- Live (16-12-16)
		[0x00000180] = 0x005e5180, -- Live (16-12-20)
		[0x000001a0] = 0x005e51a0, -- Live (17-02-16)
		[0x000001a0] = 0x005e51a0, -- Live (17-02-20)
		[0x00000a90] = 0x005e6a90, -- Live (17-04-17)
		[0x00000990] = 0x005e6990, -- Live (17-04-22)
		[0x00000990] = 0x005e6990, -- Live (17-04-29)
		[0x00000990] = 0x005e6990, -- Live (17-06-26)
	},
	OSX   = {},
	Other = {}
}

CAC.Modules.ServerDllGuessOffsets =
{
	Windows = 0x00000004,
	Linux   = 0x000005e6,
	OSX     = 0x00000000,
	Other   = 0x00000000
}

function CAC.Modules.GetServerDllBaseAddress (systemBatteryPowerAddr, operatingSystem, gameVersion)
	local moduleAlignment = CAC.GetModuleAlignment (operatingSystem)
	if not moduleAlignment then return nil, false end
	
	local remainder = systemBatteryPowerAddr % moduleAlignment
	local offset = CAC.Modules.ServerDllOffsets [operatingSystem] and CAC.Modules.ServerDllOffsets [operatingSystem] [remainder]
	if offset then
		return systemBatteryPowerAddr - offset, true
	else
		-- Make a guess
		return CAC.AlignAddress (systemBatteryPowerAddr, CAC.GetModuleAlignment (operatingSystem)) - CAC.Modules.ServerDllGuessOffsets [operatingSystem] * CAC.GetModuleAlignment (operatingSystem), false
	end
end

CAC.Modules.LuaSharedDllOffsets =
{
	Windows =
	{
		[0x000082d0] = 0x000182d0, -- Live
		[0x000086d0] = 0x000186d0, -- Dev  (14-03-04)
		[0x000086f0] = 0x000186f0, -- Dev  (14-03-28)
		[0x000086f0] = 0x000186f0, -- Live (14-04-03)
		[0x000086f0] = 0x000186f0, -- Live (14-04-04)
		[0x00008a20] = 0x00018a20, -- Live (14-04-19)
		[0x00008a50] = 0x00018a50, -- Live (14-07-08)
		[0x00008860] = 0x00018860, -- Live (14-07-13)
		[0x00006f50] = 0x00016f50, -- Dev  (15-01-31)
		[0x00006f50] = 0x00016f50, -- Live (15-03-05)
		[0x00006f50] = 0x00016f50, -- Live (15-03-12)
		[0x00006f50] = 0x00016f50, -- Live (15-03-25)
		[0x00007400] = 0x00017400, -- Live (15-06-01)
		[0x00007400] = 0x00017400, -- Live (15-06-28)
		[0x00007400] = 0x00017400, -- Live (15-08-12)
		[0x00007400] = 0x00017400, -- Live (15-09-11)
		[0x00007330] = 0x00017330, -- Live (15-09-13)
		[0x000072f0] = 0x000172f0, -- Live (15-12-16)
		[0x00007460] = 0x00017460, -- Live (16-01-18)
		[0x00007510] = 0x00017510, -- Live (16-02-02)
		[0x00007510] = 0x00017510, -- Live (16-02-03)
		[0x00009eb0] = 0x00019eb0, -- Live (16-02-22)
		[0x00009eb0] = 0x00019eb0, -- Live (16-02-23)
		[0x00009ed0] = 0x00019ed0, -- Live (16-03-30)
		[0x00009da0] = 0x00019da0, -- Live (16-04-28)
		[0x00009da0] = 0x00019da0, -- Live (16-07-06)
		[0x000099e0] = 0x000199e0, -- Live (16-10-09)
		[0x000099e0] = 0x000199e0, -- Live (16-10-29)
		[0x000099e0] = 0x000199e0, -- Live (16-12-16)
		[0x000099e0] = 0x000199e0, -- Live (16-12-20)
		[0x000099e0] = 0x000199e0, -- Live (17-02-16)
		[0x000099e0] = 0x000199e0, -- Live (17-02-20)
		[0x0000d4d0] = 0x0001d4d0, -- Live (17-04-17)
		[0x0000d4d0] = 0x0001d4d0, -- Live (17-04-22)
		[0x0000d4d0] = 0x0001d4d0, -- Live (17-04-29)
		[0x0000d560] = 0x0001d560, -- Live (17-06-26)
	},
	Linux =
	{
		[0x00000490] = 0x0002d490, -- Live (15-06-28)
		[0x00000490] = 0x0002d490, -- Live (15-08-12)
		[0x00000490] = 0x0002d490, -- Live (15-09-11)
		[0x00000490] = 0x0002d490, -- Live (15-09-13)
		[0x00000690] = 0x0003b690, -- Live (15-12-16)
		[0x000009d0] = 0x0003b9d0, -- Live (16-01-18)
		[0x00000b50] = 0x0003bb50, -- Live (16-02-02)
		[0x00000b50] = 0x0003bb50, -- Live (16-02-03)
		[0x00000fe0] = 0x00041fe0, -- Live (16-02-22)
		[0x00000fe0] = 0x00041fe0, -- Live (16-02-23)
		[0x00000040] = 0x00042040, -- Live (16-03-30)
		[0x00000d50] = 0x00041d50, -- Live (16-04-28)
		[0x00000d50] = 0x00041d50, -- Live (16-07-06)
		[0x00000c50] = 0x00041c50, -- Live (16-10-09)
		[0x00000c50] = 0x00041c50, -- Live (16-10-29)
		[0x00000c50] = 0x00041c50, -- Live (16-12-16)
		[0x00000c50] = 0x00041c50, -- Live (16-12-20)
		[0x00000c50] = 0x00041c50, -- Live (17-02-16)
		[0x00000c50] = 0x00041c50, -- Live (17-02-20)
		[0x00000070] = 0x00038070, -- Live (17-04-17)
		[0x00000070] = 0x00038070, -- Live (17-04-22)
		[0x00000070] = 0x00038070, -- Live (17-04-29)
		[0x000001c0] = 0x000381c0, -- Live (17-06-26)
	},
	OSX   = {},
	Other = {}
}

CAC.Modules.LuaSharedDllGuessOffsets =
{
	Windows = 0x00000001,
	Linux   = 0x00000041,
	OSX     = 0x00000000,
	Other   = 0x00000000
}

function CAC.Modules.GetLuaSharedDllBaseAddress (strcmpAddr, operatingSystem, gameVersion)
	local moduleAlignment = CAC.GetModuleAlignment (operatingSystem)
	if not moduleAlignment then return nil, false end
	
	local remainder = strcmpAddr % moduleAlignment
	local offset = CAC.Modules.LuaSharedDllOffsets [operatingSystem] and CAC.Modules.LuaSharedDllOffsets [operatingSystem] [remainder]
	if offset then
		return strcmpAddr - offset, true
	else
		-- Make a guess
		return CAC.AlignAddress (strcmpAddr, CAC.GetModuleAlignment (operatingSystem)) - CAC.Modules.LuaSharedDllGuessOffsets [operatingSystem] * CAC.GetModuleAlignment (operatingSystem), false
	end
end

CAC.Modules.LocalClientDllBaseAddress           = nil
CAC.Modules.LocalClientDllBaseAddressCertain    = nil
CAC.Modules.LocalServerDllBaseAddress           = nil
CAC.Modules.LocalServerDllBaseAddressCertain    = nil
CAC.Modules.LocalLuaSharedDllBaseAddress        = nil
CAC.Modules.LocalLuaSharedDllBaseAddressCertain = nil

function CAC.Modules.GetLocalClientDllBaseAddress ()
	if not CAC.Modules.LocalClientDllBaseAddress then
		local systemBatteryPowerInfo    = jit.util.funcinfo (system.BatteryPower)
		local systemBatteryPowerAddress = systemBatteryPowerInfo and systemBatteryPowerInfo.addr
		if not systemBatteryPowerAddress then return nil end
		if systemBatteryPowerAddress < 0 then systemBatteryPowerAddress = systemBatteryPowerAddress + 4294967296 end
		
		CAC.Modules.LocalClientDllBaseAddress, CAC.Modules.LocalClientDllBaseAddressCertain = CAC.Modules.GetClientDllBaseAddress (systemBatteryPowerAddress, jit.os, VERSION)
		if not CAC.Modules.LocalClientDllBaseAddressCertain then
			CAC.Error ("CAC.GetLocalClientDllBaseAddress : Unrecognised client.dll (&system.BatteryPower = " .. string.format ("0x%08x", systemBatteryPowerAddress) .. ")")
		end
	end
	
	return CAC.Modules.LocalClientDllBaseAddress
end

function CAC.Modules.GetLocalServerDllBaseAddress ()
	if not CAC.Modules.LocalServerDllBaseAddress then
		local systemBatteryPowerInfo    = jit.util.funcinfo (system.BatteryPower)
		local systemBatteryPowerAddress = systemBatteryPowerInfo and systemBatteryPowerInfo.addr
		if not systemBatteryPowerAddress then return nil end
		if systemBatteryPowerAddress < 0 then systemBatteryPowerAddress = systemBatteryPowerAddress + 4294967296 end
		
		CAC.Modules.LocalServerDllBaseAddress, CAC.Modules.LocalServerDllBaseAddressCertain = CAC.Modules.GetServerDllBaseAddress (systemBatteryPowerAddress, jit.os, VERSION)
		if not CAC.Modules.LocalServerDllBaseAddressCertain then
			CAC.Error ("CAC.GetLocalServerDllBaseAddress : Unrecognised server.dll (&system.BatteryPower = " .. string.format ("0x%08x", systemBatteryPowerAddress) .. ")")
		end
	end
	
	return CAC.Modules.LocalServerDllBaseAddress
end

function CAC.Modules.GetLocalLuaSharedDllBaseAddress ()
	if not CAC.Modules.LocalLuaSharedDllBaseAddress then
		local strcmpAddress = jit.util.ircalladdr (0)
		if strcmpAddress < 0 then strcmpAddress = strcmpAddress + 4294967296 end
		
		CAC.Modules.LocalLuaSharedDllBaseAddress, CAC.Modules.LocalLuaSharedDllBaseAddressCertain = CAC.Modules.GetLuaSharedDllBaseAddress (strcmpAddress, jit.os, VERSION)
		if not CAC.Modules.LocalLuaSharedDllBaseAddressCertain then
			CAC.Error ("CAC.GetLocalLuaSharedDllBaseAddress : Unrecognised lua_shared.dll (&strcmp = " .. string.format ("0x%08x", strcmpAddress) .. ")")
		end
	end
	
	return CAC.Modules.LocalLuaSharedDllBaseAddress
end