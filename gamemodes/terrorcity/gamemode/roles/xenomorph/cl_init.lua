local XENOMORPH = ROLE
XENOMORPH.IsRespawning = false
XENOMORPH.TimeUpdate = CurTime()
XENOMORPH.TimeLeft = 30

function XENOMORPH.HUDPaint()
	if (not XENOMORPH.IsRespawning) then return end

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, ScrW(), ScrH())

	draw.SimpleText("Oh noes! Someone killed the Xenomorph! That's you!", "moat_GunGameMedium", ScrW()/2, ScrH()/2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	draw.SimpleText("Respawning: " .. math.floor(XENOMORPH.TimeEnd - CurTime()), "moat_GunGameMedium", ScrW()/2, (ScrH()/2) + 40, Color(255, 255, 255), TEXT_ALIGN_CENTER)
end
hook.Add("HUDPaint", "terror.city.xenomorph", XENOMORPH.HUDPaint)

function XENOMORPH.ResetXenomorph()
	XENOMORPH.IsRespawning = false
end
hook.Add("TTTPrepareRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)


function XENOMORPH.TimeStart()
	XENOMORPH.TimeEnd = CurTime() + 30
	XENOMORPH.IsRespawning = true
	timer.Simple(30, function()
		XENOMORPH.IsRespawning = false
	end)
end
net.Receive("xenomorph.timer", XENOMORPH.TimeStart)
