MOAT_EVENT = MOAT_EVENT or {}
MOAT_EVENT.CurCat = 1
MOAT_EVENT.EventPnl = nil
MOAT_EVENT.HoverPanel = nil
MOAT_EVENT.ChalColors = {
    Color(0, 0, 255),
    Color(255, 0, 255),
    Color(255, 0, 0),
    Color(255, 255, 0),
    Color(0, 255, 0)
}
MOAT_EVENT.TopPlayers = MOAT_EVENT.TopPlayers or {}
MOAT_EVENT.Challenges = {
    "Obtain {num} rightful kills as a terrorist with any {weapon} as the weapon of death.",
    "Obtain {num} headshot kills as a terrorist with any {weapon} as the weapon of death.",
    "Obtain {num} rightful kills as a terrorist with a Standard {weapon} as the weapon of death.",
    "Obtain {num} headshot kills as a terrorist with a Specialized {weapon} as the weapon of death.",
    "Obtain {num} rightful kills while crouched with any {weapon} as the weapon of death.",
    "Obtain {num} double kills as a terrorist with a High-End {weapon} as the weapon of death.",
    "Obtain {num} penta-killstreaks rightfully with a High-End {weapon} as the weapon of death.",
    "Obtain {num} rightful kills as a terrorist with any {weapon} as the weapon of death."
}

MOAT_EVENT.prefixes = {"Novice", "Amateur", "Apprentice", "Professional", "Master", "Expert", "Legend", "God"}

-- weapon ids
MOAT_EVENT.Weapons = {}
MOAT_EVENT.WeaponsID = {
	["weapon_zm_sledge"] = 1,
	["weapon_ttt_m590"] = 2,
	["weapon_zm_shotgun"] = 3,
	["weapon_zm_revolver"] = 4,
	["weapon_zm_mac10"] = 5,
	["weapon_xm8b"] = 6,
	["weapon_ttt_sg552"] = 7,
	["weapon_ttt_mp5"] = 8,
	["weapon_ttt_ump45"] = 9,
	["weapon_ttt_famas"] = 10,
	["weapon_spas12pvp"] = 11,
	["weapon_ttt_vss"] = 12,
	["weapon_ttt_p228"] = 13,
	["weapon_ttt_scorpion"] = 14,
	["weapon_ttt_aug"] = 15,
	["weapon_ttt_ak47"] = 16,
	["weapon_ttt_tmp"] = 17,
	["weapon_ttt_galil"] = 18,
	["weapon_ttt_mr96"] = 19,
	["weapon_ttt_m1014"] = 20,
	["weapon_zm_pistol"] = 21,
	["weapon_ttt_m16"] = 22,
	["weapon_ttt_dual_elites"] = 23,
	["weapon_doubleb"] = 24,
	["weapon_ttt_cz75"] = 25,
	["weapon_ttt_m03a3"] = 26,
	["weapon_ttt_msbs"] = 27,
	["weapon_ttt_shotgun"] = 28,
	["weapon_ttt_p90"] = 29,
	["weapon_ttt_mp5k"] = 30,
	["weapon_ttt_mac11"] = 31,
	["weapon_zm_rifle"] = 32,
	["weapon_ttt_peacekeeper"] = 33,
	["weapon_supershotty"] = 34,
	["weapon_thompson"] = 35,
	["weapon_flakgun"] = 36,
	["weapon_ttt_glock"] = 37,
	["weapon_ttt_te_sr25"] = 38,
	["weapon_ttt_te_1911"] = 39,
	["weapon_ttt_te_ak47"] = 40,
	["weapon_ttt_te_benelli"] = 41,
	["weapon_ttt_te_cf05"] = 42,
	["weapon_ttt_te_deagle"] = 43,
	["weapon_ttt_te_fal"] = 44,
	["weapon_ttt_te_famas"] = 45,
	["weapon_ttt_te_g36c"] = 46,
	["weapon_ttt_te_glock"] = 47,
	["weapon_ttt_te_m4a1"] = 48,
	["weapon_ttt_te_m9"] = 49,
	["weapon_ttt_te_m14"] = 50,
	["weapon_ttt_te_m24"] = 51,
	["weapon_ttt_te_mac"] = 52,
	["weapon_ttt_te_mp5"] = 53,
	["weapon_ttt_te_ots33"] = 54,
	["weapon_ttt_te_sako"] = 55,
	["weapon_ttt_te_sg550"] = 56,
	["weapon_ttt_te_sterling"] = 57,
	["weapon_ttt_te_vollmer"] = 58
}

for k, v in pairs(MOAT_EVENT.WeaponsID) do
	MOAT_EVENT.Weapons[v] = k
end

MOAT_EVENT.WeaponsChallenges = {
	["weapon_zm_sledge"] = {150, 75, 75, 50, 100, 25, 20, 300},
	["weapon_ttt_m590"] = {150, 75, 75, 50, 100, 25, 21, 400},
	["weapon_zm_shotgun"] = {150, 75, 75, 50, 100, 40, 25, 400},
	["weapon_zm_revolver"] = {100, 75, 65, 50, 75, 26, 20, 300},
	["weapon_zm_mac10"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_xm8b"] = {150, 125, 125, 100, 100, 35, 25, 500},
	["weapon_ttt_sg552"] = {150, 100, 75, 75, 100, 32, 20, 450},
	["weapon_ttt_mp5"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_ump45"] = {200, 125, 125, 100, 125, 38, 27, 500},
	["weapon_ttt_famas"] = {150, 125, 125, 100, 115, 33, 23, 450},
	["weapon_spas12pvp"] = {150, 75, 75, 50, 100, 35, 20, 500},
	["weapon_ttt_vss"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_p228"] = {100, 50, 50, 50, 75, 27, 14, 300},
	["weapon_ttt_scorpion"] = {200, 125, 100, 75, 125, 32, 26, 500},
	["weapon_ttt_aug"] = {150, 100, 75, 75, 100, 25, 18, 400},
	["weapon_ttt_ak47"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_tmp"] = {150, 75, 75, 75, 100, 32, 17, 350},
	["weapon_ttt_galil"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_mr96"] = {150, 100, 75, 50, 100, 30, 20, 350},
	["weapon_ttt_m1014"] = {150, 75, 75, 50, 100, 28, 25, 400},
	["weapon_zm_pistol"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_m16"] = {200, 150, 150, 100, 125, 35, 25, 500},
	["weapon_ttt_dual_elites"] = {100, 50, 75, 50, 75, 25, 14, 300},
	["weapon_doubleb"] = {100, 50, 75, 50, 100, 20, 11, 300},
	["weapon_ttt_cz75"] = {100, 75, 75, 75, 100, 30, 20, 350},
	["weapon_ttt_m03a3"] = {150, 75, 75, 75, 100, 23, 18, 400},
	["weapon_ttt_msbs"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_shotgun"] = {150, 75, 75, 50, 100, 35, 22, 500},
	["weapon_ttt_p90"] = {200, 100, 100, 75, 125, 35, 23, 500},
	["weapon_ttt_mp5k"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_mac11"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_zm_rifle"] = {100, 65, 50, 50, 75, 20, 12, 300},
	["weapon_ttt_peacekeeper"] = {200, 150, 150, 125, 120, 35, 24, 500},
	["weapon_supershotty"] = {150, 75, 75, 50, 100, 35, 21, 500},
	["weapon_thompson"] = {200, 100, 100, 100, 125, 35, 23, 500},
	["weapon_flakgun"] = {100, 50, 50, 50, 75, 23, 12, 300},
	["weapon_ttt_glock"] = {100, 75, 75, 75, 100, 30, 18, 350},
	["weapon_ttt_te_sr25"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_te_1911"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_ak47"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_te_benelli"] = {150, 75, 75, 50, 100, 40, 25, 400},
	["weapon_ttt_te_cf05"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_te_deagle"] = {100, 75, 65, 50, 75, 26, 20, 300},
	["weapon_ttt_te_fal"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_te_famas"] = {150, 125, 125, 100, 115, 33, 23, 450},
	["weapon_ttt_te_g36c"] = {200, 150, 150, 100, 125, 35, 25, 500},
	["weapon_ttt_te_glock"] = {100, 75, 75, 75, 100, 30, 18, 350},
	["weapon_ttt_te_m4a1"] = {200, 150, 150, 125, 125, 40, 27, 500},
	["weapon_ttt_te_m9"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_m14"] = {150, 75, 75, 75, 100, 25, 20, 400},
	["weapon_ttt_te_m24"] = {100, 65, 50, 50, 75, 20, 12, 300},
	["weapon_ttt_te_mac"] = {200, 125, 100, 75, 125, 34, 24, 500},
	["weapon_ttt_te_mp5"] = {200, 100, 125, 100, 125, 35, 23, 500},
	["weapon_ttt_te_ots33"] = {100, 50, 75, 50, 75, 24, 13, 300},
	["weapon_ttt_te_sako"] = {200, 150, 150, 125, 125, 35, 25, 500},
	["weapon_ttt_te_sg550"] = {100, 65, 50, 50, 100, 23, 16, 400},
	["weapon_ttt_te_sterling"] = {150, 75, 75, 75, 100, 32, 17, 350},
	["weapon_ttt_te_vollmer"] = {150, 75, 75, 50, 100, 25, 20, 300}
}

function MOAT_EVENT.ReceiveChallenges()
    if (not MOAT_EVENT.CurChallenges) then
        MOAT_EVENT.CurChallenges = {}
    end

    local wep_id = net.ReadUInt(6)
    MOAT_EVENT.CurChallenges[wep_id] = {}

    for i = 1, 7 do
        MOAT_EVENT.CurChallenges[wep_id][i] = net.ReadUInt(8)
    end

    MOAT_EVENT.CurChallenges[wep_id][8] = net.ReadUInt(10)
end

net.Receive("moat.events.send", MOAT_EVENT.ReceiveChallenges)

function MOAT_EVENT.UpdateChallenges()
    local wep_id = net.ReadUInt(6)
    local num = net.ReadUInt(4)
    
    MOAT_EVENT.CurChallenges[wep_id][num] = net.ReadUInt(10)
end

net.Receive("moat.events.update", MOAT_EVENT.UpdateChallenges)

function MOAT_EVENT.ChallengeComplete()
    local wep = net.ReadUInt(6)
    local id = net.ReadUInt(4)
    local wpn = weapons.Get(MOAT_EVENT.Weapons[wep])

    local wpn_str = wpn.PrintName or wpn:GetPrintName()

    if (wpn_str:EndsWith("_name")) then
        wpn_str = string.sub(wpn_str, 1, wpn_str:len() - 5)
        wpn_str = string.upper(string.sub(wpn_str, 1, 1)) .. string.sub(wpn_str, 2, wpn_str:len())
    end

    chat.AddText(Material("icon16/medal_gold_3.png"), Color(255, 0, 0), "Event ", Color(0, 255, 255), "| ", Color(255, 255, 0), wpn_str .. " " .. MOAT_EVENT.prefixes[id] .. " objective completed!")

	cdn.PlayURL "https://static.moat.gg/ttt/levelup.wav"
end

net.Receive("moat.events.complete", MOAT_EVENT.ChallengeComplete)

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
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

local function ccfn(num)
    if (num == 8) then num = 9 end
    if (num == 6) then num = 5 end
    if (num == 7) then num = 6 end

    return rarity_names[num][2]:Copy()
end

local function ccfname(num)
    if (num == 8) then num = 9 end
    if (num == 6) then num = 5 end
    if (num == 7) then num = 6 end

    return rarity_names[num][1]
end

local circ_gradient = Material("moat_inv/moat_circle_grad.png")
local grad_down = Material("vgui/gradient-d")
local mat_lock = Material("icon16/lock.png")
local grad_right = Material("vgui/gradient-l")

local wpn_tbl = {}

local function crtt(pnl, wpn, num)
    local th, tw = 125, 300
    local msx, msy = gui.MousePos()

    local wpn_str = wpn.PrintName or wpn:GetPrintName()

    if (wpn_str:EndsWith("_name")) then
        wpn_str = string.sub(wpn_str, 1, wpn_str:len() - 5)
        wpn_str = string.upper(string.sub(wpn_str, 1, 1)) .. string.sub(wpn_str, 2, wpn_str:len())
    end

    local amt = MOAT_EVENT.WeaponsChallenges[wpn.ClassName][num]

    if (IsValid(MOAT_EVENT.HoverPanel)) then
        MOAT_EVENT.HoverPanel:Remove()
        MOAT_EVENT.HoverPanel = nil
    end

    local t = vgui.Create("DPanel")
    t:SetPos(msx, msy - th)
    t:SetSize(tw, th)
    t:SetDrawOnTop(true)
    t.Think = function(s)
        local msx, msy = gui.MousePos()
        s:SetPos(msx, msy - th)

        if (not IsValid(pnl)) then
            s:Remove()
            return
        end
    end
    t:SetAlpha(0)

    t.Paint = function(s, w, h)
		surface.SetFont("moat_ChatFont")
		local amt_length = surface.GetTextSize("/" .. amt)

        DrawBlur(s, 5)

        surface.SetDrawColor(0, 0, 0, 50)
        surface.DrawRect(0, 0, w, h)
        surface.DrawRect(1, 1, w-2, h-2)

        local col = ccfn(num)

        surface.SetDrawColor(col.r, col.g, col.b, 50)
        surface.DrawRect(0, 0, w, 21)

        draw.DrawText(wpn_str .. " " .. MOAT_EVENT.prefixes[num], "moat_ChatFont", 6, 2, Color(255, 255, 255, 255))

        --[[-------------------------------------------------------------------------
        Progress
        ---------------------------------------------------------------------------]]

        draw.DrawText("Reward", "moat_ChatFont", 5, h - 45, Color(255, 255, 255, 255))
        draw.DrawText(ccfname(num) .. " " .. wpn_str, "moat_ChatFont", w - 5, h - 45, col, TEXT_ALIGN_RIGHT)

        draw.DrawText("Progress", "moat_ChatFont", 5, h - 30, Color(255, 255, 255, 255))

        if (num ~= 1 and MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num - 1] < MOAT_EVENT.WeaponsChallenges[wpn.ClassName][num - 1]) then
            draw.DrawText("Locked", "moat_ChatFont", w - 5, h - 30, Color(255, 0, 0, 255), TEXT_ALIGN_RIGHT)

            surface.SetDrawColor(255, 0, 0, 50)
            surface.DrawRect(5, h - 13, w - 10, 8)
        else
            draw.DrawText(MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num], "moat_ChatFont", w - 9 - amt_length, h - 30, Color(0, 255, 0, 255), TEXT_ALIGN_RIGHT)
            draw.DrawText("/" .. amt, "moat_ChatFont", w - 5, h - 30, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)

            surface.SetDrawColor(0, 255, 0, 50)
            surface.DrawRect(5, h - 13, w - 10, 8)
        end

        surface.SetDrawColor(0, 255, 0, 150)
        surface.DrawRect(5, h - 13, (w - 10) * (MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num]/amt), 8)

        surface.SetDrawColor(0, 25, 0, 200)
        surface.SetMaterial(grad_right)
        surface.DrawTexturedRect(5, h - 13, (w - 10) * (MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num]/amt), 8)
    end

    local chal_num = MOAT_EVENT.WeaponsChallenges[wpn.ClassName][num] // MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num]

    local d = vgui.Create("DLabel", t)
    d:SetText(MOAT_EVENT.Challenges[num]:Replace("{weapon}", wpn_str):Replace("{num}", chal_num))
    d:SetSize(tw, th)
    d:SetPos(5, 24)
    d:SetFont("moat_ChatFont")
    d:SetWrap(true)
    d:SetAutoStretchVertical(true)

    timer.Simple(0.01, function() if (t:IsValid()) then t:SetAlpha(255) end end)
    pnl.MoatTooltip = t
    MOAT_EVENT.HoverPanel = t
end

local function addpnl(wpn, num, pnl)
    local bg = pnl:Add("DPanel")
    bg:SetSize(68, 68)
    bg.Paint = function(s, w, h)
        local col, col_mod = ccfn(num)

        surface.SetDrawColor(100, 100, 100, 255)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(col.r, col.g, col.b, 100)
        surface.SetMaterial(grad_down)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)

        surface.SetDrawColor(col.r, col.g, col.b, 255)
        surface.DrawOutlinedRect(0, 0, w, h)

        if (s.Hovered) then
            surface.SetDrawColor(col.r, col.g, col.b, 150)
            surface.DrawOutlinedRect(2, 2, w-4, h-4)
        end
    end

    local i = vgui.Create("MoatModelIcon", bg)
    i:SetPos(2, 2)
    i:SetSize(64, 64)
    i:SetModel(wpn.WorldModel)
    i:SetTooltip(nil)

    local btn = vgui.Create("DPanel", bg)
    btn:SetSize(68, 68)
    btn:SetText ""
    btn.Paint = function(s, w, h)
        if (num ~= 1 and MOAT_EVENT.CurChallenges[MOAT_EVENT.WeaponsID[wpn.ClassName]][num - 1] < MOAT_EVENT.WeaponsChallenges[wpn.ClassName][num - 1]) then
            surface.SetDrawColor(0, 0, 0, 250)
            surface.DrawRect(0, 0, w, h)

            surface.SetMaterial(mat_lock)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(26, 26, 16, 16)
        end
    end
    btn.Think = function(s)
        if (s.Hovered and not s.MoatTooltip) then
            crtt(s, wpn, num)
        elseif (s.MoatTooltip and not s.Hovered) then
            s.MoatTooltip:Remove()
            s.MoatTooltip = nil
        end

        bg.Hovered = s.Hovered

        if (s.Hovered) then
            s:SetCursor("hand")
        end
    end
	sfx.HoverSound(btn)
	sfx.ClickSound(btn)
    btn.DoClick = function() end
end

local function addrow(wpn, pnl, last)
    for i = 1, 8 do
        addpnl(wpn, i, pnl)
    end

    if (last) then
        local sp = pnl:Add("DPanel")
        sp:SetSize(pnl:GetWide(), 1)
        sp.Paint = nil
    end
end

function MOAT_EVENT.ObjectivePanel(pnl)
    if (not MOAT_EVENT.CurChallenges) then
        pnl.Paint = function(s, w, h)
            draw.SimpleTextOutlined("Error Loading Objectives", "GModNotify", w/2, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
            draw.SimpleTextOutlined("Please reconnect or RTV for a map change.", "moat_ItemDesc", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        end

        return
    end

	pnl.Paint = function(s, w, h)
        draw.SimpleTextOutlined("Weapon Objective List", "GModNotify", w/2, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        draw.SimpleTextOutlined("Track weapon objective progress and determine which objective you'd like to complete next.", "moat_ItemDesc", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
	end

    local spnl = vgui.Create("DScrollPanel", pnl)
    spnl:SetSize(pnl:GetWide(), pnl:GetTall() - 50)
    spnl:SetPos(0, 50)

    local sbar = spnl:GetVBar()
    m_PaintVBar(sbar)

    local o = vgui.Create("DIconLayout", spnl)
    o:SetPos(4, 4)
    o:SetSize(spnl:GetWide() - 8, spnl:GetTall() - 8)
    o:SetSpaceX(2.7)
    o:SetSpaceY(2.7)

    local weps = MOAT_EVENT.Weapons
    wpn_tbl = {}

    for i = 1, #weps do
        --if (weps[i].AutoSpawnable and (weps[i].Kind == WEAPON_HEAVY or weps[i].Kind == WEAPON_PISTOL)) then

            table.insert(wpn_tbl, weapons.Get(weps[i]))
        --end
    end

    local num_weps = #wpn_tbl

	o.LoadingSlot = 0
	o.Think = function(s)
		if (s.LoadingSlot < num_weps) then
			s.LoadingSlot = s.LoadingSlot + 1
			addrow(wpn_tbl[s.LoadingSlot], o, s.LoadingSlot == num_weps)
		end
	end
end

function MOAT_EVENT.ReceiveTop()
    if (not MOAT_EVENT.TopPlayers) then
        MOAT_EVENT.TopPlayers = {}
    end

	local num = net.ReadUInt(7)
	for i = 1, num do
		local steamid = net.ReadString()
		local name = net.ReadString()
		local complete = net.ReadUInt(16)

		MOAT_EVENT.TopPlayers[i] = {steamid, name, complete}
	end

	if (m_RebuildEventPanel and MOAT_EVENT.CurCat == 2) then
		m_RebuildEventPanel(MOAT_EVENT.CurCat)
	end
end
net.Receive("moat.events.top", MOAT_EVENT.ReceiveTop)

function MOAT_EVENT.OverviewPanel(pnl)
	if (not MOAT_EVENT.TopPlayers) then return end

	pnl.Paint = function(s, w, h)
        draw.SimpleTextOutlined("Event Overview", "GModNotify", w/2, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        draw.SimpleTextOutlined("Complete objectives for weapons to advance to harder challenges for better rewards.", "moat_ItemDesc", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        draw.SimpleTextOutlined("You may start with whichever gun you choose!", "moat_ItemDesc", w/2, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
	
        draw.SimpleTextOutlined("Top 50 Players", "GModNotify", w/2, 90, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        draw.SimpleTextOutlined("Objectives Complete", "moat_ItemDesc", w - 4, 99, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        draw.SimpleTextOutlined("Player", "moat_ItemDesc", 5, 99, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
    end

	if (#MOAT_EVENT.TopPlayers < 50 and not MOAT_EVENT.RequestedTop) then
		MOAT_EVENT.RequestedTop = true

		net.Start "moat.events.top"
		net.SendToServer()
	end

    local btn_y = 108
    local amt = math.min(#MOAT_EVENT.TopPlayers, 50)

    local TopPlayers = vgui.Create("DScrollPanel", pnl)
    TopPlayers:SetSize(pnl:GetWide(), 405)
    TopPlayers:SetPos(0, btn_y)
	TopPlayers.Paint = function(s, w, h) end
	m_PaintVBar(TopPlayers:GetVBar())
	btn_y = 0

    for i = 1, amt do
        local btn_w, btn_h, btn_x, btn__y = pnl:GetWide() - 8, 25, 4, btn_y

        local btn = vgui.Create("DButton", TopPlayers)
        btn:SetPos(btn_x, btn__y)
        btn:SetSize(btn_w, btn_h)
        btn:SetText("")
        btn.Paint = function(s, w, h)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)

			if (s:IsHovered()) then
				s.Hovered = true
			elseif (IsValid(btn.avatar) and not btn.avatar:IsHovered()) then
				s.Hovered = false
			end

            if (s.Hovered) then
                surface.SetDrawColor(255, 255, 255, 5)
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(180, 180, 0, 100)
                surface.DrawOutlinedRect(0, 0, w, h)

                s:SetSize(btn_w + 2, btn_h + 2)
                s:SetPos(btn_x - 1, btn__y - 1)

                if (IsValid(btn.avatar)) then
                    btn.avatar:SetPos(1, 1)
                    btn.avatar:SetSize(25, 25)
                end
            else
                s:SetSize(btn_w, btn_h)
                s:SetPos(btn_x, btn__y)

                if (IsValid(btn.avatar)) then
                    btn.avatar:SetPos(1, 1)
                    btn.avatar:SetSize(23, 23)
                end
            end

            draw.SimpleTextOutlined(MOAT_EVENT.TopPlayers[i][2], "moat_ItemDesc", 25 + 8, (h/2) - 1, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
            draw.SimpleTextOutlined(MOAT_EVENT.TopPlayers[i][3], "moat_ItemDesc", w - 8 - 13, (h/2) - 1, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 25 ))
        end
		sfx.HoverSound(btn)
		sfx.ClickSound(btn)
        btn.DoClick = function()
            gui.OpenURL("https://moat.gg/profile/" .. MOAT_EVENT.TopPlayers[i][1])
        end

        local ava = vgui.Create("AvatarImage", btn)
        ava:SetPos(1, 1)
        ava:SetSize(23, 23)
        ava:SetSteamID(MOAT_EVENT.TopPlayers[i][1], 32)
		ava.OnMousePressed = btn.DoClick
		ava:SetCursor "hand"
		ava.Think = function(s)
			if (s:IsHovered() and IsValid(btn)) then
				btn.Hovered = true
			elseif (IsValid(btn) and not btn:IsHovered()) then
				btn.Hovered = false
			end
		end
        btn.avatar = ava

        btn_y = btn_y + 27
    end
end
/*
function MOAT_EVENT.GroupPanel(pnl)
	pnl.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Group", "Trebuchet24", 15, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))
	end
end

function MOAT_EVENT.InvitePanel(pnl)
	pnl.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Invites", "Trebuchet24", 15, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))
	end
end

function MOAT_EVENT.ManagePanel(pnl)
	pnl.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Manage", "Trebuchet24", 15, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))
	end
end*/

local event_rules = {
	"So you want to participate in the event, huh? Well so does everyone else! To make sure",
	"every player has a goodie ol' time, we ask that you follow these simple rules friend. If you",
	"don't follow them, good luck participating in the event while you're on a ban vacation!",
	"",
	"",
	" - Please do not meta-game with other people to complete challenges.",
	"   - Even if you are the only people in a server, you may not help each other.",
	" - Don't kill someone in-game because you think they completed a challenge.",
	" - Do not try to exploit a glitch in order to complete a challenge or gain something.",
	" - Once an event is over, you may not continue.",
	"",
	"",
	"That's all! Not bad right? Now have fun participating in the event! We love you!",
	" - Moat Trust & Safety Team"
}

function MOAT_EVENT.RulesPanel(pnl)
	pnl.Paint = function(s, w, h)
		-- cdn.DrawImage("https://static.moat.gg/f/qlCyJTXSLfxArPZsI4Ee9q8caI21.png", w/2 - 80, 40, 180, 44.44)
		cdn.DrawImage("https://ttt.dev/4uKQJ.png", (w / 2) - (235 / 2), 30, 256, 256, Color(255, 255, 255, 225))

		draw.SimpleTextOutlined("Moat Official Event Rules", "Trebuchet24", w/2, 20, moat_lyanblue, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

		for i = 1, #event_rules do
			draw.SimpleText(event_rules[i], "moat_ItemDesc", 10, 165 + ((i - 1) * 15), Color(255, 255, 255))
		end
	end
end

MOAT_EVENT.Tabs = {
	{"Objectives", MOAT_EVENT.ObjectivePanel},
	{"Overview", MOAT_EVENT.OverviewPanel},
	--{"Group", MOAT_EVENT.GroupPanel},
	--{"Invites", MOAT_EVENT.InvitePanel},
	--{"Manage", MOAT_EVENT.ManagePanel},
	{"Rules", MOAT_EVENT.RulesPanel}
}

local function m_BuildEventPanel(pnl, num)
	MOAT_EVENT.Tabs[num][2](pnl)
end

local gradient_l = Material("vgui/gradient-l")
function m_PopulateEventPanel(pnl)
    pnl.Paint = function(s, w, h)
        draw.RoundedBox(0, 155, 0, w-155, h, Color(0, 0, 0, 150))
    end

	function m_RebuildEventPanel(num)
        if (IsValid(MOAT_EVENT.EventPnl)) then
            MOAT_EVENT.EventPnl:Remove()
        end

        local setpnl = vgui.Create("DScrollPanel", pnl)
        setpnl:SetPos(155, 0)
        setpnl:SetSize(pnl:GetWide()-155, pnl:GetTall())

        m_BuildEventPanel(setpnl, num)

        MOAT_EVENT.EventPnl = setpnl
    end

    for i = 1, #MOAT_EVENT.Tabs do
        local caty = (35 * (i-1))

        local cat_btn = vgui.Create("DButton", pnl)
        cat_btn:SetPos(0, caty)
        cat_btn:SetSize(155, 30)
        cat_btn:SetText("")
        cat_btn.HoveredWidth = 0
        cat_btn.Paint = function(s, w, h)
            local col = HSVToColor( i * 55 % 360, 1, 1 )

            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(gradient_l)
            surface.DrawTexturedRect(0, 0, (w-5) * s.HoveredWidth, h)

            surface.DrawTexturedRect(0, 0, (w-5) * s.HoveredWidth, 2)
            surface.DrawTexturedRect(0, h-2, (w-5) * s.HoveredWidth, 2)

            if (MOAT_EVENT.CurCat ~= i) then w = 150 end
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
            draw.SimpleTextOutlined(MOAT_EVENT.Tabs[i][1], "Trebuchet24", 10+(s.HoveredWidth*4), h/2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

            if (MOAT_EVENT.CurCat == i) then
                draw.RoundedBox(0, 0, 0, 4, h, HSVToColor( i * 55 % 360, 1, 1 ))
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(gradient_l)
                surface.DrawTexturedRect(0, 0, (w-5) * 1, h)

                surface.DrawTexturedRect(0, 0, (w-5) * 1, 2)
                surface.DrawTexturedRect(0, h-2, (w-5) * 1, 2)
            elseif (s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 1)
            elseif (not s:IsHovered()) then
                s.HoveredWidth = Lerp(10 * FrameTime(), s.HoveredWidth, 0)
            end
            draw.RoundedBox(0, 0, 0, 4 * s.HoveredWidth, h, HSVToColor( i * 55 % 360, 1, 1 ))
        end
		sfx.HoverSound(cat_btn, sfx.Click2)
		sfx.ClickSound(cat_btn)
        cat_btn.DoClick = function(s)
            MOAT_EVENT.CurCat = i
            m_RebuildEventPanel(MOAT_EVENT.CurCat)
        end
    end

    m_RebuildEventPanel(MOAT_EVENT.CurCat)
end