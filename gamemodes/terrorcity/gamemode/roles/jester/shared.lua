InstallRoleHook("ScalePlayerDamage", function(ply, hitgroup, dmginfo)
    return dmginfo:GetAttacker()
end)

function ROLE:ScalePlayerDamage(ply, hg, dmginfo)
    dmginfo:ScaleDamage(0)
end

if (CLIENT) then
	net.Receive("jester.killed", function()
		local nick1 = net.ReadString()

		chat.AddText(Material("icon16/information.png"), Color(253, 158, 255), nick1 .. " killed the jester!")
	end)
else
	util.AddNetworkString "jester.killed"

	hook.Add("PlayerDeath", "jester.killer", function(pl, inf, att)
		if (GetRoundState() == ROUND_ACTIVE and pl:GetRole() == ROLE_JESTER and IsValid(att) and att:IsPlayer() and pl ~= att) then
			net.Start("jester.killed")
			net.WriteString(att:Nick() or "Someone")
			net.Broadcast()
		end
	end)
end