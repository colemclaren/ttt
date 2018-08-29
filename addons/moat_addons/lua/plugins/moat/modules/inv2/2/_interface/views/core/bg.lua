function ii.main.init()
	ux.RefreshScreen()

	local bgw, bgh = ii.c.main.w, ii.c.main.h
	ii.bg = ux.Create("DFrame", function(s)
		s:Setup((bgw/2) + uxW2, -bgh, bgw, bgh)
		s:MoveTo(uxW2 - (bgw/2), uxH2 - (bgh/2), .2)
	end, {Think = function(s)
	
	end}):MakePopup()
end