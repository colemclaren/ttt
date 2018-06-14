/*mlogs.events.hook("PlayerSwitchWeapon", function(pl, old, new)
	if (IsValid(old) and old.CanBuy and ((old.CanBuy[1] == ROLE_TRAITOR) or (old.CanBuy[2] == ROLE_TRAITOR))) then
		mlogs.events.log(MLOGS_SWITCH_FROM, {mlogs.PlayerID(pl), mlogs.WeaponID(old)}, pl:EyePos())
	end

	if (IsValid(new) and new.CanBuy and ((new.CanBuy[1] == ROLE_TRAITOR) or (new.CanBuy[2] == ROLE_TRAITOR))) then
		mlogs.events.log(MLOGS_SWITCH_TO, {mlogs.PlayerID(pl), mlogs.WeaponID(old)}, pl:EyePos())
	end
end)*/