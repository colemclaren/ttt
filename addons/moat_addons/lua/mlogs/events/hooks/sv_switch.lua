mlogs.events.hook("PlayerSwitchWeapon", function(pl, old, new)
	if (IsValid(old) and old.CanBuy and ((old.CanBuy[1] == ROLE_TRAITOR) or (old.CanBuy[2] == ROLE_TRAITOR))) then
		mlogs.log.event(MLOGS_SWITCH_TO, {
				["player_id1"] = mlogs.PlayerID(pl),
				["weapon_id"] = mlogs.WeaponID(old)
		}, pl:EyePos())
	end

	if (IsValid(new) and new.CanBuy and ((new.CanBuy[1] == ROLE_TRAITOR) or (new.CanBuy[2] == ROLE_TRAITOR))) then
		mlogs.log.event(MLOGS_SWITCH_TO, {
				["player_id1"] = mlogs.PlayerID(pl),
				["weapon_id"] = mlogs.WeaponID(new)
		}, pl:EyePos())
	end
end)