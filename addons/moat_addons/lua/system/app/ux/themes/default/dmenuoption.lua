local PANEL = {}
AccessorFunc(PANEL, "m_pMenu", "Menu")
AccessorFunc(PANEL, "m_bChecked", "Checked")
AccessorFunc(PANEL, "m_bCheckable", "IsCheckable")

function PANEL:Init()
    self:SetContentAlignment(4)
    self:SetTextInset(30, 0) -- Room for icon on left
    self:SetTextColor(Color(180, 180, 180))
    self:SetChecked(false)
    self:SetFont("moat_ItemDesc")
end

function PANEL:SetSubMenu(menu)
    self.SubMenu = menu

    if (not self.SubMenuArrow) then
        self.SubMenuArrow = vgui.Create("DPanel", self)

        self.SubMenuArrow.Paint = function(panel, w, h)
            derma.SkinHook("Paint", "MenuRightArrow", panel, w, h)
        end
    end
end

function PANEL:AddSubMenu()
    local SubMenu = DermaMenu(self)
    SubMenu:SetVisible(false)
    SubMenu:SetParent(self)
    self:SetSubMenu(SubMenu)

    return SubMenu
end

function PANEL:OnCursorEntered()
	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop1.wav"
	end

    self:SetTextColor(Color(255, 255, 255))

    if (IsValid(self.ParentMenu)) then
        self.ParentMenu:OpenSubMenu(self, self.SubMenu)

        return
    end

    local p = self:GetParent()

    if (IsValid(p) and p.OpenSubMenu) then
        p:OpenSubMenu(self, self.SubMenu)
    end
end

function PANEL:OnCursorExited()
    self:SetTextColor(Color(180, 180, 180))
end

function PANEL:Paint(w, h)
    derma.SkinHook("Paint", "MenuOption", self, w, h)
    --
    -- Draw the button text
    --

    return false
end

function PANEL:OnMousePressed(mousecode)
    self.m_MenuClicking = true
    DButton.OnMousePressed(self, mousecode)

	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop2.wav"
	end
end

function PANEL:OnMouseReleased(mousecode)
    DButton.OnMouseReleased(self, mousecode)

    if (self.m_MenuClicking and mousecode == MOUSE_LEFT) then
        self.m_MenuClicking = false
        CloseDermaMenus()
    end
end

function PANEL:DoRightClick()
    if (self:GetIsCheckable()) then
        self:ToggleCheck()
    end

	if (cdn and cdn.PlayURL and GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/appear-online.ogg"
	end
end

function PANEL:DoClickInternal()
    if (self:GetIsCheckable()) then
        self:ToggleCheck()
    end

    if (self.m_pMenu) then
        self.m_pMenu:OptionSelectedInternal(self)
    end
end

function PANEL:ToggleCheck()
    self:SetChecked(not self:GetChecked())
    self:OnChecked(self:GetChecked())
end

function PANEL:OnChecked(b)
end

function PANEL:PerformLayout()
    self:SizeToContents()
    self:SetWide(self:GetWide() + 32)
    local w = math.max(self:GetParent():GetWide(), self:GetWide())
    self:SetSize(w, 30)

    if (self.SubMenuArrow) then
        self.SubMenuArrow:SetSize(15, 15)
        self.SubMenuArrow:CenterVertical()
        self.SubMenuArrow:AlignRight(4)
    end

    DButton.PerformLayout(self)
end

function PANEL:GenerateExample()
    -- Do nothing!
end

hook("InitPostEntity", function()
	derma.DefineControl("DMenuOption", "Menu Option Line", PANEL, "DButton")
end)