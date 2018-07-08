local prop_classes = {}
prop_classes["prop_physics"] = true
prop_classes["prop_dynamic"] = true

hook.Add("PlayerShouldTakeDamage", "moat_PreventPropDamage", function(ply, ent)
	if (GetRoundState() == ROUND_PREP) then
		if (IsValid(ply) and IsValid(ent) and ((prop_classes[ent:GetClass()]) or (IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer()))) then
			return false
		end
	end
end)