local st_old, vec, ang
vec = Vector()
ang = Angle()

hook.Add("PreDrawViewModel", function(vm, ply, wep)
	if (not IsValid(wep)) then
		return
	end

	local st = SysTime()
	st_old = st_old or st

	local delta = st - st_old
	st_old = st

	delta = delta * game.GetTimeScale()

	wep:Sway(vec, ang, delta)
	wep:CalculateViewModelOffset(delta)
end)