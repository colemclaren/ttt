function res(n)
	return n
end

ux.w, ux.h = ScrW(), ScrH()
hook.Add("Think", function()
	if (ux.w == ScrW() and ux.h == ScrH()) then
		return
	end

	ux.w, ux.h = ScrW(), ScrH()
end)