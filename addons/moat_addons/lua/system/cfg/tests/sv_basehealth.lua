-- for base health change testing
MOAT_BASE_HEALTH = {
	enabled = false,
	basehp = 200,
	unix_end = 1529046000 -- June 15th, 2018 12:00 AM PST
}

-- message shown everytime the player spawns
MOAT_BASE_HEALTH.msg = function(pl)
	D3A.Chat.SendToPlayer2(pl,
	Color(255, 0, 255), "[Head's up!]",
	Color(255, 255, 255), " Base health is ",
	Color(0, 255, 0), MOAT_BASE_HEALTH.basehp,
	Color(255, 255, 255), " for ",
	Color(0, 255, 255), "today only",
	Color(255, 255, 255), "!",
	Color(255, 255, 0), " (testing ends in " .. D3A.FormatTime(MOAT_BASE_HEALTH.unix_end) .. ")")
end