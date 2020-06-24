m_CosmeticSlots = {}
m_CosmeticSlots["Hat"] = ""
m_CosmeticSlots["Mask"] = ""
m_CosmeticSlots["Body"] = ""
m_CosmeticSlots["Effect"] = ""

function m_GetCosmeticFromEnum(item_enum)
    return table.Copy(COSMETIC_ITEMS[item_enum]) or {}
end

function m_SendCosmeticPositions(itemtbl, slot)
    if (slot ~= 6 and slot ~= 7 and slot ~= 8) then return end
    if (not itemtbl.u) then return end
    
    local cosmetic_pos = {}

    for i = 1, 6 do
        local num = cookie.GetNumber("moatbeta_pos" .. itemtbl.u .. i)
        if (num) then
            cosmetic_pos[i] = num
        else
            cosmetic_pos[i] = 0
            if (i == 3) then
                cosmetic_pos[i] = 1
            end
        end
    end

    net.Start("MOAT_UPDATE_MODEL_POS")
    net.WriteUInt(itemtbl.u, 16)
    net.WriteDouble(cosmetic_pos[1])
    net.WriteDouble(cosmetic_pos[2])
    net.WriteDouble(cosmetic_pos[3])
    net.WriteDouble(cosmetic_pos[4])
    net.WriteDouble(cosmetic_pos[5])
    net.WriteDouble(cosmetic_pos[6])
    net.SendToServer()
end

function m_SwapInventorySlots(M_INV_DRAG, m_HoveredSlot, m_tid)
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
				if (isstring(M_INV_DRAG.Slot)) then return end
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
                net.WriteLong(tonumber(m_Inventory[m_HoveredSlot].c) or 0)
                net.WriteLong(tonumber(m_Loadout[DRAG_SLOT].c) or 0)
                net.SendToServer()
                if (LOAD_BLOCK or 0) < CurTime() then
                    timer.Simple(0.1,function() m_SaveLoadout() end)
                end
            elseif (not string.EndsWith(tostring(M_INV_DRAG.Slot), "l") and string.EndsWith(tostring(m_HoveredSlot), "l")) then
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot), 1, tostring(m_HoveredSlot):len() - 1))
				if (not m_Loadout[HVRD_SLOT]) then return end
                net.Start("MOAT_SWP_INV_ITEM")
                net.WriteString("l_slot" .. HVRD_SLOT)
                net.WriteString("slot" .. M_INV_DRAG.Slot)
                net.WriteLong(tonumber(m_Loadout[HVRD_SLOT].c) or 0)
                net.WriteLong(tonumber(m_Inventory[M_INV_DRAG.Slot].c) or 0)
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
                net.WriteLong(tonumber(m_Loadout[HVRD_SLOT].c) or 0)
                net.WriteLong(tonumber(m_Loadout[DRAG_SLOT].c) or 0)
                net.SendToServer()
            end
        else
            net.Start("MOAT_SWP_INV_ITEM")
            net.WriteString("slot" .. m_HoveredSlot)
            net.WriteString("slot" .. M_INV_DRAG.Slot)
            net.WriteLong(tonumber(m_Inventory[m_HoveredSlot].c) or 0)
            net.WriteLong(tonumber(m_Inventory[M_INV_DRAG.Slot].c) or 0)
            net.SendToServer()
        end
    else
        M_INV_DRAG.VGUI.SIcon:SetVisible(true)
    end
end

local m_LoadoutLabels = {"Primary", "Secondary", "Melee", "Power-Up", "Special", "Head", "Mask", "Body", "Effect", "Model"}
local m_SlotToLoadout = {}
m_SlotToLoadout[0] = "Melee"
m_SlotToLoadout[1] = "Secondary"
m_SlotToLoadout[2] = "Primary"

function m_CanSwapLoadout(ITEM_TBL, DRAG_SLOT)
	if (not ITEM_TBL) then return false end

    if (ITEM_TBL.c == nil) then return true end
    if (ITEM_TBL.item.Kind == "Power-Up") then return DRAG_SLOT == 4 end
    if (ITEM_TBL.item.Kind == "Special") then return DRAG_SLOT == 5 end
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
    if (ITEM_TBL.item.Kind == "Special") then return 5 end
    if (ITEM_TBL.item.Kind == "Hat") then return 6 end
    if (ITEM_TBL.item.Kind == "Mask") then return 7 end
    if (ITEM_TBL.item.Kind == "Body") then return 8 end
    if (ITEM_TBL.item.Kind == "Effect") then return 9 end
    if (ITEM_TBL.item.Kind == "Model") then return 10 end

    return WeaponLoadoutSlots[weapons.Get(ITEM_TBL.w).Slot]
end

local function handleIcons(pnl1, pnl2)
	if (pnl1.WModel and IsValid(pnl2.SIcon)) then
		if (not IsValid(pnl2.SIcon.Icon)) then pnl2.SIcon:CreateIcon() end

		if (pnl1.WModel:EndsWith(".mdl")) then
            pnl2.SIcon.Icon:SetAlpha(255)
        else
            pnl2.SIcon.Icon:SetAlpha(0)
        end

		pnl2.SIcon:SetModel(pnl1.WModel, pnl1.MSkin or nil)
		pnl2.SIcon:SetVisible(true)
	elseif (IsValid(pnl2.SIcon)) then
		pnl2.SIcon:SetVisible(false)
	end
end

local function swapIcons(pnl1, pnl2)
	handleIcons(pnl1, pnl2)
	handleIcons(pnl2, pnl1)
end

local function m_SwapInventorySlotsFromServer(M_INV_DRAG3, m_HoveredSlot3)
	moat_RemoveEditPositionPanel()

    if (m_HoveredSlot3 and M_INV_DRAG3.Slot and M_INV_DRAG3.Slot ~= m_HoveredSlot3) then
        if (string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and not string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
            local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
            local M_INV_TBL2 = table.Copy(m_Trade[DRAG_SLOT])
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

			if (not M_TRADE_SLOT[DRAG_SLOT] or not M_INV_SLOT[m_HoveredSlot3]) then return end
            local M_INV_SLOT1_ICON = M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel
            local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_TRADE_SLOT[DRAG_SLOT].VGUI.Item
            local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item

			swapIcons(M_TRADE_SLOT[DRAG_SLOT].VGUI, M_INV_SLOT[m_HoveredSlot3].VGUI)

            M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
            M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
            M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_TRADE_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
            M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM
        elseif (not string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
            local M_INV_TBL1 = table.Copy(m_Trade[HVRD_SLOT])
            local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])
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

			if (not M_INV_SLOT[M_INV_DRAG3.Slot] or not M_TRADE_SLOT[HVRD_SLOT]) then return end
            local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
            local M_INV_SLOT2_ICON = M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
            local M_INV_SLOT2_ITEM = M_TRADE_SLOT[HVRD_SLOT].VGUI.Item

			swapIcons(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI, M_TRADE_SLOT[HVRD_SLOT].VGUI)

            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
            M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
            M_TRADE_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
        elseif (string.EndsWith(tostring(M_INV_DRAG3.Slot), "t") and string.EndsWith(tostring(m_HoveredSlot3), "t")) then
            local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
            local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
            local M_INV_TBL1 = table.Copy(m_Trade[HVRD_SLOT])
            local M_INV_TBL2 = table.Copy(m_Trade[DRAG_SLOT])
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

			if (not M_TRADE_SLOT[DRAG_SLOT] or not M_TRADE_SLOT[HVRD_SLOT]) then return end
            local M_INV_SLOT1_ICON = M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel
            local M_INV_SLOT2_ICON = M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_TRADE_SLOT[DRAG_SLOT].VGUI.Item
            local M_INV_SLOT2_ITEM = M_TRADE_SLOT[HVRD_SLOT].VGUI.Item

			swapIcons(M_TRADE_SLOT[DRAG_SLOT].VGUI, M_TRADE_SLOT[HVRD_SLOT].VGUI)

            M_TRADE_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
            M_TRADE_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
            M_TRADE_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_TRADE_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_TRADE_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
            M_TRADE_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
        elseif (string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") or string.EndsWith(tostring(m_HoveredSlot3), "l")) then
            if (string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") and not string.EndsWith(tostring(m_HoveredSlot3), "l")) then
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
                local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
                local M_INV_TBL2 = table.Copy(m_Loadout[DRAG_SLOT])
                m_Inventory[m_HoveredSlot3] = M_INV_TBL2
                m_Loadout[DRAG_SLOT] = M_INV_TBL1
                m_SendCosmeticPositions(m_Loadout[DRAG_SLOT], DRAG_SLOT)

                if (M_INV_TBL1 ~= nil and not m_CanSwapLoadout(M_INV_TBL1, DRAG_SLOT)) then
                    if (IsValid(M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon)) then M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true) end
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

				if (not M_LOAD_SLOT[DRAG_SLOT] or not M_INV_SLOT[m_HoveredSlot3]) then return end
                local M_INV_SLOT1_ICON = M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel
                local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_LOAD_SLOT[DRAG_SLOT].VGUI.Item
                local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item

				swapIcons(M_LOAD_SLOT[DRAG_SLOT].VGUI, M_INV_SLOT[m_HoveredSlot3].VGUI)

                M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
                M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
                M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_LOAD_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
                M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM

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
                        M_INV_PMDL:SetModel(M_INV_TBL1.item.Model, M_INV_TBL1)
                    end
                end
            elseif (not string.EndsWith(tostring(M_INV_DRAG3.Slot), "l") and string.EndsWith(tostring(m_HoveredSlot3), "l")) then
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
                local M_INV_TBL1 = table.Copy(m_Loadout[HVRD_SLOT])
                local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])
			    m_Loadout[HVRD_SLOT] = M_INV_TBL2
                m_SendCosmeticPositions(m_Loadout[HVRD_SLOT], HVRD_SLOT)
                m_Inventory[M_INV_DRAG3.Slot] = M_INV_TBL1

                if (not m_CanSwapLoadout(M_INV_TBL2, HVRD_SLOT)) then
                    if (IsValid(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon)) then M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.SIcon:SetVisible(true) end
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

				if (not M_INV_SLOT[M_INV_DRAG3.Slot] or not M_LOAD_SLOT[HVRD_SLOT]) then return end
                local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
                local M_INV_SLOT2_ICON = M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
                local M_INV_SLOT2_ITEM = M_LOAD_SLOT[HVRD_SLOT].VGUI.Item

				swapIcons(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI, M_LOAD_SLOT[HVRD_SLOT].VGUI)

                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
                M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
                M_LOAD_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM

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
                        M_INV_PMDL:SetModel(M_INV_TBL2.item.Model, M_INV_TBL2)
                    end
                end
            else
                local DRAG_SLOT = tonumber(string.sub(tostring(M_INV_DRAG3.Slot), 1, tostring(M_INV_DRAG3.Slot):len() - 1))
                local HVRD_SLOT = tonumber(string.sub(tostring(m_HoveredSlot3), 1, tostring(m_HoveredSlot3):len() - 1))
                local M_INV_TBL1 = table.Copy(m_Loadout[HVRD_SLOT])
                local M_INV_TBL2 = table.Copy(m_Loadout[DRAG_SLOT])
                m_Loadout[HVRD_SLOT] = M_INV_TBL2
                m_Loadout[DRAG_SLOT] = M_INV_TBL1
                m_SendCosmeticPositions(m_Loadout[HVRD_SLOT], HVRD_SLOT)
                m_SendCosmeticPositions(m_Loadout[DRAG_SLOT], DRAG_SLOT)

                if (not m_CanSwapLoadout(M_INV_TBL2, HVRD_SLOT)) then
                    if (IsValid(M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon)) then M_LOAD_SLOT[DRAG_SLOT].VGUI.SIcon:SetVisible(true) end
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

                if (not m_CanSwapLoadout(M_INV_TBL1, DRAG_SLOT)) then
                    if (IsValid(M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon)) then M_LOAD_SLOT[HVRD_SLOT].VGUI.SIcon:SetVisible(true) end
                    M_INV_DRAG3 = nil
                    notification.AddLegacy("You cannot equip that item there!", NOTIFY_ERROR, 3)
                    surface.PlaySound("buttons/button16.wav")

                    return
                end

				if (not M_LOAD_SLOT[DRAG_SLOT] or not M_LOAD_SLOT[HVRD_SLOT]) then return end
                local M_INV_SLOT1_ICON = M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel
                local M_INV_SLOT2_ICON = M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel
                local M_INV_SLOT1_SKIN = M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin
                local M_INV_SLOT2_SKIN = M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin
                local M_INV_SLOT1_ITEM = M_LOAD_SLOT[DRAG_SLOT].VGUI.Item
                local M_INV_SLOT2_ITEM = M_LOAD_SLOT[HVRD_SLOT].VGUI.Item

				swapIcons(M_LOAD_SLOT[DRAG_SLOT].VGUI, M_LOAD_SLOT[HVRD_SLOT].VGUI)

                M_LOAD_SLOT[DRAG_SLOT].VGUI.WModel = M_INV_SLOT2_ICON
                M_LOAD_SLOT[HVRD_SLOT].VGUI.WModel = M_INV_SLOT1_ICON
                M_LOAD_SLOT[DRAG_SLOT].VGUI.MSkin = M_INV_SLOT2_SKIN
                M_LOAD_SLOT[HVRD_SLOT].VGUI.MSkin = M_INV_SLOT1_SKIN
                M_LOAD_SLOT[DRAG_SLOT].VGUI.Item = M_INV_SLOT2_ITEM
                M_LOAD_SLOT[HVRD_SLOT].VGUI.Item = M_INV_SLOT1_ITEM
            end
        else
            local M_INV_TBL1 = table.Copy(m_Inventory[m_HoveredSlot3])
            local M_INV_TBL2 = table.Copy(m_Inventory[M_INV_DRAG3.Slot])
            m_Inventory[m_HoveredSlot3] = M_INV_TBL2
            m_Inventory[M_INV_DRAG3.Slot] = M_INV_TBL1

			if (not M_INV_SLOT[M_INV_DRAG3.Slot] or not M_INV_SLOT[m_HoveredSlot3]) then return end
            local M_INV_SLOT1_ICON = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel
            local M_INV_SLOT2_ICON = M_INV_SLOT[m_HoveredSlot3].VGUI.WModel
            local M_INV_SLOT1_SKIN = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin
            local M_INV_SLOT2_SKIN = M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin
            local M_INV_SLOT1_ITEM = M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item
            local M_INV_SLOT2_ITEM = M_INV_SLOT[m_HoveredSlot3].VGUI.Item

			swapIcons(M_INV_SLOT[M_INV_DRAG3.Slot].VGUI, M_INV_SLOT[m_HoveredSlot3].VGUI)

            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.WModel = M_INV_SLOT2_ICON
            M_INV_SLOT[m_HoveredSlot3].VGUI.WModel = M_INV_SLOT1_ICON
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.MSkin = M_INV_SLOT2_SKIN
            M_INV_SLOT[m_HoveredSlot3].VGUI.MSkin = M_INV_SLOT1_SKIN
            M_INV_SLOT[M_INV_DRAG3.Slot].VGUI.Item = M_INV_SLOT2_ITEM
            M_INV_SLOT[m_HoveredSlot3].VGUI.Item = M_INV_SLOT1_ITEM
        end
    end
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

    if (M_ITEM_TBL and M_ITEM_TBL.item and M_ITEM_TBL.item.Kind == "Special") then
        if (M_ITEM_TBL.item.WeaponClass) then
            M_ITEM_TBL.w = M_ITEM_TBL.item.WeaponClass
        end
    end

	if ((not M_TRADE_SLOT[slot]) or (not M_TRADE_SLOT[slot].VGUI) or (not IsValid(M_TRADE_SLOT[slot].VGUI.SIcon))) then
		if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
        if (IsValid(MOAT_TRADE_BG)) then MOAT_TRADE_BG:Remove() end

        if (m_utrade and m_ply2) then
            moat_inv_cooldown = CurTime() + 5
            m_ClearInventory()
            net.Start("MOAT_SEND_INV_ITEM")
            net.SendToServer()

            net.Start("MOAT_RESPOND_TRADE")
            net.WriteBool(false)
            net.WriteDouble(m_ply2:EntIndex())
            net.WriteDouble(m_utrade)
            net.SendToServer()
        end

		MsgC(Color(255, 0, 0), "Failed to load trade slot " .. slot .. ".\n")
		return
	end

    m_Trade[slot] = M_ITEM_TBL
    M_TRADE_SLOT[slot].VGUI.Item = m_Trade[slot]

    if (M_ITEM_TBL and M_ITEM_TBL.c) then
        if (m_Trade[slot].item.Image) then
            M_TRADE_SLOT[slot].VGUI.WModel = m_Trade[slot].item.Image
			if (not IsValid(M_TRADE_SLOT[slot].VGUI.SIcon.Icon)) then M_TRADE_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
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

		if (not IsValid(M_TRADE_SLOT[slot].VGUI.SIcon.Icon)) then M_TRADE_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
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
	if (item_tbl.u) then
		item_tbl.item = GetItemFromEnum(item_tbl.u)
	end

	if (item_tbl.t) then
		item_tbl.Talents = GetItemTalents(item_tbl)
	end

    m_ModifyTradeSlotsFromServer(item_tbl, t_slot)
end)

local PANEL = {}

function PANEL:Init()
	self.Dream = false
	self.Colors = {1, 1, 1}
	self.ItemStats = false
	self.MatOverride = false

    self.EntAngle = 0
    self.SnapToCenter = CurTime()
    self.Scrolled = false
    self.ScrollDelta = 105
    self.CursorSnapX, self.CursorSnapY = 0, 0
    self.PlayerModel = ClientsideModel("models/error.mdl", RENDERGROUP_BOTH)
    self.PlayerModel:SetNoDraw(true)
    local min, max = self.PlayerModel:GetRenderBounds()
    local center = (min + max) * -0.5
    self.PlayerModel:SetPos(center + Vector(0, 0, 2))
    self.PlayerModel:SetAngles(Angle(0, 0, 0))
    self.m_intLastPaint = 0
    self.AdditionalX = 0
    self.AdditionalZ = 0
    self.ChangingAdditionalXY = false
    self.AdditionalXSave = 0
    self.AdditionalZSave = 0
    self.AdditionalXSaveCache = 0
    self.AdditionalZSaveCache = 0
    self.ClientsideModels = {}
    self.ActualAdditionalX = 0
    self.ActualAdditionalZ = 0
	self.AlphaValue = 0
	self:CreateParticles(center)

    --[[self.Platform = ClientsideModel("models/props_phx/construct/glass/glass_angle360.mdl", RENDERGROUP_BOTH)
	
	self.Platform:SetNoDraw(true)

	self.Platform:SetPos(center + Vector(0, 0, 2))

	self.Platform:SetAngles(Angle(0, 0, 0))

	self.Platform:SetModelScale(0.4, 0)]]
end

function PANEL:OnRemove()
	if (IsValid(self.PlayerModel)) then
		self.PlayerModel:Remove()
	end

	for k, v in pairs(self.ClientsideModels) do
		if (IsValid(v.ModelEnt)) then
			v.ModelEnt:Remove()
		end
	end
end

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
--
function PANEL:SetModel(item_enum, item_tbl)
	item_enum = item_enum or GetGlobal "ttt_default_playermodel" or "models/player/phoenix.mdl"

    if (isnumber(item_enum)) then
        item_enum = m_GetCosmeticFromEnum(item_enum).Model
    end

    self.PlayerModel:SetModel(item_enum)
    self.PlayerModel:ResetSequence(self.PlayerModel:LookupSequence("pose_standing_02"))
	self.PlayerModel.ItemStats = item_tbl
	self.ItemStats = item_tbl

	if (item_tbl and item_tbl.Skin) then
		self.PlayerModel:SetSkin(item_tbl.Skin)
	end

	if (item_tbl and item_tbl.p3 and MOAT_PAINT and MOAT_PAINT.Skins[item_tbl.p3]) then
		local mat_str, name_str = MOAT_PAINT.Skins[item_tbl.p3][2], MOAT_PAINT.Skins[item_tbl.p3][1]
		if (mat_str:match "^http") then
			self.MatOverride = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
                ["$alphatest"] = 1,
                ["$vertexcolor"] = 1,
                ["$basetexture"] = "error"
            })

			if (mat_str:match "vtf$") then
				local set = function(m)
					if (type(self.MatOverride) == "IMaterial" and type(m) == "string") then
						self.MatOverride:SetTexture("$basetexture", m)
					end
				end

				local m = cdn.Texture(mat_str, set)
				if (m) then
					set(m)
				end
			else
				local set = function(m)
					if (type(self.MatOverride) == "IMaterial") then
						self.MatOverride:SetTexture("$basetexture", m:GetTexture("$basetexture"))
					end
				end
				local m = cdn.Image(mat_str, set)
				if (m) then
					set(m)
				end
			end
		else
			self.MatOverride = Material(mat_str)
		end
	else
		self.MatOverride = false
	end

	if (MOAT_PAINT and item_tbl) then
        if (item_tbl.p2 and MOAT_PAINT.Paints[item_tbl.p2]) then
			self.MatOverride = (not MODELS_COLORABLE[item_enum]) and Material("models/debug/debugwhite")
            local col = MOAT_PAINT.Paints[item_tbl.p2]
            if (not col) then return end
            self.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
			if (col.Dream) then
				self.Dream = true
			else
				self.Dream = false
			end
        elseif (item_tbl.p and MOAT_PAINT.Tints[item_tbl.p]) then
            local col = MOAT_PAINT.Tints[item_tbl.p]
            if (not col) then return end
            self.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
			if (col.Dream) then
				self.Dream = true
			else
				self.Dream = false
			end
		end
    else
		self.Colors = {1, 1, 1}
		self.Dream = false
    end

    --self.PlayerModel:ResetSequence(self.PlayerModel:SelectWeightedSequence(ACT_GMOD_TAUNT_ROBOT))
    /*
    self.PlayerModel:ResetSequence(self.PlayerModel:SelectWeightedSequence(ACT_HL2MP_IDLE_PASSIVE))
    if (self.HoldWeapon) then
        self.HoldWeapon:Remove()
    end

    self.HoldWeapon = ClientsideModel(Model("models/weapons/w_rif_ak47.mdl"))
    self.HoldWeapon:SetNoDraw(true)
    self.HoldWeapon:SetParent(self.PlayerModel, self.PlayerModel:LookupAttachment("anim_attachment_RH"))
    self.HoldWeapon:AddEffects(EF_BONEMERGE)*/
end

function PANEL:AddModel(item_enum, item_tbl)
	self.ClientsideModels[item_enum] = m_GetCosmeticFromEnum(item_enum)
	if (not self.ClientsideModels[item_enum]) then return end

    self.ClientsideModels[item_enum].ModelEnt = ClientsideModel(self.ClientsideModels[item_enum].Model, RENDERGROUP_OPAQUE)
    self.ClientsideModels[item_enum].ModelEnt:SetNoDraw(true)

	self.ClientsideModels[item_enum].ModelEnt.ItemStats = item_tbl
	self.ClientsideModels[item_enum].ItemStats = item_tbl

	if (self.ClientsideModels[item_enum].Skin) then
		self.ClientsideModels[item_enum].ModelEnt:SetSkin(self.ClientsideModels[item_enum].Skin)
	end

	if (item_tbl and item_tbl.p3 and MOAT_PAINT and MOAT_PAINT.Skins[item_tbl.p3]) then
		local mat_str, name_str = MOAT_PAINT.Skins[item_tbl.p3][2], MOAT_PAINT.Skins[item_tbl.p3][1]
		if (mat_str:match "^http") then
			self.ClientsideModels[item_enum].MatOverride = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
                ["$alphatest"] = 1,
                ["$vertexcolor"] = 1,
                ["$basetexture"] = "error"
            })
	
			if (mat_str:match "vtf$") then
				local set = function(m)
					if (type(self.ClientsideModels[item_enum].MatOverride) == "IMaterial" and type(m) == "string") then
						self.ClientsideModels[item_enum].MatOverride:SetTexture("$basetexture", m)
					end
				end

				local m = cdn.Texture(mat_str, set)
				if (m) then
					set(m)
				end
			else
				local set = function(m)
					if (type(self.ClientsideModels[item_enum].MatOverride) == "IMaterial") then
						self.ClientsideModels[item_enum].MatOverride:SetTexture("$basetexture", m:GetTexture("$basetexture"))
					end
				end

				local m = cdn.Image(mat_str, set)
				if (m) then
					set(m)
				end
			end
		else
			self.ClientsideModels[item_enum].MatOverride = Material(mat_str)
		end
	elseif (self.ClientsideModels[item_enum].MatOverride) then
		self.ClientsideModels[item_enum].MatOverride = false
	end
	
	if (item_tbl and item_tbl.p2 and MOAT_PAINT and MOAT_PAINT.Paints[item_tbl.p2]) then
        local col = MOAT_PAINT.Paints[item_tbl.p2]
		self.ClientsideModels[item_enum].MatOverride = (not MODELS_COLORABLE[self.ClientsideModels[item_enum].Model]) and Material "models/debug/debugwhite"
        self.ClientsideModels[item_enum].Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
		if (col.Dream) then
			self.ClientsideModels[item_enum].Dream = true
		else
			self.ClientsideModels[item_enum].Dream = false
		end
    elseif (item_tbl and item_tbl.p and MOAT_PAINT and MOAT_PAINT.Tints[item_tbl.p]) then
        local col = MOAT_PAINT.Tints[item_tbl.p]
        self.ClientsideModels[item_enum].Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
		if (col.Dream) then
			self.ClientsideModels[item_enum].Dream = true
		else
			self.ClientsideModels[item_enum].Dream = false
		end
	end

	if (not MOAT_MODEL_POS_EDITS[item_enum]) then
        MOAT_MODEL_POS_EDITS[item_enum] = {}
        for i = 1, 6 do
            local num = cookie.GetNumber("moatbeta_pos" .. item_enum .. i)
            if (num) then
				if (i == 1 and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_enum]) then
					num = 0
				end

                MOAT_MODEL_POS_EDITS[item_enum][i] = num
            end
        end
    end
end

	/*
	if (item_tbl and item_tbl.p3 and MOAT_PAINT and MOAT_PAINT.Skins[item_tbl.p3]) then
		local mat_str, name_str = MOAT_PAINT.Skins[item_tbl.p3][2], MOAT_PAINT.Skins[item_tbl.p3][1]
		if (mat_str:match "^http") then
			self.ClientsideModels[item_enum].MatOverride = CreateMaterial("skin_" .. name_str:Replace(" ", "_"):lower(), "VertexLitGeneric", {
				["$model"] = 1,
                ["$alphatest"] = 1,
                ["$vertexcolor"] = 1,
                ["$basetexture"] = "error"
            })

			if (mat_str:match "vtf$") then
				local function set(m)
					if (self.ClientsideModels and self.ClientsideModels[item_enum]) then
						self.ClientsideModels[item_enum].MatOverride:SetTexture("$basetexture", m)
					end
				end

				local m = cdn.Texture(mat_str, set)
				if (m) then
					set(m)
				end
			else
				local function set(m)
					if (self.ClientsideModels and self.ClientsideModels[item_enum]) then
						self.ClientsideModels[item_enum].MatOverride:SetTexture("$basetexture", m:GetTexture("$basetexture"))
					end
				end

				local m = cdn.Image(mat_str, set)
				if (m) then
					set(m)
				end
			end
		else
			self.ClientsideModels[item_enum].MatOverride = Material(mat_str)
		end
	end
end
*/
function PANEL:AddWeapon(class)

end

function PANEL:RemoveModel(item_enum)
    if (self.ClientsideModels[item_enum] and self.ClientsideModels[item_enum].ModelEnt) then
        self.ClientsideModels[item_enum].ModelEnt:Remove()
        self.ClientsideModels[item_enum] = nil
    end
end

function PANEL:DrawModel()
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

	if (self.Dream and rarity_names) then
		render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
	elseif (self.Colors) then
		render.SetColorModulation(self.Colors[1], self.Colors[2], self.Colors[3])
    else
		render.SetColorModulation(1, 1, 1)
	end

	if (self.MatOverride) then
		render.MaterialOverrideByIndex(0, self.MatOverride)
	end
	
	self.PlayerModel:SetCycle(self.PlayerModel:GetCycle())
	self.PlayerModel:SetSequence(self.PlayerModel:GetSequence())

	self.PlayerModel:DrawModel()

	--render.SuppressEngineLighting(false)

    --self.HoldWeapon:DrawModel()
    --local anim = ActIndex[wep.HoldType]
    --self.Entity:SetSequence(anim)

    --self.Platform:DrawModel()
    self:DrawClientsideModels()
    render.SetScissorRect(0, 0, 0, 0, false)
end

function PANEL:DrawClientsideModels()
    if (not self.ClientsideModels or table.Count(self.ClientsideModels) <= 0) then return end

    for k, v in pairs(self.ClientsideModels) do
        local pos = Vector()
        local ang = Angle()

        if (v.Attachment) then
            local attach_id = self.PlayerModel:LookupAttachment(v.Attachment)
            if (not attach_id) then return end
            local attach = self.PlayerModel:GetAttachment(attach_id)
            if (not attach) then return end
            pos = attach.Pos
            ang = attach.Ang
        else
            local bone_id = self.PlayerModel:LookupBone(v.Bone)
            if (not bone_id) then return end
            pos, ang = self.PlayerModel:GetBonePosition(bone_id)
        end

        v.ModelEnt, pos, ang = v:ModifyClientsideModel(self.PlayerModel, v.ModelEnt, pos, ang)
        -- cache the size so it's not called every frame
        -- not sure if this actually increases performance lol
        if (not v.SizeCache) then
            v.SizeCache = v.ModelEnt:GetModelScale()
        end

        if (MOAT_MODEL_POS_EDITS[k]) then
            if (MOAT_MODEL_POS_EDITS[k][3]) then
                v.ModelEnt:SetModelScale(v.SizeCache * MOAT_MODEL_POS_EDITS[k][3], 0)
            end
            if (MOAT_MODEL_POS_EDITS[k][4]) then
                pos = pos + (ang:Forward() * MOAT_MODEL_POS_EDITS[k][4])
            end
            if (MOAT_MODEL_POS_EDITS[k][5]) then
                pos = pos + (ang:Right() * -MOAT_MODEL_POS_EDITS[k][5])
            end
            if (MOAT_MODEL_POS_EDITS[k][6]) then
                pos = pos + (ang:Up() * MOAT_MODEL_POS_EDITS[k][6])
            end
            if (MOAT_MODEL_POS_EDITS[k][1]) then
                ang:RotateAroundAxis(ang:Right(), -MOAT_MODEL_POS_EDITS[k][1])
            end
            if (MOAT_MODEL_POS_EDITS[k][2]) then
                ang:RotateAroundAxis(ang:Up(), MOAT_MODEL_POS_EDITS[k][2])
            end
        else
            v.ModelEnt:SetModelScale(v.SizeCache, 0)
        end
        v.ModelEnt:SetPos(pos)
        v.ModelEnt:SetAngles(ang)

		if (v.Dream and rarity_names) then
			render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
		elseif (v.Colors) then
			render.SetColorModulation(v.Colors[1], v.Colors[2], v.Colors[3])
   		else
			render.SetColorModulation(1, 1, 1)
		end

		if (v.MatOverride) then
			render.MaterialOverride(v.MatOverride)
		end
	
		v.ModelEnt:SetCycle(v.ModelEnt:GetCycle())
		v.ModelEnt:SetSequence(v.ModelEnt:GetSequence())

    	v.ModelEnt:DrawModel()

		render.MaterialOverride(nil)
        render.SetColorModulation(1, 1, 1)
    end
end

local smokeparticles = {
    Model("particle/particle_smokegrenade"),
    Model("particle/particle_noisesphere"),
}

function PANEL:CreateParticle(s, n)
	if (not s) then return end

	local p = s:Add("particle/smokesprites_0001", self.ParticlePos + Vector(-60, -15.5, 80 * n))//Vector(-60, -15.5, -4))
	if (not p) then return end
	local col = HSVToColor((CurTime() - (14.5 * n)) * 5 % 360, 1, 1)
    p:SetColor(col.r, col.g, col.b)

	if (self.AlphaValue and self.AlphaValue < 0.999) then 
		p:SetNextThink(CurTime())
		p:SetThinkFunction(function(pa)
			local l = pa:GetLifeTime()
			if (self.AlphaValue and self.AlphaValue < 0.999) then
				pa:SetStartAlpha(self.AlphaValue * 200)
			end

			--local na = math.max(0, l - 6)/9
			--local col = HSVToColor((1 - na) * 365, 1, 1)
			--pa:SetColor(col.r, col.g, col.b)

			if (l < pa:GetDieTime()) then
				pa:SetNextThink(CurTime())
			end
		end)
	end

    p:SetStartAlpha(200)
    p:SetEndAlpha(0)
    p:SetLifeTime(15 * n)

    p:SetDieTime(15)

    p:SetStartSize(20)
    p:SetEndSize(20)
	p:SetGravity(Vector(0, 0, 65))
    p:SetAirResistance(600)
	p:SetAngles(Angle(0, 0, math.random(180)))
    p:SetCollide(true)
    p:SetBounce(0.4)
    p:SetLighting(false)
end


/*function PANEL:CreateParticle(s, n)
	for i = 1, 7 do
	local p = s:Add("particle/smokesprites_0001", self.ParticlePos + Vector(-60, -90 + (20 * i), 0))//Vector(-60, -15.5, -4))
	if (not p) then return end
	local col = HSVToColor((CurTime() - (14.5 * n)) * 5 % 360, 1, 1)
    p:SetColor(col.r, col.g, col.b)

    p:SetStartAlpha(30)
    p:SetEndAlpha(0)
    p:SetLifeTime(0)

    p:SetDieTime(5)

    p:SetStartSize(30)
    p:SetEndSize(40)
	p:SetGravity(Vector(0, 65, 65))
    p:SetAirResistance(600)
	p:SetAngles(Angle(0, 0, math.random(180)))
    p:SetCollide(true)
    p:SetBounce(0.4)
    p:SetLighting(false)
	end
end*/

function PANEL:FakeCreateParticles()
	for i = 1, 58 do
		self:CreateParticle(self.SmokeEffect, 1 - (i/58), amt)
	end
end

local particles = CreateConVar("moat_model_smoke", "0", FCVAR_ARCHIVE)
function PANEL:CreateParticles(pos)
	if (true) then return end --if (particles:GetInt() ~= 1) then return end
	
	self.SmokeEffect = ParticleEmitter(pos, true)
	self.SmokeEffect:SetNoDraw(true)

	local prpos = Vector(0, -5, -20)
	self.ParticlePos = pos + prpos

	self:FakeCreateParticles()
end

function PANEL:CustomThink()
	if (particles:GetInt() ~= 1) then return end
	if (not self.NextSmoke) then 
		self.NextSmoke = CurTime() + 0.25
	end

	if (self.NextSmoke <= CurTime()) then

		self:CreateParticle(self.SmokeEffect, 0)
		self.NextSmoke = CurTime() + 0.25
	end
end

function PANEL:DrawParticles()
	if (self.SmokeEffect and self.SmokeEffect:IsValid()) then
		self.SmokeEffect:SetPos(self.PlayerModel:GetPos())
		self.SmokeEffect:Draw()
	end
end

local light = CreateConVar("moat_inventory_lighting", "0", FCVAR_ARCHIVE)

function PANEL:HandleParticles(x, y, ang)
	local x2, y2 = MOAT_INV_BG:GetPos()
	local pcf = {["x"] = x - 33, ["y"] = y - 44 - 26, ["w"] = MOAT_INV_BG_W, ["h"] = MOAT_INV_BG_H}
	
	if (self.ParticleInventory) then
		pcf["x"], pcf["y"] = MOAT_INV_BG:LocalToScreen()
	end

    cam.Start3D(ang:Forward() * 103, (ang:Forward() * -1):Angle(), 33, pcf["x"], pcf["y"], pcf["w"], pcf["h"], 5)
	render.SetScissorRect(x2, y2, x2 + pcf["w"], y2 + pcf["h"], true)
	render.SuppressEngineLighting(true)
    render.SetLightingMode(1)
    render.SetLightingOrigin(self.PlayerModel:GetPos())
    render.ResetModelLighting(1, 1, 1)
    render.SetColorModulation(1, 1, 1)
    render.SetBlend(1)
    self:DrawParticles()
    render.SetLightingMode(0)
	render.SuppressEngineLighting(false)
	render.SetScissorRect(0, 0, 0, 0, false)
    cam.End3D()
end

function PANEL:Paint(intW, intH)
    if not IsValid(self.PlayerModel) then return end

    local x, y = self:LocalToScreen()
    local ang = Angle(0, 0, 0)

	if (particles:GetInt() == 1 and self.ShowParticles and IsValid(MOAT_INV_BG)) then
		if (MOAT_INV_BG:GetAlpha() == 255) then
			self.AlphaValue = Lerp(FrameTime() * 1, self.AlphaValue, 1)
		end

		self:HandleParticles(x, y, ang)
	else
		self.AlphaValue = 1
	end

    cam.Start3D(ang:Forward() * self.ScrollDelta + Vector(0, self.ActualAdditionalX, self.ActualAdditionalZ), (ang:Forward() * -1):Angle(), 33, x, y, intW, intH, 5)
    render.SuppressEngineLighting(light:GetInt() == 0 and true or false)
    render.SetLightingMode(1)
    render.SetLightingOrigin(self.PlayerModel:GetPos())
    render.ResetModelLighting(1, 1, 1)
    render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)

	self:DrawModel()

    render.SetLightingMode(0)
	render.SetColorModulation(1, 1, 1)
	render.MaterialOverride(nil)
    render.SuppressEngineLighting(false)
    cam.End3D()

    self.PlayerModel:FrameAdvance((RealTime() - self.m_intLastPaint) * 1)
    self.m_intLastPaint = RealTime()
end

function PANEL:ResetZoom()
    self.ScrollDelta = 105
    self.AdditionalX = 0
    self.AdditionalZ = 0
    self.ChangingAdditionalXY = false
    self.AdditionalXSave = 0
    self.AdditionalZSave = 0
    self.AdditionalXSaveCache = 0
    self.AdditionalZSaveCache = 0
    self.ActualAdditionalX = 0
    self.ActualAdditionalZ = 0
    self.EntAngle = 0
    self.PlayerModel:SetAngles(Angle(0, 0, 0))
end

function PANEL:Think()
    if (self.ActualAdditionalX ~= self.AdditionalX) then
        self.ActualAdditionalX = Lerp(FrameTime() * 10, self.ActualAdditionalX, self.AdditionalX)
    end

    if (self.ActualAdditionalZ ~= self.AdditionalZ) then
        self.ActualAdditionalZ = Lerp(FrameTime() * 10, self.ActualAdditionalZ, self.AdditionalZ)
    end

    if (input.IsMouseDown(MOUSE_LEFT) and self.Scrolled) then
        local x, y = input.GetCursorPos()

        if (self.SnapToCenter <= CurTime()) then
            input.SetCursorPos(self.CursorSnapX, self.CursorSnapY)
            self.SnapToCenter = CurTime() + 0.01
            self.dx, self.dy = input.GetCursorPos()
        end

        self.EntAngle = self.EntAngle + (x - self.dx) / 2
        self.PlayerModel:SetAngles(Angle(0, self.EntAngle, 0))

        return
    end

    local mouse_right = input.IsMouseDown(MOUSE_RIGHT) and self:IsHovered()

    if (mouse_right and not self.ChangingAdditionalXY) then
        local dax, day = input.GetCursorPos()

        self.AdditionalXSave = dax
        self.AdditionalZSave = day

        self.ChangingAdditionalXY = true
    elseif (mouse_right and self.ChangingAdditionalXY) then
        local dax, day = input.GetCursorPos()

        if (self.SnapToCenter <= CurTime()) then
            input.SetCursorPos(self.CursorSnapX, self.CursorSnapY)
            self.SnapToCenter = CurTime() + 0.01
            self.dx, self.dy = input.GetCursorPos()
        end

        local additionalx, additionalz = (dax - self.dx) / 5, (day - self.dy) / 5

        if (self.AdditionalXSaveCache ~= additionalx) then
            self.AdditionalX = self.AdditionalX - additionalx
            self.AdditionalXSaveCache = additionalx
        elseif (self.AdditionalZSaveCache ~= additionalz) then
            self.AdditionalZ = self.AdditionalZ + additionalz
            self.AdditionalZSaveCache = additionalz
        end
    elseif (not mouse_right and self.ChangingAdditionalXY) then
        self.ChangingAdditionalXY = false
    end

    if (GetConVar("moat_autorotate_model"):GetInt() == 1) then
        self.EntAngle = (CurTime() % 360) * 20
        self.PlayerModel:SetAngles(Angle(0, self.EntAngle, 0))
    end

    self:CustomThink()
end

function PANEL:OnMouseWheeled(scrl)
    if (not self:IsHovered()) then return end

    self.ScrollDelta = self.ScrollDelta - (scrl * 5)
end

function PANEL:OnMousePressed(key)
    if (key == MOUSE_LEFT) then
        self.CursorSnapX, self.CursorSnapY = input.GetCursorPos()
        self.Scrolled = true
    elseif (key == MOUSE_RIGHT) then
        self.CursorSnapX, self.CursorSnapY = input.GetCursorPos()
    end
end

function PANEL:OnMouseReleased(key)
    if (key == MOUSE_LEFT) then
        self.Scrolled = false
    end
end

vgui.Register("MOAT_PlayerPreview", PANEL, "DButton")



local PANEL = {}

AccessorFunc( PANEL, "m_strModelName",  "ModelName" )
AccessorFunc( PANEL, "m_iSkin",         "SkinID" )
AccessorFunc( PANEL, "m_strBodyGroups", "BodyGroup" )
AccessorFunc( PANEL, "m_strIconName",   "IconName" )

function PANEL:Init()

    self:SetDoubleClickingEnabled( true )
    self:SetText( "" )

    self.Icon = vgui.Create( "ModelImage", self )
    self.Icon:SetMouseInputEnabled( true )
    self.Icon:SetKeyboardInputEnabled( false )

    self:SetSize( 64, 64 )

    self.m_strBodyGroups = "000000000"

end

function PANEL:DoRightClick()

    local pCanvas = self:GetSelectionCanvas()
    if ( IsValid( pCanvas ) && pCanvas:NumSelectedChildren() > 0 ) then
        return hook.Run( "SpawnlistOpenGenericMenu", pCanvas )
    end

    self:OpenMenu()
end

function PANEL:DoClick()
    self:RebuildSpawnIcon()
end

function PANEL:OpenMenu()
end

function PANEL:Paint( w, h )

    

end


function PANEL:PerformLayout()
	self.Icon:StretchToParent(0, 0, 0, 0)
end

function PANEL:SetSpawnIcon(name)
    self.m_strIconName = name
    self.Icon:SetSpawnIcon(name)
end

function PANEL:SetBodyGroup( k, v )

    if ( k < 0 ) then return end
    if ( k > 9 ) then return end
    if ( v < 0 ) then return end
    if ( v > 9 ) then return end

    self.m_strBodyGroups = self.m_strBodyGroups:SetChar( k + 1, v )

end

function PANEL:CreateIcon(n)
	if (IsValid(self.Icon)) then self.Icon:Remove() end -- Why are we being called anyways?

	self.Icon = vgui.Create("ModelImage", self)
    self.Icon:SetMouseInputEnabled(true)
    self.Icon:SetKeyboardInputEnabled(false)
	self.Icon:StretchToParent(0, 0, 0, 0)

	local mdl = self:GetModelName()
	local skn = self:GetSkinID()

	if (MOAT_MODEL_POS[mdl]) then self.Icon:SetVisible(false) return end
	if (not mdl and not n) then return end
	mdl = tostring(mdl)

	self:SetModel(mdl, skn)
end

function PANEL:SetModel(mdl, iSkin, BodyGroups)
	if ( !mdl ) then debug.Trace() return end
	if (not mdl:EndsWith(".mdl")) then
		if (self.ModelPanel) then self:SetModelName(mdl) self.ModelPanel:Remove() end
		return
	end

	if (self:GetModelName() == mdl and (iSkin and self:GetSkinID() == iSkin or not iSkin)) then
		return
	end

    self:SetModelName( mdl )
    self:SetSkinID( iSkin )

    if ( tostring( BodyGroups ):len() != 9 ) then
        BodyGroups = "000000000"
    end

    self.m_strBodyGroups = BodyGroups
	local mdls = tostring(mdl)

	if (not IsValid(self.Icon)) then
		self:CreateIcon(true)
	end

    if (self.ModelPanel) then self.ModelPanel:Remove() end
    if (MOAT_MODEL_POS[mdls]) then
        self.Icon:SetVisible(false)

        self.ModelPanel = vgui.Create("DModelPanel", self)
        self.ModelPanel:SetPos(0, 0)
        self.ModelPanel:SetSize(64, 64)
        self.ModelPanel:SetModel(mdl)

		if (not IsValid(self.ModelPanel.Entity)) then
			return
		end

        if (iSkin) then self.ModelPanel.Entity:SetSkin(iSkin) end

        local PrevMins, PrevMaxs = self.ModelPanel.Entity:GetRenderBounds()
        self.ModelPanel:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.5, 0.5, 0.5))
        self.ModelPanel:SetLookAt((PrevMaxs + PrevMins) / 2)
        self.ModelPanel.Entity:SetModelScale(MOAT_MODEL_POS[mdls][1])
        self.ModelPanel.Entity:SetAngles(MOAT_MODEL_POS[mdls][2])
        self.ModelPanel.Entity:SetPos(MOAT_MODEL_POS[mdls][3])

        function self.ModelPanel:LayoutEntity(ent)
            ent:SetModelScale(MOAT_MODEL_POS[mdls][1])
            ent:SetAngles(MOAT_MODEL_POS[mdls][2])
            ent:SetPos(MOAT_MODEL_POS[mdls][3])
            --ent:SetAngles(Angle(0, 45, 0))
            --ent:SetPos(Vector(0, 0, 35))
        end
	else
		self.Icon:SetModel(mdl, iSkin, BodyGroups)
        self.Icon:SetVisible(true)
    end
end

function PANEL:RebuildSpawnIcon()
	if (not IsValid(self.Icon) and not MOAT_MODEL_POS[mdls]) then self:CreateIcon() end
	if (not self:GetModelName()) then return end
	if (not file.Exists("materials/spawnicons/" .. string.StripExtension(self:GetModelName()) .. ".png", "GAME")) then
		self.Icon:RebuildSpawnIcon()
	end
end

function PANEL:RebuildSpawnIconEx( t )
    self.Icon:RebuildSpawnIconEx( t )
end

function PANEL:ToTable( bigtable )

    local tab = {}

    tab.type = "model"
    tab.model = self:GetModelName()

    if ( self:GetSkinID() != 0 ) then
        tab.skin = self:GetSkinID()
    end

    if ( self:GetBodyGroup() != "000000000" ) then
        tab.body = "B" .. self:GetBodyGroup()
    end

    if ( self:GetWide() != 64 ) then
        tab.wide = self:GetWide()
    end

    if ( self:GetTall() != 64 ) then
        tab.tall = self:GetTall()
    end

    table.insert( bigtable, tab )

end

-- Icon has been editied, they changed the skin
-- what should we do?
function PANEL:SkinChanged( i )

    -- Change the skin, and change the model
    -- this way we can edit the spawnmenu....
    self:SetSkinID( i )
    self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

function PANEL:BodyGroupChanged( k, v )

    self:SetBodyGroup( k, v )
    self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

vgui.Register( "MoatModelIcon", PANEL, "DButton" )


