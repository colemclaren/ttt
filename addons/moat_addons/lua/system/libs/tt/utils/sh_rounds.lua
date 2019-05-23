--todo
local ceil = math.ceil
local max = math.max

function tt.GetRoundEnd()
	return ceil(GetGlobal("ttt_round_end"))
end

function tt.TimeLeft()
	return max(0, tt.GetRoundEnd() - CurTime())
end