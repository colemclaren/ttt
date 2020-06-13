

local kills = {}
local _SEED = 1337
net.Receive("FFA_KStreak",function()
    local c = Color(255,0,0)
    local blue = net.ReadBool()
    if blue then c = Color(0,0,255) end
    local p = net.ReadEntity()
    local s = net.ReadString()
    if IsValid(p) and p == LocalPlayer() then
        k_streak = {
            t = CurTime() + 5,
            s = s:upper() .. "!"
        }
    end
    local reward = net.ReadString()

	if (not IsValid(p)) then return end
    chat.AddText(c,p:Nick(),Color(255,255,255)," just got a ",Color(255,255,0),s,Color(255,255,255)," and received ",Color(0,255,0),reward,Color(255,255,255),"!")
end)
local stats_spawn = GetConVar("moat_showstats_spawn")
local stats_spawn_old = false
net.Receive("FFA_Begin",function()
    for k,v in pairs(player.GetAll()) do
        v.NoTarget = true
    end
    local goal = net.ReadInt(8)
    MOAT_FFA = {
        WepCache = {},
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
    local songs = {
        "https://static.moat.gg/servers/tttsounds/FFASsong.mp3",
        "https://static.moat.gg/servers/tttsounds/tdmsong.mp3"
        }
    math.randomseed(_SEED)
    cdn.PlayURL(table.Random(songs), 0.5, function(station)
        hook.Add("Think","FFA Music",function()
            if not MOAT_FFA then station:Stop() hook.Remove("Think","FFA Music") end
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
    surface.CreateFont("moat_FFALead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end


net.Receive("FFA_End",function()
    for k,v in pairs(player.GetAll()) do
        v.NoTarget = false
    end
    local players = net.ReadTable()
    local red = net.ReadBool()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)

    kills = {}
    FFA_END = {}
    timer.Create("FFA END TIMER",21,1,function()
		MOAT_FFA = nil
		if (not FFA_END) then FFA_END = nil return end

        for k,v in pairs(FFA_END.av) do
            v:Remove()
        end
        FFA_END = nil
    end)
    FFA_END.w = red
    FFA_END.p = players
    FFA_END.av = {}
    FFA_END.cur_i = #FFA_END.p + 1
    table.sort(FFA_END.p, function(a,b)
        return a[2] > b[2]
    end)

    timer.Simple(1,function()
        for i = 1, #FFA_END.p - 3 do
            timer.Simple(0.2 * i,function()
				if (not FFA_END) then return end
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                FFA_END.cur_i = FFA_END.cur_i - 1
            end)
        end

        for i =1, 3 do
			if (not FFA_END) then continue end
            timer.Simple((0.2 * ((#FFA_END.p - 3) + 0.5 ) + (i * 0.7)),function()
				if (not FFA_END) then return end
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                FFA_END.cur_i = FFA_END.cur_i - 1
            end)
        end
    end)
end)

hook.Add("HUDPaint","FFA_END_SCREEN",function()
    if not FFA_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "FREE FOR ALL OVER!!!"
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

    for k,v in pairs(FFA_END.p) do
        if k < 4 then continue end
        if FFA_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. string.Comma(math.Round(v[2])) .. " Kills", "moat_FFALead" .. (32 - k), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
    
    if not FFA_END.p[3] then FFA_END.p[3] = {} end
    if FFA_END.cur_i < 4 and IsValid(FFA_END.p[3][1]) then
        if (not FFA_END.av[3]) then
            FFA_END.av[3] = vgui.Create("AvatarImage")
            FFA_END.av[3]:SetSize(128,128)
            FFA_END.av[3]:SetPlayer(FFA_END.p[3][1],128)
            FFA_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(FFA_END.p[3][1]:Nick() .. ": " .. string.Comma(math.Round(FFA_END.p[3][2])) .. " Kills", "moat_FFALead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not FFA_END.p[2] then FFA_END.p[2] = {} end
    if FFA_END.cur_i < 3 and IsValid(FFA_END.p[2][1]) then
        if (not FFA_END.av[2]) then
            FFA_END.av[2] = vgui.Create("AvatarImage")
            FFA_END.av[2]:SetSize(128,128)
            FFA_END.av[2]:SetPlayer(FFA_END.p[2][1],128)
            FFA_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(FFA_END.p[2][1]:Nick() .. ": " .. string.Comma(math.Round(FFA_END.p[2][2])) .. " Kills", "moat_FFALead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not FFA_END.p[1] then FFA_END.p[1] = {} end
    if FFA_END.cur_i < 2 and IsValid(FFA_END.p[1][1]) then
        if (not FFA_END.av[1]) then
            FFA_END.av[1] = vgui.Create("AvatarImage")
            FFA_END.av[1]:SetSize(128,128)
            FFA_END.av[1]:SetPlayer(FFA_END.p[1][1],128)
            FFA_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        draw.SimpleTextOutlined(FFA_END.p[1][1]:Nick() .. ": " .. string.Comma(math.Round(FFA_END.p[1][2])) .. " Kills", "moat_FFALead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end

end)

net.Receive("FFA_NewKills",function()
    if not MOAT_FFA then return end
    MOAT_FFA.TopKills = net.ReadInt(8)
    MOAT_FFA.red_cur = MOAT_FFA.TopKills
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

net.Receive("FFA_Kill",function()
    local p = net.ReadEntity()
    if MOAT_FFA and IsValid(LocalPlayer()) and p == LocalPlayer() then 
        MOAT_FFA.MyKills = MOAT_FFA.MyKills + 1 
        MOAT_FFA.blue_cur = MOAT_FFA.MyKills
    end
    local killer_team = net.ReadBool()
	local deadpl = net.ReadEntity()
    local dead_team = net.ReadBool()

	if (not IsValid(p) or not IsValid(deadpl)) then return end
	local killer = p:Nick()
    local dead = deadpl:Nick()
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
hook.Add("HUDPaint", "moat.test.FFA", function()
    if not istable(MOAT_FFA) then return end
    if FFA_END then return end
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

    local f = string.FormattedTime(MOAT_FFA.time_end - CurTime())
    if tostring(f.s):len() == 1 then 
        f.s =  "0" .. f.s 
    end

     surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(scrw - 300, 50, MOAT_FFA.bar_width, 25)
    surface.DrawRect(scrw + 75, 50, MOAT_FFA.bar_width, 25)


    if (MOAT_FFA.blue_cur ~= MOAT_FFA.blue_save) then
        surface.SetDrawColor(MOAT_FFA.tdm_blue.r, MOAT_FFA.tdm_blue.g, MOAT_FFA.tdm_blue.b, 75)
        surface.DrawRect(scrw - 302, 48, MOAT_FFA.bar_width + 4, 29)

        timer.Simple(FrameTime() * 10, function() if not istable(MOAT_FFA) then return end MOAT_FFA.blue_save = MOAT_FFA.blue_cur end)
    else
        surface.SetDrawColor(MOAT_FFA.tdm_blue.r, MOAT_FFA.tdm_blue.g, MOAT_FFA.tdm_blue.b, 50)
        surface.DrawRect(scrw - 300, 50, MOAT_FFA.bar_width, 25)
    end


    local blue_w = (MOAT_FFA.bar_width - 2) * (MOAT_FFA.blue_cur/MOAT_FFA.goal)
    surface.SetDrawColor(MOAT_FFA.tdm_blue.r, MOAT_FFA.tdm_blue.g, MOAT_FFA.tdm_blue.b, 150)
    surface.DrawRect(scrw - 75 - blue_w, 51, blue_w, 23)


    if (MOAT_FFA.red_cur ~= MOAT_FFA.red_save) then
        surface.SetDrawColor(MOAT_FFA.tdm_red.r, MOAT_FFA.tdm_red.g, MOAT_FFA.tdm_red.b, 75)
        surface.DrawRect(scrw + 73, 48, MOAT_FFA.bar_width + 4, 29)

        timer.Simple(FrameTime() * 10, function() if not istable(MOAT_FFA) then return end MOAT_FFA.red_save = MOAT_FFA.red_cur end)
    else
        surface.SetDrawColor(MOAT_FFA.tdm_red.r, MOAT_FFA.tdm_red.g, MOAT_FFA.tdm_red.b, 50)
        surface.DrawRect(scrw + 75, 50, MOAT_FFA.bar_width, 25)
    end

    local red_w = (MOAT_FFA.bar_width - 2) * (MOAT_FFA.red_cur/MOAT_FFA.goal)
    surface.SetDrawColor(MOAT_FFA.tdm_red.r, MOAT_FFA.tdm_red.g, MOAT_FFA.tdm_red.b, 150)
    surface.DrawRect(scrw + 76, 51, red_w, 23)


    
    DrawShadowedText(1, "Free For All | " .. MOAT_FFA.goal .. " to Win", "GModNotify", scrw, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    DrawShadowedText(1, f.m .. ":" .. f.s, "GModNotify", scrw, 89, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    DrawShadowedText(1, "Your kills: " .. MOAT_FFA.MyKills, "GModNotify", scrw - 81, 62, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    DrawShadowedText(1, "Top kills: " .. MOAT_FFA.TopKills, "GModNotify", scrw + 82, 62, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    local spawn_prot = LocalPlayer():GetNW2Int("MG_FFA_SPAWNPROTECTION")

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

net.Receive("FFA_Prep",function()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Each player will spawn with the same weapons!",
        "Each kill gets you closer to winning (" .. net.ReadInt(8) .. " kills needed to win)",
        "Only players that do the best get the good items!",
        ""
    }

    local primary = net.ReadString()
    _SEED = util.CRC(primary)
    local secondary = net.ReadString()

    hook.Add("HUDPaint", "MG_FFA_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_FFA_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2
        local y = ScrH() / 2

        draw.SimpleTextOutlined("FREE FOR ALL!!!", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

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

         local s = "You will be using "
        if primary:match("^a ") then
            s = "You will be using a "
        end
        surface.SetFont("moat_GunGameMedium")
        local sw,sh = surface.GetTextSize(s .. primary .. " as your primary weapon")
        local tw, _ = draw.SimpleTextOutlined(s, "moat_GunGameMedium", x - sw/2, y + (oi * 23), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        tww,_ = draw.SimpleTextOutlined(primary:gsub("^a ",""), "moat_GunGameMedium", x - sw/2 + tw, y + (oi * 23), Color( 255, 255, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined(" as your primary weapon", "moat_GunGameMedium", x - sw/2 + tw + tww, y + (oi * 23), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

        oi = oi + 1

        local s = "and you will be using "
        if secondary:match("^a ") then
            s = "and you will be using a "
        end
        surface.SetFont("moat_GunGameMedium")
        local sw,sh = surface.GetTextSize(s .. secondary .. " as your secondary weapon.")
        local tw, _ = draw.SimpleTextOutlined(s, "moat_GunGameMedium", x - sw/2, y + (oi * 23), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        tww,_ = draw.SimpleTextOutlined(secondary:gsub("^a ",""), "moat_GunGameMedium", x - sw/2 + tw, y + (oi * 23), Color( 255, 255, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined(" as your secondary weapon.", "moat_GunGameMedium", x - sw/2 + tw + tww, y + (oi * 23), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

    end)
end)