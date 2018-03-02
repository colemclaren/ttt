MOAT_HITREG = MOAT_HITREG or {}

-- You can use this configuration file to change the default values
-- Don't edit something if you're unsure what it does

-- The maximum ping allowed for the alternative hit registration to be active (Default: 300)
MOAT_HITREG.MaxPing = 300

-- The chat command to open the hit registration and hitmarker menu
MOAT_HITREG.ChatCommands = {

	"/hitreg",
	"!hitreg"
	-- Add commands like this:
	-- "/chatcommand",
	-- Note: Last command in this table doesn't need a comma at the end

}

-- Should the alternative hit registration be enabled by default? (No = false, Yes = true)
MOAT_HITREG.HitRegDefaultEnabled = true

-- Should the hitmarkers be enabled by default? (No = false, Yes = true)
MOAT_HITREG.HitmarkerDefaultEnabled = true

-- Should the hitmarker sound be enabled by default? (No = false, Yes = true)
MOAT_HITREG.HitMarkerSoundDefaultEnabled = true

-- Default Hitmarker Size: (1 = Small, 2 = Normal, 3 = Large)
MOAT_HITREG.HitMarkerSizeDefault = 2

-- Default Hitmarker Color: Color( RED, GREEN, BLUE, ALPHA )
MOAT_HITREG.HitMarkerColorDefault = Color( 255, 255, 255, 255 )

-- Number of seconds crouch jumping should be disabled for while in combat
-- Set to 0 if you wish to disable
MOAT_HITREG.CrouchJumpCooldown = 5

-- Should players be able to kill exchange? Only applies if hitreg is enabled (No = false, Yes = true)
MOAT_HITREG.AllowKillExchanging = false