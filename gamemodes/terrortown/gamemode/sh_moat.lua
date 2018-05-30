TTT_GLOBALS_SAVE = TTT_GLOBALS_SAVE or {}
TTT_GLOBALS = {
	["ttt_highlight_admins"] = "Bool",
	["ttt_round_end"] = "Float",
	["ttt_haste_end"] = "Float",
	["ttt_rounds_left"] = "Int",
	["ttt_detective"] = "Bool",
	["ttt_haste"] = "Bool",
	["ttt_time_limit_minutes"] = "Int",
	["ttt_locational_voice"] = "Bool",
	["ttt_idle_limit"] = "Int",
	["ttt_voice_drain"] = "Bool",
	["ttt_voice_drain_normal"] = "Float",
	["ttt_voice_drain_admin"] = "Float",
	["ttt_voice_drain_recharge"] = "Float",
	["ttt_karma"] = "Bool"
}

if (not _GetGlobalFloat) then _GetGlobalFloat = GetGlobalFloat end
function GetGlobalFloat(str, def)
	if (TTT_GLOBALS[str]) then return TTT_GLOBALS_SAVE[str] or def end
	return _GetGlobalFloat(str, def)
end

if (not _GetGlobalInt) then _GetGlobalInt = GetGlobalInt end
function GetGlobalInt(str, def)
	if (TTT_GLOBALS[str]) then return TTT_GLOBALS_SAVE[str] or def end
	return _GetGlobalInt(str, def)
end

if (not _GetGlobalBool) then _GetGlobalBool = GetGlobalBool end
function GetGlobalBool(str, def)
	if (TTT_GLOBALS[str]) then return TTT_GLOBALS_SAVE[str] or def end
	return _GetGlobalBool(str, def)
end