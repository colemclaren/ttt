

local kills = {}

net.Receive("FFAS_KStreak",function()
    local c = Color(255,0,0)
    local blue = net.ReadBool()
    if blue then c = Color(0,0,255) end
    local p = net.ReadEntity()
    local s = net.ReadString()
    if p == LocalPlayer() then
        k_streak = {
            t = CurTime() + 5,
            s = s:upper() .. "!"
        }
    end
    local reward = net.ReadString()
    chat.AddText(c,p:Nick(),Color(255,255,255)," just got a ",Color(255,255,0),s,Color(255,255,255)," and received ",Color(0,255,0),reward,Color(255,255,255),"!")
end)
local stats_spawn = GetConVar("moat_showstats_spawn")
local stats_spawn_old = false
net.Receive("FFAS_Begin",function()
    for k,v in pairs(player.GetAll()) do
        v.NoTarget = true
    end
    local goal = net.ReadInt(8)
    MOAT_FFAS = {
        goal = goal,
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

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/FFASsong.mp3", 0.5, function(station)
		hook.Add("Think","FFAS Music",function()
            if not MOAT_FFAS then station:Stop() hook.Remove("Think","FFAS Music") end
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
    surface.CreateFont("moat_FFASLead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end


net.Receive("FFAS_End",function()
    for k,v in pairs(player.GetAll()) do
        v.NoTarget = false
    end
    local players = net.ReadTable()
    local red = net.ReadBool()
	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)
    MOAT_FFAS = nil
    kills = {}
    FFAS_END = {}
    timer.Create("FFAS END TIMER",21,1,function()
        for k,v in pairs(FFAS_END.av) do
            v:Remove()
        end
        FFAS_END = nil
    end)
    FFAS_END.w = red
    FFAS_END.p = players
    FFAS_END.av = {}
    FFAS_END.cur_i = #FFAS_END.p + 1
    table.sort(FFAS_END.p, function(a,b)
        return a[2] > b[2]
    end)

    timer.Simple(1,function()
        for i = 1, #FFAS_END.p - 3 do
            timer.Simple(0.2 * i,function()
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                FFAS_END.cur_i = FFAS_END.cur_i - 1
            end)
        end

        for i =1, 3 do
            timer.Simple((0.2 * ((#FFAS_END.p - 3) + 0.5 ) + (i * 0.7)),function()
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                FFAS_END.cur_i = FFAS_END.cur_i - 1
            end)
        end
    end)
end)

hook.Add("HUDPaint","FFAS_END_SCREEN",function()
    if not FFAS_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "SNOWBALL FIGHT OVER!!!"
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
    local col = Color(255, 255, 255)

    local textw, texth = surface.GetTextSize(txt)
    m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    for k,v in pairs(FFAS_END.p) do
        if k < 4 then continue end
        if FFAS_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. string.Comma(math.Round(v[2])) .. " Kills", "moat_FFASLead" .. (32 - k), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
    
    if not FFAS_END.p[3] then FFAS_END.p[3] = {} end
    if FFAS_END.cur_i < 4 and IsValid(FFAS_END.p[3][1]) then
        if (not FFAS_END.av[3]) then
            FFAS_END.av[3] = vgui.Create("AvatarImage")
            FFAS_END.av[3]:SetSize(128,128)
            FFAS_END.av[3]:SetPlayer(FFAS_END.p[3][1],128)
            FFAS_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(FFAS_END.p[3][1]:Nick() .. ": " .. string.Comma(math.Round(FFAS_END.p[3][2])) .. " Kills", "moat_FFASLead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not FFAS_END.p[2] then FFAS_END.p[2] = {} end
    if FFAS_END.cur_i < 3 and IsValid(FFAS_END.p[2][1]) then
        if (not FFAS_END.av[2]) then
            FFAS_END.av[2] = vgui.Create("AvatarImage")
            FFAS_END.av[2]:SetSize(128,128)
            FFAS_END.av[2]:SetPlayer(FFAS_END.p[2][1],128)
            FFAS_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(FFAS_END.p[2][1]:Nick() .. ": " .. string.Comma(math.Round(FFAS_END.p[2][2])) .. " Kills", "moat_FFASLead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not FFAS_END.p[1] then FFAS_END.p[1] = {} end
    if FFAS_END.cur_i < 2 and IsValid(FFAS_END.p[1][1]) then
        if (not FFAS_END.av[1]) then
            FFAS_END.av[1] = vgui.Create("AvatarImage")
            FFAS_END.av[1]:SetSize(128,128)
            FFAS_END.av[1]:SetPlayer(FFAS_END.p[1][1],128)
            FFAS_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        draw.SimpleTextOutlined(FFAS_END.p[1][1]:Nick() .. ": " .. string.Comma(math.Round(FFAS_END.p[1][2])) .. " Kills", "moat_FFASLead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end

end)

net.Receive("FFAS_NewKills",function()
    if not MOAT_FFAS then return end
    MOAT_FFAS.TopKills = net.ReadInt(8)
    MOAT_FFAS.red_cur = MOAT_FFAS.TopKills
end)

local gradient_d = Material("vgui/gradient-d")

local killed_words = {
    " blasted ",
    " killed ",
    " smacked ",
    " murdered ",
    " took the life of ",
    " assassinated ",
    " eliminated ",
    " terminated ",
    " finished off ",
    " executed ",
    " slaughtered ",
    " butchered ",
    " annihilated ",
    " exterminated ",
    " mowed down ",
    " shot down ",
    " took out ",
    " wasted ",
    " whacked ",
    " smoked ",
    " neutralized ",
    " slayed ",
    " destroyed "
}

net.Receive("FFAS_Kill",function()
    local p = net.ReadEntity()
    if p == LocalPlayer() then 
        MOAT_FFAS.MyKills = MOAT_FFAS.MyKills + 1 
        MOAT_FFAS.blue_cur = MOAT_FFAS.MyKills
    end
    local killer = p:Nick()
    local killer_team = net.ReadBool()
    local dead = net.ReadEntity():Nick()
    local dead_team = net.ReadBool()
    
    table.insert(kills,1,{
        killer,
        killer_team,
        dead,
        dead_team,
        table.Random(killed_words),
        CurTime() + 10})
end)

local dead = 0
local dead_oc = false
hook.Add("HUDPaint", "moat.test.FFAS", function()
    if not istable(MOAT_FFAS) then return end
    if FFAS_END then return end
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
    --print(CurTime())
    if (dead < CurTime()) and (not LocalPlayer():Alive()) then
        draw.SimpleTextOutlined("Press any button to respawn", "moat_GunGameMedium", ScrW() / 2, ScrH()/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35,255))
    end

    local f = string.FormattedTime(MOAT_FFAS.time_end - CurTime())
    if tostring(f.s):len() == 1 then 
        f.s =  "0" .. f.s 
    end

     surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(scrw - 300, 50, MOAT_FFAS.bar_width, 25)
    surface.DrawRect(scrw + 75, 50, MOAT_FFAS.bar_width, 25)


    if (MOAT_FFAS.blue_cur ~= MOAT_FFAS.blue_save) then
        surface.SetDrawColor(MOAT_FFAS.tdm_blue.r, MOAT_FFAS.tdm_blue.g, MOAT_FFAS.tdm_blue.b, 75)
        surface.DrawRect(scrw - 302, 48, MOAT_FFAS.bar_width + 4, 29)

        timer.Simple(FrameTime() * 10, function() if not istable(MOAT_FFAS) then return end MOAT_FFAS.blue_save = MOAT_FFAS.blue_cur end)
    else
        surface.SetDrawColor(MOAT_FFAS.tdm_blue.r, MOAT_FFAS.tdm_blue.g, MOAT_FFAS.tdm_blue.b, 50)
        surface.DrawRect(scrw - 300, 50, MOAT_FFAS.bar_width, 25)
    end


    local blue_w = (MOAT_FFAS.bar_width - 2) * (MOAT_FFAS.blue_cur/MOAT_FFAS.goal)
    surface.SetDrawColor(MOAT_FFAS.tdm_blue.r, MOAT_FFAS.tdm_blue.g, MOAT_FFAS.tdm_blue.b, 150)
    surface.DrawRect(scrw - 75 - blue_w, 51, blue_w, 23)


    if (MOAT_FFAS.red_cur ~= MOAT_FFAS.red_save) then
        surface.SetDrawColor(MOAT_FFAS.tdm_red.r, MOAT_FFAS.tdm_red.g, MOAT_FFAS.tdm_red.b, 75)
        surface.DrawRect(scrw + 73, 48, MOAT_FFAS.bar_width + 4, 29)

        timer.Simple(FrameTime() * 10, function() if not istable(MOAT_FFAS) then return end MOAT_FFAS.red_save = MOAT_FFAS.red_cur end)
    else
        surface.SetDrawColor(MOAT_FFAS.tdm_red.r, MOAT_FFAS.tdm_red.g, MOAT_FFAS.tdm_red.b, 50)
        surface.DrawRect(scrw + 75, 50, MOAT_FFAS.bar_width, 25)
    end

    local red_w = (MOAT_FFAS.bar_width - 2) * (MOAT_FFAS.red_cur/MOAT_FFAS.goal)
    surface.SetDrawColor(MOAT_FFAS.tdm_red.r, MOAT_FFAS.tdm_red.g, MOAT_FFAS.tdm_red.b, 150)
    surface.DrawRect(scrw + 76, 51, red_w, 23)


    
    DrawShadowedText(1, "Snowball FFA | " .. MOAT_FFAS.goal .. " to Win", "GModNotify", scrw, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    DrawShadowedText(1, f.m .. ":" .. f.s, "GModNotify", scrw, 89, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    DrawShadowedText(1, "Your kills: " .. MOAT_FFAS.MyKills, "GModNotify", scrw - 81, 62, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    DrawShadowedText(1, "Top kills: " .. MOAT_FFAS.TopKills, "GModNotify", scrw + 82, 62, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    local spawn_prot = LocalPlayer():GetNW2Int("MG_FFAS_SPAWNPROTECTION")

	if (spawn_prot and spawn_prot > CurTime()) then
		draw.SimpleTextOutlined("Spawn Protection: " .. math.ceil(spawn_prot - CurTime()), "moat_GunGameMedium", x, (ScrH() *0.6), Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end
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

net.Receive("FFAS_Prep",function()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Each player will spawn with a snowball",
        "Each kill gets you closer to winning (" .. net.ReadInt(8) .. " kills needed to win)",
        "Only players on the top get the best items!"
    }

    hook.Add("HUDPaint", "MG_FFAS_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_FFAS_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2
        local y = ScrH() / 2

        draw.SimpleTextOutlined("SNOWBALL FFA", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

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