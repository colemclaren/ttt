--todo
local ceil = math.ceil
local max = math.max

function tt.GetRoundEnd()
	return ceil(GetGlobalFloat("ttt_round_end", 0))
end

function tt.TimeLeft()
	return max(0, tt.GetRoundEnd() - CurTime())
end