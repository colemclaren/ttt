ii.main.cooldown = 0

function ii.toggle()
	if (ii.main.cooldown > CurTime()) then
		return
	end

	if (ii.using) then ii.close() return end
	if (not ux.active()) then ii.init() return end
end

function ii.init()
	ii.main.init()
	ii.main.cooldown = CurTime() + 1
end

function ii.close()
	ii.bg:MoveTo(ScrW() / 2 - ii.bg:GetWide() / 2, ScrH() + ii.bg:GetTall(), 0.4, 0, 1)
    ii.bg:AlphaTo(0, 0.4, 0)

    timer.Simple(0.4, function()
    	ii.bg:Remove()
    end)

    ii.main.cooldown = CurTime() + 1
end


concommand.Add("inventory2", ii.toggle)
hook("PlayerButtonDown", function(p, k)
	if (k == KEY_I) then ii.toggle() end
end)