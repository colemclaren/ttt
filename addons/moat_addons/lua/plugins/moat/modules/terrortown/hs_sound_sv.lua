util.AddNetworkString "Moat.Headshot.Sound"

hook("ScalePlayerDamage", function(ply, hitgroup, dmginfo)
	local att = dmginfo:GetAttacker()

	if (hitgroup == HITGROUP_HEAD) then
		att.lasthead = ply
	elseif (att.lasthead == ply) then
		att.lasthead = att
	end
end)

hook("PlayerDeath", function(ply, inf, att)
	if (IsValid(att) and att:IsPlayer()) then
		inf = att:GetActiveWeapon()
	end

	if (IsValid(att) and att:IsPlayer() and ply ~= att and IsValid(inf) and inf:IsWeapon() and (att.lasthead and att.lasthead == ply)) then
		net.Start "Moat.Headshot.Sound"
		net.Send(att)
	end
end)