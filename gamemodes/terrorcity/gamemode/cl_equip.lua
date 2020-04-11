---- Traitor equipment menu
local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation
include "system/app/ttt/interface/tttradialmenu.lua"

-- create ClientConVars
local numColsVar = CreateClientConVar("ttt_moat_bem_cols", 4, true, false, "Sets the number of columns in the Traitor/Detective menu's item list.")
local numRowsVar = CreateClientConVar("ttt_moat_bem_rows", 5, true, false, "Sets the number of rows in the Traitor/Detective menu's item list.")
local itemSizeVar = CreateClientConVar("ttt_moat_bem_size", 64, true, false, "Sets the item size in the Traitor/Detective menu's item list.")
local showCustomVar = CreateClientConVar("ttt_moat_bem_marker_custom", 1, true, false, "Should custom items get a marker?")
local showFavoriteVar = CreateClientConVar("ttt_moat_bem_marker_fav", 1, true, false, "Should favorite items get a marker?")
local showSlotVar = CreateClientConVar("ttt_moat_bem_marker_slot", 1, true, false, "Should items get a slot-marker?")

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

-- Buyable weapons are loaded automatically. Buyable items are defined in
-- equip_items_shd.lua

local Equipment = nil
function GetEquipmentForRole(role)
   -- need to build equipment cache?
   if not Equipment then
      -- start with all the non-weapon goodies
      local tbl = table.Copy(EquipmentItems)

      -- find buyable weapons to load info from
      for k, v in pairs(weapons.GetList()) do
         if v and v.CanBuy then
            local data = v.EquipMenuData or {}
            local base = {
               id       = WEPS.GetClass(v),
               name     = v.PrintName or "Unnamed",
               limited  = v.LimitedStock,
               kind     = v.Kind or WEAPON_NONE,
               slot     = (v.Slot or 0) + 1,
               material = v.Icon or "vgui/ttt/icon_id",
               -- the below should be specified in EquipMenuData, in which case
               -- these values are overwritten
               type     = "Type not specified",
               model    = "models/weapons/w_bugbait.mdl",
               desc     = "No description specified."
            };

            -- Force material to nil so that model key is used when we are
            -- explicitly told to do so (ie. material is false rather than nil).
            if data.modelicon then
               base.material = nil
            end

            table.Merge(base, data)

            -- add this buyable weapon to all relevant equipment tables
            for _, r in pairs(v.CanBuy) do
                if (BASIC_ROLE_LOOKUP[r] ~= r and not table.HasValue(tbl[r], base)) then
                    table.insert(tbl[r], base)
                else
                    for real_role, basic_role in pairs(BASIC_ROLE_LOOKUP) do
                        if (basic_role == r and not table.HasValue(tbl[real_role], base)) then
                            table.insert(tbl[real_role], base)
                        end
                    end
                end
            end
         end
      end

      -- mark custom items
      for r, is in pairs(tbl) do
         for _, i in pairs(is) do
            if i and i.id then
               i.custom = not table.HasValue(DefaultEquipment[r], i.id)
            end
         end
      end

      Equipment = tbl
   end

   return Equipment and Equipment[role] or {}
end


local function ItemIsWeapon(item) return not tonumber(item.id) end
local function CanCarryWeapon(item) return LocalPlayer():CanCarryType(item.kind) end

local color_bad = Color(220, 60, 60, 255)
local color_good = Color(0, 200, 0, 255)

-- Creates tabel of labels showing the status of ordering prerequisites
/*
local function PreqLabels(parent, x, y)
   local tbl = {}

   tbl.credits = vgui.Create("DLabel", parent)
   --tbl.credits:SetTooltip(GetTranslation("equip_help_cost"))
   tbl.credits:SetPos(x, y)
   -- coins icon
   tbl.credits.img = vgui.Create( "DImage", parent )
   tbl.credits.img:SetSize(32, 32)
   tbl.credits.img:CopyPos(tbl.credits)
   tbl.credits.img:MoveLeftOf(tbl.credits)
   tbl.credits.img:SetImage("vgui/ttt/equip/coin.png")

   -- remaining credits text
   tbl.credits.Check = function(s, sel)
                          local credits = LocalPlayer():GetCredits()
                          return credits > 0, " " .. credits, GetPTranslation("equip_cost", {num = credits})
                       end


   tbl.owned = vgui.Create("DLabel", parent)
   --tbl.owned:SetTooltip(GetTranslation("equip_help_carry"))
   tbl.owned:CopyPos(tbl.credits)
   tbl.owned:MoveRightOf(tbl.credits, y*3)
   -- carry icon
   tbl.owned.img = vgui.Create( "DImage", parent )
   tbl.owned.img:SetSize(32, 32)
   tbl.owned.img:CopyPos(tbl.owned)
   tbl.owned.img:MoveLeftOf(tbl.owned)
   tbl.owned.img:SetImage( "vgui/ttt/equip/briefcase.png" )

   tbl.owned.Check = function(s, sel)
                        if ItemIsWeapon(sel) and (not CanCarryWeapon(sel)) then
                           return false, sel.slot, GetPTranslation("equip_carry_slot", {slot = sel.slot})
                        elseif (not ItemIsWeapon(sel)) and LocalPlayer():HasEquipmentItem(sel.id) then
                           return false, "X", GetTranslation("equip_carry_own")
                        else
                           return true, "✔", GetTranslation("equip_carry")
                        end
                     end

   tbl.bought = vgui.Create("DLabel", parent)
   --tbl.bought:SetTooltip(GetTranslation("equip_help_stock"))
   tbl.bought:CopyPos(tbl.owned)
   tbl.bought:MoveRightOf(tbl.owned, y*3)
   -- stock icon
   tbl.bought.img = vgui.Create( "DImage", parent )
   tbl.bought.img:SetSize(32, 32)
   tbl.bought.img:CopyPos(tbl.bought)
   tbl.bought.img:MoveLeftOf(tbl.bought)
   tbl.bought.img:SetImage( "vgui/ttt/equip/package.png" )

   tbl.bought.Check = function(s, sel)
                         if sel.limited and LocalPlayer():HasBought(tostring(sel.id)) then
                            return false, "X", GetTranslation("equip_stock_deny")
                         else
                            return true, "✔", GetTranslation("equip_stock_ok")
                         end
                      end

   for k, pnl in pairs(tbl) do
      pnl:SetFont("DermaLarge")
   end

   return function(selected)
             local allow = true
             for k, pnl in pairs(tbl) do
                local result, text, tooltip = pnl:Check(selected)
                pnl:SetTextColor(result and COLOR_WHITE or color_bad)
                pnl:SetText(text)
                pnl:SizeToContents()
                pnl:SetTooltip(tooltip)
                pnl.img:SetImageColor(result and COLOR_WHITE or color_bad)
                pnl.img:SetTooltip(tooltip)
                allow = allow and result
             end
             return allow
          end
end*/

local function PreqLabels(parent, x, y)
   local tbl = {}

   tbl.credits = vgui.Create("DLabel", parent)
   tbl.credits:SetTooltip(GetTranslation("equip_help_cost"))
   tbl.credits:SetPos(x, y)
   tbl.credits.Check = function(s, sel)
                          local credits = LocalPlayer():GetCredits()
                          return credits > 0, GetPTranslation("equip_cost", {num = credits})
                       end

   tbl.owned = vgui.Create("DLabel", parent)
   tbl.owned:SetTooltip(GetTranslation("equip_help_carry"))
   tbl.owned:CopyPos(tbl.credits)
   tbl.owned:MoveBelow(tbl.credits, 0)
   tbl.owned.Check = function(s, sel)
                        if ItemIsWeapon(sel) and (not CanCarryWeapon(sel)) then
                           return false, GetPTranslation("equip_carry_slot", {slot = sel.slot})
                        elseif (not ItemIsWeapon(sel)) and LocalPlayer():HasEquipmentItem(sel.id) then
                           return false, GetTranslation("equip_carry_own")
                        else
                           return true, GetTranslation("equip_carry")
                        end
                     end

   tbl.bought = vgui.Create("DLabel", parent)
   tbl.bought:SetTooltip(GetTranslation("equip_help_stock"))
   tbl.bought:CopyPos(tbl.owned)
   tbl.bought:MoveBelow(tbl.owned, 0)
   tbl.bought.Check = function(s, sel)
                         if sel.limited and LocalPlayer():HasBought(tostring(sel.id)) then
                            return false, GetTranslation("equip_stock_deny")
                         else
                            return true, GetTranslation("equip_stock_ok")
                         end
                      end

   for k, pnl in pairs(tbl) do
      pnl:SetFont("TabLarge")
   end

   return function(selected)
             local allow = true
             for k, pnl in pairs(tbl) do
                local result, text = pnl:Check(selected)
                pnl:SetTextColor(result and color_good or color_bad)
                pnl:SetText(text)
                pnl:SizeToContents()

                allow = allow and result
             end
             return allow
          end
end


-- quick, very basic override of DPanelSelect
local PANEL = {}
local function DrawSelectedEquipment(pnl)
  surface.SetDrawColor(255, 200, 0, 255)
  surface.DrawOutlinedRect(0, 0, pnl:GetWide(), pnl:GetTall())
end

function PANEL:SelectPanel(pnl)
   self.BaseClass.SelectPanel(self, pnl)
   if pnl then
      pnl.PaintOver = DrawSelectedEquipment
   end
end
vgui.Register("EquipSelect", PANEL, "DPanelSelect")


local SafeTranslate = LANG.TryTranslation

local color_darkened = Color(255,255,255, 80)
-- TODO: make set of global role colour defs, these are same as wepswitch
local color_slot = {
   [ROLE_TRAITOR]   = Color(180, 50, 40, 255),
   [ROLE_DETECTIVE] = Color(50, 60, 180, 255)
};
color_slot[ROLE_HITMAN] = color_slot[ROLE_TRAITOR]

local eqframe = nil

local function sbar_paint(sbar)
    local smooth_scrolling = GetConVar("moat_smooth_scrolling"):GetInt()

    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()

        if (smooth_scrolling > 0) then
            dlta = dlta * 75
        else
            dlta = dlta * 50
        end

        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
    end

    sbar.Think = function(s)
        if (input.IsMouseDown(MOUSE_LEFT)) then
            s.LerpTarget = s:GetScroll()
        end
        
        local frac = FrameTime() * 5

        if (smooth_scrolling > 0) then
            if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize/10)) then frac = FrameTime() * 2 end
        else
            frac = FrameTime() * 10
        end

        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        newpos = math.Clamp(newpos, 0, s.CanvasSize)

        s:SetScroll(newpos)

        if (s.LerpTarget < 0 and s:GetScroll() == 0) then
            s.LerpTarget = 0
        end

        if (s.LerpTarget > s.CanvasSize and s:GetScroll() == s.CanvasSize) then
            s.LerpTarget = s.CanvasSize
        end
    end

    sbar.moving = false
end

local function TraitorMenuPopup()
  -- calculate dimensions
  local numCols = 4
  local numRows = 5
  local itemSize = 64

  if true then
    numCols = numColsVar:GetInt()
    numRows = numRowsVar:GetInt()
    itemSize = itemSizeVar:GetInt()
  end
  -- margin
  local m = 5
  -- item list width
  local dlistw = ((itemSize + 2) * numCols) - 2 + 15
  local dlisth = ((itemSize + 2) * numRows) - 2 + 15
  -- right column width
  local diw = 270
  -- frame size
  local w = dlistw + diw + (m*4)
  local h = dlisth + 75

   local ply = LocalPlayer()
   if not IsValid(ply) or not ply:IsActiveSpecial() then
      return
   end

   -- Close any existing traitor menu
   if eqframe and IsValid(eqframe) then eqframe:Close() end

   local credits = ply:GetCredits()
   local can_order = credits > 0

   local dframe = vgui.Create("DFrame")
   dframe:SetSize(w, h)
   dframe:Center()
   dframe:SetSkin("moat")
   dframe:SetTitle("Equipment Shop")
   dframe:SetVisible(true)
   dframe:ShowCloseButton(true)
   dframe:SetMouseInputEnabled(true)
   dframe:SetDeleteOnClose(true)
   /*dframe.Paint = function(s, w, h)
        DrawBlur(s, 3)
        draw.WebImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 230))
   end*/

   local dsheet = vgui.Create("DPropertySheet", dframe)
   /*dsheet.Paint = function(s, w, h)
        surface.SetDrawColor(13, 19, 24, 178.5)
        surface.DrawRect(0, 0, w, h)
   end*/
   -- Add a callback when switching tabs
   local oldfunc = dsheet.SetActiveTab
   dsheet.SetActiveTab = function(self, new)
      if self.m_pActiveTab != new and self.OnTabChanged then
         self:OnTabChanged(self.m_pActiveTab, new)
      end
      oldfunc(self, new)
   end

   dsheet:SetPos(0,0)
   dsheet:StretchToParent(m,m + 25,m,m)
   local padding = dsheet:GetPadding()

   local dequip = vgui.Create("DPanel", dsheet)
   dequip:SetPaintBackground(false)
   dequip:StretchToParent(padding,padding,padding,padding)

   -- Determine if we already have equipment
   local owned_ids = {}
   for _, wep in pairs(ply:GetWeapons()) do
      if IsValid(wep) and wep.IsEquipment and wep:IsEquipment() then
         table.insert(owned_ids, wep:GetClass())
      end
   end

   -- Stick to one value for no equipment
   if #owned_ids == 0 then
      owned_ids = nil
   end

   --- Construct icon listing
   --- icon size = 64 x 64
   local dlist = vgui.Create("EquipSelect", dequip)
   -- local dlistw = 288
   dlist:SetPos(0, 0)
   dlist:SetSize(dlistw, dlisth)
   dlist:EnableVerticalScrollbar(true)
   dlist:EnableHorizontal(true)
   sbar_paint(dlist.VBar)


   local items = GetEquipmentForRole(ply:GetRole())

   local to_select = nil

   -- temp table for sorting
   local paneltablefav = {}
   local paneltable = {}

   for k, item in pairs(items) do
      local ic = nil

      -- Create icon panel
      if item.material then
         ic = vgui.Create("LayeredIcon", dlist)

         if item.custom && showCustomVar:GetBool() then
            -- Custom marker icon
            local marker = vgui.Create("DImage")
            marker:SetImage("vgui/ttt/custom_marker")
            marker.PerformLayout = function(s)
                                      s:AlignBottom(2)
                                      s:AlignRight(2)
                                      s:SetSize(16, 16)
                                   end
            marker:SetTooltip(GetTranslation("equip_custom"))

            ic:AddLayer(marker)

            ic:EnableMousePassthrough(marker)
         end

         -- Favorites marker icon
         ic.favorite = false
         local favorites = BetterEQ.GetFavorites(ply:SteamID(), ply:GetRole())
         if favorites then
           if BetterEQ.IsFavorite(favorites, item.id) then
             ic.favorite = true
             if showFavoriteVar:GetBool() then
               local star = vgui.Create("DImage")
               star:SetImage("icon16/star.png")
               star.PerformLayout = function(s)
                                         s:AlignTop(2)
                                         s:AlignRight(2)
                                         s:SetSize(12, 12)
                                      end
               star:SetTooltip("Favorite")
               ic:AddLayer(star)
               ic:EnableMousePassthrough(star)
             end
           end
         end

         -- Slot marker icon
         if ItemIsWeapon(item) && showSlotVar:GetBool() then
            local slot = vgui.Create("SimpleIconLabelled")
            slot:SetIcon("vgui/ttt/slotcap")
            slot:SetIconColor(color_slot[ply:GetRole()] or COLOR_GREY)
            slot:SetIconSize(16)

            slot:SetIconText(item.slot)

            slot:SetIconProperties(COLOR_WHITE,
                                   "DefaultBold",
                                   {opacity=220, offset=1},
                                   {10, 8})

            ic:AddLayer(slot)
            ic:EnableMousePassthrough(slot)
         end

         ic:SetIconSize(itemSize)
         ic:SetIcon(item.material)
      elseif item.model then
         ic = vgui.Create("SpawnIcon", dlist)
         ic:SetModel(item.model)
      else
         ErrorNoHalt("Equipment item does not have model or material specified: " .. tostring(item) .. "\n")
      end

      ic.item = item

      local tip = SafeTranslate(item.name) .. " (" .. SafeTranslate(item.type) .. ")"
      ic:SetTooltip(tip)

      -- If we cannot order this item, darken it
      if ((not can_order) or
          -- already owned
          table.HasValue(owned_ids, item.id) or
          (tonumber(item.id) and ply:HasEquipmentItem(tonumber(item.id))) or
          -- already carrying a weapon for this slot
          (ItemIsWeapon(item) and (not CanCarryWeapon(item))) or
          -- already bought the item before
          (item.limited and ply:HasBought(tostring(item.id)))) then

         ic:SetIconColor(color_darkened)
      end

      if ic.favorite then
        paneltablefav[k] = ic
      else
        paneltable[k] = ic
      end

   end

   -- add favorites first
   for _, panel in pairs(paneltablefav) do
     dlist:AddPanel(panel)
   end
   -- non favorites second
   for _, panel in pairs(paneltable) do
     dlist:AddPanel(panel)
   end

   local bw, bh = 100, 25

   -- Whole right column
   local dih = h - bh - m*5
   -- local diw = w - dlistw - m*6 - 2
   local dinfobg = vgui.Create("DPanel", dequip)
   dinfobg:SetPaintBackground(false)
   dinfobg:SetSize(diw - m + 4, dih)
   dinfobg:SetPos(dlistw + m, 0)

   -- item info pane
   local dinfo = vgui.Create("DPanel", dinfobg)
   dinfo:SetPos(0,0)
   dinfo:StretchToParent(0, 0, m*2, 130)

   local dinfo2 = vgui.Create("DPanel", dinfobg)
   dinfo2:SetPos(0,dinfo:GetTall() + 5)
   dinfo2:SetSize(diw - m - 6, 70)

   local dfields = {}
   for _, k in pairs({"name", "type", "desc"}) do
      dfields[k] = vgui.Create("DLabel", dinfo)
      dfields[k]:SetTooltip(GetTranslation("equip_spec_" .. k))
      dfields[k]:SetPos(m*3, m*2)
      dfields[k]:SetWidth((diw - m*6) - 10)
   end

   dfields.name:SetFont("TabLarge")

   dfields.type:SetFont("DermaDefault")
   dfields.type:MoveBelow(dfields.name)

   dfields.desc:SetFont("DermaDefaultBold")
   dfields.desc:SetContentAlignment(7)
   dfields.desc:MoveBelow(dfields.type, 1)

   local iw, ih = dinfo:GetSize()

   local dhelp = vgui.Create("DPanel", dinfobg)
   dhelp:SetPaintBackground(false)
   dhelp:SetSize(diw, 100)
   dhelp:MoveBelow(dinfo, 0)

   local update_preqs = PreqLabels(dhelp, (m*7) - 25, (m*2) + 3)

   dhelp:SizeToContents()

   local dconfirm = vgui.Create("DButton", dinfobg)
   dconfirm:SetPos(0, dih - bh*2)
   dconfirm:SetSize(bw, bh)
   dconfirm:SetDisabled(true)
   dconfirm.Green = true
   dconfirm:SetText("Buy Equipment")


   dsheet:AddSheet(GetTranslation("equip_tabtitle"), dequip, "icon16/bomb.png", false, false, "Traitor equipment menu")

   -- Item control
   if ply:HasEquipmentItem(EQUIP_RADAR) then
      local dradar = RADAR.CreateMenu(dsheet, dframe)
      dsheet:AddSheet(GetTranslation("radar_name"), dradar, "icon16/magnifier.png", false,false, "Radar control")
   end

   if ply:HasEquipmentItem(EQUIP_DISGUISE) then
      local ddisguise = DISGUISE.CreateMenu(dsheet)
      dsheet:AddSheet(GetTranslation("disg_name"), ddisguise, "icon16/user.png", false,false, "Disguise control")
   end

   -- Weapon/item control
   if IsValid(ply.radio) or ply:HasWeapon("weapon_ttt_radio") then
      local dradio = TRADIO.CreateMenu(dsheet)
      dsheet:AddSheet(GetTranslation("radio_name"), dradio, "icon16/transmit.png", false,false, "Radio control")
   end

   -- Credit transferring
   if credits > 0 then
      local dtransfer = CreateTransferMenu(dsheet)
      dsheet:AddSheet(GetTranslation("xfer_name"), dtransfer, "icon16/group_gear.png", false,false, "Transfer credits")
   end

   hook.Run("TTTEquipmentTabs", dsheet)


   -- couple panelselect with info
   dlist.OnActivePanelChanged = function(self, _, new)
                                   for k,v in pairs(new.item) do
                                      if dfields[k] then
                                         dfields[k]:SetText(SafeTranslate(v))
                                         dfields[k]:SetAutoStretchVertical(true)
                                         dfields[k]:SetWrap(true)
                                      end
                                   end

                                   -- Trying to force everything to update to
                                   -- the right size is a giant pain, so just
                                   -- force a good size.
                                   dfields.desc:SetTall(70)

                                   can_order = update_preqs(new.item)

                                   dconfirm:SetDisabled(not can_order)
                                end

   -- select first
   dlist:SelectPanel(to_select or dlist:GetItems()[1])

   -- prep confirm action
   dconfirm.DoClick = function()
                         local pnl = dlist.SelectedPanel
                         if not pnl or not pnl.item then return end
                         local choice = pnl.item
                         RunConsoleCommand("ttt_order_equipment", choice.id)
                         dframe:Close()
                      end

   -- update some basic info, may have changed in another tab
   -- specifically the number of credits in the preq list
   dsheet.OnTabChanged = function(s, old, new)
                            if not IsValid(new) then return end

                            if new:GetPanel() == dequip then
                               can_order = update_preqs(dlist.SelectedPanel.item)
                               dconfirm:SetDisabled(not can_order)
                            end
                         end

   local dcancel = vgui.Create("DButton", dframe)
   dcancel:SetPos(w - 13 - bw, h - bh - 16)
   dcancel:SetSize(bw, bh)
   dcancel:SetDisabled(false)
   dcancel:SetText(GetTranslation("close"))
   dcancel.Red = true
   dcancel.DoClick = function()
     dframe:Close()
   end

   function file.AppendLine(filename, addme)
       data = file.Read(filename)
       if ( data ) then
         file.Write(filename, data .. "\n" .. tostring(addme))
       else
           file.Write(filename, tostring(addme))
       end
   end

   --add as favorite button
   dfav = vgui.Create("DButton", dinfobg)
   dfav:SetPos(0, dih - bh*2)
   dfav:MoveRightOf(dconfirm)
   dfav:SetSize(bh, bh)
   dfav:SetDisabled(false)
   dfav:SetText("")
   dfav:SetImage("icon16/star.png")
   dfav.DoClick = function()
     local ply = LocalPlayer()
     local role = ply:GetRole()
     local guid = ply:SteamID()
     local pnl = dlist.SelectedPanel
     if not pnl or not pnl.item then return end
     local choice = pnl.item
     local weapon = choice.id
     BetterEQ.CreateFavTable()
     if pnl.favorite then
       BetterEQ.RemoveFavorite(guid, role, weapon)
     else
       BetterEQ.AddFavorite(guid, role, weapon)
     end
   end

   dframe:MakePopup()
   dframe:SetKeyboardInputEnabled(false)

   eqframe = dframe
end
concommand.Add("ttt_cl_traitorpopup", TraitorMenuPopup)

local function ForceCloseTraitorMenu(ply, cmd, args)
   if IsValid(eqframe) then
      eqframe:Close()
   end
end
concommand.Add("ttt_cl_traitorpopup_close", ForceCloseTraitorMenu)

function GM:OnContextMenuOpen()
    local r = GetRoundState()
    if r == ROUND_ACTIVE and not (LocalPlayer():GetTraitor() or LocalPlayer():GetDetective()) then
       return
    elseif r == ROUND_POST or r == ROUND_PREP then
         CLSCORE:Toggle()
       return
    end
 
    local ply = LocalPlayer()
    if IsValid(eqframe) then
       eqframe:Close()
    elseif (IsValid(ply) and ply:IsActiveSpecial()) then
        print(cookie.GetNumber("quickmenu_disable", 0) )
     if (cookie.GetNumber("quickmenu_disable", 0) == 0) then
         eqframe = vgui.Create("TTTRadialMenu")
     else
        eqframe = vgui.Create("EquipmentMenu")
     end
     eqframe:SetRole(LocalPlayer():GetRole())
     eqframe:MakePopup()
     eqframe:SetKeyboardInputEnabled(false)
    end
 end

function GM:OnContextMenuClose()
    if (IsValid(eqframe) and eqframe.Finish) then
        eqframe = eqframe:Finish()
    end
end


local function ReceiveEquipment()
   local ply = LocalPlayer()
   if not IsValid(ply) then return end

   ply.equipment_items = net.ReadUInt(16)
   hook.Run("OnEquipmentReceived", ply.equipment_items)
end
net.Receive("TTT_Equipment", ReceiveEquipment)

local function ReceiveCredits()
   local ply = LocalPlayer()
   if not IsValid(ply) then return end

   ply.equipment_credits = net.ReadUInt(8)
   hook.Run("OnEquipmentCreditsChanged", ply.equipment_credits)
end
net.Receive("TTT_Credits", ReceiveCredits)

local r = 0
local function ReceiveBought()
   local ply = LocalPlayer()
   if not IsValid(ply) then return end

   ply.bought = {}
   local num = net.ReadUInt(8)
   for i=1,num do
      local s = net.ReadString()
      if s != "" then
         table.insert(ply.bought, s)
      end
   end

   -- This usermessage sometimes fails to contain the last weapon that was
   -- bought, even though resending then works perfectly. Possibly a bug in
   -- bf_read. Anyway, this hack is a workaround: we just request a new umsg.
   if num != #ply.bought and r < 10 then -- r is an infinite loop guard
      RunConsoleCommand("ttt_resend_bought")
      r = r + 1
   else
      r = 0
   end
end
net.Receive("TTT_Bought", ReceiveBought)

-- Player received the item he has just bought, so run clientside init
local function ReceiveBoughtItem()
   local is_item = net.ReadBit() == 1
   local id = is_item and net.ReadUInt(16) or net.ReadString()

   -- I can imagine custom equipment wanting this, so making a hook
   hook.Run("TTTBoughtItem", is_item, id)
end
net.Receive("TTT_BoughtItem", ReceiveBoughtItem)

/*
net.Receive("TTT_Player_Equipment", function()
    local n = net.ReadString()
    local c = net.ReadBool()
    local e = net.ReadString()
    local d = net.ReadBool()
    if (c) then
        e = weapons.Get(e)
        if (not e) then return end
        e = e.PrintName or e:GetPrintName() or e:GetClass()
    end
    e = SafeTranslate(e) or e

    if (d) then
        chat.AddText(Material("icon16/information.png"), Color(50, 100, 200), "[Detective] " .. n .. " has purchased a " .. e .. " from the Detective shop.")
    else
        chat.AddText(Material("icon16/information.png"), Color(200, 0, 0), "[Traitor] " .. n .. " has purchased a " .. e .. " from the Traitor shop.")
    end
end)*/