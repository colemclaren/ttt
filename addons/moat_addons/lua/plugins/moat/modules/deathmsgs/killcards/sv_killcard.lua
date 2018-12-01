util.AddNetworkString("moat_killcard_died")
util.AddNetworkString("moat_killcard_kill")

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
	net.WriteUInt(GetRoundState() or 1, 4)

	if (att:IsPlayer()) then
		local role = att:GetRole()
		if (not role) then return end -- Player Left or Something?

		net.WriteUInt(role, 8)
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
	//if (pl.was_pushed and dmg:IsDamageType(DMG_FALL)) then dmg_str = "Pushed You" end
	net.WriteString(dmg_str)

	if (inf and IsValid(inf) and inf:IsWeapon()) then
		net.WriteEntity(inf)
		if (inf.ItemStats and inf.ItemStats.s) then
			net.WriteBool(true)
		else
			net.WriteBool(false)
		end
	else
		if (wep_dmgs[dt] and IsValid(att) and att:IsPlayer()) then
			local wep = att:GetActiveWeapon()
			if (IsValid(wep)) then
				net.WriteEntity(wep)
				if (wep.ItemStats and wep.ItemStats.s) then
					net.WriteBool(true)
				else
					net.WriteBool(false)
				end
			end
		else
			net.WriteEntity(Entity(0))
			net.WriteBool(false)
		end
	end

	net.Send(pl)
end

hook.Add("DoPlayerDeath", "moat.killcard.networking", function(pl, att, dmg)
	if (pl:GetInfo("moat_enable_deathcard") ~= "1") then return end
	moat_send_killcard(pl, att, dmg)
end)