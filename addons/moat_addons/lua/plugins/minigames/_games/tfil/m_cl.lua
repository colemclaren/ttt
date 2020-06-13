Lava = Lava or {}

Lava.SetLevel = function( n ) Lava.CurrentLevel = n end
Lava.ShiftLevel = function( n )	Lava.CurrentLevel = Lava.CurrentLevel + n end
Lava.StartingLevel = false
Lava.CurrentLevel = -32768
Lava.GetLevel = function()
	return CLIENT and GetGlobalFloat("$lavalev", -32768 ) or SERVER and Lava.CurrentLevel
end


-- end of sh

LAVA_EX = false

local hook = hook
local cam = cam
local draw = draw
local render = render
local EyePos = EyePos
local CurTime = CurTime
local math = math
local drawOverlay = DrawMaterialOverlay
local drawColor = DrawBloom
local LocalPlayer = LocalPlayer
local surface = surface
local tem2 = 0
local LavaTexture = false
local SmoothLevel = -32000
local MapScale = 1
local SkyboxScale = 1
local ClipTab = {}
local c_CurrentColor = Color( 255, 0, 0 )
local c_DesiredColor = CurrentColor

local kills = {}

local bTab = { 
    [ "$pp_colour_addr" ] = 0.02, 
    [ "$pp_colour_addg" ] = 0.02, 
    [ "$pp_colour_addb" ] = 0, 
    [ "$pp_colour_brightness" ] = 0, 
    [ "$pp_colour_contrast" ] = 1, 
    [ "$pp_colour_colour" ] = 2, 
    [ "$pp_colour_mulr" ] = 0, 
    [ "$pp_colour_mulg" ] = 0.02, 
    [ "$pp_colour_mulb" ] = 0 
}
local fDensity = 0
local RenderFog = function(f)
	fDensity = fDensity:lerp( 0.9, FrameTime()/3 )
	render.FogStart(5)
	render.FogColor(255, 128, 0)
	render.FogMode(MATERIAL_FOG_LINEAR)
	render.FogMaxDensity(fDensity)
	render.FogEnd( (5000 - (1500*fDensity) )* ( f or 1 ) )
	return true
end

local stats_spawn = GetConVar("moat_showstats_spawn")
local stats_spawn_old = false
net.Receive("lava_Begin",function()
	LavaTexture = cdn.Image("https://static.moat.gg/f/YOTZd8TJzmcaKD70AJ0laY73nZpw.jpg", function(img) LavaTexture = img end, "noclamp")

    SmoothLevel = Entity(0):GetModelRenderBounds().z
    MOAT_LAVA = {
        goal = 100,
        TopKills = 0,
        MyKills = 0,
        time_end = CurTime() + (60) * 10,
        tdm_blue = Color(90, 200, 255),
        tdm_red = Color(255, 50, 50),
        bar_width = 225,
        blue_cur = 0,
        red_cur = 0,
        red_save = 0,
        blue_save = 0,
    }

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/tdmsong.mp3", 0.5, function(station)
        hook.Add("Think","J Music",function()
            if not MOAT_LAVA then station:Stop() hook.Remove("Think","J Music") end
        end)
    end)

    kills = {}

    hook.Add("SetupWorldFog", "tfil.WorldFog", RenderFog)

    hook.Add("SetupSkyboxFog", "tfil.SkyboxFog", RenderFog)

    hook.Add("PostDraw2DSkyBox", "tfil.FogSkyUnity", function()
        render.Clear(255 * fDensity, 128 * fDensity, 0, 0, false, true)
    end)

    hook.Add("RenderScreenspaceEffects","tfil.LavaColorModify",function()
        DrawColorModify( bTab )
    end)

    hook.Add("Lava.PostRound", "tfil.ResetFoglerp", function()
        fDensity = 0
    end)

    hook.Add("Lava.PlayerEggDispatched", "TFIL", function(Player, Weapon, Egg)
        Egg:Ignite( 500, 0 )
        Weapon:SetEggs( Weapon:GetEggs() + 1 )
    end)

    hook.Add("EntityTakeDamage", "TFIL", function(Entity, Damage)
        if Entity:GetModel() == "models/props_phx/misc/egg.mdl" then
            if Damage:GetInflictor():IsValid() and Damage:GetInflictor():GetClass() == "entityflame" then
                return true
            end
        end

        if Entity:IsPlayer() and (Damage:IsFallDamage() or Damage:IsExplosionDamage()) then
            return true
        end
    end)

    hook.Add("PlayerShouldTakeDamage", "TFIL", function(Player, Attacker)
        if Attacker:IsValid() and Attacker:GetClass() == "env_explosion" then
            Player:SetVelocity( ( Player:GetPos() - Attacker:GetPos() ) * 10 + Vector( 0, 0, 200 ))
            return false
        end
    end)
    hook.Add("ShouldCollide","TFIL",function(a,b)
        if (a:GetClass() == "prop_physics") then
            if (a:GetModel() == "models/props_phx/misc/egg.mdl") then
                return false
            end
        elseif (b:GetClass() == "prop_physics") then
            if (b:GetModel() == "models/props_phx/misc/egg.mdl") then
                return false
            end
        end
    end)
end)



local blur = Material("pp/blurscreen")

local function DrawBlurScreen(amount)
    local x, y = 0, 0
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

surface.CreateFont("moat_BossWarning", {
    font = "DermaLarge",
    size = 52,
    weight = 800,
    italic = true
})

for i = 1, 50 do
    surface.CreateFont("MOAT_LAVALead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end


net.Receive("LAVA_End",function()
    LAVA_EX = false
    hook.Remove("SetupWorldFog", "tfil.WorldFog")
    hook.Remove("SetupSkyboxFog", "tfil.SkyboxFog")
    hook.Remove("PostDraw2DSkyBox", "tfil.FogSkyUnity")
    hook.Remove("RenderScreenspaceEffects","tfil.LavaColorModify")
    hook.Remove("Lava.PostRound", "tfil.ResetFoglerp")
    hook.Remove("Lava.PlayerEggDispatched", "TFIL")
    hook.Remove("EntityTakeDamage", "TFIL")
    hook.Remove("PlayerShouldTakeDamage", "TFIL")

    local players = net.ReadTable()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)
    MOAT_LAVA = nil
    kills = {}
    LAVA_END = {}
    timer.Create("J END TIMER",21,1,function()
		if (not LAVA_END) then LAVA_END = nil return end
        for k,v in pairs(LAVA_END.av) do
            v:Remove()
        end
        LAVA_END = nil
    end)
    LAVA_END.w = red
    LAVA_END.p = players
    PrintTable(players)
    LAVA_END.av = {}
    LAVA_END.cur_i = #LAVA_END.p + 1
    table.sort(LAVA_END.p, function(a,b)
        return a[2] > b[2]
    end)

    timer.Simple(1,function()
		if (not LAVA_END) then return end
        for i = 1, #LAVA_END.p - 3 do
			if (not LAVA_END) then continue end
            timer.Simple(0.2 * i,function()
				if (not LAVA_END) then return end
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                LAVA_END.cur_i = LAVA_END.cur_i - 1
            end)
        end

        for i =1, 3 do
			if (not LAVA_END) then continue end
            timer.Simple((0.2 * ((#LAVA_END.p - 3) + 0.5 ) + (i * 0.7)),function()
				if (not LAVA_END) then return end
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                LAVA_END.cur_i = LAVA_END.cur_i - 1
            end)
        end
    end)
end)

hook.Add("HUDPaint","LAVA_END_SCREEN",function()
    if not LAVA_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "THE FLOOR IS LAVA OVER!!!"
    local textc = Color(255,0,0)
    local textc2 = Color(0,0,50)

    surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))

    surface.SetFont("moat_BossInfo")
    local txt = "Top Score"
    local col = Color(255, 255, 255)

    local textw, texth = surface.GetTextSize(txt)
    m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    for k,v in pairs(LAVA_END.p) do
        if k < 4 then continue end
        if LAVA_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. k.. " Place", "MOAT_LAVALead" .. math.max((32 - k), 1), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
    
    if not LAVA_END.p[3] then LAVA_END.p[3] = {} end
    if LAVA_END.cur_i < 4 and IsValid(LAVA_END.p[3][1]) then
        if (not LAVA_END.av[3]) then
            LAVA_END.av[3] = vgui.Create("AvatarImage")
            LAVA_END.av[3]:SetSize(128,128)
            LAVA_END.av[3]:SetPlayer(LAVA_END.p[3][1],128)
            LAVA_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(LAVA_END.p[3][1]:Nick() .. ": 3rd Place", "MOAT_LAVALead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not LAVA_END.p[2] then LAVA_END.p[2] = {} end
    if LAVA_END.cur_i < 3 and IsValid(LAVA_END.p[2][1]) then
        if (not LAVA_END.av[2]) then
            LAVA_END.av[2] = vgui.Create("AvatarImage")
            LAVA_END.av[2]:SetSize(128,128)
            LAVA_END.av[2]:SetPlayer(LAVA_END.p[2][1],128)
            LAVA_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(LAVA_END.p[2][1]:Nick() .. ": 2nd Place", "MOAT_LAVALead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not LAVA_END.p[1] then LAVA_END.p[1] = {} end
    if LAVA_END.cur_i < 2 and IsValid(LAVA_END.p[1][1]) then
        if (not LAVA_END.av[1]) then
            LAVA_END.av[1] = vgui.Create("AvatarImage")
            LAVA_END.av[1]:SetSize(128,128)
            LAVA_END.av[1]:SetPlayer(LAVA_END.p[1][1],128)
            LAVA_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        draw.SimpleTextOutlined(LAVA_END.p[1][1]:Nick() .. ": 1st Place", "MOAT_LAVALead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end

end)

net.Receive("LAVA_NewKills",function()

end)

local gradient_d = Material("vgui/gradient-d")




local dead = 0
local dead_oc = false
hook.Add("HUDPaint", "moat.test.L", function()
    if not istable(MOAT_LAVA) then return end
    if LAVA_END then return end
    local top = 0
    for k,v in ipairs(player.GetAll()) do
        if v:GetNW2Float("JBScore",0) > top then top = v:GetNW2Float("JBScore",0) end
    end
    local scrw = (ScrW() / 2) 
    if (not LocalPlayer():Alive()) and not (dead > CurTime()) and not (dead_oc) then
        dead = CurTime() + 5
        dead_oc = true
    elseif LocalPlayer():Alive() then dead_oc = false end
    local x = (ScrW() * 0.5)
    local y = 100
    local sp = 30
    for i = 1,5 do
        --if not LocalPlayer():Alive() then continue end
        if not kills[i] then continue end
        surface.SetFont("moat_GunGameMedium")
        local v = kills[i]
        local sw, sh = surface.GetTextSize(v[5])
        local c = Color(0,255,0,255/i + 100)
        if v[6] < CurTime() then
            c.a = 255 - ((CurTime() - v[6]) * 50) 
            if (255 - (CurTime() - v[6]) * 50) < 0 then
                kills[i] = nil
                continue
            end
        end
        local tw,th = draw.SimpleTextOutlined(v[3], "moat_GunGameMedium", x + sw / 2, y + (i * sp), c, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35, c.a))
        local c = Color(0,255,0,255/i + 100)
        if v[6] < CurTime() then
            c.a = 255 - ((CurTime() - v[6]) * 50) 
        end
        tw,th = draw.SimpleTextOutlined(v[1], "moat_GunGameMedium", x - sw / 2, y + (i * sp), c, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35,c.a))
        local c = Color(255,255,255,255/i + 100)
        if v[6] < CurTime() then
            c.a = 255 - ((CurTime() - v[6]) * 50) 
        end
        draw.SimpleTextOutlined(v[5], "moat_GunGameMedium", x, y + (i * sp),c, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35,c.a))
    end

    local f = string.FormattedTime(MOAT_LAVA.time_end - CurTime())
    if tostring(f.s):len() == 1 then 
        f.s =  "0" .. f.s 
    end

    DrawShadowedText(1, "DON'T FALL INTO THE LAVA!", "GModNotify", scrw, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    DrawShadowedText(1, f.m .. ":" .. f.s, "GModNotify", scrw, 65, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)


surface.CreateFont("moat_GunGameMedium", {
    font = "DermaLarge",
    size = 28,
    weight = 800,
    italic = true
})
surface.CreateFont("moat_GunGameSmall", {
    font = "DermaLarge",
    size = 18,
    weight = 800
})
surface.CreateFont("moat_GunGameLarge", {
    font = "DermaLarge",
    size = 52,
    weight = 800,
    italic = true
})

net.Receive("lava_Prep",function()
    local explosive = net.ReadBool()
    LAVA_EX = explosive
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Try to be the last one alive by climbing away from the lava!",
        "Falling into the lava will make you burn until you die!",
        "Only players that stay alive the longest get the best items!",
        "",
        "Left click to shove people",
        "Right click to throw eggs to blind people",
        "Headshotting someone with an egg will give you another egg back"
    }
    if explosive then
        desc = {
            "<EXPLOSIVE EGGS>",
            "Right click to throw infinite explosive eggs!",
            "Falldamage is turned off!",
            "",
            "Try to be the last one alive by climbing away from the lava!",
            "Falling into the lava will make you burn until you die!",
            "Only players that stay alive the longest get the best items!",
            "",
            "Left click to shove people"
        }
    end

    hook.Add("HUDPaint", "MG_LAVA_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_LAVA_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2
        local y = ScrH() / 2

        draw.SimpleTextOutlined("THE FLOOR IS LAVA!", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

        local time = math.ceil(GetGlobal("ttt_round_end") - CurTime())

        if (time < 1) then
            time = "BEGIN"
        end

        draw.SimpleTextOutlined(time, "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        local oi = 1
        for i = 1, #desc do
            local c = Color(255,255,255,255)
            if explosive and i < 4 then c = Color(255,0,0) end
            if desc[i]:match("items") then c = Color(255,255,0,255) end
            draw.SimpleTextOutlined(desc[i], "moat_GunGameMedium", x, y + (i * 23), c, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
            oi = i + 1
        end
    end)
end)



--- Lava CL

local windows = system.IsWindows()

function cam.Wrap2D( func, ... )
	cam.Start2D( ... )
		func()
	cam.End2D()
end

function cam.Wrap3D( func, ... )
	cam.Start3D( ... )
		func()
	cam.End3D()
end

function cam.Wrap3D2D( func, ... )
	cam.Start3D2D( ... )
		func()
	cam.End3D2D()
end

function render.Clip( tab, func )
	if not windows then
		return func()
	end
	render.EnableClipping( true )
	for i = 1, #tab do
		render.PushCustomClipPlane( tab[i][1], tab[i][2])
	end
	func()
	for i = 1, #tab do
		render.PopCustomClipPlane()
	end
	render.EnableClipping(false)
end

function math.lerp(n, to, val)
	val = val or FrameTime() * 3

	return Lerp(val, n, to)
end

function math.absolutize( n, onNeg, onPos )
	return n == 0 and 0 or n < 0 and (onNeg or -1) or (onPos or 1)
end

function math.inrange( n, min, max )
	return n >= min and n <= max
end

local Vec = debug.getregistry().Vector
local Vector = Vector

function Vec:SetX( n, alter )
	if not alter then
		return Vector( n, self.y, self.z )
	end
	self.x = n
	return self
end

function Vec:SetY( n, alter )
	if not alter then
		return Vector( self.x, n, self.z )
	end
	self.y = n
	return self
end

function Vec:SetZ( n, alter )
	if not alter then
		return Vector( self.x, self.y, n )
	end
	self.z = n
	return self
end

debug.setmetatable(-1, {
	__index = math
})

function hook.RunOnce(event, func)
	tem2 = tem2 + 1
	local c = 'temporary_hook_once_' .. tem2

	hook.Add(event, c, function(...)
		hook.Remove(event, c)

		return func(...)
	end)
end

local v = Vector()

local dirs = {
	right = Vector(1, 0, 0),
	frwd = Vector(0, 1, 0)
}

local function GetMapBounds()
	local a, b = Entity(0):GetModelRenderBounds()
	--a.z, b.z = 0, 0

	return a:Distance(b)
end


hook.RunOnce("SetupSkyboxFog", function(Scale)
	SkyboxScale = 1 / Scale
end)


hook.RunOnce("HUDPaint", function()
	MapScale = GetMapBounds() * 2
	local min, max = Entity(0):GetModelRenderBounds()
    SmoothLevel = Entity(0):GetModelRenderBounds().z
	ClipTab = {
		[1] = {dirs.right, -min.x:abs()},
		[2] = {-dirs.right, -max.x:abs()},
		[3] = {dirs.frwd, -min.y:abs()},
		[4] = {-dirs.frwd, -max.y:abs()}
	}
end)

hook.Add("PostDrawTranslucentRenderables", "DrawLava", function(a, b)
    if not istable(MOAT_LAVA) then return end
	SmoothLevel = SmoothLevel:lerp(Lava.GetLevel())
	local LavaLevel = v:SetZ(SmoothLevel)
	local Ang = Angle(0, CurTime(), 0)

	render.Clip(ClipTab, function()
		if (not LavaTexture) then
			LavaTexture = cdn.Image("https://static.moat.gg/f/YOTZd8TJzmcaKD70AJ0laY73nZpw.jpg", function(img)
				LavaTexture = img
			end, "noclamp")
			return
		end

		local x = 220 + (CurTime():sin() * 35):abs()
		surface.SetDrawColor(x, x, x)
		surface.SetMaterial(LavaTexture)

		if not b then
			cam.Wrap3D2D(function()
				surface.DrawTexturedRectUV(-MapScale / 2, -MapScale / 2, MapScale, MapScale, 0, 0, MapScale / 5000, MapScale / 5000)
			end, LavaLevel, Ang, 1)

			if EyePos().z < SmoothLevel then
				cam.Wrap3D2D(function()
					surface.DrawTexturedRectUV(-MapScale / 2, -MapScale / 2, MapScale, MapScale, 0, 0, MapScale / 5000, MapScale / 5000)
				end, LavaLevel, Ang + Angle( 180, 0, 0 ), 1)
			end
		end
	end)

	if b then
		cam.Wrap3D2D(function()
			surface.DrawTexturedRectUV(-MapScale / 2, -MapScale / 2, MapScale, MapScale, 0, 0, MapScale / 5000 * SkyboxScale, MapScale / 5000 * SkyboxScale)
		end, Vector(0, 0, 0) + (LavaLevel / SkyboxScale), Ang, 1)
	end

end)


hook.Add("RenderScreenspaceEffects", "DrawLavaOverlay", function()
	if not istable(MOAT_LAVA) then return end

	if EyePos().z < Lava.GetLevel() then
		if not LocalPlayer():Alive() then
			DrawBloom(0, 3, 0, 0, 0, 20, 255, 128, 0)

			return
		end

		DrawBloom(0, 3, 0, 0, 0, 20, 255, 128, 0)
		DrawMaterialOverlay("effects/water_warp01", 1)
	elseif LocalPlayer():GetPos().z <= Lava.GetLevel() and LocalPlayer():Alive() then
		DrawBloom(0, math.abs((math.sin(CurTime() * 10) * 3)), 0, 0, 0, 20, 255, 128, 0)
	end
end)

hook.Add("HUDShouldDraw", "DisableDeathscreen", function(name)
    if not istable(MOAT_LAVA) then return end
	if name == "CHudDamageIndicator" then return false end
end)