include "shared.lua"
--[[---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------]]
function ENT:Initialize()
    self.Color = Color(255, 255, 255, 255)
end

--[[---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------]]
local fire_mat = Material "effects/fire_cloud2"
local fire_mat2 = Material "effects/energyball"

function ENT:Draw()
    local mat = fire_mat
    local sc = self.Owner:GetModelScale()

    if (self.Entity:GetModelScale() == 10 * math.Clamp(sc, .5, 1)) then
        mat = fire_mat2
    end

    local scl = math.Clamp(self.Entity:GetModelScale(), .25, 4)
    local pos = self.Entity:GetPos() + Vector(0, 0, 8)
    local lcolor = render.GetLightColor(pos) * 2
    lcolor.x = self.Color.r * math.Clamp(lcolor.x, .5, 1)
    lcolor.y = self.Color.g * math.Clamp(lcolor.y, .5, 1)
    lcolor.z = self.Color.b * math.Clamp(lcolor.z, .5, 1)
    render.SetMaterial(mat)
    local col = Color(lcolor.x, lcolor.y, lcolor.z, 255)
    render.DrawSprite(pos, 32 * scl, 32 * scl, col)
end