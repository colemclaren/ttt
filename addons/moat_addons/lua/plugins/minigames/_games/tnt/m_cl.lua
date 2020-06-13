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
local TNTTexture = Material("error")
local SmoothLevel = -32000
local MapScale = 1
local SkyboxScale = 1
local ClipTab = {}


local kills = {}

local stats_spawn = GetConVar("moat_showstats_spawn")
local stats_spawn_old = false

net.Receive("TNT_Begin",function()
    for k,v in ipairs(player.GetAll()) do
        v.Skeleton = false
    end
    SmoothLevel = Entity(0):GetModelRenderBounds().z
    MOAT_TNT = {
        goal = 100,
        TopKills = 0,
        MyKills = 0,
        time_end = CurTime() + (#player.GetAll() * 15) + 30,
        tdm_blue = Color(90, 200, 255),
        tdm_red = Color(255, 50, 50),
        bar_width = 225,
        blue_cur = 0,
        red_cur = 0,
        red_save = 0,
        blue_save = 0,
    }
    MOAT_DISABLE_BUNNY_HOP = true

    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/tdmsong.mp3", 0.5, function(station)
        hook.Add("Think","J Music",function()
            if not MOAT_TNT then station:Stop() hook.Remove("Think","J Music") end
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
    surface.CreateFont("MOAT_TNTLead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end

hook.Add("PreDrawHalos","Moat_TNT",function()
    local t = {}
    if not MOAT_TNT then return end
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and not v:IsSpec() and (not v.Skeleton) then
            table.insert(t,v)
        end
    end
    if (#t > 10) and (not LocalPlayer().IsBomb) then return end
    halo.Add(t, Color(255, 0, 0), 1, 1, 1, true, true)
end)

net.Receive("TNT_End",function()
    for k,v in ipairs(player.GetAll()) do
        v:SetNoDraw(false)
    end
    MOAT_DISABLE_BUNNY_HOP = false
    local players = net.ReadTable()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)
    MOAT_TNT = nil
    kills = {}
    TNT_END = {}
    timer.Create("J END TIMER",21,1,function()
        for k,v in pairs(TNT_END.av) do
            v:Remove()
        end
        TNT_END = nil
    end)
    TNT_END.w = red
    TNT_END.p = players
    PrintTable(players)
    TNT_END.av = {}
    TNT_END.cur_i = #TNT_END.p + 1
    table.sort(TNT_END.p, function(a,b)
        return a[2] > b[2]
    end)

    timer.Simple(1,function()
        for i = 1, #TNT_END.p - 3 do
            timer.Simple(0.2 * i,function()
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                TNT_END.cur_i = TNT_END.cur_i - 1
            end)
        end

        for i =1, 3 do
            timer.Simple((0.2 * ((#TNT_END.p - 3) + 0.5 ) + (i * 0.7)),function()
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                TNT_END.cur_i = TNT_END.cur_i - 1
            end)
        end
    end)
end)

hook.Add("HUDPaint","TNT_END_SCREEN",function()
    if not TNT_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "TNT-TAG IS OVER!!!"
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

    for k,v in pairs(TNT_END.p) do
        if k < 4 then continue end
        if TNT_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. k.. " Place", "MOAT_TNTLead" .. math.max((32 - k), 1), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
    
    if not TNT_END.p[3] then TNT_END.p[3] = {} end
    if TNT_END.cur_i < 4 and IsValid(TNT_END.p[3][1]) then
        if (not TNT_END.av[3]) then
            TNT_END.av[3] = vgui.Create("AvatarImage")
            TNT_END.av[3]:SetSize(128,128)
            TNT_END.av[3]:SetPlayer(TNT_END.p[3][1],128)
            TNT_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(TNT_END.p[3][1]:Nick() .. ": 3rd Place", "MOAT_TNTLead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not TNT_END.p[2] then TNT_END.p[2] = {} end
    if TNT_END.cur_i < 3 and IsValid(TNT_END.p[2][1]) then
        if (not TNT_END.av[2]) then
            TNT_END.av[2] = vgui.Create("AvatarImage")
            TNT_END.av[2]:SetSize(128,128)
            TNT_END.av[2]:SetPlayer(TNT_END.p[2][1],128)
            TNT_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(TNT_END.p[2][1]:Nick() .. ": 2nd Place", "MOAT_TNTLead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not TNT_END.p[1] then TNT_END.p[1] = {} end
    if TNT_END.cur_i < 2 and IsValid(TNT_END.p[1][1]) then
        if (not TNT_END.av[1]) then
            TNT_END.av[1] = vgui.Create("AvatarImage")
            TNT_END.av[1]:SetSize(128,128)
            TNT_END.av[1]:SetPlayer(TNT_END.p[1][1],128)
            TNT_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        draw.SimpleTextOutlined(TNT_END.p[1][1]:Nick() .. ": 1st Place", "MOAT_TNTLead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end

end)

net.Receive("TNT_NewKills",function()

end)

local gradient_d = Material("vgui/gradient-d")




local dead = 0
local dead_oc = false
TNT_Bomb = "forsenE"
net.Receive("TNT.NewBomb",function()
    TNT_Bomb = net.ReadString()
    chat.AddText(Color(255,0,0),TNT_Bomb,Color(255,255,255),[[ now has the bomb!]])
end)

TNTFuseTime = 0
net.Receive("TNT.FuseTime",function()
    TNTFuseTime = net.ReadInt(32)
end)

surface.CreateFont("TNT.Big",{
    font = "Coolvetica",
    size = 50,
    weight = 800,
    antialias = true,
    blursize = 0
})
surface.CreateFont("TNT.Small",{
    font = "Coolvetica",
    size = 30,
    weight = 800,
    antialias = true,
    blursize = 0
})

net.Receive("TNT.Skeleton",function()
    net.ReadEntity().Skeleton = true
end)

hook.Add("HUDPaint", "moat.test.LTNT", function()
    if not istable(MOAT_TNT) then return end
    local w,h = ScrW(),ScrH()
    local f = string.FormattedTime(MOAT_TNT.time_end - CurTime())
    if tostring(f.s):len() == 1 then 
        f.s =  "0" .. f.s 
    end
    f = f.m .. ":" .. f.s
    local col = Color(255,255,255)
    if LocalPlayer().IsBomb then
        col = Color(255,0,0)
    end
    draw.SimpleTextOutlined(f, "TNT.Big", w/2, 64, col, TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    surface.SetFont("TNT.Big")
    local txtw = surface.GetTextSize(TNT_Bomb .. " has the bomb!")
    local txw = draw.SimpleTextOutlined(TNT_Bomb, "TNT.Big", (w/2) - (txtw/2), h, Color(255,0,0), TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
    local _,txh = draw.SimpleTextOutlined(" has the bomb!", "TNT.Big", (w/2) - (txtw/2) + txw, h, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))

    local txw = draw.SimpleTextOutlined(TNT_Bomb, "TNT.Big", (w/2) - (txtw/2), 100, Color(255,0,0), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    local _,txh = draw.SimpleTextOutlined(" has the bomb!", "TNT.Big", (w/2) - (txtw/2) + txw, 100, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    if LocalPlayer().Skeleton then
        draw.SimpleTextOutlined("You are now a skeleton!", "TNT.Small", (w/2), 170, Color(255,0,0), TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP, 1, Color(0,0,0))
        draw.SimpleTextOutlined("Body-block and shove the survivors to make them lose!", "TNT.Small", (w/2), 200, Color(255,0,0), TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP, 1, Color(0,0,0))
        draw.SimpleTextOutlined("Getting close to the bomb carrier will kill you, though", "TNT.Small", (w/2), 230, Color(255,0,0), TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    end

    surface.SetDrawColor(255,0,0,255)
    local bw = 300
    local t = TNTFuseTime - CurTime()
    bw = math.max(0,bw * (t/15))
    draw.RoundedBox(0, w/2-150, h-txh-50, math.min(bw, 300), 30, col)
    surface.DrawOutlinedRect(w/2 - 150, h - txh - 50, 300, 30)
    local right = "Throw fire!"
    local left = "Shove people!"
    if LocalPlayer().IsBomb then
        left = "Throw your bomb!"
        right = 'Throw your bomb!'
    end
    if LocalPlayer().Skeleton then
        left = "Shove people!"
        right = "Shove people!"
    end
    draw.SimpleTextOutlined("Right Click:", "TNT.Small", (w/2) + (38), h - txh - 124, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    draw.SimpleTextOutlined(right, "TNT.Small", (w/2) + (38), h - txh - 94, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1, Color(0,0,0))

    draw.SimpleTextOutlined("Left Click:", "TNT.Small", (w/2) - (38), h - txh - 124, col, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP, 1, Color(0,0,0))
    draw.SimpleTextOutlined(left, "TNT.Small", (w/2) - (38), h - txh - 94, col, TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP, 1, Color(0,0,0))


    cdn.DrawImage("https://static.moat.gg/f/jnlPyDmSerPSksH3gfvhDGl4wZRF.png", (w/2) - (32), h - txh - 124, 64, 64)
    cdn.DrawImage("https://static.moat.gg/f/MaUmSSziOxewOLgyvLQ967CEEt4k.png", (w/2) - (32), 0, 64, 64)
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

net.Receive("TNT_Prep",function()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Be the last one alive in this hot-potato style minigame!",
        "When the timer at the bottom runs out, the bomb carrier explodes!",
        "Only players that stay alive the longest get the best items!",
        "",
        "Innocent's can throw fire that lowers the fuse time!",
        "But be careful, they can also shove eachother!",
        "(When you die, you turn into a skeleton. Skeletons can shove survivors and bodyblock!)"
    }

    hook.Add("HUDPaint", "MG_TNT_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_TNT_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2
        local y = ScrH() / 2

        draw.SimpleTextOutlined("TNT TAG!", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

        local time = math.ceil(GetGlobal("ttt_round_end") - CurTime())

        if (time < 1) then
            time = "BEGIN"
        end

        draw.SimpleTextOutlined(time, "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        local oi = 1
        for i = 1, #desc do
            local c = Color(255,255,255,255)
            if desc[i]:match("items") then c = Color(255,255,0,255) end
            draw.SimpleTextOutlined(desc[i], "moat_GunGameMedium", x, y + (i * 23), c, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
            oi = i + 1
        end
    end)
end)