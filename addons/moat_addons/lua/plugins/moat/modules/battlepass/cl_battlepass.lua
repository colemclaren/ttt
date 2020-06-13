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
MOAT_BP = MOAT_BP or {
    tiers = {},
    current_tier = 0,
    xp = 0,
    Examples = {}
}
-- MOAT_BP.current_tier = 0
-- MOAT_BP.xp = 0
MOAT_BP.Hovered = false
local function xp_needed(lvl)
    local mult = math.max(0, lvl - 20)

    return mult * 175 + 1250
end

net.Receive("BP.StatUpdate",function()
    MOAT_BP.current_tier = net.ReadInt(16)
    MOAT_BP.xp = net.ReadInt(32)
end)

local mat = Material("icon16/medal_gold_3.png")
local mat2 = Material("icon16/information.png")
net.Receive("BP.Chat",function()
    local b = net.ReadBool()
    local tier = net.ReadInt(32)
    if b then
        -- TD: make better messages
        chat.AddText(mat,Color(255,255,255),"[Summer ",Color(0,255,255),"Climb",Color(255,255,255),"] You just unlocked tier ",Color(255,0,0),tostring(tier),Color(255,255,255)," and earned ",rarity_names[MOAT_BP.tiers[tier].rarity][2]:Copy(),MOAT_BP.tiers[tier].name,Color(255,255,255),"!")
    else
        chat.AddText(mat2,Color(255,255,255),"[Summer ",Color(0,255,255),"Climb",Color(255,255,255),"] You've gained XP towards your next Summer Climb tier! (",Color(0,255,255),tostring(net.ReadInt(32)),Color(255,255,255),"/",tostring(xp_needed(tier + 1)),")!")
    end
end)

local droppable_cache_count, droppable_cache = 0, {}
local function GetDroppableWeapons()
    if (droppable_cache[1]) then return droppable_cache, droppable_cache_count end

    for k, v in ipairs(weapons.GetList()) do
        if (v.AutoSpawnable and v.Base == "weapon_tttbase") then
            droppable_cache_count = droppable_cache_count + 1

            droppable_cache[droppable_cache_count] = {
                ClassName = v.ClassName,
                WeaponTable = weapons.Get(v.ClassName)
            }
        end
    end

    return droppable_cache, droppable_cache_count
end
local crates = {
    "https://static.moat.gg/f/2uz9PPFhaYcHQYy31r6JycNg9KMP.png",
    "https://static.moat.gg/f/SmrFpqNJJXbfArfUzFfyo3JLAul9.png",
    "https://static.moat.gg/f/iTt6ooG8RtbHjnkyC8Q4jABhv2WS.png",
    "https://static.moat.gg/f/Po473i0jlwewqan8JfV6Rn38ErxM.png",
    "https://static.moat.gg/f/h84hIxkywtI3EoZvWXRz76DRgkWe.png",
    "https://static.moat.gg/f/NJGw8ZNeDfESPnIDvdewX1eGFTP0.png",
    "https://static.moat.gg/f/AHlVbE8xBe1bFYTmtsd6A0XmretE.png",
    "https://static.moat.gg/f/mMpashogkwi43rDH2fCNyk5UfjAZ.png",
    "https://static.moat.gg/f/QsvbPr7sgwoHKQVbuq4PXSYLWkMd.png",
    "https://static.moat.gg/f/djAqvEhuNLBVDUR2oFDRq7D92gDS.png",
    "https://static.moat.gg/f/VRfIdxR5Or4GYC3ULukcdwdx0SvT.png",
    "https://static.moat.gg/f/3043b.png",
    "https://static.moat.gg/f/vc0YQ6pW2e7ifimTXGHEf1yMxqLp.png",
}
function make_randompanel(model,ITEM_BG)
    local m_WClass = {} 
    if weapons.Get(model) then
        m_WClass = weapons.Get(model)
    elseif (model == "tier") then
        m_WClass = table.Random(GetDroppableWeapons()).WeaponTable
    elseif (model == "crates") then
        m_WClass.WorldModel = table.Random(crates)
    else
        m_WClass.WorldModel = model
    end
    

    local m_DPanelIcon = {}
    m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", ITEM_BG)
    m_DPanelIcon.SIcon:SetPos(397, 6)
    m_DPanelIcon.SIcon:SetSize(48, 48)
    m_DPanelIcon.SIcon:SetTooltip(nil)

    m_DPanelIcon.SIcon.Think = function(s)
        s:SetTooltip(nil)
    end

    m_DPanelIcon.SIcon:SetVisible(false)

    if (m_WClass) then
        if (not string.EndsWith(tostring(m_WClass.WorldModel), ".mdl")) then
            if (not IsValid(m_DPanelIcon.SIcon.Icon)) then m_DPanelIcon.SIcon:CreateIcon(n) end
            m_DPanelIcon.SIcon.Icon:SetAlpha(0)
        end

        m_DPanelIcon.SIcon:SetModel(m_WClass.WorldModel, m_WClass.ModelSkin)
        m_DPanelIcon.SIcon:SetVisible(true)
    end

    m_DPanelIcon.WModel = nil
    m_DPanelIcon.Item = nil
    m_DPanelIcon.MSkin = nil

    if (m_WClass) then
        m_DPanelIcon.WModel = m_WClass.WorldModel
        m_DPanelIcon.Item = itemtbl
        if (m_WClass.ModelSkin) then
            m_DPanelIcon.MSkin = m_WClass.ModelSkin
        end
    end

    m_DPanelIcon.SIcon.PaintOver = function(s, w, h)
        if (not string.EndsWith(m_DPanelIcon.WModel, ".mdl")) then
            s.Icon:SetAlpha(0)
            if (m_DPanelIcon.WModel:StartWith("https")) then
                cdn.DrawImage(m_DPanelIcon.WModel, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
            else
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material(m_DPanelIcon.WModel))
                surface.DrawTexturedRect(0, 0, w, h)
            end
        else
            s.Icon:SetAlpha(255)
        end
    end
    return m_DPanelIcon.SIcon
end
local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local draw_DrawText = draw.DrawText
local draw_NoTexture = draw.NoTexture
local surface_SetFont = surface.SetFont
local surface_SetTextColor = surface.SetTextColor
local surface_SetTextPos = surface.SetTextPos
local surface_DrawText = surface.DrawText
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")
local stat_anim = 10
local ActIndex = {
    [ "pistol" ]        = ACT_HL2MP_IDLE_PISTOL,
    [ "smg" ]           = ACT_HL2MP_IDLE_SMG1,
    [ "grenade" ]       = ACT_HL2MP_IDLE_GRENADE,
    [ "ar2" ]           = ACT_HL2MP_IDLE_AR2,
    [ "shotgun" ]       = ACT_HL2MP_IDLE_SHOTGUN,
    [ "rpg" ]           = ACT_HL2MP_IDLE_RPG,
    [ "physgun" ]       = ACT_HL2MP_IDLE_PHYSGUN,
    [ "crossbow" ]      = ACT_HL2MP_IDLE_CROSSBOW,
    [ "melee" ]         = ACT_HL2MP_IDLE_MELEE,
    [ "slam" ]          = ACT_HL2MP_IDLE_SLAM,
    [ "normal" ]        = ACT_HL2MP_IDLE,
    [ "fist" ]          = ACT_HL2MP_IDLE_FIST,
    [ "melee2" ]        = ACT_HL2MP_IDLE_MELEE2,
    [ "passive" ]       = ACT_HL2MP_IDLE_PASSIVE,
    [ "knife" ]         = ACT_HL2MP_IDLE_KNIFE,
    [ "duel" ]          = ACT_HL2MP_IDLE_DUEL,
    [ "camera" ]        = ACT_HL2MP_IDLE_CAMERA,
    [ "magic" ]         = ACT_HL2MP_IDLE_MAGIC,
    [ "revolver" ]      = ACT_HL2MP_IDLE_REVOLVER
}
local function pmdl_weapon(pmdl,weapon)
    if pmdl.weapon == weapon then return end
    pmdl.weapon = weapon
    if (pmdl.HoldWeapon) then
        pmdl.HoldWeapon:Remove()
    end
    if weapon == "" then
        pmdl.PlayerModel:ResetSequence(pmdl.PlayerModel:LookupSequence("pose_standing_02"))
        return
    end
    local anim = "normal"

    if not string.EndsWith(weapon, "mdl") then
        local wep = weapons.Get(weapon)
        weapon = wep.WorldModel or "models/weapons/w_rif_ak47.mdl"
        anim = wep.HoldType or "normal"
    end
    pmdl.PlayerModel:ResetSequence(pmdl.PlayerModel:SelectWeightedSequence(ActIndex[anim]))
    pmdl.HoldWeapon = ClientsideModel(Model(weapon))
    if not IsValid(pmdl.HoldWeapon) then return end
    pmdl.HoldWeapon:SetNoDraw(true)
    pmdl.HoldWeapon:SetMoveType(MOVETYPE_NONE)
    if pmdl.HoldWeapon:LookupBone "ValveBiped.Bip01_R_Hand" then
        pmdl.HoldWeapon:SetParent(pmdl.PlayerModel, pmdl.PlayerModel:LookupAttachment("anim_attachment_RH"))
    end
    pmdl.HoldWeapon:AddEffects(EF_BONEMERGE)
end
local cosm_lookup = {
    ["Hat"] = 6,
    ["Mask"] = 7,
    ["Body"] = 8,
    ["Effect"] = 9
}
local last_cosm = 0
function pmdl_cosmetic(M_INV_PMDL,cosm)
    if istable(cosm) then
        if last_cosm == cosm.u then return end
        last_cosm = cosm.u
    else
        if last_cosm == cosm then return end
        last_cosm = 0
    end
    local set_model = false
    for k,v in pairs(M_INV_PMDL.ClientsideModels) do
        v.ModelEnt:Remove()
        M_INV_PMDL.ClientsideModels[k] = nil
    end
    if (m_Loadout) then
        for i = 6, 10 do
            if IsValid(M_INV_PMDL) and istable(cosm) and i == cosm_lookup[cosm.item.Kind] then
                M_INV_PMDL:AddModel(cosm.u,cosm)
                continue
            end
            if (IsValid(M_INV_PMDL) and m_Loadout[i] and m_Loadout[i].c) then
                if (m_Loadout[i].item and m_Loadout[i].item.Kind and m_CosmeticSlots[m_Loadout[i].item.Kind]) then
                    M_INV_PMDL:AddModel(m_Loadout[i].u, m_Loadout[i])
                end
                if (m_Loadout[i].item and m_Loadout[i].item.Kind == "Model") then
                    M_INV_PMDL:SetModel(m_Loadout[i].u)
					set_model = true
                end
            end
            if (istable(cosm) and cosm.item.Kind == "Model") then
                M_INV_PMDL:SetModel(cosm.u)
                set_model = true
            end
        end
    end

	if (not set_model) then
		 M_INV_PMDL:SetModel(GetGlobal("ttt_default_playermodel") or "models/player/phoenix.mdl")
	end
end

function make_about()
    local clr = HSVToColor(math.random(1,200) * 1000 % 360, 1, 1)
    BP_ABOUT = vgui.Create("DPanel", M_BATTLE_PNL)
	BP_ABOUT:SetPos(1, 46)
	BP_ABOUT:SetSize(738, 468)
    BP_ABOUT.Paint = function(s, w, h)
		local txtw = draw.SimpleText("Welcome to the Summer Climb!", "moat_NotifyTest2", w/2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)

		surface.SetDrawColor(clr.r, clr.g, clr.b, 10)
		surface.DrawRect(0, 0, w, 45)

		surface.SetDrawColor(clr.r, clr.g, clr.b, 35)
		surface.SetMaterial(gradient_u)
		surface.DrawTexturedRect(0, 0, w, 45)

		surface.DrawOutlinedRect(0, 0, w, 45)

		cdn.DrawImage("https://static.moat.gg/f/cWeit2ZL5WhFze49xX7jV76mFvOG.png", (w/2) - (235/2), 55, 254, 235, Color(255, 255, 255, 225))
	end

	local lbl = vgui.Create("DLabel", BP_ABOUT)
	lbl:SetPos(10, 145)
	lbl:SetText("Welcome to the Summer Climb! Here, for a limited time you will be able to earn XP and level up your Summer Climb to earn free rewards! Please keep in mind that any of the guns that you preview in the Summer Climb are just that, a preview, and the gun that you earn will be random and unique! <3\n\nSome quick info:\n- Earned XP towards the Summer Climb is not affected by Quadra XP (This might change)\n- Experience lovers (weapon XP) do not count towards the Summer Climb\n- XP from Dailies do count towards the Summer Climb\n- Dailies give half of their XP as rewards towards the Summer Climb\n\nPlease remember to be nice to other players and to not meta game for the Summer Climb rewards!\n- Moat Gaming Staff Team <3\n\nEnjoy the event! (To get started, press 'Summer Climb' in the tab above)")
	lbl:SetWide(BP_ABOUT:GetWide() - 20)
	lbl:SetWrap(true)
	lbl:SetAutoStretchVertical(true)
	lbl:SetTextColor(Color(255, 255, 255))
	lbl:SetFont("GModNotify")
end

function remove_about()
    BP_ABOUT:Remove()
end
BPMODEL_PANELS = {}
function make_battlepass()
    cookie.Set("SeenBP1",1)
    M_BP = vgui.Create("DScrollPanel", M_BATTLE_PNL)
	M_BP:SetPos(1, 46)
	M_BP:SetSize(738, 468)
    M_BP.Paint = function(s, w, h)
		local tl = util.TimeRemaining(1569844800, os.time())
		local left = string(
			tl.days, " day" .. (tl.days == 1 and "" or "s") .. ", ", 
			tl.hours, " hr" .. (tl.hours == 1 and "" or "s") .. ", ",
			tl.minutes, " min" .. (tl.minutes == 1 and "" or "s") .. "",
			tl.seconds, " sec" .. (tl.seconds == 1 and "" or "s")
		)

        draw.DrawText('Summer Climb', "moat_JackBig", w/3, 15, Color(0, 255, 0), TEXT_ALIGN_CENTER)
        draw.SimpleTextOutlined("Event ends in " .. left, "moat_GambleTitle", w/3, 110, Color(255,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
		draw.SimpleTextOutlined("Kick back this Summer with Free XP and Rewards", "moat_GambleTitle", w/3,80, Color(0, 198, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        surface.SetDrawColor(183, 183, 183)
        -- surface.DrawLine(5, 130, 455, 130)
    end
    local tiers_overlay = vgui.Create("DPanel",M_BP)
    tiers_overlay:SetSize(451,335)
    tiers_overlay:SetPos(5,130)
    tiers_overlay:SetDrawOnTop(true)
    function tiers_overlay:Paint(w,h)
        surface.SetDrawColor(183, 183, 183)
        surface.DrawLine(0, 0, w, 0)
        surface.DrawLine(0, h-1, w, h-1)
    end

    local tiers = vgui.Create("DScrollPanel",M_BP)
    tiers:SetSize(451,335)
    tiers:SetPos(5,130)
    tiers:GetVBar():SetWide(0)
    tiers:DockPadding(0, 0, 0, 15)
    function tiers:Paint(w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,50)) 
    end
    timer.Create("BP.HoveredExampleRateLimit",5,0,function()
        if not IsValid(tiers) then timer.Destroy("BP.HoveredExampleRateLimit") return end
        if MOAT_BP.Hovered then
            net.Start("BP.ItemExample")
            net.WriteInt(MOAT_BP.Hovered.item.ID,16)
            net.SendToServer()
        end
    end)
    for tier,v in pairs(table.Reverse(MOAT_BP.tiers)) do
        tier = (#MOAT_BP.tiers+1) - tier
        local a = vgui.Create("DPanel",tiers)
        a:DockMargin(0, 5, 0, 0)
        a:SetSize(0,60)
        a:Dock(TOP)
        a:SetCursor("hand")

        if math.min(MOAT_BP.current_tier + 3,100) == tier then
            timer.Simple(0.2,function()
                if not IsValid(tiers) then return end
                tiers:PerformLayout()

                local x, y = tiers.pnlCanvas:GetChildPosition( a )
                local w, h = a:GetSize()

                y = y + h * 0.5
                y = y - a:GetTall() * 0.5

                tiers.VBar:AnimateTo( y , 5, 0, 3 )
            end)
        end
        local cur = MOAT_BP.current_tier
        function a:OnCursorEntered()
            if MOAT_BP.Examples[v.ID] then
                MOAT_BP.Hovered = MOAT_BP.Examples[v.ID]
            end
        end
        function a:OnCursorExited()
            MOAT_BP.Hovered = nil
        end
    
        function a:Paint(w,h)
            local xp = math.min(MOAT_BP.xp,xp_needed(MOAT_BP.current_tier + 1)) -- in here incase they have it open when the round ends and xp updates
            local alpha = (MOAT_BP.current_tier >= tier and 255 or 20)
            local alpha2 = (MOAT_BP.current_tier >= tier and 150 or MOAT_BP.current_tier + 1 == tier and 20 or 0)
            if MOAT_BP.Examples[v.ID] and a:IsHovered() then
                MOAT_BP.Hovered = MOAT_BP.Examples[v.ID]
            end
            draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,50))
            local c = rarity_names[v.rarity][2]:Copy()
            c.a = alpha2
            -- surface.DrawTexturedRect(0, 0, w * 0.75, h)
            surface.SetDrawColor(183, 183, 183,alpha)
            surface.DrawOutlinedRect(0, 0, w, h)
            surface.DrawOutlinedRect(5, 5, 50, 50)
            surface.SetDrawColor(c.r,c.g,c.b,alpha)
            surface.DrawOutlinedRect(w-55, 5, 50, 50)
            surface.SetDrawColor(c.r,c.g,c.b,alpha/2)
            surface.SetMaterial(gradient_d)
            surface.DrawTexturedRect(w-55, 10, 50, 45)
            if MOAT_BP.current_tier + 1 == tier then
                local frac = (xp/xp_needed(MOAT_BP.current_tier + 1))
                draw.RoundedBox(0, 5, 55 - (50 * frac),50,50 * frac,c)
                if xp > 0 then
                    local frac_w = w * (frac)
                    surface.SetDrawColor(183, 183, 183,255)
                    surface.DrawLine(0,0,0,h)
                    surface.DrawLine(0,0,frac_w,0)
                    surface.DrawLine(0,h-1,frac_w,h-1)
                    if frac_w > 4 then
                        surface.DrawLine(5,5,5,55)
                        surface.DrawLine(5,5,math.min(frac_w,54),5)
                        surface.DrawLine(5,55,math.min(frac_w,54),55)
                        if frac_w > 54 then 
                            surface.DrawLine(54,5,54,55)
                        end
                    end
                    surface.SetDrawColor(c.r,c.g,c.b,255)
                    if frac_w > 396 then
                        surface.DrawLine(396,5,396,55)
                        surface.DrawLine(396,5,math.min(frac_w,450),5)
                        surface.DrawLine(396,55,math.min(frac_w,450),55)
                        if frac_w > 446 then 
                            surface.DrawLine(446,5,446,55)
                        end
                    end
                end
                draw.DrawText("Unlocks in " .. xp .. "/" .. xp_needed(MOAT_BP.current_tier + 1) .. " XP!","moat_Medium5",w/2,30,Color(255,255,255,alpha),TEXT_ALIGN_CENTER)
            elseif MOAT_BP.current_tier < tier then
                draw.DrawText("Unlock more tiers to unlock this!","moat_Medium5",w/2,30,Color(255,255,255,alpha),TEXT_ALIGN_CENTER)
            else
                draw.DrawText("Unlocked, nicely done!","moat_Medium5",w/2,30,Color(255,255,255,alpha),TEXT_ALIGN_CENTER)
                draw.RoundedBox(0, 5, 5, 50, 50, c)
            end
            local draw_name_y = 5
            local name_col = rarity_names[v.rarity][2]:Copy()
            name_col.a = alpha
            local name_font = "moat_Medium5"
            surface.SetFont(name_font)
            local tw, th = surface.GetTextSize(v.name)
            local draw_name_x = w/2 - tw/2

            if (v.effect) ~= "" then
                local tfx = v.effect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, v.name, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "fire") then
                    m_DrawFireText(v.rarity, v.name, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(v.name, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(v.name, name_font, draw_name_x, draw_name_y, name_col, Color(255, 0, 0))
                elseif (tfx == "electric") then
                    m_DrawElecticText(v.name, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "frost") then
                    DrawFrostingText(10, 1.5, v.name, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
                else
                    m_DrawShadowedText(1, v.name, name_font, draw_name_x, draw_name_y, name_col)
                end
            else
                m_DrawShadowedText(1, v.name, name_font, draw_name_x, draw_name_y, name_col)
            end
            draw.DrawText(tier, "DermaLarge", 30, 15, Color(255,255,255,alpha), TEXT_ALIGN_CENTER)
        end
        local s = tier
        if v.model == "tier" or v.model == "crates" then
            timer.Create(tostring(s),3,0,function()
                if not IsValid(tiers) then timer.Destroy(s) return end
                if not IsValid(BPMODEL_PANELS[tier]) then timer.Destroy(tostring(s)) return end
                BPMODEL_PANELS[tier]:Remove()
                local b = make_randompanel(v.model,a)
                function b:OnCursorEntered()
                    if MOAT_BP.Examples[v.ID] then
                        MOAT_BP.Hovered = MOAT_BP.Examples[v.ID]
                    end
                end
                function b:OnCursorExited()
                    MOAT_BP.Hovered = nil
                end
                BPMODEL_PANELS[tier] = b
            end)
        end
        local b = make_randompanel(v.model,a)
        function b:OnCursorEntered()
            if MOAT_BP.Examples[v.ID] then
                MOAT_BP.Hovered = MOAT_BP.Examples[v.ID]
            end
        end
        function b:OnCursorExited()
            MOAT_BP.Hovered = nil
        end
        BPMODEL_PANELS[tier] = b
    end
    local b = vgui.Create("DPanel",tiers)
    b:SetSize(0,5)
    b:Dock(TOP) -- dockmargin bottom broken on scrollpanel?
    function b:Paint(w,h) end

    local info = vgui.Create("DPanel",M_BP)
    info:SetPos(459,3)
    info:SetSize(277, 462)
    function info:Paint(w,h)
    end
    local m_LoadoutTypes = {}
    m_LoadoutTypes[0] = "Melee"
    m_LoadoutTypes[1] = "Weapon"
    m_LoadoutTypes[2] = "Weapon"
    local gui_frame_off = 5
    local drawn_stats = 0
    local draw_stats_x = 7
    local draw_stats_multi = 0
    local draw_xp_lvl = 9
    local draw_stats_y = 26 + 21 + draw_xp_lvl
    local M_INV_PMDL = vgui.Create("MOAT_PlayerPreview", info)
    M_INV_PMDL:SetSize(325, 512)
    M_INV_PMDL:SetPos(0, 0)
    M_INV_PMDL:SetText("")
    local set_model = false
    if (m_Loadout) then
        for i = 6, 10 do
            if (IsValid(M_INV_PMDL) and m_Loadout[i] and m_Loadout[i].c) then
                if (m_Loadout[i].item and m_Loadout[i].item.Kind and m_CosmeticSlots[m_Loadout[i].item.Kind]) then
                    M_INV_PMDL:AddModel(m_Loadout[i].u, m_Loadout[i])
                end

                if (m_Loadout[i].item and m_Loadout[i].item.Kind == "Model") then
                    M_INV_PMDL:SetModel(m_Loadout[i].u)
					set_model = true
                end
            end
        end
    end
	if (not set_model) then
		 M_INV_PMDL:SetModel(GetGlobal("ttt_default_playermodel") or "models/player/phoenix.mdl")
	end
    function M_INV_PMDL:DrawModel()
        local curparent = self
        local rightx = self:GetWide()
        local leftx = 0
        local topy = 0
        local bottomy = self:GetTall()
        local previous = curparent

        while curparent:GetParent() ~= nil do
            curparent = curparent:GetParent()
            local x, y = previous:GetPos()
            topy = math.Max(y, topy + y)
            leftx = math.Max(x, leftx + x)
            bottomy = math.Min(y + previous:GetTall(), bottomy + y)
            rightx = math.Min(x + previous:GetWide(), rightx + x)
            previous = curparent
        end

        render.SetScissorRect(leftx, topy, rightx, bottomy, true)
        self.PlayerModel:DrawModel()
        self:DrawClientsideModels()
        render.SetScissorRect(0, 0, 0, 0, false)
        if IsValid(self.HoldWeapon) then
            self.HoldWeapon:DrawModel()
            local att = self.PlayerModel:GetAttachment(self.PlayerModel:LookupAttachment("anim_attachment_RH"))
            if not att then return end
            if not att.Pos then return end
            self.HoldWeapon:SetPos(att.Pos)
            self.HoldWeapon:SetAngles(att.Ang)
            self.HoldWeapon:SetupBones()
            local _Owner = self.PlayerModel
            local WorldModel = self.HoldWeapon
            local boneid = _Owner:LookupBone "ValveBiped.Bip01_R_Hand" -- Right Hand
            local b3 = WorldModel:LookupBone "ValveBiped.Bip01_R_Hand"
            if not boneid or not b3 then return end

            local matrix = _Owner:GetBoneMatrix(boneid)
            local mpos, mang
            local m3 = WorldModel:GetBoneMatrix(b3)
            if (m3) then
                mpos, mang = m3:GetTranslation(), m3:GetAngles()
            else
                mpos, mang = WorldModel:GetBonePosition(b3)
            end

            if not matrix or not mpos then return end
            
            local pos, ang = LocalToWorld(vector_origin, Angle(0, 0, 0), matrix:GetTranslation(), matrix:GetAngles())
            local lpos, lang = WorldToLocal(WorldModel:GetPos(), WorldModel:GetAngles(), mpos, mang)
            pos, ang = LocalToWorld(lpos, lang, pos, ang)


            local offsetVec = Vector(0, -5, 0)
            local offsetAng = Angle(-5, -10, 0)

            pos, ang = LocalToWorld(offsetVec, offsetAng, pos, ang)

            WorldModel:SetPos(pos)
            WorldModel:SetAngles(ang)
            WorldModel:SetupBones()

        end
    end
    local BP_HOVER = vgui.Create("DPanel")
    BP_HOVER:SetDrawOnTop(true)
    BP_HOVER:SetSize(275, 150)
    function BP_HOVER.Paint(s,w,h)
        local ITEM_HOVERED = MOAT_BP.Hovered

        draw_stats_y = 26 + 21 + draw_xp_lvl
        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            if ITEM_HOVERED.w then
                pmdl_weapon(M_INV_PMDL,ITEM_HOVERED.w)
            elseif m_CosmeticSlots[ITEM_HOVERED.item.Kind] or ITEM_HOVERED.item.Kind == "Model" then
                pmdl_cosmetic(M_INV_PMDL,ITEM_HOVERED)
            end
            local ITEM_NAME_FULL = ""
            if (ITEM_HOVERED.item.Kind == "tier") then
                local ITEM_NAME = util.GetWeaponName(ITEM_HOVERED.w)

                if (string.EndsWith(ITEM_NAME, "_name")) then
                    ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
                    ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
                end

                ITEM_NAME_FULL = ITEM_HOVERED.item.Name .. " " .. ITEM_NAME

                if (ITEM_HOVERED.item.Rarity == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
                    ITEM_NAME_FULL = ITEM_NAME
                end
            else
                ITEM_NAME_FULL = ITEM_HOVERED.item.Name
            end

			if (not ITEM_NAME_FULL) then ITEM_NAME_FULL = "Error with Item Name" end

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                draw_xp_lvl = 9
            else
                draw_xp_lvl = 3
            end

            if (ITEM_HOVERED.n) then
                draw_xp_lvl = draw_xp_lvl + 15
            end

            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local num_stats = 0

            if (ITEM_HOVERED.s) then
                num_stats = table.Count(ITEM_HOVERED.s)
            end

            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawOutlinedRect(0, 0, w, h)
            --draw_RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
            surface_SetDrawColor(15, 15, 15, 245)
            surface_DrawRect(1, 1, w - 2, h - 2)
            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawLine(6, 22 + draw_xp_lvl, w - 6, 22 + draw_xp_lvl)
            surface_DrawLine(6, 43 + draw_xp_lvl, w - 6, 43 + draw_xp_lvl)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawLine(6, 23 + draw_xp_lvl, w - 6, 23 + draw_xp_lvl)
            surface_DrawLine(6, 44 + draw_xp_lvl, w - 6, 44 + draw_xp_lvl)
            surface_SetDrawColor(rarity_gradient[ITEM_HOVERED.item.Rarity].r, rarity_gradient[ITEM_HOVERED.item.Rarity].g, rarity_gradient[ITEM_HOVERED.item.Rarity].b, rarity_gradient[ITEM_HOVERED.item.Rarity].a)
            local grad_x = 1
            local grad_y = 25 + draw_xp_lvl
            local grad_w = (w - 2) / 2
            local grad_h = 16
            local grad_x2 = 1 + ((w - 2) / 2) + (((w - 2) / 2) / 2)
            local grad_y2 = 25 + (grad_h / 2) + draw_xp_lvl
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRect(grad_x, grad_y, grad_w, grad_h)
            surface_SetMaterial(gradient_r)
            surface_DrawTexturedRectRotated(grad_x2, grad_y2, grad_w, grad_h, 180)
            surface_SetMaterial(gradient_d)
            surface_SetDrawColor(rarity_names[ITEM_HOVERED.item.Rarity][2].r, rarity_names[ITEM_HOVERED.item.Rarity][2].g, rarity_names[ITEM_HOVERED.item.Rarity][2].b, 100)
            --surface_DrawTexturedRect( 1, 1 + ( h / 2 ), w - 2, ( h / 2 ) - 2 )
            local RARITY_TEXT = ""

            if (ITEM_HOVERED.nt or ITEM_HOVERED.item.NotTradeable) then
                RARITY_TEXT = LocalPlayer():Nick() .. "'s "
            end

            if (ITEM_HOVERED.item.Kind ~= "tier") then
                RARITY_TEXT = RARITY_TEXT .. rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. ITEM_HOVERED.item.Kind
            else
                RARITY_TEXT = "A Random " .. RARITY_TEXT .. rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. m_LoadoutTypes[weapons.Get(ITEM_HOVERED.w).Slot]
            end

			grad_y2 = grad_y2 - 1

            for i = 1, 2 do
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w + i, grad_y2 - i, rarity_shadow[ITEM_HOVERED.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw_SimpleText(RARITY_TEXT, "moat_Medium4s", grad_w - i, grad_y2 + i, rarity_shadow[ITEM_HOVERED.item.Rarity][i], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			draw_SimpleText(RARITY_TEXT, "moat_Medium4", grad_w, grad_y2, rarity_accents[ITEM_HOVERED.item.Rarity], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            local draw_name_x = 7
            local draw_name_y = 3
            local name_col = ITEM_HOVERED.item.NameColor or rarity_names[ITEM_HOVERED.item.Rarity][2]:Copy()
            local name_font = "moat_Medium5"

            if (ITEM_HOVERED.item.NameEffect) then
                local tfx = ITEM_HOVERED.item.NameEffect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, nil, true)
                elseif (tfx == "fire") then
                    m_DrawFireText(ITEM_HOVERED.item.Rarity, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[1], nil, nil, true)
                elseif (tfx == "electric") then
                    m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
                elseif (tfx == "frost") then
                    DrawFrostingText(10, 1.5, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
                else
                    emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                end
                --local x_p, y_p = s:GetPos()
                --draw_SimpleTextDegree( ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, x_p, y_p, Color(255,0,0), Color(0,0,255), 0.7, TEXT_ALIGN_LEFT )
            else
                emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
            end

            if (ITEM_HOVERED.n) then
                emoji.SimpleText("\"" .. ITEM_HOVERED.n:Replace("''", "'") .. "\"", "moat_ItemDesc", draw_name_x, draw_name_y + 21, Color(255, 128, 128))
            end

            local drawn_stats = 0

            if (ITEM_HOVERED.s and (ITEM_HOVERED.item.Kind == "tier" or ITEM_HOVERED.item.Kind == "Unique" or ITEM_HOVERED.item.Kind == "Melee")) then
                draw_stats_multi = 25
                m_DrawItemStats("moat_ItemDesc", draw_stats_x, draw_stats_y + (drawn_stats * draw_stats_multi), ITEM_HOVERED, s)
                drawn_stats = 10
            else
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then

                    for i = 1, #item_desctbl do
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (s.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                m_DrawItemDesc(item_desc, "moat_ItemDesc", draw_stats_x, draw_stats_y, w - 12, h - draw_stats_y - 20)
                drawn_stats = m_GetItemDescH(item_desc, "moat_ItemDesc", w - 12)
                draw_stats_multi = 15
                local collection_y = draw_stats_y + (drawn_stats * draw_stats_multi) - 1
                m_DrawShadowedText(1, "From the " .. ITEM_HOVERED.item.Collection, "moat_Medium2", 6, collection_y, Color(150, 150, 150, 100))
            end

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                m_DrawShadowedText(1, ITEM_HOVERED.s.l, "moat_ItemDescLarge3", s:GetWide() - 6, 0, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                m_DrawShadowedText(1, "LVL", "moat_ItemDesc", s:GetWide() - 6 - level_w, 4, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                m_DrawShadowedText(1, "XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100), "moat_ItemDescSmall2", s:GetWide() - 6 - level_w - 2, 16, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                
                local nt_ = 0
                if (ITEM_HOVERED.n) then nt_ = 15 end

                surface_SetDrawColor(255, 255, 255, 20)
                surface_DrawRect(6, 27 + nt_, w - 12, 2)
                local bar_width = w - 12
                local xp_bar_width = bar_width * (ITEM_HOVERED.s.x / (ITEM_HOVERED.s.l * 100))
                surface_SetDrawColor(200, 200, 200, 255)
                surface_SetMaterial(gradient_r)
                surface_DrawTexturedRect(7, 27 + nt_, xp_bar_width, 2)
            end
        else
            pmdl_weapon(M_INV_PMDL,"")
            pmdl_cosmetic(M_INV_PMDL,0)
        end
    end

    local non_drawn_stats = {"d", "f", "m", "l", "x", "j", "tr"}

    BP_HOVER.Think = function(s)
        if (not IsValid(tiers)) then
            s:Remove()
            return
        end

        s.ctrldown = input.IsKeyDown(KEY_LCONTROL)

        local ITEM_HOVERED = MOAT_BP.Hovered

        if (IsValid(M_INV_MENU) and M_INV_MENU.Hovered) then
            s:SetAlpha(0)
            return
        end

        if (ITEM_HOVERED and ITEM_HOVERED.c) then
            if not s.AnimVal then s.AnimVal = 0 end
            s.AnimVal = Lerp(FrameTime() * stat_anim, s.AnimVal, 1)

            if (not s.SavedItem or (s.SavedItem ~= ITEM_HOVERED)) then
                s.AnimVal = 0
                s.SavedItem = ITEM_HOVERED
            end

            local ITEM_NAME_FULL = ""

            if (ITEM_HOVERED.item.Kind == "tier") then
                local ITEM_NAME = util.GetWeaponName(ITEM_HOVERED.w)

                if (string.EndsWith(ITEM_NAME, "_name")) then
                    ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
                    ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
                end

                ITEM_NAME_FULL = ITEM_HOVERED.item.Name .. " " .. ITEM_NAME

                if (ITEM_HOVERED.item.Rarity == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
                    ITEM_NAME_FULL = ITEM_NAME
                end
            else
                ITEM_NAME_FULL = ITEM_HOVERED.item.Name
            end

			if (not ITEM_NAME_FULL) then ITEM_NAME_FULL = "Error with Item Name" end

            surface_SetFont("moat_Medium5")
            local namew, nameh = surface_GetTextSize(ITEM_NAME_FULL)
            local namew2, nameh2 = 0, 0

            if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
                surface_SetFont("moat_ItemDescLarge3")
                local level_w, level_h = surface_GetTextSize(ITEM_HOVERED.s.l)
                surface_SetFont("moat_ItemDescSmall2")
                namew2, nameh2 = surface_GetTextSize("XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100))
                namew2 = namew2 + level_w
            end

            if ((namew + namew2) > 250) then
                s:SetWide(namew + namew2 + 12 + 10)
            end

            if (not s.savewide) then s.savewide = s:GetWide() end

            if (s.ctrldown and ITEM_HOVERED.s) then
                s:SetWide(s.savewide + 75)
            else
                s:SetWide(s.savewide)
            end

            local num_stats = 0

            if (ITEM_HOVERED.s) then
                for k, v in pairs(ITEM_HOVERED.s) do
                    if (not table.HasValue(non_drawn_stats, tostring(k))) then
                        num_stats = num_stats + 1
                    end
                end
            end

            local draw_stats_multi = 25
            local default_drawn_stats = 40

            if (ITEM_HOVERED.item.Kind ~= "tier" and ITEM_HOVERED.item.Kind ~= "Unique" and ITEM_HOVERED.item.Kind ~= "Melee") then
                local item_desc = ITEM_HOVERED.item.Description
                local item_desctbl = string.Explode("^", item_desc)

                if (ITEM_HOVERED.s and ITEM_HOVERED.item and ITEM_HOVERED.item.Stats) then
                    
                    for i = 1, #item_desctbl do
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i])), 2)

                        if (s.ctrldown) then
                            item_stat = "(" .. ITEM_HOVERED.item.Stats[i].min .. "-" .. ITEM_HOVERED.item.Stats[i].max .. ") " .. math.Round(item_stat, 2)
                        end

                        item_desctbl[i] = string.format(item_desctbl[i], item_stat)
                    end
                end

                item_desc = string.Implode("", item_desctbl)
                item_desc = string.Replace(item_desc, "_", "%")
                num_stats = m_GetItemDescH(item_desc, "moat_ItemDesc", 275 - 14)
                draw_stats_multi = 15
                default_drawn_stats = 0
            end

            local drawn_talents = 0

            if (ITEM_HOVERED.t) then
                drawn_talents = 12

                for k, v in ipairs(ITEM_HOVERED.t) do
                    local talent_desc2 = ITEM_HOVERED.Talents[k].Description
                    local talent_desctbl2 = string.Explode("^", talent_desc2)

                    for i = 1, table.Count(v.m) do
                        local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1)
                        
                        if (s.ctrldown) then
                            mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                        end

                        talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                    end

                    talent_desc2 = string.Implode("", talent_desctbl2)
                    talent_desc2 = string.Replace(talent_desc2, "_", "%")
                    local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", s:GetWide() - 12) * 15)
                    drawn_talents = drawn_talents + talent_desc_h + 3
                end
            end

            local collection_add = 0

            if (ITEM_HOVERED.item) then
                if (ITEM_HOVERED.item.Collection) then
                    collection_add = 10
                end
            end

            local panel_height = draw_stats_y + default_drawn_stats + drawn_talents + (num_stats * draw_stats_multi) + 4 + collection_add

            if (ITEM_HOVERED.item.Rarity == 0 and ITEM_HOVERED.item.ID and ITEM_HOVERED.item.ID ~= 7820 and ITEM_HOVERED.item.ID ~= 7821) then
                panel_height = 100
            end
            
            s:SetTall(panel_height)

            local w2, h2 = s:GetSize()
            local x2, y2 = 0, 0

            if (gui.MouseX() + w2 + gui_frame_off > ScrW()) then
                x2 = (gui.MouseX() + w2 + gui_frame_off) - ScrW()
            end

            if (gui.MouseY() - panel_height - gui_frame_off < 0) then
                y2 = math.abs((gui.MouseY() - panel_height - gui_frame_off))
            end

            s:SetPos(gui.MouseX() - x2 + gui_frame_off, gui.MouseY() - (panel_height) + y2 - gui_frame_off)
            s:SetAlpha(255)
        else
            s.AnimVal = 0
            s:SetAlpha(0)
        end
    end

end

function remove_battlepass()
    M_BP:Remove()
end

function m_CreateBattlePanel(pnl_x, pnl_y, pnl_w, pnl_h)
    if IsValid(M_BATTLE_PNL) then return end
    MOAT_BP.Open = true
	MOAT_BP.CurCat = 1
	MOAT_BP.TitlePoly = {
		{x = 1, y = 1},
		{x = 0, y = 1},
		{x = 30, y = 45},
		{x = 1, y = 45}
	}
    M_BATTLE_PNL = vgui.Create("DFrame")
    M_BATTLE_PNL:SetSize(pnl_w, pnl_h)
    M_BATTLE_PNL:SetPos(pnl_x, pnl_y)
    M_BATTLE_PNL:MakePopup()
    M_BATTLE_PNL:SetKeyboardInputEnabled(false)
    M_BATTLE_PNL:SetDraggable(false)
    M_BATTLE_PNL:ShowCloseButton(false)
    M_BATTLE_PNL:SetTitle("")
    M_BATTLE_PNL:SetAlpha(0)
    M_BATTLE_PNL.Think = function(s)
    	if (not IsValid(MOAT_INV_BG)) then
    		s:Remove()
    	else
			local x, y = MOAT_INV_BG:GetPos()
            s:SetPos(x + 5, y + 30)
    	end
    	if ((input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT)) and not s:IsHovered()) then
    		s:MakePopup()
    	end
    end
    M_BATTLE_PNL.Paint = function(s, w, h)
    	
        cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))
    	draw.RoundedBox(0, 0, 0, w, 45, Color(56, 56, 56, 255))
    	draw.RoundedBox(0, 0, 45, w, 1, Color(86, 86, 86, 255))

    	MOAT_BP.TitlePoly[2].x = Lerp(FrameTime() * 10, MOAT_BP.TitlePoly[2].x, 140)
    	MOAT_BP.TitlePoly[3].x = Lerp(FrameTime() * 10, MOAT_BP.TitlePoly[3].x, 170)

    	surface.SetDrawColor(46, 46, 46)
    	draw.NoTexture()
    	surface.DrawPoly(MOAT_BP.TitlePoly)

    	surface.SetDrawColor(15, 15, 15, 150)
        surface.SetMaterial(Material("vgui/gradient-d"))
        surface.DrawTexturedRect(0, 0, w, 45)

    	draw.SimpleText("Moat", "moat_GambleTitle", 5, 1, Color(0, 25, 50))
    	draw.SimpleText("Gaming", "moat_GambleTitle", 55, 1, Color(50, 50, 50))

    	draw.SimpleText("Moat", "moat_GambleTitle", 4, 0, Color(0, 198, 255))
    	draw.SimpleText("Gaming", "moat_GambleTitle", 54, 0, Color(255, 255, 255))

    	draw.SimpleText("Summer Climb", "moat_GambleTitle", 6, 21, Color(50, 50, 0))
    	draw.SimpleText("Summer Climb", "moat_GambleTitle", 5, 20, HSVToColor((CurTime() * 10) % 360, 1, 1))

    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 194, 6, Color(0, 0, 0))
    	draw.SimpleText(LocalPlayer():Nick(), "moat_ItemDesc", 193, 5, Color(255, 255, 255))

    	draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 208, 27, Color(0, 0, 0))
        draw.SimpleText("IC: " .. string.Comma(MOAT_INVENTORY_CREDITS), "moat_ItemDesc", 207, 26, Color(255, 255, 255))
        surface.SetMaterial(Material("icon16/coins.png"))
        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawTexturedRect(185, 26, 16, 16)

    end
    local MOAT_BP_AVA = vgui.Create("AvatarImage", M_BATTLE_PNL)
    MOAT_BP_AVA:SetPos(170, 4)
    MOAT_BP_AVA:SetSize(17, 17)
    MOAT_BP_AVA:SetPlayer(LocalPlayer(), 32)

    local MOAT_BP_CATS = {{"Summer Climb", Color(255, 0, 50)}, {"About", Color(150, 0, 255)}}
    local CAT_WIDTHS = 0

    for i = 1, #MOAT_BP_CATS do
    	local MOAT_BP_CAT_BTN = vgui.Create("DButton", M_BATTLE_PNL)
    	MOAT_BP_CAT_BTN:SetSize(150, 30)
    	MOAT_BP_CAT_BTN:SetPos(320 + CAT_WIDTHS, 15)
    	MOAT_BP_CAT_BTN:SetText("")
    	MOAT_BP_CAT_BTN.HoveredNum = 0
        MOAT_BP_CAT_BTN.Paint = function(s, w, h)
            local col = MOAT_BP_CATS[i][2]

            surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
            surface.SetMaterial(Material("vgui/gradient-d"))
            surface.DrawTexturedRect(0, h - (h * s.HoveredNum), w, h * s.HoveredNum)

            draw.SimpleTextOutlined(MOAT_BP_CATS[i][1], "GModNotify", w/2, (h/2)-(s.HoveredNum*4), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0, 25 ))

            if (MOAT_BP.CurCat == i) then
                draw.RoundedBox(0, 0, h-4, w, 4, MOAT_BP_CATS[i][2])
                surface.SetDrawColor(Color(col.r, col.g, col.b, 50))
                surface.SetMaterial(Material("vgui/gradient-d"))
                surface.DrawTexturedRect(0, 0, w, h)
            elseif (s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 1)
            elseif (not s:IsHovered()) then
                s.HoveredNum = Lerp(10 * FrameTime(), s.HoveredNum, 0)
            end

            draw.RoundedBox(0, 0, h - (4 * s.HoveredNum), w, 4 * s.HoveredNum, MOAT_BP_CATS[i][2])
        end
    	
        MOAT_BP_CAT_BTN.DoClick = function(s)
        	if (i == MOAT_BP.CurCat) then return end
            MOAT_BP.CurCat = i

            if (i == 1) then
                make_battlepass()
            else
                remove_battlepass()
            end

            if (i == 2 ) then
                make_about()
            else
                remove_about()
            end

            if (GetConVar("moat_ui_sounds"):GetInt() > 0) then LocalPlayer():EmitSound("moatsounds/pop1.wav") end

           
        end

        MOAT_BP_CAT_BTN.OnCursorEntered = function() if (GetConVar("moat_ui_sounds"):GetInt() > 0) then LocalPlayer():EmitSound("moatsounds/pop2.wav") end end

        CAT_WIDTHS = CAT_WIDTHS + 152
    end
    if cookie.GetNumber("SeenBP1", 0) == 1 then
        MOAT_BP.CurCat = 1
        make_battlepass()
    else
        MOAT_BP.CurCat = 2
        make_about()
    end

    M_BATTLE_PNL:AlphaTo(255, 0.15, 0.15)
end

function m_RemoveBattlePanel()
    if (not IsValid(M_BATTLE_PNL)) then return end

	M_BATTLE_PNL:AlphaTo(0, 0.15, 0, function()
		M_BATTLE_PNL:Remove()
        MOAT_BP.Open = false
	end)
end

local release_date = 1561708800
-- hook.Add("InitPostEntity","Disable Until It's time",function()
--     if not moat.isdev(LocalPlayer()) then
--     -- if LocalPlayer() then
--         function m_CreateBattlePanel(pnl_x, pnl_y, pnl_w, pnl_h) --overwrite
--             if IsValid(M_BATTLE_PNL) then return end
--             M_BATTLE_PNL = vgui.Create("DFrame")
--             M_BATTLE_PNL:SetSize(pnl_w, pnl_h)
--             M_BATTLE_PNL:SetPos(pnl_x, pnl_y)
--             M_BATTLE_PNL:MakePopup()
--             M_BATTLE_PNL:SetKeyboardInputEnabled(false)
--             M_BATTLE_PNL:SetDraggable(false)
--             M_BATTLE_PNL:ShowCloseButton(false)
--             M_BATTLE_PNL:SetTitle("")
--             M_BATTLE_PNL:SetAlpha(0)
--             M_BATTLE_PNL.Think = function(s)
--                 if (not IsValid(MOAT_INV_BG)) then
--                     s:Remove()
--                 else
--                     local x, y = MOAT_INV_BG:GetPos()
--                     s:SetPos(x + 5, y + 30)
--                 end
--                 if ((input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT)) and not s:IsHovered()) then
--                     s:MakePopup()
--                 end
--             end
--             M_BATTLE_PNL.Paint = function(s, w, h)
--                 local degrees = (CurTime() * 10) % 360
--                 local r = HSVToColor(degrees, 1, 1)
--                 surface.SetDrawColor(21, 28, 35, 150)
--                 surface.DrawRect(0, 0, w, h)
--                 DrawBlur(s, 3)
--                 cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 225))
--                 draw.DrawText('There is an error', "moat_JackBig", w/2, h/2 - 40 - 30, r, TEXT_ALIGN_CENTER)
--                 draw.DrawText("I've disabled it until it's fixed, sorry.", "moat_JackBig", w/2, h/2 - 40 + 30, r, TEXT_ALIGN_CENTER)
--             end
--             M_BATTLE_PNL:AlphaTo(255, 0.15, 0.15)
--         end

--     end
-- end)