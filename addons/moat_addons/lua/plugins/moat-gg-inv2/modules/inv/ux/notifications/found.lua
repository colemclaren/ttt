MOAT_VERSION = "1.7.1"
MOAT_BG_URL = "https://cdn.moat.gg/f/AngryProfuseCottontail.png"

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

local MOAT_ITEM_FOUND_QUEUE = {}
local MOAT_ITEM_IS_BEING_DRAWN = false

function m_DrawFoundItem(tbl, s_type)
    local itemtbl = tbl
    local m_LoadoutTypes = {}
    m_LoadoutTypes[0] = "Melee"
    m_LoadoutTypes[1] = "Secondary"
    m_LoadoutTypes[2] = "Primary"
    local extra_y_padding = 20

    if (s_type == "chat" or s_type == "remove_chat" or s_type == "inspect" or s_type == "remove_inspect") then
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:Remove()
        end

        if (timer.Exists("moat_StatsPanel1")) then
            timer.Remove("moat_StatsPanel1")
        end

        if (timer.Exists("moat_StatsPanel2")) then
            timer.Remove("moat_StatsPanel2")
        end

        MOAT_ITEM_IS_BEING_DRAWN = false
        if (s_type == "remove_chat" or s_type == "remove_inspect") then return end
    end
	

    MOAT_ITEM_IS_BEING_DRAWN = true
    MOAT_ITEM_STATS = vgui.Create("DPanel")
    MOAT_ITEM_STATS:SetDrawOnTop(true)
    MOAT_ITEM_STATS:SetSize(275, 150)
    MOAT_ITEM_STATS.StatTbl = itemtbl
    local drawn_stats = 0
    local draw_stats_x = 7
    local draw_stats_multi = 0
    local draw_xp_lvl = 9
    local draw_stats_y = 26 + 21 + draw_xp_lvl
    MOAT_ITEM_STATS.AnimVal = 1
    MOAT_ITEM_STATS.Paint = function(s, w, h)
        s.ctrldown = input.IsKeyDown(KEY_LCONTROL)

        local ITEM_HOVERED = itemtbl
        draw_stats_y = 26 + 21 + draw_xp_lvl

        if (ITEM_HOVERED and ITEM_HOVERED.c) then
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
            surface_SetDrawColor(15, 15, 15, 250)
            surface_DrawRect(1, 1, w - 2, h - 2)
            surface_SetDrawColor(100, 100, 100, 50)
            surface_DrawLine(6, 22 + draw_xp_lvl, w - 6, 22 + draw_xp_lvl)
            surface_DrawLine(6, 43 + draw_xp_lvl, w - 6, 43 + draw_xp_lvl)
            surface_SetDrawColor(0, 0, 0, 100)
            surface_DrawLine(6, 23 + draw_xp_lvl, w - 6, 23 + draw_xp_lvl)
            surface_DrawLine(6, 44 + draw_xp_lvl, w - 6, 44 + draw_xp_lvl)
			surface_SetDrawColor(rarity_names[ITEM_HOVERED.item.Rarity][2].r, rarity_names[ITEM_HOVERED.item.Rarity][2].g, rarity_names[ITEM_HOVERED.item.Rarity][2].b, 200)
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
            local RARITY_TEXT = ""

            if (ITEM_HOVERED.item.Kind ~= "tier") then
                RARITY_TEXT = rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. ITEM_HOVERED.item.Kind
            else
                RARITY_TEXT = rarity_names[ITEM_HOVERED.item.Rarity][1] .. " " .. m_LoadoutTypes[weapons.Get(ITEM_HOVERED.w).Slot]
            end

			m_DrawShadowedText(1, RARITY_TEXT, "moat_Medium4s", grad_w + 1, grad_y2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			m_DrawShadowedText(1, RARITY_TEXT, "moat_Medium4", grad_w, grad_y2 - 1, rarity_accents[ITEM_HOVERED.item.Rarity], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
            local draw_name_x = 7
            local draw_name_y = 3
            local name_col = ITEM_HOVERED.item.NameColor or rarity_names[ITEM_HOVERED.item.Rarity][2]
            local name_font = "moat_Medium5"

            if (ITEM_HOVERED.item.NameEffect) then
                local tfx = ITEM_HOVERED.item.NameEffect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "fire") then
                    m_DrawFireText(ITEM_HOVERED.item.Rarity, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, ITEM_HOVERED.item.NameEffectMods[1])
                elseif (tfx == "electric") then
                    m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                elseif (tfx == "frost") then
                    DrawFrostingText(10, 1.5, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, Color(100, 100, 255), Color(255, 255, 255))
                else
                    m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                end
            else
                m_DrawShadowedText(1, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
            end

            if (ITEM_HOVERED.n) then
                m_DrawShadowedText(1, "\"" .. ITEM_HOVERED.n:Replace("''", "'") .. "\"", "moat_ItemDesc", draw_name_x, draw_name_y + 21, Color(255, 128, 128))
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
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * ITEM_HOVERED.s[i]), 2)

                        if (MOAT_ITEM_STATS.ctrldown) then
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
        end
    end

    local non_drawn_stats = {"d", "f", "m", "l", "x", "j", "tr"}
    local ITEM_HOVERED = itemtbl
    -- Put your Lua here
    if (ITEM_HOVERED and ITEM_HOVERED.c) then
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

        if ((namew + namew2) > 275) then
            MOAT_ITEM_STATS:SetWide(namew + namew2 + 12 + 10)
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
                    local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * ITEM_HOVERED.s[i]), 2)

                    if (MOAT_ITEM_STATS.ctrldown) then
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
                    local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * v.m[i]), 1)

                    if (MOAT_ITEM_STATS.ctrldown) then
                        mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                    end

                    talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                end

                talent_desc2 = string.Implode("", talent_desctbl2)
                talent_desc2 = string.Replace(talent_desc2, "_", "%")
                local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12) * 15)
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

        MOAT_ITEM_STATS:SetTall(panel_height)
    end

    MOAT_ITEM_STATS.Think = function(s, w, h)
        if (ITEM_HOVERED and ITEM_HOVERED.c) then
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

            if ((namew + namew2) > 275) then
                MOAT_ITEM_STATS:SetWide(namew + namew2 + 12 + 10)
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
                        local item_stat = math.Round(ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * ITEM_HOVERED.s[i]), 2)

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
                        local mod_num = math.Round(ITEM_HOVERED.Talents[k].Modifications[i].min + ((ITEM_HOVERED.Talents[k].Modifications[i].max - ITEM_HOVERED.Talents[k].Modifications[i].min) * v.m[i]), 1)

                        if (MOAT_ITEM_STATS.ctrldown) then
                            mod_num = "(" .. ITEM_HOVERED.Talents[k].Modifications[i].min .. "-" .. ITEM_HOVERED.Talents[k].Modifications[i].max .. ") " .. math.Round(mod_num, 2)
                        end

                        talent_desctbl2[i] = string.format(talent_desctbl2[i], tostring(mod_num))
                    end

                    talent_desc2 = string.Implode("", talent_desctbl2)
                    talent_desc2 = string.Replace(talent_desc2, "_", "%")
                    local talent_desc_h = 17 + (m_GetItemDescH(talent_desc2, "moat_ItemDesc", MOAT_ITEM_STATS:GetWide() - 12) * 15)
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

            MOAT_ITEM_STATS:SetTall(panel_height)
        end
    end

    if (s_type == "inspect") then
		local vm = LocalPlayer():GetViewModel()
		if (not vm) then
			return
		end

		local inspect_attach, att_cache = {1, 2, 3, "muzzle", "muzzle_flash"}
		for k, v in ipairs(inspect_attach) do
			local num = isstring(v) and vm:LookupAttachment(v) or v
			if (vm:GetAttachment(num)) then
				att = vm:GetAttachment(num)
				att_cache = num

				break
			end
		end

		if (not att_cache) then
			return
		end

		local pw, ph = MOAT_ITEM_STATS:GetSize()
		local p, a = att.Pos, att.Ang

		p = p - (a:Forward() * 0) + (a:Right() * 0) + (a:Up() * 0)
		p = p:ToScreen()
		p.x = math.Clamp(p.x, 0, ScrW())
		p.y = math.Clamp(p.y - ph, 0, ScrH())

		MOAT_ITEM_STATS:SetPos(p.x - pw, p.y - ph)
        MOAT_ITEM_STATS:SetAlpha(0)
        MOAT_ITEM_STATS:AlphaTo(255, 1, 0)

        return
    end

    if (s_type == "chat") then
        local mx, my = gui.MousePos()
        MOAT_ITEM_STATS:SetPos(mx + 5, my - MOAT_ITEM_STATS:GetTall() - 5)
        local px, py = MOAT_ITEM_STATS:GetPos()

        if (py < 0) then
            MOAT_ITEM_STATS:SetPos(px, 0)
        end

        MOAT_ITEM_STATS:SetAlpha(0)
        MOAT_ITEM_STATS:AlphaTo(255, 0.5, 0)

        timer.Create("moat_StatsPanel1", 5, 1, function()
            if (IsValid(MOAT_ITEM_STATS)) then
                MOAT_ITEM_STATS:AlphaTo(0, 0.5, 0)
            end
        end)

        timer.Create("moat_StatsPanel2", 5.5, 1, function()
            if (IsValid(MOAT_ITEM_STATS)) then
                MOAT_ITEM_STATS:Remove()
                MOAT_ITEM_IS_BEING_DRAWN = false
            end
        end)

        return
    end

    MOAT_ITEM_STATS:SetPos((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall())
    MOAT_ITEM_STATS:SetAlpha(0)
    local label_y_padding = 30
    MOAT_ITEM_STATS_LBL = vgui.Create("DPanel")
    MOAT_ITEM_STATS_LBL:SetSize(MOAT_ITEM_STATS:GetWide(), 30)
    MOAT_ITEM_STATS_LBL:SetPos((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall() - label_y_padding)
    MOAT_ITEM_STATS_LBL:SetAlpha(0)

    MOAT_ITEM_STATS_LBL.Paint = function(s, w, h)
        --m_DrawShadowedText( 1, "Item Obtained!", "moat_ItemDescLarge3", w / 2, 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
        if (not MOAT_ITEM_FOUND_QUEUE[1]) then return end

        if (s_type ~= "pickup") then
            draw_SimpleTextOutlined("Item Obtained!", "moat_ItemDescLarge3", w / 2, 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0.5, Color(10, 10, 10, 255))
        end
    end

    -- Entering
    if (IsValid(MOAT_ITEM_STATS)) then
        MOAT_ITEM_STATS:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), 50, 0.5, 0)
        MOAT_ITEM_STATS:AlphaTo(255, 0.5, 0)
    end

    if (IsValid(MOAT_ITEM_STATS_LBL)) then
        MOAT_ITEM_STATS_LBL:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), 50 - label_y_padding, 0.5, 0)
        MOAT_ITEM_STATS_LBL:AlphaTo(255, 0.5, 0)
    end

    -- Leaving - Tried setting the delay for the animations, but there were different results ( sometimes had delay, sometimes didn't, specificly for moveto )
    timer.Simple(2, function()
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall(), 0.5, 0)
            MOAT_ITEM_STATS:AlphaTo(0, 0.5, 0)
        end

        if (IsValid(MOAT_ITEM_STATS_LBL)) then
            MOAT_ITEM_STATS_LBL:MoveTo((ScrW() / 2) - (MOAT_ITEM_STATS:GetWide() / 2), -MOAT_ITEM_STATS:GetTall() - label_y_padding, 0.5, 0)
            MOAT_ITEM_STATS_LBL:AlphaTo(0, 0.5, 0)
        end
    end)

    -- Removing
    timer.Simple(3, function()
        if (IsValid(MOAT_ITEM_STATS)) then
            MOAT_ITEM_STATS:Remove()
        end

        if (IsValid(MOAT_ITEM_STATS_LBL)) then
            MOAT_ITEM_STATS_LBL:Remove()
        end

        table.remove(MOAT_ITEM_FOUND_QUEUE, 1)
        MOAT_ITEM_IS_BEING_DRAWN = false
    end)
end

hook.Add("Think", "moat_DrawItemsFound", function()
    if (#MOAT_ITEM_FOUND_QUEUE > 0 and not MOAT_ITEM_IS_BEING_DRAWN) then
        local draw_type = "default"

        if (MOAT_ITEM_FOUND_QUEUE[1].ItemStatType) then
            draw_type = MOAT_ITEM_FOUND_QUEUE[1].ItemStatTypeItemStatType
        end

        m_DrawFoundItem(MOAT_ITEM_FOUND_QUEUE[1], draw_type)
    end
end)

function m_DrawFoundItemAdd(item_tbl, draw_type)
    local item_tbl = item_tbl
    item_tbl.ItemStatType = draw_type
    table.insert(MOAT_ITEM_FOUND_QUEUE, item_tbl)
end

net.Receive("Moat.NewItem", function(len)
    table.insert(MOAT_ITEM_FOUND_QUEUE, m_ReadWeaponFromNetCache())
end)