--todo
local ceil = math.ceil
local max = math.max

function ttt.GetRoundEnd()
	return ceil(GetGlobal("ttt_round_end"))
end

function ttt.TimeLeft()
	return max(0, ttt.GetRoundEnd() - CurTime())
end