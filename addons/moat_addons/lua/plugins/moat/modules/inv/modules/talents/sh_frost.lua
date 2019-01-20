local plyMeta = FindMetaTable('Player')

function plyMeta:canBeMoatFrozen()
	return (IsValid(self) && self:Team() != TEAM_SPEC && not MOAT_MINIGAME_OCCURING && GetRoundState() == ROUND_ACTIVE)
end
