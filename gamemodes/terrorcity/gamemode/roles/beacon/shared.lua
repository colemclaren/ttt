if (SERVER) then
    include "sv_init.lua"
end

DEFINE_BASECLASS "gamemode_base"

if (not CLIENT) then return end

local lightning_pos, lightning_time
net.Receive("tc_beacon_pos", function(len, ply)
    lightning_pos = net.ReadVector()
    lightning_time = CurTime()
    EmitSound("ambient/atmosphere/thunder1.wav", lightning_pos, 0, CHAN_STATIC, 1, 130)
end)

-- from wiki!

-- Our sprite texture to render. Rendering this texture without
-- render.OverrideBlendFunc will result in black borders around the lightning beam.
local lightningMaterial = Material( "sprites/lgtning" )

function GM:PreDrawTranslucentRenderables( isDrawingDepth, isDrawingSkybox )
    BaseClass.PreDrawTranslucentRenderables(isDrawingDepth, isDrawingSkybox)

    if isDrawingDepth or isDrawSkybox or not lightning_time or lightning_time < CurTime() - 2 then return end
    local offset = CurTime() - lightning_time
    if (offset > 0.75 and offset < 1.25) then return end

    -- Calculate a random UV to use for the lightning to give it some movement
    local uv = math.Rand( 0, 1 )

    -- Enable blend override to interpret the color and alpha from the texture.
    render.OverrideBlendFunc( true, BLEND_SRC_COLOR, BLEND_SRC_ALPHA, BLEND_ONE, BLEND_ZERO )

    render.SetMaterial( lightningMaterial )

    -- Render a lightning beam along points randomly offset from a line above the player.
    render.StartBeam( 5 )
        render.AddBeam( lightning_pos + Vector( 0, 0, 035 ), 20, uv, Color( 255, 255, 255, 255 ) )
        render.AddBeam( lightning_pos + Vector( 0, 0, 135 ) + Vector( math.Rand( -20, 20 ), math.Rand( -20, 20 ), 0 ), 20, uv * 2, color_white )
        render.AddBeam( lightning_pos + Vector( 0, 0, 235 ) + Vector( math.Rand( -20, 20 ), math.Rand( -20, 20 ), 0 ), 20, uv * 3, color_white )
        render.AddBeam( lightning_pos + Vector( 0, 0, 335 ) + Vector( math.Rand( -20, 20 ), math.Rand( -20, 20 ), 0 ), 20, uv * 4, color_white )
        render.AddBeam( lightning_pos + Vector( 0, 0, 435 ) + Vector( math.Rand( -20, 20 ), math.Rand( -20, 20 ), 0 ), 20, uv * 5, color_white )
    render.EndBeam()

    -- Disable blend override
    render.OverrideBlendFunc( false )

end