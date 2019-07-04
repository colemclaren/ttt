local Mats, _Material = {}, _Material or Material
function Material(n, p)
	p = p or ""

	if (Mats[n .. p] and Mats[n .. p]:IsError() or Mats[n .. p] == nil) then
		Mats[n .. p] = _Material(n, Either(type(p) == "string", p, false))
	end

	return Mats[n .. p]
end

function ScreenScale(size)
	return size * (ScrW() / 640.0)
end

SScale = ScreenScale
RealMaterial = (not RealMaterial) and _Material or RealMaterial