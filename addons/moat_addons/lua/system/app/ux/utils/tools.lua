uxW = ScrW()
uxH = ScrH()

ux.RefreshScreen = function()
	uxW = ScrW()
	uxH = ScrH()
end

ux.Active = function()
	local x, y = gui.MousePos()
	return (x ~= 0 or y ~= 0)
end

ux.CenterX = function(w) return ux.Center(w, ScrW()) end
ux.CenterY = function(h) return ux.Center(h, ScrH()) end
ux.Center = function(child, parent)
	parent = parent / 2

	if (not child) then
		return parent
	end

	return parent - (child/2)
end

local blur = Material "pp/blurscreen"
ux.Blur = function(p, n, a)
	local x, y = p:LocalToScreen(0, 0)
	local scrw, scrh = ScrW(), ScrH()

	surface.SetDrawColor(255, 255, 255, a or 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (n or 3))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrw, scrh)
	end
end

ux.HoverThink = function(s, bounce, custom, speedIn, speedOut)
	custom = isfunction(custom) and custom() or custom or false
	bounce = bounce or false
	speedIn = speedIn or 5
	speedOut = speedOut or 2

	s.hover = s.hover or 0
	s.hoverBounce = s.hoverBounce or 0

	if (bounce) then
		if (s:IsHovered() or custom) then
			if (s.hoverBounce == 1) then
				s.hover = Lerp(FrameTime() * speedOut, s.hover, 0.3)
				if (s.hover <= 0.31) then s.hoverBounce = 2 end
			elseif (s.hoverBounce == 2) then
				s.hover = Lerp(FrameTime() * speedOut, s.hover, 1)
				if (s.hover >= 0.99) then s.hoverBounce = 1 end
			elseif (s.hoverBounce == 0) then
				s.hover = Lerp(FrameTime() * speedIn, s.hover, 1)
				if (s.hover >= 0.99) then s.hoverBounce = 1 end
			end
		elseif (s.hover > 0) then
			s.hover = Lerp(FrameTime() * speedOut, s.hover, 0)
			s.hoverBounce = 0
		end
	else
		if (s:IsHovered() or custom) then
			s.hover = Lerp(FrameTime() * speedIn, s.hover, 1)
		elseif (s.hover > 0) then
			s.hover = Lerp(FrameTime() * speedOut, s.hover, 0)
		end
	end
end

ux.ShiftColor = function(from, to, frac)
	from.a = from.a or 255
	to.a = to.a or 255

	return Color(
		from.r + ((to.r - from.r) * frac),
		from.g + ((to.g - from.g) * frac),
		from.b + ((to.b - from.b) * frac),
		from.a + ((to.a - from.a) * frac)
	)
end