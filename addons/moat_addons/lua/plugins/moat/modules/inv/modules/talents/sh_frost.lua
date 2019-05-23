local plyMeta = FindMetaTable('Player')

function plyMeta:canBeMoatFrozen()
	return (IsValid(self) && self:Team() != TEAM_SPEC && not GetGlobal("MOAT_MINIGAME_ACTIVE") && GetRoundState() == ROUND_ACTIVE)
end
