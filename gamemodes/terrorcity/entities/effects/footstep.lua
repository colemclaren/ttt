function EFFECT:Init(data)
    self.time = CurTime()
    self:SetPos(data:GetOrigin())
    local ang = data:GetAngles()
    ang.p = 0
    self:SetAngles(ang)
    self:SetRenderBounds(Vector(-5, -2, -1), Vector(5, 2, 1))
    self:SetRenderMode(RENDERMODE_GLOW)
end

local color = Color(255, 80, 0)
function EFFECT:Render()
    local v = {
        Vector(-4, 2, 0),
        Vector(4, 2, 0),
        Vector(4, -2, 0),
        Vector(-4, -2, 0),
    }

    for i = 1, #v do
        v[i] = LocalToWorld(v[i], angle_zero, self:GetPos(), self:GetAngles())
    end

    render.SetColorMaterial()
    render.DrawQuad(v[1], v[2], v[3], v[4], color)
end

function EFFECT:Think()
    return CurTime() <= self.time + 1
end

--[[
    
hook.Add("PlayerFootstep", "ttc.phoenix.footstep", function(ply, pos)
	local data = EffectData()
	data:SetOrigin(ply:GetPos())
	data:SetAngles(ply:EyeAngles())
	util.Effect("phoenix_footstep", data)
end)
]]