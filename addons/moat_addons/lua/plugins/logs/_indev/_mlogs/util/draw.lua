if (SERVER) then return end

local zerod = {sin = math.sin(math.rad(0)), cos = math.cos(math.rad(0))}
function mlogs.DrawCircle(x, y, radius, seg)
	local cir, cur = {{x = x, y = y, u = 0.5, v = 0.5}}, 1

	for i = 0, seg do
		cur = cur + 1

		local a = math.rad((i/seg) * -360)
		cir[cur] = {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5}
	end

	cur = cur + 1
	cir[cur] = {x = x + zerod.sin * radius, y = y + zerod.cos * radius, u = zerod.sin / 2 + 0.5, v = zerod.cos / 2 + 0.5}
	surface.DrawPoly(cir)
end