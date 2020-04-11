-- TTT Round Controls

function ttt.AddTime(num)
	return SetRoundEnd(CurTime() + num)
end

-- stop all timers
function ttt.StopTimers()
	timer.Stop "wait2prep"
	timer.Stop "prep2begin"
	timer.Stop "end2begin"
	timer.Stop "winchecker"
end

-- just like ttt_roundrestart
function ttt.ForceRestart()
	ttt.StopTimers()
	PrepareRound()
end

function ttt.ExtendPrep(length)
	length = length or 30
	ttt.SetPrepareTime(length)
end