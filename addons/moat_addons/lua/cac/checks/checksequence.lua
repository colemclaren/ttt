-- 0000 Initialization
CAC.Checks:AddNextCheck ("",                            "FluidExchange"              )
CAC.Checks:AddNextCheck ("FluidExchange",               "SystemInformation"          )

-- 0001 SystemInformation
CAC.Checks:AddNextCheck ("SystemInformation",           "AdditionalSystemInformation")
CAC.Checks:AddNextCheck ("SystemInformation",           "RconPasswordTheft"          )

-- 0002 AdditionalSystemInformation
-- 0003 GarbageCount
-- 0004 QACBypassCheck
-- 0005 SysTime
CAC.Checks:AddNextCheck ("AdditionalSystemInformation", "GarbageCount"               )
-- This is not worth the false bans it causes when another addon errors in the OnGamemodeLoaded hook
-- and prevents our hook from being called.
-- CAC.Checks:AddNextCheck ("AdditionalSystemInformation", "QACBypassCheck"             )
CAC.Checks:AddNextCheck ("AdditionalSystemInformation", "SysTime"                    )

-- 0006 SysTime
-- 0007 DebugLibraryCheck
-- 0008 AdditionalLibraryChecks
CAC.Checks:AddNextCheck ("SysTime",                     "DebugLibraryCheck"          )
CAC.Checks:AddNextCheck ("DebugLibraryCheck",           "AdditionalLibraryChecks"    )
-- CAC.Checks:AddNextCheck ("AdditionalLibraryChecks",     "Resources"                  )
CAC.Checks:AddNextCheck ("AdditionalLibraryChecks",     "Hooks"                      )

-- 0100 Hooks
-- 0101 ConsoleCommands
-- 0102 Timers
-- 0103 Detours
-- 0104 ConVarBlacklist
-- CAC.Checks:AddNextCheck ("Resources",                   "Hooks"                      )
CAC.Checks:AddNextCheck ("Hooks",                       "ConsoleCommands"            )
CAC.Checks:AddNextCheck ("ConsoleCommands",             "Timers"                     )
CAC.Checks:AddNextCheck ("Timers",                      "Detours"                    )
CAC.Checks:AddNextCheck ("Detours",                     "ConVarBlacklist"            )
CAC.Checks:AddNextCheck ("ConVarBlacklist",             "ConVarMonitor"              )

-- 0105 ConVarMonitor
-- CAC.Checks:AddNextCheck ("ConVarMonitor",               "ILuaInterface"              )
CAC.Checks:AddNextCheck ("ConVarMonitor",               "Aimbot"                     )

-- 0200 ILuaInterface
-- 0201 ConVars
-- 0202 WindowsVersion
-- 0203 Modules
CAC.Checks:AddNextCheck ("ILuaInterface",               "ConVars"                    )
CAC.Checks:AddNextCheck ("ConVars",                     "WindowsVersion"             )
CAC.Checks:AddNextCheck ("WindowsVersion",              "Modules"                    )

-- 0300 Aimbot
-- 0301 ScreenshotBlocker
CAC.Checks:AddNextCheck ("Aimbot",                      "ScreenshotBlocker"          )
CAC.Checks:AddNextCheck ("ScreenshotBlocker",           "FluidExchange2"             )