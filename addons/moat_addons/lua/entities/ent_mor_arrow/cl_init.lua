include('shared.lua')


local trail = Material("trails/plasma")

function ENT:UpdateSavedPos()
	self.savedpos = self:GetPos()
	self.nextposcheck = CurTime() + 0.05
end

function ENT:Think()
	if (not self.nextposcheck or (self.nextposcheck <= CurTime())) then self:UpdateSavedPos() end
end

function ENT:Draw()
    if (self.C_Pos) then
        self:SetPos(self.C_Pos)
    end
    self:DrawModel()

    if (not IsValid(self:GetOwner())) then return end
    if (self:GetOwner() ~= LocalPlayer()) then return end
    if (not self.savedpos) then return end

    render.SetMaterial(trail)
    render.DrawBeam(self:GetPos(), self.savedpos, 5, 1, 1, Color(255, 0, 0, 255))
end
