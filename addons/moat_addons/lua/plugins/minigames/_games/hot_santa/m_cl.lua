

local kills = {}

net.Receive("HS_Begin",function()
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Hot Santa")
    MOAT_HS = {
        nextdie = CurTime() + 20
    }

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/FFASsong.mp3", 0.5, function(station)
		hook.Add("Think","HS Music",function()
            if not MOAT_HS then station:Stop() hook.Remove("Think","HS Music") end
        end)
	end)
	
    kills = {}
end)

net.Receive("HS_Time",function()
    (MOAT_HS or {}).nextdie = net.ReadInt(32) - (LocalPlayer():Ping()/1000)
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

for i = 1, 25 do
    surface.CreateFont("moat_HSLead" .. i, {
    font = "DermaLarge",
    size = 20 + i,
    weight = 800,
    italic = true
})
end


net.Receive("HS_End",function()
    for k,v in pairs(player.GetAll()) do
        v.NoTarget = false
    end
    local players = net.ReadTable()
    local red = net.ReadBool()
    SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/forsen_end.mp3", 0.5)
    MOAT_HS = nil
    kills = {}
    HS_END = {}
    timer.Create("HS END TIMER",21,1,function()
        for k,v in pairs(HS_END.av) do
            v:Remove()
        end
        HS_END = nil
    end)
    HS_END.w = red
    HS_END.p = players
    HS_END.av = {}
    HS_END.cur_i = #HS_END.p + 1
    table.sort(HS_END.p, function(a,b)
        return a[2] < b[2]
    end)

    timer.Simple(1,function()
        for i = 1, #HS_END.p - 3 do
            timer.Simple(0.2 * i,function()
                sound.Play(Sound("buttons/blip1.wav"),LocalPlayer():EyePos(),150,100 + (i * 2.5),1)
                HS_END.cur_i = HS_END.cur_i - 1
            end)
        end

        for i =1, 3 do
            timer.Simple((0.2 * ((#HS_END.p - 3) + 0.5 ) + (i * 0.7)),function()
                sound.Play(Sound("weapons/357_fire2.wav"),LocalPlayer():EyePos(),150,100 + ((i) * 5),1)
                HS_END.cur_i = HS_END.cur_i - 1
            end)
        end
    end)
end)

local function place(n)
    n = tostring(n)
    if n:match("^1$") then
        return "st"
    end
    if n:match("^1") then
        return "th"
    end
    if n:match("2$") then
        return "nd"
    end
    if n:match("3$") then
        return "rd"
    end
    return "th"
end

hook.Add("HUDPaint","HS_END_SCREEN",function()
    if not HS_END then return end

    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	DrawBlurScreen(5)
    local text = "SECRET SANTA TAG IS OVER!!"
    local textc = Color(255,0,0)
    local textc2 = Color(0,0,50)

    surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))

    surface.SetFont("moat_BossInfo")
    local txt = "Top Place"
    local col = Color(255, 255, 255)

    local textw, texth = surface.GetTextSize(txt)
    m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    for k,v in pairs(HS_END.p) do
        if k < 4 then continue end
        if HS_END.cur_i > k then continue end
        if not IsValid(v[1]) then continue end
        draw.SimpleTextOutlined(v[1]:Nick() .. ": " .. math.Round(v[2]) .. place(v[2]) ..  " Place", "moat_HSLead" .. (24 - k), ScrW() * 0.5, 300 + (k * 35) , Color( 255, 255, 255, 255 - (k * 7.5) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
    end
    
    if not HS_END.p[3] then HS_END.p[3] = {} end
    if HS_END.cur_i < 4 and IsValid(HS_END.p[3][1]) then
        if (not HS_END.av[3]) then
            HS_END.av[3] = vgui.Create("AvatarImage")
            HS_END.av[3]:SetSize(128,128)
            HS_END.av[3]:SetPlayer(HS_END.p[3][1],128)
            HS_END.av[3]:SetPos(ScrW() * 0.25 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(HS_END.p[3][1]:Nick() .. ": " .. math.Round(HS_END.p[3][2]) .. place(HS_END.p[3][2]) .. " Place", "moat_HSLead7", ScrW() * 0.25, 395 , Color( 164,102,40, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not HS_END.p[2] then HS_END.p[2] = {} end
    if HS_END.cur_i < 3 and IsValid(HS_END.p[2][1]) then
        if (not HS_END.av[2]) then
            HS_END.av[2] = vgui.Create("AvatarImage")
            HS_END.av[2]:SetSize(128,128)
            HS_END.av[2]:SetPlayer(HS_END.p[2][1],128)
            HS_END.av[2]:SetPos(ScrW() * 0.75 - 64,300 - 64)
        end
        draw.SimpleTextOutlined(HS_END.p[2][1]:Nick() .. ": " .. math.Round(HS_END.p[2][2]) .. place(HS_END.p[2][2]) .. " Place", "moat_HSLead7", ScrW() * 0.75, 395 , Color( 200,200,200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end
    
    if not HS_END.p[1] then HS_END.p[1] = {} end
    if HS_END.cur_i < 2 and IsValid(HS_END.p[1][1]) then
        if (not HS_END.av[1]) then
            HS_END.av[1] = vgui.Create("AvatarImage")
            HS_END.av[1]:SetSize(128,128)
            HS_END.av[1]:SetPlayer(HS_END.p[1][1],128)
            HS_END.av[1]:SetPos(ScrW() * 0.5 - 64,300 - 74)
        end
        draw.SimpleTextOutlined(HS_END.p[1][1]:Nick() .. ": " .. math.Round(HS_END.p[1][2]) .. place(HS_END.p[1][2]) .. " Place", "moat_HSLead17", ScrW() * 0.5, 395 , Color( 205,166,50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 200))
    end

end)

local gradient_d = Material("vgui/gradient-d")


local dead = 0
local dead_oc = false

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

hook.Add("HUDPaint", "moat.test.HS", function()
    if not MOAT_HS then return end
    draw.SimpleTextOutlined("Secret Santa dying in " .. math.Round( MOAT_HS.nextdie - CurTime() ) .. " seconds!","moat_GunGameMedium", ScrW()/2,(ScrH() * 0.5) - 50, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 100))
    local a = 0
    for k,v in ipairs(player.GetAll()) do if v:Alive() then a = a + 1 end end
    draw.SimpleTextOutlined("Players left: " .. a,"moat_GunGameMedium", ScrW()/2, 100, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0,100))
    if IsValid(LocalPlayer():GetActiveWeapon()) then
        if LocalPlayer():GetActiveWeapon():GetClass() == "snowball_hs" then
            draw.SimpleTextOutlined("YOU ARE THE SECRET SANTA! THROW YOUR SNOWBALL INTO SOMEONE OR DIE.", "moat_GunGameMedium", ScrW()/2, ScrH() * 0.6, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 100))
        end
    end
end)

net.Receive("HS_Prep",function()
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

    local desc = {
        "Someone random will receive a snowball after this countdown",
        "Every 15 seconds the player holding the snowball will die",
        "And someone else will be randomly picked." ,
        "Throwing your snowball at someone will make them have to hold it",
        "Last person alive gets the best items!"
    }

    hook.Add("HUDPaint", "MG_HS_PREPPAINT", function()
        if (GetRoundState() ~= ROUND_PREP) then
            hook.Remove("HUDPaint", "MG_HS_PREPPAINT")
            return
        end

        --MG_OC.DrawBlurScreen(5)

        local x = ScrW() / 2    
        local y = ScrH() / 2

        draw.SimpleTextOutlined("SECRET SANTA TAG", "moat_GunGameLarge", x, y - 70, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

        local time = math.ceil(GetGlobal("ttt_round_end") - CurTime())

        if (time < 1) then
            time = "BEGIN"
        end

        draw.SimpleTextOutlined(time, "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
        local oi = 1
        for i = 1, #desc do
            local c = Color(255,255,255,255)
            if desc[i]:match("Last person") then c = Color(255,255,0,255) end
            draw.SimpleTextOutlined(desc[i], "moat_GunGameMedium", x, y + (i * 23), c, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
            oi = i + 1
        end

    end)
end)