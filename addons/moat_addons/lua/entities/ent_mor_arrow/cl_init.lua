include "shared.lua"


local trail = Material "trails/plasma"
local color_red = Color(255, 0, 0, 255)

function ENT:Draw()
    local pos = self:GetPos()
    self:DrawModel()

    if (self:GetFirer() ~= LocalPlayer()) then
        return
    end

    self.Positions = self.Positions or {}
    table.insert(self.Positions, {
        time = CurTime(),
        pos = pos
    })

    local forwardpos, forwardtime = pos, CurTime()

    local deletebefore = 0
    render.SetMaterial(trail)

    for i = #self.Positions - 1, 1, -1 do
        local found = self.Positions[i]
        local thispos = found.pos
        if (found.time < CurTime() - 0.05) then
            deletebefore = i
            thispos = thispos + (forwardpos - thispos) * ((found.time - forwardtime) / (0.05 - CurTime() + forwardtime))
        end
        render.DrawBeam(thispos, forwardpos, 5, 1, 1, color_red)
        if (deletebefore ~= 0) then
            break
        end
    end

    for i = 1, deletebefore do
        table.remove(self.Positions, i)
    end
end
