include('shared.lua')

SWEP.PrintName = "Predator Blade"
SWEP.Slot = 0

function SWEP:DrawHUD()
	local tr = self.Owner:GetEyeTrace(MASK_SHOT)
	local ent = tr.Entity

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	if (tr.HitNonWorld and IsValid(ent) and ent:IsPlayer() or ent:IsNPC()) then
		local color, text
		if ((ent:TranslatePhysBoneToBone(tr.PhysicsBone) == 6) or (math.abs(math.AngleDifference(ent:GetAngles().y, self.Owner:GetAngles().y)) <= 50)) then
			color = Color(200 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()), 0, 200, 255 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()))
			text = "Instant kill"
		else
			color = Color(0, 0, 102 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()), 204 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()))
			text = "Weak"
		end

		local outer = 40
		local inner = 20

		surface.SetDrawColor(color)

		surface.DrawLine(x - outer, y - outer, x - inner, y - inner)
		surface.DrawLine(x + outer, y + outer, x + inner, y + inner)

		surface.DrawLine(x - outer, y + outer, x - inner, y + inner)
		surface.DrawLine(x + outer, y - outer, x + inner, y - inner)

		draw.SimpleText(text, "Default", x + 70, y - 55, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end

	y = ScrH() * 0.995
	draw.SimpleText("Primary attack to attack.", "Default", x, y - 40, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Secondary attack to jump.", "Default", x, y - 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Reload to taunt.", "Default", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

	return self.BaseClass.DrawHUD(self)
end
