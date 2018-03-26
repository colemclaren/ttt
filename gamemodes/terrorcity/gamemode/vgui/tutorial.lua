local PANEL = {}

local role_string

function PANEL:Init()
    role_string = {}
    for roleid, rolestr in pairs(role_strings) do
        table.insert(role_string, {
            id = roleid,
            str = rolestr,
            name = LANG.GetRawTranslation(rolestr)
        })
    end
    table.sort(role_string, function(a,b) return a.name < b.name end)
    self:Redirect "home"
end

function PANEL:PerformLayout(w, h)
    self:StretchToParent(0, 0, 0, 0)
end

function PANEL:Redirect(str)
    print("redirect received: ", str)
    for _, v in pairs(self:GetChildren()) do
        v:Remove()
    end
    if (str == "home") then

        local firstpage = vgui.Create("TutorialPage", self)
        firstpage:Dock(FILL)
        firstpage:DockMargin(0, 0, 0, 0)
        for _, role in ipairs(role_string) do
            local pnl = vgui.Create("TutorialRedirector", firstpage)
            pnl:Dock(TOP)
            pnl:SetRedirect(role.id)
            pnl:SetStuff(role.name)
        end
    elseif (type(str) == "number") then
        local pnl = vgui.Create("TutorialRolePage", self)
        pnl:Dock(FILL)
        pnl:DockMargin(0, 0, 0, 0)
        pnl:SetRoleID(str)
        -- assume id
    end

    self:InvalidateLayout(true)
end

derma.DefineControl("Tutorial", "", PANEL, "EditablePanel")

local PANEL = {}

PANEL.NoHover = Color(255,255,255,200)
PANEL.Hover = Color(200,200,200,200)

function PANEL:Init()
    self.BaseClass.Init(self)
    self:SetMouseInputEnabled(true)
    self:SetText ""
    self:SetCursor "hand"
end

function PANEL:PerformLayout(w, h)
    self.BaseClass.PerformLayout(self, w, h)
    self:DockMargin(w / 16, 0, w / 16, 0)
end

function PANEL:SetRedirect(redirect)
    self.redirect = redirect
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(ColorAlpha(GetRoleColor(self.redirect), 120))
    surface.DrawRect(0, 0, w, h)

    surface.SetFont(self:GetFont())
    local tw, th = surface.GetTextSize(self.text)
    surface.SetTextColor(self:IsHovered() and self.Hover or self.NoHover)
    surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
    surface.DrawText(self.text)
end

function PANEL:SetStuff(t)
    self.text = t
end

function PANEL:DoClick()
    self:GetParent():Redirect(self.redirect)
end

derma.DefineControl("TutorialRedirector", "", PANEL, "DLabel")

local PANEL = {}
function PANEL:Redirect(str)
    self:GetParent():Redirect(str)
end

derma.DefineControl("TutorialPage", "", PANEL, "EditablePanel")

local PANEL = {}

surface.CreateFont("ttc_tutorial_id", {
    size = 40,
    font = "Arial"
})
surface.CreateFont("ttc_tutorial_lbl", {
    size = 15,
    font = "Arial",
    weight = 1000
})

function PANEL:Init()
    self.Home = vgui.Create("DButton", self)
    self.Home:SetText "<-"
    function self.Home.DoClick()
        self:Redirect "home"
    end

    self.RoleIdentifier = vgui.Create("TutorialRoleIdentifier", self)
    self.RoleIdentifier:Dock(TOP)

    self.Label = vgui.Create("DLabel", self)
    self.Label:Dock(TOP)
    self.Label:SetWrap(true)
    self.Label:DockMargin(10, 22, 10, 0)
    self.Label:SetAutoStretchVertical(true)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:SetRoleID(id)
    self.id = id
    self.Label:SetText(LANG.GetRawTranslation("tutorial_text_"..role_strings[self.id]) or "lang translation not found")
    self.Label:SetFont "ttc_tutorial_lbl"
    self.Label:SizeToContents()
end

function PANEL:PerformLayout(w, h)
    self.Home:SetPos(w - self.Home:GetWide(), h - self.Home:GetTall())
end

derma.DefineControl("TutorialRolePage", "", PANEL, "TutorialPage")

local PANEL = {}

function PANEL:PerformLayout()
    surface.SetFont "ttc_tutorial_id"
    local id = self:GetParent().id
    local name = LANG.GetRawTranslation(role_strings[id])
    self:SetSize(self:GetParent():GetWide(), select(2, surface.GetTextSize(name)))
end

function PANEL:Paint(w, h)
    local id = self:GetParent().id
    local col = GetRoleColor(id)
    local name = LANG.GetRawTranslation(role_strings[id])

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(ColorAlpha(col, 120))
    surface.DrawRect(0, 0, w, h)

    surface.SetFont "ttc_tutorial_id"
    surface.SetTextColor(color_white)
    surface.SetTextPos(self:GetWide() / 2 - surface.GetTextSize(name) / 2,0)
    surface.DrawText(name)
end

derma.DefineControl("TutorialRoleIdentifier", "", PANEL, "TutorialPage")