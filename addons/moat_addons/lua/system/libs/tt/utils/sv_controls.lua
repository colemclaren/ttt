-- TTT Round Controls

function tt.AddTime(num)
	return SetRoundEnd(CurTime() + num)
end

-- stop all timers
function tt.StopTimers()
	timer.Stop "wait2prep"
	timer.Stop "prep2begin"
	timer.Stop "end2begin"
	timer.Stop "winchecker"
end

-- just like ttt_roundrestart
function tt.ForceRestart()
	tt.StopTimers()
	PrepareRound()
end

function tt.ExtendPrep(length)
	length = length or 30
	tt.SetPrepareTime(length)
end