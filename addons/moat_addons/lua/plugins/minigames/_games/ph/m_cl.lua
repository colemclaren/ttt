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
local PHTexture = Material("error")
local SmoothLevel = -32000
local MapScale = 1
local SkyboxScale = 1
local ClipTab = {}
local hullz = 80
// Resets the player hull
function ResetHull(um)
	if LocalPlayer() && IsValid(LocalPlayer()) then
		LocalPlayer():ResetHull()
		hullz = 80
	end
end
usermessage.Hook("ResetHull", ResetHull)

// Sets the player hull
function SetHull(um)
	hullxy = um:ReadLong()
	hullz = um:ReadLong()
	new_health = um:ReadLong()
	
	LocalPlayer():SetHull(Vector(hullxy * -1, hullxy * -1, 0), Vector(hullxy, hullxy, hullz))
	LocalPlayer():SetHullDuck(Vector(hullxy * -1, hullxy * -1, 0), Vector(hullxy, hullxy, hullz))
	LocalPlayer():SetHealth(new_health)
end
usermessage.Hook("SetHull", SetHull)

local kills = {}

local stats_spawn = GetConVar("moat_showstats_spawn")
local stats_spawn_old = false

net.Receive("PH_Kill",function()
    local killer = net.ReadEntity()
    local ply = net.ReadString()
    timer.Simple(1,function()
        local props = #ents.FindByClass("ph_prop")
        if (not IsValid(killer)) then 
        return end
        if killer == LocalPlayer() then
            chat.AddText(Color(255,0,0),"You",Color(255,255,255)," killed ",Color(0,255,0), ply,Color(255,255,255), " and got 10 HP! ",tostring(props)," props left!")
        else
            local k = "Something"
            if killer:IsPlayer() then
                k = killer:Nick()
            end
            chat.AddText(Color(255,0,0),k,Color(255,255,255)," killed ",Color(0,255,0),ply,Color(255,255,255),", ",tostring(props)," props remain!")
        end
    end)
end)

net.Receive("PH_Begin",function()
    for k,v in ipairs(player.GetAll()) do
		MOAT_LOADOUT.RemoveModels(v)
        v.Skeleton = false
        v.NoTarget = true
    end

    SmoothLevel = Entity(0):GetModelRenderBounds().z
    MOAT_PH = {
        goal = 100,
        Blind = CurTime() + 25,
        TopKills = 0,
        MyKills = 0,
        time_end = CurTime() + (#player.GetAll() * 13) + 30,
        tdm_blue = Color(90, 200, 255),
        tdm_red = Color(255, 50, 50),
        bar_width = 225,
        blue_cur = 0,
        red_cur = 0,
        red_save = 0,
        blue_save = 0,
    }
    MOAT_IGNORE_FOV = true
    hook.Add("CalcView","MOAT_PH",function(pl, origin, angles, fov)
        local view = {} 
        if not MOAT_PH then return end
        if MOAT_PH.Blind > CurTime() and (LocalPlayer().t_hunter) then
            view.origin = Vector(20000, 0, 0)
            view.angles = Angle(0, 0, 0)
            view.fov = fov
            
            return view
        end
        
        view.origin = origin 
        view.angles	= angles 
        view.fov = fov 
        
        // Give the active weapon a go at changing the viewmodel position 
        if pl.t_prop && pl:Alive() and (not pl:IsSpec()) then
            local Forward = 100
			local Up = 17.5
			local Right = 0

            local traceData = {}
            traceData.start = origin
            traceData.endpos = traceData.start + angles:Forward() * -Forward
            traceData.endpos = traceData.endpos + angles:Right() * Right
            traceData.endpos = traceData.endpos + angles:Up() * Up
            traceData.filter = { LocalPlayer(), LocalPlayer().ph_prop }
            
            local trace = util.TraceLine(traceData)

            pos = trace.HitPos
            
            if trace.Fraction < 1.0 then
                pos = pos + trace.HitNormal * 5
            end
            
            view.origin = pos
        else
            local wep = pl:GetActiveWeapon() 
            if wep && wep != NULL then 
                local func = wep.GetViewModelPosition 
                if func then 
                    view.vm_origin, view.vm_angles = func(wep, origin*1, angles*1) // Note: *1 to copy the object so the child function can't edit it. 
                end
                
                local func = wep.CalcView 
                if func then 
                    view.origin, view.angles, view.fov = func(wep, pl, origin*1, angles*1, fov) // Note: *1 to copy the object so the child function can't edit it. 
                end 
            end
        end
        
        return view 
    end)
    MOAT_DISABLE_BUNNY_HOP = true

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/inception.mp3", 0.8, function(station)
        hook.Add("Think","J Music",function()
            if not MOAT_PH then station:Stop() hook.Remove("Think","J Music") end
        end)
    end)

    kills = {}
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
    surface.CreateFont("MOAT_PHLead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end

net.Receive("PH.Role",function()
    LocalPlayer().t_hunter = net.ReadBool()
    LocalPlayer().t_prop = (not LocalPlayer().t_hunter)

    if LocalPlayer().t_prop then
        LocalPlayer().ph_prop = net.ReadEntity()
        print("Got prop",LocalPlayer().ph_prop)
    end
end)

hook.Add("PreDrawHalos","Moat_PH",function()
    local t = {}
    if not MOAT_PH then return end
    if not LocalPlayer().t_prop then return end
    for k,v in ipairs(ents.GetAll()) do
        if v:GetPos():DistToSqr(LocalPlayer():GetPos()) < 102154.71837072 and (v:GetClass() == "prop_physics" or v:GetClass() == "prop_physics_multiplayer") then
            t[#t+1] = v
        end
    end
    halo.Add(t, Color(0, 255, 0), 3, 3, 1, true, false)
end)
local props_w = false
net.Receive("PH_End",function()
    ResetHull()
    MOAT_IGNORE_FOV = false
    for k,v in ipairs(player.GetAll()) do
        v:SetNoDraw(false)
        v.NoTarget = false
    end
    LocalPlayer().t_hunter = false
    LocalPlayer().t_prop = false
    MOAT_DISABLE_BUNNY_HOP = false
    props_w = net.ReadBool()
    local players = net.ReadTable()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)
    MOAT_PH = nil
    kills = {}
    PH_END = {}
    timer.Create("J END TIMER",21,1,function()
		if (not PH_END) then PH_END = nil return end
        for k,v in pairs(PH_END.av) do
            v:Remove()
        end
        PH_END = nil
    end)
    PH_END.w = red
    PH_END.p = players
    PrintTable(players)
    PH_END.av = {}
    PH_END.cur_i = #PH_END.p + 1
    table.sort(PH_END.p, function(a,b)
        return a[2] > b[2]
    end)

    timer.Simple(1,function()
		if (not PH_END) then return end
        for i = 1, #PH_END.p - 3 do
			if (not PH_END) then continue end
            timer.Simple(0.2 * i,function()
				if (not PH_END) then return end
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                PH_END.cur_i = PH_END.cur_i - 1
            end)
        end

        for i =1, 3 do
			if (not PH_END) then continue end
            timer.Simple((0.2 * ((#PH_END.p - 3) + 0.5 ) + (i * 0.7)),function()
				if (not PH_END) then return end
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                PH_END.cur_i = PH_END.cur_i - 1
            end)
        end
    end)
end)

hook.Add("CalcViewModelView","MOAT_PH",function()
    if not MOAT_PH then return end
    if LocalPlayer().t_prop then
        return Vector(20000,0,0),Angle(0,0,0)
    end
end)

hook.Add("HUDPaint","PH_END_SCREEN",function()
    if not PH_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "HUNTERS WIN!!!"
    if props_w then
        text = "PROPS WIN!!!"
    end
    local textc = Color(255,0,0)
    local textc2 = Color(0,0,50)

    surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))

    surface.SetFont("moat_BossInfo")
    local txt = "Top Kills"
    if props_w then txt = "Top Score" end
    local col = Color(255, 255, 255)

    local textw, texth = surface.GetTextSize(txt)
    m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    for k,v in pairs(PH_END.p) do
        if k < 4 then continue end
        if PH_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        if props_w then
            draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. k.. (props_w and "th place") or " kills", "MOAT_PHLead" .. math.max((32 - k), 1), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. v[2] .. " kills", "MOAT_PHLead" .. math.max((32 - k), 1), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        end
    end
    
    if not PH_END.p[3] then PH_END.p[3] = {} end
    if PH_END.cur_i < 4 and IsValid(PH_END.p[3][1]) then
        if (not PH_END.av[3]) then
            PH_END.av[3] = vgui.Create("AvatarImage")
            PH_END.av[3]:SetSize(128,128)
            PH_END.av[3]:SetPlayer(PH_END.p[3][1],128)
            PH_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        if props_w then
            draw.SimpleTextOutlined(PH_END.p[3][1]:Nick() .. ": 3rd Place", "moat_TDMLead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        else
            draw.SimpleTextOutlined(PH_END.p[3][1]:Nick() .. ": " .. PH_END.p[3][2] .. " kills", "moat_TDMLead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        end
    end
    
    if not PH_END.p[2] then PH_END.p[2] = {} end
    if PH_END.cur_i < 3 and IsValid(PH_END.p[2][1]) then
        if (not PH_END.av[2]) then
            PH_END.av[2] = vgui.Create("AvatarImage")
            PH_END.av[2]:SetSize(128,128)
            PH_END.av[2]:SetPlayer(PH_END.p[2][1],128)
            PH_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        if props_w then
            draw.SimpleTextOutlined(PH_END.p[2][1]:Nick() .. ": 2nd Place", "moat_TDMLead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        else
            draw.SimpleTextOutlined(PH_END.p[2][1]:Nick() .. ": " .. PH_END.p[2][2] .. " kills", "moat_TDMLead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        end
    end
    
    if not PH_END.p[1] then PH_END.p[1] = {} end
    if PH_END.cur_i < 2 and IsValid(PH_END.p[1][1]) then
        if (not PH_END.av[1]) then
            PH_END.av[1] = vgui.Create("AvatarImage")
            PH_END.av[1]:SetSize(128,128)
            PH_END.av[1]:SetPlayer(PH_END.p[1][1],128)
            PH_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        if props_w then
            draw.SimpleTextOutlined(PH_END.p[1][1]:Nick() .. ": 1st Place", "moat_TDMLead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        else
            draw.SimpleTextOutlined(PH_END.p[1][1]:Nick() .. ": " .. PH_END.p[1][2] .. " kills", "moat_TDMLead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
        end
    end

end)

net.Receive("PH_NewKills",function()

end)

local gradient_d = Material("vgui/gradient-d")




local dead = 0
local dead_oc = false
PH_Bomb = "forsenE"
net.Receive("PH.NewBomb",function()
    PH_Bomb = net.ReadString()
    chat.AddText(Color(255,0,0),PH_Bomb,Color(255,255,255),[[ now has the bomb!]])
end)

PHFuseTime = 0
net.Receive("PH.FuseTime",function()
    PHFuseTime = net.ReadInt(32)
end)

surface.CreateFont("PH.Big",{
    font = "Coolvetica",
    size = 50,
    weight = 800,
    antialias = true,
    blursize = 0
})
surface.CreateFont("PH.Small",{
    font = "Coolvetica",
    size = 30,
    weight = 800,
    antialias = true,
    blursize = 0
})
hook.Add("HUDPaint", "moat.test.LPH", function()
    if not istable(MOAT_PH) then return end
    if MOAT_PH.Blind > CurTime() then
        if LocalPlayer().t_hunter then
            draw.SimpleTextOutlined("You're blinded for " .. math.Round(MOAT_PH.Blind - CurTime()) .. " seconds.", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.6), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
            draw.SimpleTextOutlined("Giving the props a chance to hide!", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.66), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
        else
            draw.SimpleTextOutlined("The hunters are blinded for another " .. math.Round(MOAT_PH.Blind - CurTime()) .. " seconds!", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.6), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
            draw.SimpleTextOutlined("Make sure to hide!", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.66), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
        end
    end
    local w,h = ScrW(),ScrH()
    local f = string.FormattedTime(MOAT_PH.time_end - CurTime())
    if tostring(f.s):len() == 1 then 
        f.s =  "0" .. f.s 
    end
    f = f.m .. ":" .. f.s
    local col = Color(255,255,255)
    if LocalPlayer().IsBomb then
        col = Color(255,0,0)
    end
    draw.SimpleTextOutlined(f .. " left", "PH.Big", w/2, 64, col, TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    
    cdn.DrawImage("https://static.moat.gg/f/MaUmSSziOxewOLgyvLQ967CEEt4k.png", (w/2) - (32), 0, 64, 64, Color(255, 255, 255, 225))

    if (not LocalPlayer():Alive()) or (LocalPlayer():IsSpec()) then return end

    if LocalPlayer().t_prop then
        draw.SimpleTextOutlined("Press E on a prop to become one!", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.3), Color(0,255,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
    else
        draw.SimpleTextOutlined("Hunt down all the props!", "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.3), Color(255,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
    end

    local t = LocalPlayer():GetEyeTrace()
    local ent = t.Entity
    if IsValid(t.Entity) then
        if ent:IsPlayer() then
            if (LocalPlayer():IsTraitor() and ent:IsTraitor()) or ((not LocalPlayer():IsTraitor()) and (not ent:IsTraitor())) then
                draw.SimpleTextOutlined(ent:Nick(), "moat_GunGameMedium", ScrW() * 0.5, (ScrH() *0.55), Color(0,255,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
            end
        end
    end

    /*surface.SetFont("PH.Big")
    local txtw = surface.GetTextSize(PH_Bomb .. " has the bomb!")
    local txw = draw.SimpleTextOutlined(PH_Bomb, "PH.Big", (w/2) - (txtw/2), h, Color(255,0,0), TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
    local _,txh = draw.SimpleTextOutlined(" has the bomb!", "PH.Big", (w/2) - (txtw/2) + txw, h, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))

    local txw = draw.SimpleTextOutlined(PH_Bomb, "PH.Big", (w/2) - (txtw/2), 100, Color(255,0,0), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    local _,txh = draw.SimpleTextOutlined(" has the bomb!", "PH.Big", (w/2) - (txtw/2) + txw, 100, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))

    surface.SetDrawColor(255,0,0,255)
    local bw = 300
    local t = PHFuseTime - CurTime()
    bw = math.max(0,bw * (t/15))
    draw.RoundedBox(0, w/2-150, h-txh-50, math.min(bw, 300), 30, col)
    surface.DrawOutlinedRect(w/2 - 150, h - txh - 50, 300, 30)
    local right = "Throw fire!"
    local left = "Shove people!"
    if LocalPlayer().IsBomb then
        left = "Throw your bomb!"
        right = 'Throw your bomb!'
    end

    draw.SimpleTextOutlined("Right Click:", "PH.Small", (w/2) + (38), h - txh - 124, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    draw.SimpleTextOutlined(right, "PH.Small", (w/2) + (38), h - txh - 94, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))

    draw.SimpleTextOutlined("Left Click:", "PH.Small", (w/2) - (38), h - txh - 124, col, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    draw.SimpleTextOutlined(left, "PH.Small", (w/2) - (38), h - txh - 94, col, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP, 1, Color(0,0,0))


    cdn.DrawImage("https://static.moat.gg/f/jnlPyDmSerPSksH3gfvhDGl4wZRF.png", (w/2) - (32), h - txh - 124, 64, 64, Color(255, 255, 255, 225))*/
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

net.Receive("PH_Prep",function()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Everyone will be on one of two teams!",
        "",
        "As a prop:",
        "Press " .. string.upper(input.LookupBinding("+use")) .. " on outlined green props to turn into them, prop size changes your health.",
        "Hide to win! Bigger props give you better items!",
        "",
        "As a hunter:",
        "Shooting non-players will make you take damage.",
        "Hunt down all the props, kill them for the best items!",
    }

    hook.Add("HUDPaint", "MG_PH_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_PH_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2
        local y = ScrH() / 2

        draw.SimpleTextOutlined("PROP HUNT!", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

        local time = math.ceil(GetGlobal("ttt_round_end") - CurTime())

        if (time < 1) then
            time = "BEGIN"
        end

        draw.SimpleTextOutlined(time, "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        local oi = 1
        for i = 1, #desc do
            local c = Color(255,255,255,255)
            if desc[i]:match("items") then c = Color(255,255,0,255) end
            if desc[i]:match("As a prop:") then c = Color(0,255,0) end
            if desc[i]:match("As a hunter:") then c = Color(255,0,0) end
            draw.SimpleTextOutlined(desc[i], "moat_GunGameMedium", x, y + (i * 23), c, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
            oi = i + 1
        end
    end)
end)