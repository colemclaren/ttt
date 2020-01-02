util.AddNetworkString "ClientDeathNotify"
local dna_cache = {}
hook("TTTPrepareRound", function()
	dna_cache = {}
end)

hook("TTTFoundDNA", function(ply, dna_owner, ent)
	if (not dna_cache[ply]) then
		dna_cache[ply] = {FoundDNA = {}}
	end

	if (IsValid(ply) and GetRoundState() == ROUND_ACTIVE and IsValid(dna_owner) and not dna_cache[ply].FoundDNA[ent]) then
		dna_cache[ply].FoundDNA[ent] = dna_owner
	end
end)

hook("PlayerDeath", function(victim, entity, killer)
    local reason = "prop"
    local killerz = "idk"
    local role = "idk"
	local gotdna = false

	if (not IsValid(victim) or not IsValid(entity) or not IsValid(killer)) then
		return
	end

   	if (entity:GetClass() == "entityflame" and killer:GetClass() == "entityflame") then
        reason = "burned"
        killerz = "idk"
        role = "idk"
    elseif (victim.DiedByWater) then
        reason = "water"
        killerz = "idk"
        role = "idk"
    elseif (entity:GetClass() == "worldspawn" and killer:GetClass() == "worldspawn") then
        reason = "fell"
        killerz = "idk"
        role = "idk"
    elseif (victim:IsPlayer() and entity:GetClass() == 'prop_physics' or entity:GetClass() == "prop_dynamic" or entity:GetClass() == 'prop_physics') then
        -- If the killer is also a prop
        reason = "prop"
        killerz = "idk"
        role = "idk"
    elseif (killer == victim) then
        reason = "suicide"
        killerz = "idk"
        role = "idk"
    elseif (killer:IsPlayer() and victim ~= killer) then
        reason = "ply"
        killerz = killer:Nick()
        role = killer:GetRole()

		if (dna_cache[killer] and dna_cache[killer].FoundDNA) then
			for k, v in pairs(dna_cache[killer].FoundDNA) do
				if (v == victim) then
					gotdna = true
				end
			end
		end
    else
        reason = "idk"
        killerz = "idk"
        role = "idk"
    end

    net.Start("ClientDeathNotify")
    net.WriteString(killerz)
    net.WriteString(role)
    net.WriteString(reason)
	net.WriteBool(gotdna)
    net.Send(victim)
end)