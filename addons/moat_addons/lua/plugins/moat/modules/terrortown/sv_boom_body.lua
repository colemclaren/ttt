local function PressedBoomBodyKey(ply, ent)
	if (ply:Team() ~= TEAM_SPEC and ent.ExplosiveCorpse and IsValid(ent.ExplosiveCorpse) and not ent.ExplodedAlready) then
		if (ply:IsTraitor()) then
			CustomMsg(ply, "This is an explosive body placed by a Traitor!", Color(255, 0, 0))
			return false
		end
		util.BlastDamage(ent.ExplosiveCorpse, ent, ent:GetPos(), 190, 150)
		ent.ExplodedAlready = true
		ent:Remove()
		return false
	end
end

hook.Add("TTTCanSearchCorpse", "BoomBodyKeyListener", PressedBoomBodyKey)