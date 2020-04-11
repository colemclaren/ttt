local passthroughs = {}
local function Passthrough(what)
    if (not passthroughs[what]) then
        passthroughs[what] = function(self, ...)
            self = self:GetParent()
            self[what](self, ...)
        end
    end

    return passthroughs[what]
end

local itemSizeVar = CreateClientConVar("ttt_moat_bem_size", 64, true, false, "Sets the item size in the Traitor/Detective menu's item list.")
local quickMenuClickBuy = CreateClientConVar("ttt_moat_quickmenu_click", 1, true, false, "Sets whether you must click or not in the quick menu.")

sql.Query([[
    CREATE TABLE IF NOT EXISTS `ttt_menu_collapsed` (
        `role` INT UNSIGNED NOT NULL,
        `steamid` TEXT NOT NULL,
        `category` TEXT NOT NULL,
        PRIMARY KEY (`steamid`, `category`, `role`)
    );
    CREATE TABLE IF NOT EXISTS `ttt_menu_radial` (
        `role` INT UNSIGNED NOT NULL,
        `steamid` TEXT NOT NULL,
        `id` TEXT NOT NULL,
        PRIMARY KEY(`steamid`, `role`, `id`)
    )
]])

local function SetRadial(role, item, inside)
    if (not inside) then
        sql.Query("DELETE FROM `ttt_menu_radial` WHERE `id` = "..sql.SQLStr(tostring(item)).." AND `steamid` = "..LocalPlayer():SteamID64().." AND `role` = "..role..";")
    else
        sql.Query([[INSERT INTO `ttt_menu_radial` VALUES (
            ]]..role..[[,
            ]]..LocalPlayer():SteamID64()..[[,
            ]]..sql.SQLStr(tostring(item))..[[
        )]])
    end
end

local function IsRadialItem(role, item)
    return "1" == sql.QueryValue("SELECT 1 FROM `ttt_menu_radial` WHERE `role` = "..role.." AND `steamid` = "..LocalPlayer():SteamID64().." AND `id` = "..sql.SQLStr(item.id))
end

function GetRadialItems(role)
    local entries = sql.Query("SELECT `id` FROM `ttt_menu_radial` WHERE `role` = "..role.." AND `steamid` = "..LocalPlayer():SteamID64().." ORDER BY `_rowid_`;")
    if (not entries) then
        return
    end

    local items = GetEquipmentForRole(role)

    for i = #entries, 1, -1 do
        local id = entries[i].id
        if (tonumber(id)) then
            id = tonumber(id)
        end
        entries[i] = id
        for _, item in pairs(items) do
            if (item.id == id) then
                entries[i] = item
            end
        end
        if (not istable(entries[i])) then
            table.remove(entries, i)
        end
    end

    return entries
end

local function SetCollapsed(category, role, collapsed)
    if (not collapsed) then
        sql.Query([[DELETE FROM `ttt_menu_collapsed` WHERE `category` = ]]..sql.SQLStr(category)..[[ AND `role` = ]]..role..[[ AND `steamid` = ]]..LocalPlayer():SteamID64()..[[;]])
    else
        sql.Query([[INSERT INTO `ttt_menu_collapsed` VALUES(
            ]]..role..[[, 
            ]]..LocalPlayer():SteamID64()..[[, 
            ]]..sql.SQLStr(category)..[[
        );]])
    end
end


local function IsCollapsed(category, role)
    return sql.QueryValue([[SELECT 1 FROM `ttt_menu_collapsed` WHERE `category` = ]]..sql.SQLStr(category)..[[ AND `role` = ]]..role..[[ AND `steamid` = ]]..LocalPlayer():SteamID64()) == "1"
end


function PanelMousePassthrough(p)
    p.OnMousePressed  = Passthrough "OnMousePressed"
    p.OnCursorEntered = Passthrough "OnCursorEntered"
    p.OnCursorExited  = Passthrough "OnCursorExited"
end

local GetTranslation = function(...) return LANG and LANG.GetTranslation(...) end
local GetPTranslation = function(...) return LANG and LANG.GetParamTranslation(...) end
local SafeTranslate = function(...) return LANG and LANG.TryTranslation(...) end

local color_slot = {
   [ROLE_TRAITOR]   = Color(180, 50, 40, 255),
   [ROLE_DETECTIVE] = Color(50, 60, 180, 255)
};
if (ROLE_HITMAN) then
    color_slot[ROLE_HITMAN] = color_slot[ROLE_TRAITOR]
end

local function ItemIsWeapon(item) return not tonumber(item.id) end
local function CanCarryWeapon(item) return LocalPlayer():CanCarryType(item.kind) end
local function CanBuy(item)
    return not (ItemIsWeapon(item) and (not CanCarryWeapon(item)) or not ItemIsWeapon(item) and LocalPlayer():HasEquipmentItem(item.id) or item.limited and LocalPlayer():HasBought(tostring(item.id)))
end

DEFINE_BASECLASS "DFrame"

local PANEL = {}

local Passives = {
    ["Active Use Item"] = true,
    item_passive = true,
    item_active = true
}

local au = "Actually Used"
local ClassCategories = {
    weapon_vadim_blink = au,
    weapon_banana = au,
    weapon_ttt_sandwich = au,
    weapon_ttt_mine_turtle = au,
    weapon_ttt_c4 = au,
    weapon_ttt_jihad = au,
    weapon_ttt_awp = au,
    weapon_ttt_knife = au,
    ttt_realistic_hook = au,
    weapon_ttt_proximitymine = au
}

function PANEL:Init()
    hook.Add("TTTFavoritesChanged", self, self.FavoritesUpdate)
    self:SetTitle "Equipment Shop"

    self:SetSizable(true)

    self:SetSize(
        math.max(400, cookie.GetNumber("equipment_menu_w", ScrW() / 2)),
        math.max(300, cookie.GetNumber("equipment_menu_h", ScrH() / 2))
    )
    if (cookie.GetNumber("equipment_menu_x")) then
        self:SetPos(cookie.GetNumber("equipment_menu_x", 0), cookie.GetNumber("equipment_menu_y", 0))
    else
        self:Center()
    end
    self.Sheet = vgui.Create("DPropertySheet", self)
    self.Sheet:Dock(FILL)
    self.Sheet:DockPadding(5, 5, 5, 5)

    self.EquipmentTab = vgui.Create("EditablePanel", self.Sheet)
    self.EquipmentTab:Dock(FILL)

    self.ScrollList = vgui.Create("DScrollPanel", self.EquipmentTab)
    self.ScrollList:Dock(FILL)

    self.EquipmentInfo = vgui.Create("EquipmentItemInfo", self.EquipmentTab)
    self.EquipmentInfo:SetRoot(self)
    self.EquipmentInfo:Dock(RIGHT)
    self.EquipmentInfo:DockMargin(5, 0, 0, 0)

    self.Sheet:AddSheet(GetTranslation("equip_tabtitle"), self.EquipmentTab, "icon16/bomb.png", false, false, "Traitor equipment menu")

    self.Categories = {}

    self.ItemPanels = {}

    BetterEQ.CreateFavTable()

    local ply = LocalPlayer()

    -- Item control
    if ply:HasEquipmentItem(EQUIP_RADAR) then
       local dradar = RADAR.CreateMenu(self.Sheet, self)
       self.Sheet:AddSheet(GetTranslation("radar_name"), dradar, "icon16/magnifier.png", false,false, "Radar control")
    end

    if ply:HasEquipmentItem(EQUIP_DISGUISE) then
       local ddisguise = DISGUISE.CreateMenu(self.Sheet)
       self.Sheet:AddSheet(GetTranslation("disg_name"), ddisguise, "icon16/user.png", false,false, "Disguise control")
    end

    -- Weapon/item control
    if IsValid(ply.radio) or ply:HasWeapon("weapon_ttt_radio") then
       local dradio = TRADIO.CreateMenu(self.Sheet)
       self.Sheet:AddSheet(GetTranslation("radio_name"), dradio, "icon16/transmit.png", false,false, "Radio control")
    end

    -- Credit transferring
    if ply:GetCredits() > 0 then
       local dtransfer = CreateTransferMenu(self.Sheet)
       self.Sheet:AddSheet(GetTranslation("xfer_name"), dtransfer, "icon16/group_gear.png", false,false, "Transfer credits")
    end

    local settings = vgui.Create("DPanel", self.Sheet)
    self.Settings = settings
    self.Settings:DockPadding(10, 10, 10, 10)
    self.Sheet:AddSheet("Settings", settings, "icon16/plugin.png", false,false, "Settings")

    local disable = vgui.Create("DCheckBoxLabel", self.Settings)
    self.Settings.DisableQuickMenu = disable
    disable:SetText("Disable Quick Menu")
    disable:Dock(TOP)
    disable:SetValue(cookie.GetNumber("quickmenu_disable", 0))
    function disable:OnChange(v)
        cookie.Set("quickmenu_disable", v and 1 or 0)
    end

    local clickbuy = vgui.Create("DCheckBoxLabel", self.Settings)
    self.Settings.ClickBuy = clickbuy
    clickbuy:SetText("Disable Quick Buy for Quick Menu (no clicking)")
    clickbuy:Dock(TOP)
    clickbuy:SetConVar "ttt_moat_quickmenu_click"
    clickbuy:DockMargin(0, 5, 0, 0)

    local size = vgui.Create("DNumSlider", self.Settings)
    self.IconSize = size
    size:Dock(TOP)
    size:SetZPos(-1)
    size:SetText "Icon Size (reopen to change)"
    size:SetMin(32)
    size:SetMax(128)
    size:SetDecimals(0)
    size:SetConVar "ttt_moat_bem_size"

    local resizenote = vgui.Create("DLabel", self.Settings)

    resizenote:SetText"You can resize this window by dragging the bottom right corner."
    resizenote:SetZPos(-2)
    resizenote:Dock(TOP)

end

function PANEL:FavoritesUpdate(added, id)
    self.Favorites = BetterEQ.GetFavorites(LocalPlayer():SteamID(), self.Role)

    local panel = self.ItemPanels[id]
    local cat
    cat, panel.SortPriority = self:GetCategoryForItem(panel.Item)
    cat = self:GetEquipmentCategory(cat)

    local cur = panel:GetParent()
    panel:SetParent(cat)
    panel:UpdateFavorite()
    cur:Layout()
    cat:Layout()
end

function PANEL:GetEquipmentCategory(category)
    local pnl = self.Categories[category]
    if (not pnl) then
        pnl = vgui.Create("DCollapsibleCategory", self.ScrollList)
        pnl:SetExpanded(not IsCollapsed(category, self.Role))
        function pnl.OnToggle()
            SetCollapsed(category, self.Role, not pnl:GetExpanded())
        end
        pnl:SetLabel(category)
        pnl:Dock(TOP)

        pnl.ItemList = vgui.Create("DSortableIconLayout", pnl)
        pnl.ItemList:SetSpaceY(5)
        pnl.ItemList:SetSpaceX(5)
        pnl.ItemList:Dock(TOP)

        pnl:SetContents(pnl.ItemList)

        self.Categories[category] = pnl
    end

    return pnl.ItemList
end

function PANEL:EquipmentSelected(pnl)
    if (IsValid(self.Selected)) then
        self.Selected.Selected = nil
    end
    pnl.Selected = true
    self.Selected = pnl
    self.EquipmentInfo:SetItem(pnl.Item)
end

function PANEL:GetCategoryForItem(item)
    local cat, extra = nil, 0
    if (BetterEQ.IsFavorite(self.Favorites, item.id)) then
        cat = "Favorites"
        for i, _item in pairs(self.Favorites) do
            if (_item.weapon_id == tostring(item.id)) then
                extra = _item.rowid
            end
        end
    elseif (Passives[item.type]) then
        cat = "Passives"
    elseif (ClassCategories[item.id]) then
        cat = ClassCategories[item.id]
    else
        cat = "Items"
    end
    return cat, extra
end

function PANEL:SetRole(role)
    self.Favorites = BetterEQ.GetFavorites(LocalPlayer():SteamID(), role)
    self.Role = role

    self:GetEquipmentCategory "Favorites"
    self:GetEquipmentCategory "Passives"
    self:GetEquipmentCategory(au)

    local items = GetEquipmentForRole(role)

    local selected = function(ic) self:EquipmentSelected(ic) end

    for _, item in ipairs(items) do
        local cat_name, sort = self:GetCategoryForItem(item)
        local cat = self:GetEquipmentCategory(cat_name)

        local icon
        icon = cat:Add("EquipmentIcon")
        icon.SortPriority = sort
        icon.Root = self
        icon:SetIcon(item.material)
        icon:SetIconSize(itemSizeVar:GetInt())
        icon.DoClick = selected
        icon:SetRole(role)
        icon:SetArbitrator(self)
        icon:SetItem(item)

        if (not self.Selected) then
            icon:OnMousePressed(MOUSE_LEFT)
        end

        self.ItemPanels[item.id] = icon
    end

    for _, cat in pairs(self.Categories) do
        cat.ItemList:Layout()
    end
end

function PANEL:OnRemove()
    if (IsValid(self.Dropdown)) then
        self.Dropdown:Remove()
    end

    local x, y = self:GetPos()
    local w, h = self:GetSize()
    cookie.Set("equipment_menu_x", x)
    cookie.Set("equipment_menu_y", y)
    cookie.Set("equipment_menu_w", w)
    cookie.Set("equipment_menu_h", h)
end

vgui.Register("EquipmentMenu", PANEL, "DFrame")

local PANEL = {}

DEFINE_BASECLASS "LayeredIcon"

function PANEL:Init()
    BaseClass.Init(self)
    hook.Add("TTTBoughtItem", self, self.TTTBoughtItem)
    hook.Add("TTTSearchUpdated", self, self.TTTSearchUpdated)
end

function PANEL:TTTBoughtItem(is_item, id)
    if (self.Item.id == id) then
        local item = self.Item
        self.Dark = not is_item and not CanCarryWeapon(item) or is_item or item.limited
        self.Root.EquipmentInfo.BuyButton:SetDisabled(self.Dark)
    end
end

function PANEL:PaintOver(w, h)
    if (self.Selected) then
        surface.SetDrawColor(255, 200, 0, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    if (self.Filtered) then
        surface.SetDrawColor(0, 0, 0, 220)
        surface.DrawRect(0, 0, w, h)
    elseif (self.Dark) then
        surface.SetDrawColor(0, 0, 0, 180)
        surface.DrawRect(0, 0, w, h)
    end
end

function PANEL:UpdateFavorite()
    if (self:IsFavorite() ~= not not self.FavoriteLayer) then
        if (IsValid(self.FavoriteLayer)) then
            self.FavoriteLayer:Remove()
            for i = 1, #self.Layers do
                if (self.Layers[i] == self.FavoriteLayer) then
                    table.remove(self.Layers, i)
                    break
                end
            end
            self.FavoriteLayer = nil
        else
            local star = vgui.Create("DImage")
            star:SetImage("icon16/star.png")
            function star:PerformLayout()
                self:AlignTop(2)
                self:AlignRight(2)
                self:SetSize(16, 16)
            end
            self:AddLayer(star)
            self.FavoriteLayer = star
        end
    end
end

function PANEL:TTTSearchUpdated(search)
    if (search == "") then
        self.Filtered = false
    end

    search = search:lower()
    self.Filtered = not SafeTranslate(self.Item.name):lower():find(search, 1, true) and not SafeTranslate(self.Item.desc):find(search, 1, true)
end

function PANEL:OnMousePressed(code)
    if (code == MOUSE_LEFT and input.IsKeyDown(KEY_LCONTROL)) then
        RunConsoleCommand("ttt_order_equipment", self.Item.id)
    end

    if (code == MOUSE_RIGHT) then
        self:OnMousePressed(MOUSE_LEFT)
        if (IsValid(self.Root.Dropdown)) then
            self.Root.Dropdown:Remove()
        end
        local menu = DermaMenu()
        self.Root.Dropdown = menu

        menu:AddOption("Buy", function()
            RunConsoleCommand("ttt_order_equipment", self.Item.id)
        end):SetImage("icon16/money.png")

        if (self:IsFavorite()) then
            menu:AddOption("Remove from Favorites", function()
                BetterEQ.RemoveFavorite(LocalPlayer():SteamID(), self.Role, self.Item.id)
                hook.Run("TTTFavoritesChanged", false, self.Item.id)
            end):SetImage "icon16/award_star_delete.png"
        else
            menu:AddOption("Add to Favorites", function()
                BetterEQ.AddFavorite(LocalPlayer():SteamID(), self.Role, self.Item.id)
                hook.Run("TTTFavoritesChanged", true, self.Item.id)
            end):SetImage "icon16/award_star_add.png"
        end

        if (IsRadialItem(self.Role, self.Item)) then
            menu:AddOption("Remove from Quick Menu", function()
                SetRadial(self.Role, self.Item.id, false)
            end):SetImage "icon16/heart_delete.png"
        else
            menu:AddOption("Add to Quick Menu", function()
                SetRadial(self.Role, self.Item.id, true)
            end):SetImage "icon16/heart_add.png"
        end

        menu:AddOption("Copy bind template", function()
            SetClipboardText(string.format("bind <key> \"ttt_order_equipment %s\"", self.Item.id))
        end):SetImage "icon16/comment.png"

        menu:SetPos(gui.MousePos())
        menu:Open()
        return
    end
    self.BaseClass.OnMousePressed(self, code)
end

function PANEL:SetRole(role)
    self.Role = role
end

function PANEL:SetItem(item)
    self.Item = item
    if (self.Arbitrator) then
        self:UpdateFavorite()
    end

    if (ItemIsWeapon(item)) then
       local slot = vgui.Create("SimpleIconLabelled")
       slot:SetIcon("vgui/ttt/slotcap")
       slot:SetIconColor(color_slot[self.Role] or color_white)
       slot:SetIconSize(16)

       slot:SetIconText(item.slot)

       slot:SetIconProperties(color_white, "DefaultBold", {
           opacity = 220,
           offset = 1
        }, {10, 8})

       self:AddLayer(slot)
    end

    self.Dark = not CanBuy(item)
end

function PANEL:IsFavorite()
    return BetterEQ.IsFavorite(self.Arbitrator.Favorites, self.Item.id)
end

function PANEL:SetArbitrator(p)
    self.Arbitrator = p
    if (self.Item) then
        self:UpdateFavorite()
    end
end

vgui.Register("EquipmentIcon", PANEL, "LayeredIcon")

local PANEL = {}

local color_bad = Color(220, 60, 60, 255)
local color_good = Color(0, 200, 0, 255)
function PANEL:Init()
    self:DockPadding(15,15,15,15)

    self.Search = vgui.Create("DTextEntry", self)
    self.Search:Dock(BOTTOM)
    self.Search:DockMargin(0, 15, 0, 0)
    self.Search:SetPlaceholderText("Search...")
    self.Search:SetZPos(-2)
    self.Search.omp = self.Search.OnMousePressed
    function self.Search.OnMousePressed(_, code)
        if (code == MOUSE_LEFT) then
            self.Root:SetKeyboardInputEnabled(true)
        end
        _:omp(code)
    end
    function self.Search.OnFocusChanged(_, gained)
        if (not gained) then
            self.Root:SetKeyboardInputEnabled(false)
        end
    end
    function self.Search:OnChange()
        hook.Run("TTTSearchUpdated", self:GetText())
    end


    self.BuyButton = vgui.Create("DButton", self)
    self.BuyButton:SetText("Buy Equipment")
    self.BuyButton:Dock(BOTTOM)
    self.BuyButton:DockMargin(0, 5, 0, 0)
    self.BuyButton:SetZPos(-1)
    function self.BuyButton.DoClick()
        RunConsoleCommand("ttt_order_equipment", self.Item.id)
        self.Root:Remove()
    end

    self.InStock = vgui.Create("DLabel", self)
    self.InStock:Dock(BOTTOM)
    self.InStock:SetFont("TabLarge")
    self.InStock:SetZPos(0)

    self.CanCarry = vgui.Create("DLabel", self)
    self.CanCarry:Dock(BOTTOM)
    self.CanCarry:SetFont("TabLarge")
    self.CanCarry:SetZPos(1)

    self.Credits = vgui.Create("DLabel", self)
    self.Credits:Dock(BOTTOM)
    self.Credits:SetFont("TabLarge")
    self.Credits:SetZPos(2)
    self:OnEquipmentCreditsChanged(LocalPlayer():GetCredits())

    self.Name = vgui.Create("DLabel", self)
    self.Name:SetFont("TabLarge")
    self.Name:Dock(TOP)
    self.Name:SetAutoStretchVertical(true)
    self.Name:SetWrap(true)

    self.Desc = vgui.Create("DLabel", self)
    self.Desc:Dock(TOP)
    self.Desc:SetContentAlignment(7)
    self.Desc:SetFont("DermaDefaultBold")
    self.Desc:SetAutoStretchVertical(true)
    self.Desc:DockMargin(0, 20, 0, 0)
    self.Desc:SetWrap(true)

    hook.Add("OnEquipmentCreditsChanged", self, self.OnEquipmentCreditsChanged)
end

function PANEL:OnEquipmentCreditsChanged(credits)
    self.Credits:SetText(GetPTranslation("equip_cost", {num = credits}))
    self.Credits:SetTextColor(credits > 0 and color_good or color_bad)
end

function PANEL:SetItem(item)
    self.Item = item

    local carry_text, carry_color
    if ItemIsWeapon(item) and (not CanCarryWeapon(item)) then
       carry_color, carry_text = color_bad, GetPTranslation("equip_carry_slot", {slot = item.slot})
    elseif (not ItemIsWeapon(item)) and LocalPlayer():HasEquipmentItem(item.id) then
        carry_color, carry_text = color_bad, GetTranslation("equip_carry_own")
    else
        carry_color, carry_text = color_good, GetTranslation("equip_carry")
    end
    self.CanCarry:SetTextColor(carry_color)
    self.CanCarry:SetText(carry_text)


    local limit_color, limit_text
    if item.limited and LocalPlayer():HasBought(tostring(item.id)) then
        limit_color, limit_text = color_bad, GetTranslation("equip_stock_deny")
    else
        limit_color, limit_text = color_good, GetTranslation("equip_stock_ok")
    end

    self.InStock:SetTextColor(limit_color)
    self.InStock:SetText(limit_text)

    self.Name:SetText(SafeTranslate(item.name))
    self.Desc:SetText(SafeTranslate(item.desc))

    self.BuyButton:SetDisabled(not (CanBuy(item) and LocalPlayer():GetCredits() > 0))
end

function PANEL:PerformLayout(w, h)
    self:SetWide(256)
end

function PANEL:SetRoot(panel)
    self.Root = panel
end

vgui.Register("EquipmentItemInfo", PANEL, "DPanel")

local PANEL = {}

local function sort(a, b)
    if (a.SortPriority ~= b.SortPriority) then
        return a.SortPriority > b.SortPriority
    end
    return SafeTranslate(a.Item.name) < SafeTranslate(b.Item.name)
end

function PANEL:Init()
    self._GetChildren = self.GetChildren
    self.GetChildren = self.OverrideGetChildren
end

function PANEL:OverrideGetChildren()
    local children = self:_GetChildren()
    table.sort(children, sort)
    return children
end

vgui.Register("DSortableIconLayout", PANEL, "DIconLayout")


local radial_colors = GetRenderTargetEx(
    "radial_colors",
    8,
    8,
    RT_SIZE_NO_CHANGE,
    MATERIAL_RT_DEPTH_NONE,
    1 + 256,
    CREATERENDERTARGETFLAGS_UNFILTERABLE_OK,
    IMAGE_FORMAT_RGBA8888
)

local ttt_radial_colors_mat = CreateMaterial("radial_colors_mat2", "UnlitGeneric", {
    ["$translucent"] = 1
})

local function GetXY(pixnum)
    local row = math.floor(pixnum / radial_colors:Width())
    return pixnum % radial_colors:Width(), row
end

local function GetUV(pixnum)
    local x, y = GetXY(pixnum)
    return (x + 0.4) / radial_colors:Width(), (y + 0.4) / radial_colors:Height()
end

local function SetPixels(pixels)
    render.PushRenderTarget(radial_colors)
    cam.Start2D()
    render.OverrideBlend(true, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
    for pixnum, col in pairs(pixels) do
        surface.SetDrawColor(col)
        local x, y = GetXY(pixnum)
        surface.DrawRect(x, y, 1, 1)
    end
    render.OverrideBlend(false)
    cam.End2D()
    render.PopRenderTarget()
end

local PANEL = {}

function PANEL:MakeTriangles(triangles, p0, p1, mid, p2, u, v)
    table.insert(triangles, {
        pos = p0,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = p1,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = mid,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = p0,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = mid,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = p2,
        u = u,
        v = v
    })
end

function PANEL:Init()
    ttt_radial_colors_mat:SetTexture("$basetexture", radial_colors)
    local size = 400
    self:SetSize(size, size)
    self:Center()

    self:SetKeyboardInputEnabled(false)
    self.Circle = Mesh()

    local mid = size / 2

    local middle = Vector(mid, mid)
    local u, v = GetUV(0)
    local lineu, linev = GetUV(17)
    local triangles = {}
    local lastsmall, lastbig, lastcollide
    local firstsmall, firstbig, firstcollide
    local edges = 8
    local fulllength = size / 2
    local smaller = fulllength / 32 * 31

    local innerdist = fulllength / 4

    self.LongEdges = {}
    self.ShortEdges = {}

    for edge = 0, edges - 1 do
        local tmp  = math.rad((edge + 0.5) / edges * 360)
        local c, s = math.cos(tmp), math.sin(tmp)

        -- smaller part
        local nowsmall = Vector(mid + c * smaller, mid + s * smaller)
        local nowcollide = Vector(mid + c * innerdist, mid + s * innerdist)
        if (lastsmall) then
            -- surrounded
            self:MakeTriangles(triangles, nowcollide, lastcollide, lastsmall, nowsmall, GetUV(edge + 1))
            self.ShortEdges[edge] = {
                close = lastcollide,
                far = nowcollide
            }
            -- center
            table.insert(triangles, {
                pos = middle,
                u = u,
                v = v
            })
            table.insert(triangles, {
                pos = lastcollide,
                u = u,
                v = v
            })
            table.insert(triangles, {
                pos = nowcollide,
                u = u,
                v = v
            })
        end
        if (not firstsmall) then
            firstcollide = nowcollide
            firstsmall = nowsmall
        end


        local nowbig = Vector(mid + c * fulllength, mid + s * fulllength)
        if (lastbig) then
            -- outside
            self:MakeTriangles(triangles, lastsmall, lastbig, nowbig, nowsmall, GetUV(edges + edge + 1))
            self.LongEdges[edge] = {
                close = lastbig,
                far = nowbig
            }
        end
        if (not firstbig) then
            firstbig = nowbig
        end

        local hi = math.rad((edge + 0.5) / edges * 360 + 0.5)
        local lo = math.rad((edge + 0.5) / edges * 360 - 0.5)
        table.insert(triangles, {
            pos = nowcollide,
            u = lineu,
            v = linev
        })
        table.insert(triangles, {
            pos = Vector(mid + math.cos(lo) * smaller, mid + math.sin(lo) * smaller),
            u = lineu,
            v = linev
        })
        table.insert(triangles, {
            pos = Vector(mid + math.cos(hi) * smaller, mid + math.sin(hi) * smaller),
            u = lineu,
            v = linev
        })

        lastsmall = nowsmall
        lastcollide = nowcollide
        lastbig = nowbig

    end

    -- outside
    self:MakeTriangles(triangles, lastsmall, lastbig, firstbig, firstsmall, GetUV(edges + 1))
    self.LongEdges[0] = {
        close = lastbig,
        far = firstbig
    }
    -- surrounded
    self:MakeTriangles(triangles, firstcollide, lastcollide, lastsmall, firstsmall, GetUV(1))
    self.ShortEdges[0] = {
        close = lastcollide,
        far = firstcollide
    }
    -- center
    table.insert(triangles, {
        pos = middle,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = lastcollide,
        u = u,
        v = v
    })
    table.insert(triangles, {
        pos = firstcollide,
        u = u,
        v = v
    })

    self.SelectedColor = Color(200, 200, 200, 130)
    self.NotSelectedColor = Color(0, 0, 0, 130)
    self.SelectedOutline = Color(0, 100, 200, 200)
    self.NotSelectedOutline = Color(30, 30, 10, 255)
    local default_colors = {[0] = self.NotSelectedColors}
    for i = 1, 8 do
        default_colors[i] = self.NotSelectedColor
    end
    for i = 9, 16 do
        default_colors[i] = self.NotSelectedOutline
    end
    default_colors[17] = self.NotSelectedOutline
    SetPixels(default_colors)

    self.Circle:BuildFromTriangles(triangles)
end

function PANEL:SetRole(role)
    self.Role = role

    self.Items = GetRadialItems(role) or {}
    self.ItemIcons = {}
    local w, h = self:GetSize()

    local label = vgui.Create("DLabel", self)
    label:SetText "Open Menu"
    label:SetFont "TabLarge"
    label:SizeToContents()
    surface.SetFont "TabLarge"
    local tw, th = surface.GetTextSize(label:GetText())
    label:SetPos(w / 2 - tw / 2, h / 2 - th / 2 + 20)
    label:SetColor(color_white)

    local credits = vgui.Create("DLabel", self)
    credits:SetText(LocalPlayer():GetCredits() .. " credits")
    credits:SetFont "TabLarge"
    credits:SizeToContents()
    surface.SetFont "TabLarge"
    tw, th = surface.GetTextSize(credits:GetText())
    credits:SetPos(w / 2 - tw / 2, h / 2 - th / 2 - 20)
    credits:SetColor(LocalPlayer():GetCredits() > 0 and color_good or color_bad)

    local note = vgui.Create("DLabel", self)
    note:SetText "Add items by right clicking and selecting \"Add to Quick Menu\""
    note:SetFont "TabLarge"
    note:SizeToContents()
    note:SetPos(w / 2 - note:GetWide() / 2, 0)
    note:SetColor(color_white)

    for edge = 0, math.min(#self.Items, 8) - 1, 1 do
        local p = vgui.Create("DImage", self)
        p:SetImage(self.Items[edge + 1].material)

        local tmp  = math.rad(edge / 8 * 360)
        local c, s = math.cos(tmp), math.sin(tmp)
        p:SetSize(64, 64)
        p:SetPos(w / 2 + c * (w / 3) - p:GetWide() / 2, h / 2 + s * (w / 3) - p:GetTall() / 2)
        self.ItemIcons[edge] = p
    end
end

local function Intersect(A, B, C, D)
    local a1 = B.y - A.y
    local b1 = A.x - B.x
    local c1 = a1 * A.x + b1 * A.y

    local a2 = D.y - C.y
    local b2 = C.x - D.x
    local c2 = a2 * C.x + b2 * C.x

    local d = a1 * b2 - a2 * b1

    if (d ~= 0) then
        local x = (b2 * c1 - b1 * c2) / d
        local y = (a1 * c2 - a2 * c1) / d
        return Vector(x, y)
    end
end

function PANEL:InsideWhere()
    local w, h = self:GetSize()
    local edge = self:GetHoveredSide()
    local short = self.ShortEdges[edge]
    local long = self.LongEdges[edge]
    local mid = Vector(w / 2, h / 2)
    local cursor = Vector(self:ScreenToLocal(gui.MousePos()))

    local close = Intersect(short.close, short.far, mid, cursor)
    if (not close) then
        return 0
    end
    close = close:DistToSqr(mid)
    local far = Intersect(long.close, long.far, mid, cursor):DistToSqr(mid)
    local cur = cursor:DistToSqr(mid)
    if (cur < close) then
        return 0
    elseif (cur < far) then
        return 1, edge
    else
        return -1
    end
end


function PANEL:GetHoveredSide()
    local x, y = self:LocalToScreen(0, 0)
    x, y = x + self:GetWide() / 2, y + self:GetTall() / 2

    local mx, my = gui.MousePos()

    local d = math.deg(math.atan2(my - y, mx - x))

    return math.floor(((d + (360 / 16)) % 360) / (360 / 8))
end

function PANEL:Paint(w, h)
    local where, edge = self:InsideWhere()
    if (where == 1 and edge ~= self.LastHovered) then
        if (self.LastHovered) then
            SetPixels({
                [self.LastHovered + 1] = self.NotSelectedColor,
                [self.LastHovered + 9] = self.NotSelectedOutline
            })
        else
            SetPixels({
                [0] = self.SelectedColor,
            })
        end

        local canbuy = true
        if (self.Items[edge + 1]) then
            canbuy = CanBuy(self.Items[edge + 1]) and LocalPlayer():GetCredits() > 1
        end

        SetPixels({
            [edge + 1] = canbuy and self.SelectedColor or color_bad,
            [edge + 9] = self.SelectedOutline
        })
        self.LastHovered = edge
    elseif (edge ~= self.LastHovered) then
        SetPixels({
            [self.LastHovered + 1] = self.NotSelectedColor,
            [self.LastHovered + 9] = self.NotSelectedOutline
        })
        self.LastHovered = nil
    end

    if (self.LastPosition ~= where) then
        SetPixels({
            [0] = where == 0 and self.SelectedOutline or self.SelectedColor,
        })
    end

    self.LastPosition = where


    local mat = Matrix()
    mat:Translate(Vector(self:LocalToScreen(0, 0)))
    cam.PushModelMatrix(mat)
    render.SetMaterial(ttt_radial_colors_mat)
    self.Circle:Draw()
    cam.PopModelMatrix()

end

function PANEL:OnMousePressed(code)
    if (code == MOUSE_LEFT) then
        local where, edge = self:InsideWhere()
        if (where ~= 1) then
            return
        end
        self:Remove()
        if (not edge) then
            return
        end
        local item = self.Items[edge + 1]
        if (not item) then
            return
        end
        RunConsoleCommand("ttt_order_equipment", item.id)
    end
end

function PANEL:Finish()
    local where, edge = self:InsideWhere()
    self:Remove()
    if (where == 0) then
        local eqframe = vgui.Create("EquipmentMenu")

        eqframe:SetRole(LocalPlayer():GetRole())
        eqframe:MakePopup()
        eqframe:SetKeyboardInputEnabled(false)
        return eqframe
    elseif (where == 1 and not quickMenuClickBuy:GetBool()) then
        self:OnMousePressed(MOUSE_LEFT)
    end
end

vgui.Register("TTTRadialMenu", PANEL, "EditablePanel")