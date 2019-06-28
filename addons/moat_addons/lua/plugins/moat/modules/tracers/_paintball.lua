local TRACER = TRACERS.paintball or {}

local tracer = TRACER.tracer or {}
TRACER.tracer = tracer

local matBall = Material "sprites/sent_ball"

local sounds = {
    hit = {
        "https://cdn.moat.gg/ttt/summer/paintball1.mp3",
        "https://cdn.moat.gg/ttt/summer/paintball2.mp3",
        "https://cdn.moat.gg/ttt/summer/paintball3.mp3",
    },
    hityou = {
        "https://cdn.moat.gg/ttt/summer/paintballhit.mp3",
    }
}


local EFFECT = {
    Base = "base"
}

local mats = {
    Material "cable/redlaser",
    Material "cable/hydra",
    Material "cable/physbeam",
    Material "cable/xbeam"
}

function EFFECT:Init(data)
    self.pos = self:GetTracerShootPos(data:GetEntity():GetPos(), data:GetEntity(), data:GetEntity():LookupAttachment "muzzle") or data:GetEntity():GetPos()
    self.endpos = data:GetOrigin()
    self.endtime = CurTime() + self.endpos:Distance(self.pos) / 15500
    self.starttime = CurTime()
    self.Material = mats[data:GetEntity():GetEntityID() % #mats + 1]

    cdn.PlayURL(sounds.hit[math.random(#sounds.hit)], 6, function(g)
        g:SetPos(self.endpos)
    end, "3d")
end

function EFFECT:Render()
    local pos = LerpVector((CurTime() - self.starttime) / (self.endtime - self.starttime), self.pos, self.endpos)
    local size = 4
	render.SetMaterial(matBall)
    render.DrawSprite(pos, size, size, color_white)
end

function EFFECT:Think()
    return CurTime() <= self.endtime
end

if (CLIENT) then
    effects.Register(EFFECT, "paintball")
end

local decals = {
    Material(util.DecalMaterial "PaintSplatGreen"),
    Material(util.DecalMaterial "PaintSplatPink"),
    Material(util.DecalMaterial "PaintSplatBlue")
}

TRACER.ApplyData = {
    _RunNow = function(self)
        self.TracerName = "paintball"
        self.Tracer = 1
    end,
    DoImpactEffect = function(old, self, tr, type)
        if (SERVER) then
            return
        end

        util.DecalEx(decals[math.random(#decals)], tr.Entity, tr.HitPos, tr.HitNormal, color_white, 0.2, 0.2)
        return true
    end
}

return TRACER