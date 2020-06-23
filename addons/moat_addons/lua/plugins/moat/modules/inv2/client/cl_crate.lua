
crate_wait = CurTime()

function m_OpenCrate(tbl, fastopen)
    if (crate_wait > CurTime()) then 
        chat.AddText(Color(255, 0, 0), "Please wait " .. math.Round(CurTime() - crate_wait) .. " sec(s) before opening another crate!")
        return
    end

	if (not tbl or not tbl.c) then return end
    net.Start("MOAT_VERIFY_CRATE")
    net.WriteDouble(tonumber(tbl.c))
    net.WriteBool(fastopen or false)
    net.SendToServer()

    // crate_wait = CurTime() + 1

	// print "open"
end

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

local crate_pnl_height = 70
local global_table_items = {}
local gradient_d = Material("vgui/gradient-d")
local function m_StartCrateRoll(crate_slot, crate_class, parent_pnl)
    net.Start("MOAT_CRATE_OPEN")
    net.WriteDouble(crate_slot)
    net.WriteDouble(crate_class)
    net.WriteDouble(1)
    net.SendToServer()

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_CR = MT[CurTheme].Crate

    local pnl_x, pnl_y = (parent_pnl:GetWide() / 2) - (358 / 2), 50
    local MOAT_ROLL_PNL = vgui.Create("DPanel", parent_pnl)
    MOAT_ROLL_PNL:SetPos(pnl_x, pnl_y)
    MOAT_ROLL_PNL:SetSize(358, 73)

    MOAT_ROLL_PNL.Paint = function(s, w, h)
        if (MT_CR and MT_CR.Roll) then
            MT_CR.Roll(s, w, h)
            return
        end

        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
    end

    MOAT_ROLL_PNL.PaintOver = function(s, w, h)
        if (MT_CR and MT_CR.RollOver) then
            MT_CR.RollOver(s, w, h)
            return
        end

        draw.RoundedBox(0, (w / 2) - 1, 0, 2, h, Color(255, 128, 0))
    end

    local spacing = 3
    local icon_wide = 68
    local contents_wide = (spacing + icon_wide) * 100
    local MOAT_ROLL_CONTENTS = vgui.Create("DPanel", MOAT_ROLL_PNL)
    MOAT_ROLL_CONTENTS:SetSize(contents_wide, 73)
    MOAT_ROLL_CONTENTS:SetPos(contents_wide * -1, 0)
    MOAT_ROLL_CONTENTS.Paint = function(s, w, h) end
    --draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
    local table_items = table.Copy(global_table_items)
    local item_value = 0

    for i = 1, 100 do
        local m_ItemExists = false

        if (table_items[i].c) then
            m_ItemExists = true
        end

        local m_WClass = {}

        if (m_ItemExists) then
            if (table_items[i].item.Image) then
                m_WClass.WorldModel = table_items[i].item.Image
            elseif (table_items[i].item.Model) then
                m_WClass.WorldModel = table_items[i].item.Model
                m_WClass.ModelSkin = table_items[i].item.Skin
            else
                m_WClass = weapons.Get(table_items[i].w)
            end
        end

        local Item_Panel = vgui.Create("DPanel", MOAT_ROLL_CONTENTS)
        Item_Panel:SetSize(68, 68)
        Item_Panel:SetPos((spacing + icon_wide) * (i - 1), 3)
        Item_Panel.Col = ColorRand(false)

        Item_Panel.Paint = function(s, w, h)
            local draw_x = 2
            local draw_y = 2
            local draw_w = w - 4
            local draw_h = h - 4
            local draw_y2 = 2 + ((h - 4) / 2)
            local draw_h2 = (h - 4) - ((h - 4) / 2)
            draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
            draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(50, 50, 50, 150))
            local item_col = 150

            if (table_items[i].c) then
                draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150 + (item_col / 2), 150 + (item_col / 2), 150 + (item_col / 2), 100))
                surface.SetDrawColor(rarity_names[table_items[i].item.Rarity][2].r, rarity_names[table_items[i].item.Rarity][2].g, rarity_names[table_items[i].item.Rarity][2].b, 100 + item_col)
                surface.SetMaterial(gradient_d)
                surface.DrawTexturedRect(draw_x, draw_y2 - (item_col / 7), draw_w, draw_h2 + (item_col / 7) + 1)
            end

            surface.SetDrawColor(62, 62, 64, 255)

            if (table_items[i].c) then
                surface.SetDrawColor(rarity_names[table_items[i].item.Rarity][2])
            end

            surface.DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
            surface.SetDrawColor(62, 62, 64, item_col / 2)

            if (table_items[i].c) then
                surface.SetDrawColor(rarity_names[table_items[i].item.Rarity][2].r, rarity_names[table_items[i].item.Rarity][2].g, rarity_names[table_items[i].item.Rarity][2].b, item_col / 2)
            end

            surface.DrawOutlinedRect(0, 0, w, h)
        end

        local m_DPanelIcon = {}
        m_DPanelIcon.SIcon = vgui.Create("MoatModelIcon", Item_Panel)
        m_DPanelIcon.SIcon:SetPos(2, 2)
        m_DPanelIcon.SIcon:SetSize(64, 64)
        m_DPanelIcon.SIcon:SetTooltip(nil)

        m_DPanelIcon.SIcon.Think = function(s)
            s:SetTooltip(nil)
        end

        m_DPanelIcon.SIcon:SetVisible(false)

        if (m_ItemExists and m_WClass) then
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

        if (m_ItemExists and m_WClass) then
            m_DPanelIcon.WModel = m_WClass.WorldModel
            m_DPanelIcon.Item = table_items[i]
            if (m_WClass.ModelSkin) then
                m_DPanelIcon.MSkin = m_WClass.ModelSkin
            end
        end

        m_DPanelIcon.SIcon.PaintOver = function(s, w, h)
            if (table_items[i].c) then
                if (not string.EndsWith(m_DPanelIcon.WModel, ".mdl")) then
                    s.Icon:SetAlpha(0)
                    if (m_DPanelIcon.WModel:StartWith("https")) then
                        cdn.DrawImage(m_DPanelIcon.WModel, 0, 0, w, h, {r = 255, g = 255, b = 255, a = 255})
                    else
						if (m_DPanelIcon.WModel and (not s.MatPath or (s.MatPath and m_DPanelIcon.WModel ~= s.MatPath))) then
							s.MatPath = m_DPanelIcon.WModel
							s.Mat = Material(m_DPanelIcon.WModel)
						end

                        if (s.Mat) then
							surface.SetDrawColor(255, 255, 255, 255)
							surface.SetMaterial(s.Mat)
							surface.DrawTexturedRect(0, 0, w, h)
						end
                    end
                else
                    s.Icon:SetAlpha(255)
                end
            end
        end

        local m_DPanelP = vgui.Create("DPanel", Item_Panel)
        m_DPanelP:SetSize(68, 68)
        m_DPanelP:SetPos(0, 0)
        m_DPanelP.Paint = nil
    end

    local roll_contents_x, roll_y = MOAT_ROLL_CONTENTS:GetPos()
    local random_nums = {-27, -12, 16, 34}
    local roll_to = random_nums[math.random(1, 4)]

    MOAT_ROLL_CONTENTS.Think = function(s, w, h)
        if (math.abs(roll_contents_x - roll_to) < 1) then return end
            
            if (math.abs(roll_contents_x - roll_to) > 1500) then
                roll_contents_x = math.Approach(roll_contents_x, roll_to, 1500 * FrameTime())
            else
                roll_contents_x = Lerp(0.9 * FrameTime(), roll_contents_x, roll_to)
            end

        if (math.floor(roll_contents_x / 71) ~= item_value) then
            -- LocalPlayer():EmitSound("moatsounds/pop1.wav")
			sfx.Tick()
        end

        s:SetPos(roll_contents_x, roll_y)
        item_value = math.floor(roll_contents_x / 71)

        if (math.abs(roll_contents_x - roll_to) < 1) then
            net.Start("MOAT_CRATE_DONE")
            net.SendToServer()

            if (IsValid(MOAT_CRATE_BG)) then
                MOAT_CRATE_BG:Remove()
                MOAT_CRATE_FRAME:Remove()
            end
        end
    end
end

function m_InitCrateWindow(itemtbl, item_crate_slot, item_crate_class, preview)
	if (itemtbl.u) then
		itemtbl.item = GetItemFromEnum(itemtbl.u)
	end

	itemtbl.item.Contents = GetCrateContents(itemtbl.item.Collection)

    local MT = MOAT_THEME.Themes
    local CurTheme = GetConVar("moat_Theme"):GetString()
    if (not MT[CurTheme]) then
        CurTheme = "Original"
    end
    local MT_CR = MT[CurTheme].Crate



    global_table_items = {}
    MOAT_CRATE_BG = vgui.Create("DFrame")
    MOAT_CRATE_BG:SetSize(ScrW(), ScrH())
    MOAT_CRATE_BG:SetTitle("")
    MOAT_CRATE_BG:MakePopup()
    MOAT_CRATE_BG:SetKeyBoardInputEnabled(false)
    MOAT_CRATE_BG:Center()
    MOAT_CRATE_BG:ShowCloseButton(false)
    MOAT_CRATE_BG:SetDraggable(false)
    MOAT_CRATE_BG:RequestFocus()
    MOAT_CRATE_BG:SetDrawOnTop(true)
    MOAT_CRATE_BG:MoveToFront()
    MOAT_CRATE_BG:SetAlpha(0)

    MOAT_CRATE_BG.Paint = function(s, w, h)
        DrawBlur(s, 3)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
    end

    MOAT_CRATE_BG:AlphaTo(210, 1, 0)
    MOAT_CRATE_FRAME = vgui.Create("DFrame")
    MOAT_CRATE_FRAME:SetSize(550, 500)
    MOAT_CRATE_FRAME:SetTitle("")
    MOAT_CRATE_FRAME:MakePopup()
    MOAT_CRATE_FRAME:SetKeyBoardInputEnabled(false)
    MOAT_CRATE_FRAME:Center()
    MOAT_CRATE_FRAME:SetBackgroundBlur(true)
    MOAT_CRATE_FRAME:ShowCloseButton(false)
    MOAT_CRATE_FRAME:SetDraggable(true)
    MOAT_CRATE_FRAME:RequestFocus()
    MOAT_CRATE_FRAME:SetDrawOnTop(true)
    MOAT_CRATE_FRAME:MoveToFront()

    MOAT_CRATE_FRAME.OnClose = function()
        MOAT_CRATE_BG:Remove()
    end

    MOAT_CRATE_FRAME.TitleText = "Please wait to open your crate."

    if (preview) then MOAT_CRATE_FRAME.TitleText = "This is a preview of the crate." end
    
    MOAT_CRATE_FRAME:SetAlpha(0)

    MOAT_CRATE_FRAME.Paint = function(s, w, h)
        if (MT_CR and MT_CR.BG) then
            MT_CR.BG(s, w, h, itemtbl)
            return
        end

        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, w, 25)
        surface.DrawLine(0, 25 + (70 * 2), w, 25 + (70 * 2))
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, w, 26)
        surface.DrawLine(0, 26 + (70 * 2), w, 26 + (70 * 2))
        m_DrawShadowedText(1, itemtbl.item.Name, "Trebuchet24", w / 2, 26, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        m_DrawShadowedText(1, s.TitleText, "moat_ItemDesc", 13, 5, Color(255, 255, 255))
    end

    MOAT_CRATE_FRAME:AlphaTo(255, 1, 0)
    local MOAT_CRATE = vgui.Create("DPanel", MOAT_CRATE_FRAME)
    MOAT_CRATE:SetSize(68, 68)
    MOAT_CRATE:SetPos(275 - (68 / 2), (crate_pnl_height * 2) - 87)

    MOAT_CRATE.Paint = function(s, w, h)
        local draw_x = 2
        local draw_y = 2
        local draw_w = w - 4
        local draw_h = h - 4
        local draw_y2 = 2 + ((h - 4) / 2)
        local draw_h2 = (h - 4) - ((h - 4) / 2)
        draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(0, 0, 0, 100))
        draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(50, 50, 50, 150))
        local item_col = 150
        draw.RoundedBox(0, draw_x, draw_y, draw_w, draw_h, Color(150 + (item_col / 2), 150 + (item_col / 2), 150 + (item_col / 2), 100))
        surface.SetDrawColor(rarity_names[itemtbl.item.Rarity][2].r, rarity_names[itemtbl.item.Rarity][2].g, rarity_names[itemtbl.item.Rarity][2].b, 100 + item_col)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(draw_x, draw_y2 - (item_col / 7), draw_w, draw_h2 + (item_col / 7) + 1)
        surface.SetDrawColor(62, 62, 64, 255)
        surface.SetDrawColor(rarity_names[itemtbl.item.Rarity][2])
        surface.DrawOutlinedRect(draw_x - 1, draw_y - 1, draw_w + 2, draw_h + 2)
        surface.SetDrawColor(62, 62, 64, item_col / 2)
        surface.SetDrawColor(rarity_names[itemtbl.item.Rarity][2].r, rarity_names[itemtbl.item.Rarity][2].g, rarity_names[itemtbl.item.Rarity][2].b, item_col / 2)
        surface.DrawOutlinedRect(0, 0, w, h)
        
        if (itemtbl.item.Image:StartWith("https")) then
            cdn.DrawImage(itemtbl.item.Image, 2, 2, 64, 64, {r = 255, g = 255, b = 255, a = 255})
        else
			if (itemtbl.item.Image and (not s.MatPath or (s.MatPath and itemtbl.item.Image ~= s.MatPath))) then
				s.MatPath = itemtbl.item.Image
				s.Mat = Material(itemtbl.item.Image)
			end

            if (s.Mat) then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(s.Mat)
				surface.DrawTexturedRect(2, 2, 64, 64)
			end
        end
    end

    local crate_lower_panel = {
        x = 10,
        y = 35 + (crate_pnl_height * 2),
        w = MOAT_CRATE_FRAME:GetWide() - 20,
        h = MOAT_CRATE_FRAME:GetTall() - (35 + (crate_pnl_height * 2)) - 10
    }

    local MOAT_CRATE_LP = vgui.Create("DPanel", MOAT_CRATE_FRAME)
    MOAT_CRATE_LP:SetPos(crate_lower_panel.x, crate_lower_panel.y)
    MOAT_CRATE_LP:SetSize(crate_lower_panel.w, crate_lower_panel.h)
    local crate_contents = {}

    for k, v in pairs(itemtbl.item.Contents) do
        for k2, v2 in pairs(v) do
            local tbl = {}
            tbl.Kind = tostring(k)
            tbl.Name = v2.name or nil
            tbl.Color = v2.color or nil
            tbl.Effect = v2.effect or nil
            tbl.Rarity = v2.rarity or 1
            tbl.Skin = v2.iskin or nil
            tbl.Model = v2.model or nil
            tbl.ID = v2.id or nil

            if (tbl.Kind == "tier") then
                tbl.Kind = "Tier"
                tbl.Name = tbl.Name .. " Weapon"
            end

            table.insert(crate_contents, tbl)
        end
    end

    table.sort(crate_contents, function(a, b) return a.Rarity < b.Rarity end)

    if (itemtbl.item.Name == "50/50 Crate") then
        crate_contents = "no"
    end

    MOAT_CRATE_LP.Paint = function(s, w, h)
        if (MT_CR and MT_CR.Panel) then
            MT_CR.Panel(s, w, h, crate_contents)
            return
        end

        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        m_DrawShadowedText(1, "This crate contains one of the following " .. #crate_contents .. " items:", "moat_ItemDesc", 5, 2, Color(200, 200, 200))
    end

    local MOAT_CRATE_SCRL = vgui.Create("DScrollPanel", MOAT_CRATE_LP)
    MOAT_CRATE_SCRL:SetPos(0, 20)
    MOAT_CRATE_SCRL:SetSize(MOAT_CRATE_LP:GetWide(), MOAT_CRATE_LP:GetTall() - 20)
    local sbar = MOAT_CRATE_SCRL:GetVBar()
    m_PaintVBar(sbar)

    local scroll_w, scroll_h = MOAT_CRATE_SCRL:GetWide(), MOAT_CRATE_SCRL:GetTall()
    local MOAT_CRATE_IL = vgui.Create("DIconLayout", MOAT_CRATE_SCRL)
    MOAT_CRATE_IL:SetPos(0, 0)
    MOAT_CRATE_IL:SetSize(scroll_w, scroll_h)
    MOAT_CRATE_IL:SetSpaceX(0)
    MOAT_CRATE_IL:SetSpaceY(5)

    local function IsHovering(self, w, h, x, y)

        local xx, yy = self:CursorPos()

        if (xx > x and xx < x + w and yy > y and yy < y + h) then
            return true
        else
            return false
        end
    end

    local custom_preview = GetConVar("moat_model_preview"):GetBool()

    local MOAT_ITEM_PREVIEW = vgui.Create("MOAT_PlayerPreview")
    MOAT_ITEM_PREVIEW:SetSize(350, 550)
    MOAT_ITEM_PREVIEW:SetPos(-275, 0)
    MOAT_ITEM_PREVIEW.DefaultModel = GetGlobal("ttt_default_playermodel") or "models/player/phoenix.mdl"
    MOAT_ITEM_PREVIEW:SetModel(MOAT_ITEM_PREVIEW.DefaultModel)
    MOAT_ITEM_PREVIEW:SetText("")
    MOAT_ITEM_PREVIEW:SetDrawOnTop(true)
    MOAT_ITEM_PREVIEW.HoveringModel = false

    if (m_Loadout and m_Loadout[10] and m_Loadout[10].item and m_Loadout[10].item.Kind == "Model") then
        MOAT_ITEM_PREVIEW:SetModel(m_Loadout[10].u)
        MOAT_ITEM_PREVIEW.DefaultModel = m_Loadout[10].u
    end

    MOAT_ITEM_PREVIEW.CustomThink = function(s)
        if (not IsValid(MOAT_CRATE_FRAME)) then s:Remove() return end

        local x, y = gui.MousePos()
        s:SetPos(x + 1, y - 275)

        s:SetTooltip(nil)

        if (not IsHovering(MOAT_CRATE_FRAME, crate_lower_panel.w, crate_lower_panel.h, crate_lower_panel.x, crate_lower_panel.y)) then
            s:SetSize(0, 0)
            return
        else
            s:SetSize(350, 550)
        end

        if (not s.HoveringModel) then
            s:SetSize(0, 0)
        else
            s:SetSize(350, 550)
        end
    end

    if (not custom_preview and IsValid(MOAT_CRATE_PREVIEW)) then MOAT_ITEM_PREVIEW:Remove() end

    local MOAT_CRATE_PREVIEW = vgui.Create("MoatModelIcon", MOAT_CRATE_FRAME)
    MOAT_CRATE_PREVIEW:SetModel("models/props_borealis/bluebarrel001.mdl")
    MOAT_CRATE_PREVIEW:SetTooltip(nil)
    MOAT_CRATE_PREVIEW:SetPos(0, 0)
    MOAT_CRATE_PREVIEW:SetSize(64, 64)
    MOAT_CRATE_PREVIEW:SetDrawOnTop(true)
    MOAT_CRATE_PREVIEW.Mdl = {}
    MOAT_CRATE_PREVIEW.Think = function(s)
        if (not IsValid(MOAT_CRATE_FRAME)) then s:Remove() return end

        local x, y = MOAT_CRATE_FRAME:CursorPos()
        s:SetPos(x + 1, y - 65)

        s:SetTooltip(nil)

        if (not IsHovering(MOAT_CRATE_FRAME, crate_lower_panel.w, crate_lower_panel.h, crate_lower_panel.x, crate_lower_panel.y)) then
            s:SetSize(0, 0)
            return
        else
            s:SetSize(64, 64)
        end


        if (s.Mdl and (s.Mdl.mdl or s.Mdl.skn)) then
            s:SetModel(s.Mdl.mdl, s.Mdl.skn)
            s:SetAlpha(255)
        else
            s:SetAlpha(0)
        end
    end

    if (custom_preview and IsValid(MOAT_CRATE_PREVIEW)) then MOAT_CRATE_PREVIEW:Remove() end

    local function IsHovering(self, w, h, x, y)

        local xx, yy = self:CursorPos()

        if (xx > x and xx < x + w and yy > y and yy < y + h) then
            return true
        else
            return false
        end
    end
    MOAT_CRATE_FRAME.Think = function(s)
        s:RequestFocus()
        s:MoveToFront()
    end

    function m_AddItemToContents(tbl)
        local M_ITEM = MOAT_CRATE_IL:Add("DPanel")
        M_ITEM:SetSize(scroll_w, 22)
        M_ITEM.Item = tbl
        M_ITEM.Paint = function(s, w, h)
            local ITEM_NAME_FULL = tbl.Name
            local name_col = tbl.Color or rarity_names[tbl.Rarity][2]:Copy()
            local name_font = "Trebuchet24"
            local draw_name_x = 10
            local draw_name_y = 0

            if (tbl.Effect) then
                local tfx = tbl.Effect

                if (tfx == "glow") then
                    m_DrawGlowingText(false, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "fire") then
                    m_DrawFireText(tbl.Rarity, ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "bounce") then
                    m_DrawBouncingText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, true)
                elseif (tfx == "enchanted") then
                    m_DrawEnchantedText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, nil, nil, nil, true)
                elseif (tfx == "electric") then
                    m_DrawElecticText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col, true)
                else
                    emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
                end
            else
                emoji.SimpleText(ITEM_NAME_FULL, name_font, draw_name_x, draw_name_y, name_col)
            end
        end

        M_ITEM.OnCursorEntered = function(s)
            if (not custom_preview and IsValid(MOAT_CRATE_PREVIEW)) then
                if (s.Item.Model) then
                    MOAT_CRATE_PREVIEW.Mdl = {mdl = s.Item.Model, skn = s.Item.Skin or nil}
                end
                return
            end
            if (s.Item.ID and s.Item.Model and MOAT_ITEM_PREVIEW and IsValid(MOAT_ITEM_PREVIEW)) then
                if (s.Item.Kind == "Model") then
                    MOAT_ITEM_PREVIEW:SetModel(s.Item.ID)
                else
                    MOAT_ITEM_PREVIEW:AddModel(s.Item.ID)
                end

                MOAT_ITEM_PREVIEW.HoveringModel = s.Item.ID
            end
        end
        M_ITEM.OnCursorExited = function(s)
            if (not custom_preview and IsValid(MOAT_CRATE_PREVIEW)) then
                MOAT_CRATE_PREVIEW.Mdl = {}
                return
            end

            if (not s.Item.ID or not s.Item.Model) then return end
			if (not (MOAT_ITEM_PREVIEW and IsValid(MOAT_ITEM_PREVIEW))) then return end

            if (s.Item.Kind == "Model") then
                MOAT_ITEM_PREVIEW:SetModel(MOAT_ITEM_PREVIEW.DefaultModel)
            else
                MOAT_ITEM_PREVIEW:RemoveModel(s.Item.ID)
            end

            if (MOAT_ITEM_PREVIEW.HoveringModel and MOAT_ITEM_PREVIEW.HoveringModel == s.Item.ID) then
                MOAT_ITEM_PREVIEW.HoveringModel = nil
            end
        end
    end

    if (type(crate_contents) ~= "table" and crate_contents == "no") then
        local table_rarity = {
            Name = "High-End Item",
            Rarity = 5
        }

        m_AddItemToContents(table_rarity)

        local table_rarity = {
            Name = "Worn Item",
            Rarity = 1
        }

        m_AddItemToContents(table_rarity)
    else
        for k, v in pairs(crate_contents) do
            m_AddItemToContents(v)
        end
    end

    local MOAT_CRATE_C = vgui.Create("DButton", MOAT_CRATE_FRAME)

    if (MT_CR and MT_CR.CloseB) then
        MOAT_CRATE_C:SetPos(MOAT_CRATE_FRAME:GetWide() - MT_CR.CloseB[1], MT_CR.CloseB[2])
        MOAT_CRATE_C:SetSize(MT_CR.CloseB[3], MT_CR.CloseB[4])
    else
        MOAT_CRATE_C:SetPos(MOAT_CRATE_FRAME:GetWide() - 36, 3)
        MOAT_CRATE_C:SetSize(33, 19)
    end

    MOAT_CRATE_C:SetText("")
    MOAT_CRATE_C.Paint = function(s, w, h)
        if (MT_CR and MT_CR.CLOSE_PAINT) then
            MT_CR.CLOSE_PAINT(s, w, h)
            return
        end

        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 15))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 20))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end

    MOAT_CRATE_C.DoClick = function()
        MOAT_CRATE_BG:Remove()
        MOAT_CRATE_FRAME:Remove()
        if (preview) then return end

        net.Start("MOAT_CRATE_DONE")
        net.SendToServer()
    end

    if (preview) then return end

    local hover_coloral = 0
    
    local MOAT_CRATE_OPEN = vgui.Create("DButton", MOAT_CRATE_FRAME)
    MOAT_CRATE_OPEN:SetSize(125, 30)
    MOAT_CRATE_OPEN:SetPos(275 - (125 / 2), (crate_pnl_height * 2) - 14)
    MOAT_CRATE_OPEN:SetText("")
    MOAT_CRATE_OPEN.Clicked = false

    MOAT_CRATE_OPEN.Paint = function(s, w, h)
        if (MT_CR and MT_CR.Open_Background) then
            surface.SetDrawColor(0, 0, 0, 245)
            surface.DrawRect(0, 0, w, h)
        end

        local green_col = 200

        if (not IsValid(s)) then MOAT_CRATE_BG:Remove() MOAT_CRATE_FRAME:Remove() return end

        if (s:GetDisabled()) then
            green_col = 50
        end

        surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, green_col, 0, 20 + hover_coloral / 5)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, green_col + 55, 0, 20 + hover_coloral / 5)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        local accept_text = "OPEN"
        m_DrawShadowedText(1, accept_text, "Trebuchet24", w / 2, h / 2, Color(100, 200, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local btn_hovered = 1
    local btn_color_a = false

    MOAT_CRATE_OPEN.Think = function(s)
        if (#global_table_items < 100 or s.Clicked) then
            s:SetDisabled(true)

            if (s.Clicked) then
                if (not MOAT_CRATE_FRAME.Finished) then
                    MOAT_CRATE_FRAME.TitleText = "Seeing what's inside..."
                else
                    MOAT_CRATE_FRAME.TitleText = "You have received your item!"
                end
            end
        else
            MOAT_CRATE_FRAME.TitleText = "Click the open button to see what's inside!"
            s:SetDisabled(false)
        end

        if (not s:IsHovered()) then
            btn_hovered = 0
            btn_color_a = false

            if (hover_coloral > 0) then
                hover_coloral = Lerp(2 * FrameTime(), hover_coloral, 0)
            end
        else
            if (hover_coloral < 154 and btn_hovered == 0) then
                hover_coloral = Lerp(5 * FrameTime(), hover_coloral, 155)
            else
                btn_hovered = 1
            end

            if (btn_hovered == 1) then
                if (btn_color_a) then
                    if (hover_coloral >= 154) then
                        btn_color_a = false
                    else
                        hover_coloral = hover_coloral + (100 * FrameTime())
                    end
                else
                    if (hover_coloral <= 50) then
                        btn_color_a = true
                    else
                        hover_coloral = hover_coloral - (100 * FrameTime())
                    end
                end
            end
        end
    end

    MOAT_CRATE_OPEN.DoClick = function(s)
        MOAT_CRATE:SetVisible(false)
        s.Clicked = true
        m_StartCrateRoll(item_crate_slot, item_crate_class, MOAT_CRATE_FRAME)
    end
end

net.Receive("MOAT_VERIFY_CRATE", function(len)
    local item_class = net.ReadDouble()
    local item_slot = net.ReadDouble()
    local item_tbl = {}

    for k, v in pairs(m_Inventory) do
        if (v.c and tonumber(v.c) == item_class) then
            item_tbl = v
        end
    end

    if (IsValid(MOAT_CRATE_BG)) then
        return
    end

    m_InitCrateWindow(item_tbl, item_slot, item_class)
    net.Start("MOAT_INIT_CRATE")
    net.SendToServer()
end)

local function m_AddItemToTable(tbl)
    table.insert(global_table_items, tbl)
end

net.Receive("MOAT_ITEMS_CRATE", function(len)
    local tbl = net.ReadTable()
	if (tbl.u) then
		tbl.item = GetItemFromEnum(tbl.u)
	end

    m_AddItemToTable(tbl)
end)