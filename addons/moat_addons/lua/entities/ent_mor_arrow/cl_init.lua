include "shared.lua"


local trail = Material "trails/plasma"
local color_red = Color(0, 0, 255, 255)

function ENT:Draw()

	self:SetRenderAngles(self:GetAbsVelocity():Angle() - Angle(180, 0, 0))
	self:DrawModel()

    if (self:GetFirer() ~= LocalPlayer()) then
		return
    end

	if (not self.AbsolutePosition) then
		self.AbsolutePosition = {self:GetPos(), self:GetAngles()}
	end

	local pos = self.AbsolutePosition
	if (self.Weapon and IsValid(self.Weapon) and self.Weapon.ItemStats and self.Weapon.ItemStats.item and self.Weapon.ItemStats.item.Rarity) then
		color_red = self.Weapon.ItemStats.item.NameColor or rarity_names[self.Weapon.ItemStats.item.Rarity][2]:Copy()
		if (not color_red) then
			color_red = Color(0, 0, 255)
		end
	end

	render.SetColorModulation(color_red.r / 255, color_red.g / 255, color_red.b / 255)
	render.SetMaterial(trail)
	render.StartBeam(3)
		render.AddBeam(pos[1] - (pos[2]:Forward() * 20), 5, 1, color_red)
		render.AddBeam(pos[1], 5, 1, color_red)
		render.AddBeam(pos[1] + (pos[2]:Forward() * 20), 5, 1, color_red)
	render.EndBeam()
	render.SetColorModulation(1, 1, 1)

	local fr = FrameTime() * 10
	self.AbsolutePosition[1] = LerpVector(fr, self.AbsolutePosition[1], self:GetPos())
	self.AbsolutePosition[2] = LerpAngle(fr, self.AbsolutePosition[2], self:GetAngles())
end