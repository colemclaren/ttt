local convar = CreateClientConVar("moat_ui_sounds", 1, true, false)
sfx = sfx or {}

function sfx.Dustbin()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/2533282972.mp3"
	end
end

function sfx.Cut()
	if (convar:GetInt() > 0) then
		cdn.PlayURL("https://static.moat.gg/ttt/cut.ogg")
	end
end

function sfx.Tick()
	if (convar:GetInt() > 0) then
		cdn.PlayURL("https://static.moat.gg/ttt/cut.ogg", .1)
	end
end

function sfx.Bells()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/message.ogg"
	end
end

function sfx.Subtract()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/click4.ogg"
	end
end

function sfx.Add()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/click5.ogg"
	end
end

function sfx.Max()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/click6.ogg"
	end
end

function sfx.Agree()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/accept.mp3"
	end
end

function sfx.Decline()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/decline.wav"
	end
end

function sfx.Hover()
	if (convar:GetInt() > 0) then
		LocalPlayer():EmitSound("moatsounds/pop1.wav")
	end
end

function sfx.Click1()
	if (convar:GetInt() > 0) then
		LocalPlayer():EmitSound("moatsounds/pop2.wav")
	end
end

function sfx.Click2()
	if (convar:GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/appear-online.ogg"
	end
end

function sfx.HoverSound(s, func)
	s._OnCursorEntered = s._OnCursorEntered or s.OnCursorEntered
	s.OnCursorEntered = function(s)
		if (convar:GetInt() > 0) then
			if (func) then
				func()
			else
				LocalPlayer():EmitSound "moatsounds/pop1.wav"
			end
		end

		if (s._OnCursorEntered) then
			s._OnCursorEntered(s)
		end
	end
end

function sfx.ClickSound(s, func)
	s._OnMousePressed = s._OnMousePressed or s.OnMousePressed
	s.OnMousePressed = function(s, key)
		if (convar:GetInt() > 0) then
			if (key == MOUSE_LEFT) then
				if (func) then
					func()
				else
					LocalPlayer():EmitSound "moatsounds/pop2.wav"
				end
			elseif (key == MOUSE_RIGHT) then
				if (func) then
					func()
				else
					cdn.PlayURL "https://static.moat.gg/ttt/appear-online.ogg"
				end
			end
		end

		if (s._OnMousePressed) then
			s._OnMousePressed(s, key)
		end
	end
end

function sfx.SoundEffects(s, func)
	sfx.HoverSound(s, func)
	sfx.ClickSound(s, func)

	return s
end