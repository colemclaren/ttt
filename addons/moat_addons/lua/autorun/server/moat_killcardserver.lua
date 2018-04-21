util.AddNetworkString("moat_killcard_died")
util.AddNetworkString("moat_killcard_kill")

/*hook.Add("DoPlayerDeath", "moat_killcard_death", function(pl, att, dmg)
	if (pl:GetInfo("moat_enable_deathcard") ~= "1") then return end

	net.Start("moat_killcard_died")

	local dtype = 1
	if (dmg:IsExplosionDamage()) then
		dtype = 6
	elseif (dmg:IsFallDamage()) then
		dtype = 4		
	elseif (dmg:IsDamageType(DMG_DROWN)) then
		dtype = 2
	elseif (dmg:IsDamageType(DMG_BURN)) then
		dtype = 5
	elseif (dmg:IsDamageType(DMG_CRUSH)) then
		dtype = 3
	elseif (dmg:IsDamageType(DMG_VEHICLE)) then
		dtype = 7
	elseif (dmg:IsDamageType(DMG_SHOCK)) then
		dtype = 8
	end
	net.WriteUInt(dtype, 8)

	if (not att:IsValid() or (att:IsValid() and not att:IsPlayer()) or att == pl) then
		net.WriteEntity(pl)
	elseif (dtype == 1) then
		net.WriteEntity(att)

		if (GetRoundState() == ROUND_ACTIVE) then
			local str = "Innocent"

			if (att:GetRole() == ROLE_TRAITOR) then
				str = "Traitor"
			elseif (att:GetRole() == ROLE_DETECTIVE) then
				str = "Detective"
			elseif (ROLE_JESTER and att:GetRole() == ROLE_JESTER) then
				str = "Jester"
			elseif (ROLE_KILLER and att:GetRole() == ROLE_KILLER) then
				str = "Serial Killer"
			elseif (ROLE_DOCTOR and att:GetRole() == ROLE_DOCTOR) then
				str = "Doctor"
			elseif (ROLE_BEACON and att:GetRole() == ROLE_BEACON) then
				str = "Beacon"
			elseif (ROLE_SURVIVOR and att:GetRole() == ROLE_SURVIVOR) then
				str = "Survivor"
			elseif (ROLE_HITMAN and att:GetRole() == ROLE_HITMAN) then
				str = "Hitman"
			elseif (ROLE_BODYGUARD and att:GetRole() == ROLE_BODYGUARD) then
				str = "Bodyguard"
			elseif (ROLE_VETERAN and att:GetRole() == ROLE_VETERAN) then
				str = "Veteran"
			elseif (ROLE_XENOMORPH and att:GetRole() == ROLE_XENOMORPH) then
				str = "Phoenix"
			elseif (ROLE_WITCHDOCTOR and att:GetRole() == ROLE_WITCHDOCTOR) then
				str = "Witch Doctor"
			end

			net.WriteString(str)
		end
	end

	if (dtype == 1) then
		local inf = dmg:GetInflictor()
		if (inf and inf:IsValid() and inf:IsWeapon()) then
			net.WriteEntity(dmg:GetInflictor())
		else
			if (IsValid(att) and att:IsPlayer() and IsValid(att:GetActiveWeapon())) then
				net.WriteEntity(att:GetActiveWeapon())
			else
				net.WriteEntity(Entity(0))
			end
		end
	end

	net.Send(pl)
end)



--[[-------------------------------------------------------------------------
Killcard Networking
---------------------------------------------------------------------------]]
if (true) then return end*/
local wep_dmgs = {
	[DMG_BULLET] = true,
	[DMG_BUCKSHOT] = true
}

local dmg_types = {
	[DMG_CRUSH] = "Crushed to Death",
	[DMG_BULLET] = "Shot to Death",
	[DMG_SLASH] = "Slashed to Death",
	[DMG_BURN] = "Burned to a Crisp",
	[DMG_VEHICLE] = "Hit n' Run",
	[DMG_FALL] = "Fell to Your Death",
	[DMG_BLAST] = "Exploded You",
	[DMG_CLUB] = "Clubbed to Death",
	[DMG_SHOCK] = "Shocked to Death",
	[DMG_ENERGYBEAM] = "Laser Beamed",
	[DMG_DROWN] = "Drowned to Death",
	[DMG_PARALYZE] = "Poisoned to Death",
	[DMG_NERVEGAS] = "Poisoned to Death",
	[DMG_POISON] = "Poisoned to Death",
	[DMG_RADIATION] = "Poisoned to Death",
	[DMG_ACID] = "Acid Burns",
	[DMG_SLOWBURN] = "Burned Very Slowly",
	[DMG_PHYSGUN] = "Forced into Death",
	[DMG_PLASMA] = "Plasma'd to Death",
	[DMG_AIRBOAT] = "Shot to Death",
	[DMG_BUCKSHOT] = "Shot to Death"
}

local function moat_send_killcard(pl, att, dmg)
	local dt = dmg:GetDamageType()

	net.Start("moat_killcard_kill")
	if (not IsValid(att)) then att = pl end
	net.WriteEntity(att)

	if (att:IsPlayer()) then
		net.WriteUInt(att:GetRole(), 8)
		net.WriteUInt(att:Team() == TEAM_SPEC and 0 or att:Health(), 32)
		net.WriteUInt(att:Team() == TEAM_SPEC and 0 or att:GetMaxHealth(), 32)
	end

	local dmg_str = dmg_types[dt] or "Something Strange"
	local inf = dmg:GetInflictor()
	if (IsValid(inf)) then
		if (inf:GetClass() == "entityflame") then dmg_str = dmg_types[DMG_BURN] end
		if (inf:GetClass() == "prop_physics" or inf:GetClass() == "prop_dynamic") then dmg_str = dmg_types[DMG_CRUSH] end
	end
	if (att == pl) then dmg_str = "Couldn't Take it Anymore :(" end
	if (pl.ignite_info and dmg:IsDamageType(DMG_DIRECT)) then dmg_str = "Burned to a Crisp" end
	if (pl.was_pushed and dmg:IsDamageType(DMG_FALL)) then dmg_str = "Pushed You" end
	net.WriteString(dmg_str)

	if (inf and IsValid(inf) and inf:IsWeapon()) then
		local wep = dmg:GetInflictor()
		net.WriteEntity(wep)
		if (wep.ItemStats and wep.ItemStats.s) then
			net.WriteUInt(2, 1)
		end
	else
		if (wep_dmgs[dt] and IsValid(att) and att:IsPlayer()) then
			local wep = att:GetActiveWeapon()
			if (IsValid(wep)) then
				net.WriteEntity(wep)
				if (wep.ItemStats and wep.ItemStats.s) then
					net.WriteUInt(2, 1)
				end
			end
		else
			net.WriteEntity(Entity(0))
		end
	end
	net.Send(pl)
end

hook.Add("DoPlayerDeath", "moat.killcard.networking", function(pl, att, dmg)
	if (pl:GetInfo("moat_enable_deathcard") ~= "1") then return end
	moat_send_killcard(pl, att, dmg)
end)