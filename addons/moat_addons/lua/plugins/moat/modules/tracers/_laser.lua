local TRACER = TRACERS.laser or {}

local EFFECT = {
    Base = "base"
}

local mats
if (CLIENT) then
    mats = {
        Material "cable/redlaser",
        Material "cable/hydra",
        Material "cable/physbeam",
        Material "cable/xbeam"
    }
end

local sounds = {
    "https://static.moat.gg/ttt/summer/laser1.mp3",
}

function EFFECT:Init(data)
    self.endtime = CurTime() + data:GetEntity().Primary.Delay
    self.pos = self:GetTracerShootPos(data:GetEntity():GetPos(), data:GetEntity(), data:GetEntity():LookupAttachment "muzzle") or data:GetEntity():GetPos()
    self.endpos = data:GetOrigin()
    self.Material = mats[data:GetEntity():GetEntityID() % #mats + 1]
    
    if (not system.HasFocus()) then
        return
    end

    local pos = self.pos
    -- cdn.PlayURL(sounds[math.random(#sounds)], .8, function(g)
    --    if (g) then
	-- 		g:SetPos(pos)
	-- 		g:Play()
	-- 	end
    -- end, "3d noplay")

	sound.Play("Meep.Laser.Fire", pos)
end

function EFFECT:Render()
    -- Enable blend override to interpret the color and alpha from the texture.
    --render.OverrideBlend(true, BLEND_SRC_COLOR, BLEND_SRC_ALPHA, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)

    render.SetMaterial(self.Material)

    
    render.StartBeam(2)
        render.AddBeam(self.pos, 5, 0, color_white)
        render.AddBeam(self.endpos, 5, 1, color_white)
    render.EndBeam()

    --render.OverrideBlend(false)
end

function EFFECT:Think()
    return CurTime() <= self.endtime
end

if (CLIENT) then
    effects.Register(EFFECT, "laser_stuff")
end

TRACER.ApplyData = {
    _RunNow = function(self)
        self.Primary.Sound = ""
        self.TracerName = "laser_stuff"
        self.Tracer = 1
    end,
    DoImpactEffect = function(old, self, tr, type)
        if (SERVER) then
            return
        end

        -- util.DecalEx(decals[math.random(#decals)], tr.Entity, tr.HitPos, tr.HitNormal, color_white, 0.2, 0.2)
        return true
    end
}

return TRACER