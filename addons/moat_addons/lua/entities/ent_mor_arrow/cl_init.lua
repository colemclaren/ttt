include('shared.lua')

function ENT:Draw()
    if (self.C_Pos) then
        self:SetPos(self.C_Pos)
    end
    self:DrawModel()
end
