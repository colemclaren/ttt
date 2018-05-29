local m_LoadoutLabels = {"Primary", "Secondary", "Melee", "Power-Up", "Other", "Head", "Mask", "Body", "Effect", "Model"}
local m_SlotToLoadout = {}
hook.Add("Initialize", "MOAT_INV.Swap", function()
    m_SlotToLoadout[WEAPON_MELEE] = "Melee"
    m_SlotToLoadout[WEAPON_PISTOL] = "Secondary"
    m_SlotToLoadout[WEAPON_HEAVY] = "Primary"
end)
if (WEAPON_MELEE) then
    m_SlotToLoadout[WEAPON_MELEE] = "Melee"
    m_SlotToLoadout[WEAPON_PISTOL] = "Secondary"
    m_SlotToLoadout[WEAPON_HEAVY] = "Primary"
end

local function m_CanSwapLoadout(ITEM_TBL, DRAG_SLOT)
    if (ITEM_TBL.c == nil) then return true end
    if (ITEM_TBL.item.Kind == "Power-Up") then return DRAG_SLOT == 4 end
    if (ITEM_TBL.item.Kind == "Other") then return DRAG_SLOT == 5 end
    if (ITEM_TBL.item.Kind == "Hat") then return DRAG_SLOT == 6 end
    if (ITEM_TBL.item.Kind == "Mask") then return DRAG_SLOT == 7 end
    if (ITEM_TBL.item.Kind == "Body") then return DRAG_SLOT == 8 end
    if (ITEM_TBL.item.Kind == "Effect") then return DRAG_SLOT == 9 end
    if (ITEM_TBL.item.Kind == "Model") then return DRAG_SLOT == 10 end
    if (not ITEM_TBL.w) then return false end

    return m_SlotToLoadout[weapons.Get(ITEM_TBL.w).Kind] == m_LoadoutLabels[DRAG_SLOT]
end

function MOAT_INV:SwapSlotPanels(pnl1, pnl2)
    local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG.Slot].VGUI.WModel
    local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot].VGUI.WModel
    local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG.Slot].VGUI.MSkin
    local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot].VGUI.MSkin
    local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG.Slot].VGUI.Item
    local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot].VGUI.Item
    local M_INV_TBL1 = m_Inventory[m_HoveredSlot]
    local M_INV_TBL2 = m_Inventory[M_INV_DRAG.Slot]

    if (M_INV_SLOT[M_INV_DRAG.Slot].VGUI.WModel) then
        if (string.EndsWith(M_INV_SLOT[M_INV_DRAG.Slot].VGUI.WModel, ".mdl")) then
            M_INV_SLOT[m_HoveredSlot].VGUI.SIcon.Icon:SetAlpha(255)
        else
            M_INV_SLOT[m_HoveredSlot].VGUI.SIcon.Icon:SetAlpha(0)
        end

        M_INV_SLOT[m_HoveredSlot].VGUI.SIcon:SetModel(M_INV_SLOT[M_INV_DRAG.Slot].VGUI.WModel, M_INV_SLOT[M_INV_DRAG.Slot].VGUI.MSkin)
        M_INV_SLOT[m_HoveredSlot].VGUI.SIcon:SetVisible(true)
    else
        M_INV_SLOT[m_HoveredSlot].VGUI.SIcon:SetVisible(false)
    end

    if (M_INV_SLOT[m_HoveredSlot].VGUI.WModel) then
        if (string.EndsWith(M_INV_SLOT[m_HoveredSlot].VGUI.WModel, ".mdl")) then
            M_INV_SLOT[M_INV_DRAG.Slot].VGUI.SIcon.Icon:SetAlpha(255)
        else
            M_INV_SLOT[M_INV_DRAG.Slot].VGUI.SIcon.Icon:SetAlpha(0)
        end

        M_INV_SLOT[M_INV_DRAG.Slot].VGUI.SIcon:SetModel(M_INV_SLOT[m_HoveredSlot].VGUI.WModel, M_INV_SLOT[m_HoveredSlot].VGUI.MSkin)
        M_INV_SLOT[M_INV_DRAG.Slot].VGUI.SIcon:SetVisible(true)
    else
        M_INV_SLOT[M_INV_DRAG.Slot].VGUI.SIcon:SetVisible(false)
    end

    M_INV_SLOT[M_INV_DRAG.Slot].VGUI.WModel = M_INV_SLOT2_ICON
    M_INV_SLOT[m_HoveredSlot].VGUI.WModel = M_INV_SLOT1_ICON
    M_INV_SLOT[M_INV_DRAG.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
    M_INV_SLOT[m_HoveredSlot].VGUI.MSkin = M_INV_SLOT1_SKIN
    M_INV_SLOT[M_INV_DRAG.Slot].VGUI.Item = M_INV_SLOT2_ITEM
    M_INV_SLOT[m_HoveredSlot].VGUI.Item = M_INV_SLOT1_ITEM
    m_Inventory[m_HoveredSlot] = M_INV_TBL2
    m_Inventory[M_INV_DRAG.Slot] = M_INV_TBL1
end

local function TranslateVGUISlot(slot)
    if (isnumber(slot)) then
        return slot
    end
    if (slot and slot:EndsWith "l") then
        return -tonumber(slot:sub(1, -2))
    end
    return tonumber(slot) or math.huge
end


function m_SwapInventorySlots(drag, m_HoveredSlot, m_tid)
    if (drag.Slot == m_HoveredSlot or INV_SELECT_MODE) then
        return
    end

    local islot_d, islot_e = TranslateVGUISlot(drag.Slot), TranslateVGUISlot(m_HoveredSlot)
    local ends = M_INV_SLOT[m_HoveredSlot]
    if (not ends) then
        ends = M_LOAD_SLOT[-islot_e]
        if (ends) then
            drag, ends = ends, drag
            islot_d, islot_e = islot_e, islot_d
        else
            return
        end
    end


    -- Under no circumstances it will be possible to transfer loadout to loadout
    if (islot_d < 0 and islot_e < 0) then
        return
    end

    local tbl_drag, tbl_hovr = islot_d < 0 and m_Loadout or m_Inventory, m_Inventory

    local id = ends.VGUI.Item and ends.VGUI.Item.c or 0
    -- Check if you can transfer loadout to regular inventory
    if ((islot_d < 0) ~= (islot_e < 0) and id ~= 0 and not m_CanSwapLoadout(ends.VGUI.Item, -islot_d)) then
        return
    end
    if (islot_d < 0) then
        net.Start "MOAT_INV.Swap"
            net.WriteUInt(id, 32)
            if (id == 0) then
                net.WriteByte(-islot_d)
            end
            print("pls equip ", id)
        net.SendToServer()
    end

    MOAT_INV:SwapSlotItem(islot_d, islot_e)

    if (drag.VGUI.WModel) then
        if (string.EndsWith(drag.VGUI.WModel, ".mdl")) then
            ends.VGUI.SIcon.Icon:SetAlpha(255)
        else
            ends.VGUI.SIcon.Icon:SetAlpha(0)
        end

        ends.VGUI.SIcon:SetModel(drag.VGUI.WModel, drag.VGUI.MSkin)
        ends.VGUI.SIcon:SetVisible(true)
    else
        ends.VGUI.SIcon:SetVisible(false)
    end

    if (ends.VGUI.WModel) then
        if (string.EndsWith(ends.VGUI.WModel, ".mdl")) then
            drag.VGUI.SIcon.Icon:SetAlpha(255)
        else
            drag.VGUI.SIcon.Icon:SetAlpha(0)
        end

        drag.VGUI.SIcon:SetModel(ends.VGUI.WModel, ends.VGUI.MSkin)
        drag.VGUI.SIcon:SetVisible(true)
    else
        drag.VGUI.SIcon:SetVisible(false)
    end

    drag.VGUI.WModel, ends.VGUI.WModel = ends.VGUI.WModel, drag.VGUI.WModel
    drag.VGUI.MSkin, ends.VGUI.MSkin = ends.VGUI.MSkin, drag.VGUI.MSkin
    drag.VGUI.Item, ends.VGUI.Item = ends.VGUI.Item, drag.VGUI.Item
    islot_d, islot_e = math.abs(islot_d), math.abs(islot_e)
    tbl_drag[islot_d], tbl_hovr[islot_e] = tbl_hovr[islot_e], tbl_drag[islot_d]
end


/*function m_SwapInventorySlots(M_INV_DRAG, m_HoveredSlot, m_tid)
    if (INV_SELECT_MODE) then return end
    if (m_HoveredSlot and M_INV_DRAG.Slot and M_INV_DRAG.Slot ~= m_HoveredSlot) then
        if (string.EndsWith(tostring(M_INV_DRAG.Slot), "t") or string.EndsWith(tostring(m_HoveredSlot), "t")) then
            if (string.EndsWith(tostring(M_INV_DRAG.Slot), "t") and not string.EndsWith(tostring(m_HoveredSlot), "t")) then
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG.Slot), 1, tostring(M_INV_DRAG.Slot):len() - 1))
                if (DRAG_SLOT > 10) then return end
                net.Start("MOAT_TRADE_REM")
                net.WriteDouble(m_HoveredSlot)
                net.WriteDouble(DRAG_SLOT)
                net.WriteString(m_Inventory[m_HoveredSlot].c or "")
                net.WriteString(m_Trade[DRAG_SLOT].c or "")
                net.WriteDouble(tonumber(m_tid))
                net.SendToServer()
            elseif (not string.EndsWith(tostring(M_INV_DRAG.Slot), "t") and string.EndsWith(tostring(m_HoveredSlot), "t")) then
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))
                if (HVRD_SLOT > 10) then return end
                net.Start("MOAT_TRADE_ADD")
                net.WriteDouble(HVRD_SLOT)
                net.WriteDouble(M_INV_DRAG.Slot)
                net.WriteString(m_Trade[HVRD_SLOT].c or "")
                net.WriteString(m_Inventory[M_INV_DRAG.Slot].c or "")
                net.WriteDouble(tonumber(m_tid))
                net.SendToServer()
            else
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG.Slot), 1, tostring(M_INV_DRAG.Slot):len() - 1))
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))
                if (DRAG_SLOT > 10) then return end
                if (HVRD_SLOT > 10) then return end
                net.Start("MOAT_TRADE_SWAP")
                net.WriteDouble(HVRD_SLOT)
                net.WriteDouble(DRAG_SLOT)
                net.WriteString(m_Trade[HVRD_SLOT].c or "")
                net.WriteString(m_Trade[DRAG_SLOT].c or "")
                net.WriteDouble(tonumber(m_tid))
                net.SendToServer()
            end
        elseif (string.EndsWith(tostring(M_INV_DRAG.Slot), "l") or string.EndsWith(tostring(m_HoveredSlot), "l")) then
            if (string.EndsWith(tostring(M_INV_DRAG.Slot), "l") and not string.EndsWith(tostring(m_HoveredSlot), "l")) then
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG.Slot), 1, tostring(M_INV_DRAG.Slot):len() - 1))
                net.Start("MOAT_SWP_INV_ITEM")
                net.WriteString("slot" .. m_HoveredSlot)
                net.WriteString("l_slot" .. DRAG_SLOT)
                net.WriteString(m_Inventory[m_HoveredSlot].c or "")
                net.WriteString(m_Loadout[DRAG_SLOT].c or "")
                net.SendToServer()
                if (LOAD_BLOCK or 0) < CurTime() then
                    timer.Simple(0.1,function() m_SaveLoadout() end)
                end
            elseif (not string.EndsWith(tostring(M_INV_DRAG.Slot), "l") and string.EndsWith(tostring(m_HoveredSlot), "l")) then
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))
                net.Start("MOAT_SWP_INV_ITEM")
                net.WriteString("l_slot" .. HVRD_SLOT)
                net.WriteString("slot" .. M_INV_DRAG.Slot)
                net.WriteString(m_Loadout[HVRD_SLOT].c or "")
                net.WriteString(m_Inventory[M_INV_DRAG.Slot].c or "")
                net.SendToServer()
                if (LOAD_BLOCK or 0) < CurTime() then
                    timer.Simple(0.1,function() m_SaveLoadout() end)
                end
            else
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG.Slot), 1, tostring(M_INV_DRAG.Slot):len() - 1))
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))
                net.Start("MOAT_SWP_INV_ITEM")
                net.WriteString("l_slot" .. HVRD_SLOT)
                net.WriteString("l_slot" .. DRAG_SLOT)
                net.WriteString(m_Loadout[HVRD_SLOT].c or "")
                net.WriteString(m_Loadout[DRAG_SLOT].c or "")
                net.SendToServer()
            end
        else
            net.Start("MOAT_SWP_INV_ITEM")
            net.WriteString("slot" .. m_HoveredSlot)
            net.WriteString("slot" .. M_INV_DRAG.Slot)
            net.WriteString(m_Inventory[m_HoveredSlot].c or "")
            net.WriteString(m_Inventory[M_INV_DRAG.Slot].c or "")
            net.SendToServer()
        end
    else
        M_INV_DRAG.VGUI.SIcon:SetVisible(true)
    end
end

local m_LoadoutLabels = {"Primary", "Secondary", "Melee", "Power-Up", "Other", "Head", "Mask", "Body", "Effect", "Model"}
local m_SlotToLoadout = {}
m_SlotToLoadout[0] = "Melee"
m_SlotToLoadout[1] = "Secondary"
m_SlotToLoadout[2] = "Primary"

function m_CanSwapLoadout(ITEM_TBL, DRAG_SLOT)
    if (ITEM_TBL.c == nil) then return true end
    if (ITEM_TBL.item.Kind == "Power-Up") then return DRAG_SLOT == 4 end
    if (ITEM_TBL.item.Kind == "Other") then return DRAG_SLOT == 5 end
    if (ITEM_TBL.item.Kind == "Hat") then return DRAG_SLOT == 6 end
    if (ITEM_TBL.item.Kind == "Mask") then return DRAG_SLOT == 7 end
    if (ITEM_TBL.item.Kind == "Body") then return DRAG_SLOT == 8 end
    if (ITEM_TBL.item.Kind == "Effect") then return DRAG_SLOT == 9 end
    if (ITEM_TBL.item.Kind == "Model") then return DRAG_SLOT == 10 end

    return m_SlotToLoadout[weapons.Get(ITEM_TBL.w).Slot] == m_LoadoutLabels[DRAG_SLOT]
end

local WeaponLoadoutSlots = {}
WeaponLoadoutSlots[0] = 3
WeaponLoadoutSlots[1] = 2
WeaponLoadoutSlots[2] = 1

function m_GetCorrectLoadoutSlot(ITEM_TBL)
    if (ITEM_TBL.c == nil) then return end
    if (ITEM_TBL.item.Kind == "Power-Up") then return 4 end
    if (ITEM_TBL.item.Kind == "Other") then return 5 end
    if (ITEM_TBL.item.Kind == "Hat") then return 6 end
    if (ITEM_TBL.item.Kind == "Mask") then return 7 end
    if (ITEM_TBL.item.Kind == "Body") then return 8 end
    if (ITEM_TBL.item.Kind == "Effect") then return 9 end
    if (ITEM_TBL.item.Kind == "Model") then return 10 end

    return WeaponLoadoutSlots[weapons.Get(ITEM_TBL.w).Slot]
end

local function m_SwapInventorySlotsFromServer(M_INV_DRAG3, m_HoveredSlot3)
    if (m_HoveredSlot3 and M_INV_DRAG3.Slot and M_INV_DRAG3.Slot ~= m_HoveredSlot3) then
        if (string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and not string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
            local M_INV_SLOT1_ICON = M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel
            local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_TRADE_SLOT[DRAG_SLOT].VGUI.Item
            local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item
            local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
            local M_INV_TBL2 = table.Copy(m_Trade[DRAG_SLOT])

            if (M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel) then
                if (string.EndsWith(M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel, ".mdl")) then
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetModel(M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel, M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin)
                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(true)
            else
                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(false)
            end

            if (M_INV_SLOT[m_HoveredSlot3].VGUI.WModel) then
                if (string.EndsWith(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, ".mdl")) then
                    M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetModel(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin)
                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
            else
                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(false)
            end

            M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
            M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
            M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_TRADE_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
            M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM
            m_Inventory[m_HoveredSlot3] = M_INV_TBL2
            m_Trade[DRAG_SLOT] = M_INV_TBL1

            if (IsValid(MOAT_TRADE_BG)) then
                MOAT_TRADE_BG.ConfirmTime = 5
                MOAT_TRADE_BG.ACCEPTED = 0
                net.Start("MOAT_TRADE_STATUS")
                net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
                net.WriteDouble(m_utrade)
                local eslots = m_GetESlots()
                net.WriteDouble(eslots)
                net.SendToServer()
            end
        elseif (not string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
            local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
            local M_INV_SLOT2_ICON = M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
            local M_INV_SLOT2_ITEM = M_TRADE_SLOT[HVRD_SLOT].VGUI.Item
            local M_INV_TBL1 = table.Copy(m_Trade[HVRD_SLOT])
            local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])

            if (M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel) then
                if (string.EndsWith(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, ".mdl")) then
                    M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetModel(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin)
                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true)
            else
                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(false)
            end

            if (M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel) then
                if (string.EndsWith(M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel, ".mdl")) then
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetModel(M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel, M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin)
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(true)
            else
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(false)
            end

            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
            M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
            M_TRADE_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
            m_Trade[HVRD_SLOT] = M_INV_TBL2
            m_Inventory[M_INV_DRAG3.Slot] = M_INV_TBL1

            if (IsValid(MOAT_TRADE_BG)) then
                MOAT_TRADE_BG.ConfirmTime = 5
                MOAT_TRADE_BG.ACCEPTED = 0
                net.Start("MOAT_TRADE_STATUS")
                net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
                net.WriteDouble(m_utrade)
                local eslots = m_GetESlots()
                net.WriteDouble(eslots)
                net.SendToServer()
            end
        elseif (string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
            local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
            local M_INV_SLOT1_ICON = M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel
            local M_INV_SLOT2_ICON = M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_TRADE_SLOT[DRAG_SLOT].VGUI.Item
            local M_INV_SLOT2_ITEM = M_TRADE_SLOT[HVRD_SLOT].VGUI.Item
            local M_INV_TBL1 = table.Copy(m_Trade[HVRD_SLOT])
            local M_INV_TBL2 = table.Copy(m_Trade[DRAG_SLOT])

            if (M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel) then
                if (string.EndsWith(M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel, ".mdl")) then
                    M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetModel(M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel, M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin)
                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true)
            else
                M_TRADE_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(false)
            end

            if (M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel) then
                if (string.EndsWith(M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel, ".mdl")) then
                    M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetModel(M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel, M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin)
                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
            else
                M_TRADE_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(false)
            end

            M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
            M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
            M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_TRADE_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
            M_TRADE_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
            m_Trade[HVRD_SLOT] = M_INV_TBL2
            m_Trade[DRAG_SLOT] = M_INV_TBL1

            if (IsValid(MOAT_TRADE_BG)) then
                MOAT_TRADE_BG.ConfirmTime = 5
                MOAT_TRADE_BG.ACCEPTED = 0
                net.Start("MOAT_TRADE_STATUS")
                net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
                net.WriteDouble(m_utrade)
                local eslots = m_GetESlots()
                net.WriteDouble(eslots)
                net.SendToServer()
            end
        elseif (string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") or string.EndsWith(tostring(m_HoveredSlot3), "l")) then
            if (string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") and not string.EndsWith(tostring(m_HoveredSlot3), "l")) then
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
                local M_INV_SLOT1_ICON = M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel
                local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_LOAD_SLOT[DRAG_SLOT].VGUI.Item
                local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item
                local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
                local M_INV_TBL2 = table.Copy(m_Loadout[DRAG_SLOT])

                if (M_INV_TBL1 ~= nil and not m_CanSwapLoadout(M_INV_TBL1, DRAG_SLOT)) then
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

                if (M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel) then
                    if (string.EndsWith(M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel, ".mdl")) then
                        M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetModel(M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel, M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin)
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(true)
                else
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(false)
                end

                if (M_INV_SLOT[m_HoveredSlot3].VGUI.WModel) then
                    if (string.EndsWith(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, ".mdl")) then
                        M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetModel(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin)
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
                else
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(false)
                end

                M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
                M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
                M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_LOAD_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
                M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM
                m_Inventory[m_HoveredSlot3] = M_INV_TBL2
                m_Loadout[DRAG_SLOT] = M_INV_TBL1
                m_SendCosmeticPositions(m_Loadout[DRAG_SLOT], DRAG_SLOT)

                if (M_INV_TBL2 and M_INV_TBL2.item and m_CosmeticSlots[M_INV_TBL2.item.Kind]) then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:RemoveModel(M_INV_TBL2.u)
                    end
                end

                if (M_INV_TBL1 and M_INV_TBL1.item and m_CosmeticSlots[M_INV_TBL1.item.Kind]) then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:AddModel(M_INV_TBL1.u, M_INV_TBL1)
                    end
                end

                if (M_INV_TBL2 and M_INV_TBL2.item and M_INV_TBL2.item.Kind == "Model") then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:SetModel()
                    end
                end

                if (M_INV_TBL1 and M_INV_TBL1.item and M_INV_TBL1.item.Kind == "Model") then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:SetModel(M_INV_TBL1.item.Model)
                    end
                end
            elseif (not string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") and string.EndsWith(tostring(m_HoveredSlot3), "l")) then
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
                local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
                local M_INV_SLOT2_ICON = M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
                local M_INV_SLOT2_ITEM = M_LOAD_SLOT[HVRD_SLOT].VGUI.Item
                local M_INV_TBL1 = table.Copy(m_Loadout[HVRD_SLOT])
                local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])

                if (not m_CanSwapLoadout(M_INV_TBL2, HVRD_SLOT)) then
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(true)
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

                if (M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel) then
                    if (string.EndsWith(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, ".mdl")) then
                        M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetModel(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin)
                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true)
                else
                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(false)
                end

                if (M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel) then
                    if (string.EndsWith(M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel, ".mdl")) then
                        M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetModel(M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel, M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin)
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(true)
                else
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(false)
                end

                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
                M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
                M_LOAD_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
                m_Loadout[HVRD_SLOT] = M_INV_TBL2
                m_SendCosmeticPositions(m_Loadout[HVRD_SLOT], HVRD_SLOT)
                m_Inventory[M_INV_DRAG3.Slot] = M_INV_TBL1

                if (M_INV_TBL1 and M_INV_TBL1.item and m_CosmeticSlots[M_INV_TBL1.item.Kind]) then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:RemoveModel(M_INV_TBL1.u)
                    end
                end

                if (M_INV_TBL2 and M_INV_TBL2.item and m_CosmeticSlots[M_INV_TBL2.item.Kind]) then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:AddModel(M_INV_TBL2.u, M_INV_TBL2)
                    end
                end

                if (M_INV_TBL1 and M_INV_TBL1.item and M_INV_TBL1.item.Kind == "Model") then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:SetModel()
                    end
                end

                if (M_INV_TBL2 and M_INV_TBL2.item and M_INV_TBL2.item.Kind == "Model") then
                    if (IsValid(M_INV_PMDL)) then
                        M_INV_PMDL:SetModel(M_INV_TBL2.item.Model)
                    end
                end
            else
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
                local M_INV_SLOT1_ICON = M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel
                local M_INV_SLOT2_ICON = M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_LOAD_SLOT[DRAG_SLOT].VGUI.Item
                local M_INV_SLOT2_ITEM = M_LOAD_SLOT[HVRD_SLOT].VGUI.Item
                local M_INV_TBL1 = table.Copy(m_Loadout[HVRD_SLOT])
                local M_INV_TBL2 = table.Copy(m_Loadout[DRAG_SLOT])

                if (not m_CanSwapLoadout(M_INV_TBL2, HVRD_SLOT)) then
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

                if (not m_CanSwapLoadout(M_INV_TBL1, DRAG_SLOT)) then
                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true)
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

                if (M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel) then
                    if (string.EndsWith(M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel, ".mdl")) then
                        M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetModel(M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel, M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin)
                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true)
                else
                    M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(false)
                end

                if (M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel) then
                    if (string.EndsWith(M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel, ".mdl")) then
                        M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(255)
                    else
                        M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon.Icon:SetAlpha(0)
                    end

                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetModel(M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel, M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin)
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true)
                else
                    M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(false)
                end

                M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
                M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
                M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_LOAD_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
                M_LOAD_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
                m_Loadout[HVRD_SLOT] = M_INV_TBL2
                m_Loadout[DRAG_SLOT] = M_INV_TBL1
                m_SendCosmeticPositions(m_Loadout[HVRD_SLOT], HVRD_SLOT)
                m_SendCosmeticPositions(m_Loadout[DRAG_SLOT], DRAG_SLOT)
            end
        else
            local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
            local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
            local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item
            local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
            local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])

            if (M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel) then
                if (string.EndsWith(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, ".mdl")) then
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetModel(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel, M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin)
                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(true)
            else
                M_INV_SLOT[m_HoveredSlot3].VGUI.SIcon:SetVisible(false)
            end

            if (M_INV_SLOT[m_HoveredSlot3].VGUI.WModel) then
                if (string.EndsWith(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, ".mdl")) then
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(255)
                else
                    M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon.Icon:SetAlpha(0)
                end

                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetModel(M_INV_SLOT[m_HoveredSlot3].VGUI.WModel, M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin)
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(true)
            else
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(false)
            end

            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
            M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
            M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM
            m_Inventory[m_HoveredSlot3] = M_INV_TBL2
            m_Inventory[M_INV_DRAG3.Slot] = M_INV_TBL1
        end
    end
    moat_RemoveEditPositionPanel()
end

net.Receive("MOAT_SWP_INV_ITEM", function(len)
    local passed = net.ReadBool()

    if (not passed) then
        notification.AddLegacy("Error verifying item to swap slots! Please reconnect!", NOTIFY_ERROR, 3)
        surface.PlaySound("buttons/button16.wav")

        return
    end

    local slot1 = net.ReadString()
    local slot2 = net.ReadString()
    local m_HoveredSlot2 = 0
    local slot1_l = 0

    if (string.StartWith(slot1, "t_")) then
        slot1_l = tonumber(string.sub(tostring(slot1), 7, tostring(slot1):len()))
        m_HoveredSlot2 = slot1_l .. "t"
    elseif (string.StartWith(slot1, "l_")) then
        slot1_l = tonumber(string.sub(tostring(slot1), 7, tostring(slot1):len()))
        m_HoveredSlot2 = slot1_l .. "l"
    else
        slot1_l = tonumber(string.sub(tostring(slot1), 5, tostring(slot1):len()))
        m_HoveredSlot2 = slot1_l
    end

    local M_INV_DRAG2 = {}
    local slot2_l = 0

    if (string.StartWith(slot2, "t_")) then
        slot2_l = tonumber(string.sub(tostring(slot2), 7, tostring(slot2):len()))
        M_INV_DRAG2 = table.Copy(M_TRADE_SLOT[slot2_l])
    elseif (string.StartWith(slot2, "l_")) then
        slot2_l = tonumber(string.sub(tostring(slot2), 7, tostring(slot2):len()))
        M_INV_DRAG2 = table.Copy(M_LOAD_SLOT[slot2_l])
    else
        slot2_l = tonumber(string.sub(tostring(slot2), 5, tostring(slot2):len()))
        M_INV_DRAG2 = table.Copy(M_INV_SLOT[slot2_l])
    end

    m_SwapInventorySlotsFromServer(M_INV_DRAG2, m_HoveredSlot2)
end)

local function m_ModifyTradeSlotsFromServer(M_ITEM_TBL, m_tradeslot)
    local slot = m_tradeslot

    if (M_ITEM_TBL and M_ITEM_TBL.item and M_ITEM_TBL.item.Kind == "Other") then
        if (M_ITEM_TBL.item.WeaponClass) then
            M_ITEM_TBL.w = M_ITEM_TBL.item.WeaponClass
        end    
    end

    m_Trade[slot] = M_ITEM_TBL
    M_TRADE_SLOT[slot].VGUI.Item = m_Trade[slot]

    if (M_ITEM_TBL and M_ITEM_TBL.c) then
        if (m_Trade[slot].item.Image) then
            M_TRADE_SLOT[slot].VGUI.WModel = m_Trade[slot].item.Image
            M_TRADE_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(255)
        elseif (m_Trade[slot].item.Model) then
            M_TRADE_SLOT[slot].VGUI.WModel = m_Trade[slot].item.Model
            M_TRADE_SLOT[slot].VGUI.MSkin = m_Trade[slot].item.Skin
            M_TRADE_SLOT[slot].VGUI.SIcon:SetModel(m_Trade[slot].item.Model, m_Trade[slot].item.Skin)
        else
            M_TRADE_SLOT[slot].VGUI.WModel = weapons.Get(m_Trade[slot].w).WorldModel
            M_TRADE_SLOT[slot].VGUI.SIcon:SetModel(M_TRADE_SLOT[slot].VGUI.WModel)
        end

        M_TRADE_SLOT[slot].VGUI.SIcon:SetVisible(true)
    else
        M_TRADE_SLOT[slot].VGUI.SIcon:SetVisible(false)
        M_TRADE_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(0)
    end

    if (IsValid(MOAT_TRADE_BG)) then
        MOAT_TRADE_BG.ConfirmTime = 5
        MOAT_TRADE_BG.ACCEPTED = 0
        net.Start("MOAT_TRADE_STATUS")
        net.WriteDouble(MOAT_TRADE_BG.ACCEPTED)
        net.WriteDouble(m_utrade)
        local eslots = m_GetESlots()
        net.WriteDouble(eslots)
        net.SendToServer()
    end
end

net.Receive("MOAT_TRADE_SWAP", function(len)
    local t_slot = net.ReadDouble()
    local item_tbl = net.ReadTable()
    m_ModifyTradeSlotsFromServer(item_tbl, t_slot)
end)*/