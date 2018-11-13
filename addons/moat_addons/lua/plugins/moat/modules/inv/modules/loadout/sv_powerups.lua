print( "powerups loaded" )

MOAT_POWERUPTABLE = {}


function m_ApplyPowerUp( ply, powerup_tbl )
	MOAT_LOADOUT.ResetPowerupAbilities(ply)

	local powerup_mods = powerup_tbl.s or {}
	local powerup_servertbl = powerup_tbl.item
	if ( powerup_servertbl.OnPlayerSpawn ) then
		powerup_servertbl:OnPlayerSpawn( ply, powerup_mods )
	end

	MOAT_POWERUPTABLE[ply] = powerup_tbl
end

hook.Add("TTTPrepareRound", "moat_WipePowerups", function()
	MOAT_POWERUPTABLE = {}
end)

hook.Add("TTTBeginRound", "moat_BeginRoundPowerups", function()
	for k, v in ipairs(player.GetAll()) do
		if (MOAT_POWERUPTABLE[v]) then
			local powerup_tbl = MOAT_POWERUPTABLE[v]
			local powerup_mods = powerup_tbl.s or {}
			local powerup_servertbl = powerup_tbl.item
			if (powerup_servertbl.OnBeginRound) then
				powerup_servertbl:OnBeginRound(v, powerup_mods)
			end
		end
	end
end)

hook.Add("EntityTakeDamage", "moat_ApplyTakenDamagePowerups", function(ply, dmginfo)
	local powerup = MOAT_POWERUPTABLE[ply]

    if (ply:IsValid() and ply:IsPlayer() and powerup and powerup.item) then
		local powerup_mods = powerup.s or {}
		local powerup_servertbl = powerup.item
		if (powerup_servertbl.OnDamageTaken) then
			powerup_servertbl:OnDamageTaken(ply, dmginfo, powerup_mods)
		end
    end
end)

hook.Add("ScalePlayerDamage", "moat_ApplyScaleDamagePowerups", function(ply, hitgroup, dmginfo)
	local powerup = MOAT_POWERUPTABLE[ply]
    if (IsValid(ply) and ply:IsValid() and dmginfo:IsBulletDamage() and dmginfo:GetDamage() > 0 and powerup and powerup.item) then
		local powerup_mods = powerup.s or {}
		local powerup_servertbl = powerup.item
		if (powerup_servertbl.ScalePlayerDamage) then
			powerup_servertbl:ScalePlayerDamage(ply, hitgroup, dmginfo, powerup_mods)
		end
    end
end)

util.AddNetworkString("theres more detections somewhere faggot")

net.Receive("theres more detections somewhere faggot", function(l, pl)
	print("mga", "perma", pl:SteamID(), "Exploits are my skiddy")
end)