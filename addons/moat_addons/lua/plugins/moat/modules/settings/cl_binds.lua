local FILENAME = "moat_gg_binds.txt"
local TTT_RADIO = {}
local GUI = {}
local client, GetTranslation
local OpenTab = false
TTT_RADIO.Category = {"General", "Gameplay", "Radio Chats", "Traitor Commands"}

TTT_RADIO.Commands = {
    ["General"] = {
        {
            id = 10,
            label = "Access Quickchat Keys",
            tip = "Shortcut to a list of radio chats."
        },
        {
            id = 12,
            label = "Open Damage Logs",
            tip = "Open Damage Logs"
        },
        {
            id = 13,
            label = "Access MGA Menu",
            tip = "This is the menu for available commands."
        }
    },
	["Gameplay"] = {
        {
            id = 14,
            label = "Weapon Inspect",
            tip = "View the stats of the weapon you're holding."
        },
    },
    ["Radio Chats"] = {
        {
            id = 1,
            label = "quick_yes"
        },
        {
            id = 2,
            label = "quick_no"
        },
        {
            id = 3,
            label = "quick_help"
        },
        {
            id = 4,
            label = "quick_imwith"
        },
        {
            id = 5,
            label = "quick_see"
        },
        {
            id = 6,
            label = "quick_suspect"
        },
        {
            id = 7,
            label = "quick_traitor"
        },
        {
            id = 8,
            label = "quick_inno"
        },
		{
            id = 10,
            label = "quick_jester"
        },
        {
            id = 9,
            label = "quick_check"
        }
    },
    ["Traitor Commands"] = {
        {
            id = 11,
            label = "Toggle Disguiser",
            tip = "Disguiser must be equipped."
        }
    }
}

TTT_RADIO.Storage = {
    ["Data"] = {
        {
            id = 1,
            type = "ttt_radio",
            cmd = "yes",
            key = KEY_NONE
        },
        {
            id = 2,
            type = "ttt_radio",
            cmd = "no",
            key = KEY_NONE
        },
        {
            id = 3,
            type = "ttt_radio",
            cmd = "help",
            key = KEY_NONE
        },
        {
            id = 4,
            type = "ttt_radio",
            cmd = "imwith",
            key = KEY_NONE
        },
        {
            id = 5,
            type = "ttt_radio",
            cmd = "see",
            key = KEY_NONE
        },
        {
            id = 6,
            type = "ttt_radio",
            cmd = "suspect",
            key = KEY_NONE
        },
        {
            id = 7,
            type = "ttt_radio",
            cmd = "traitor",
            key = KEY_NONE
        },
        {
            id = 8,
            type = "ttt_radio",
            cmd = "innocent",
            key = KEY_NONE
        },
        {
            id = 15,
            type = "ttt_radio",
            cmd = "jester",
            key = KEY_NONE
        },
        {
            id = 9,
            type = "ttt_radio",
            cmd = "check",
            key = KEY_NONE
        },
        {
            id = 10,
            type = "ttt_radio",
            cmd = "quickchat",
            key = KEY_NONE
        },
        {
            id = 11,
            type = "ttt_toggle_disguise",
            cmd = "",
            key = KEY_NONE
        },
        {
            id = 12,
            type = "damagelog",
            cmd = "",
            key = KEY_NONE
        },
        {
            id = 13,
            type = "mga_menu",
            cmd = "",
            key = KEY_NONE
        },
        {
            id = 14,
            type = "inspect",
            cmd = "",
            key = KEY_NONE
        }
    }
}

hook.Add("TTTSettingsTabs", "moat.bindinterface.settings", function(dtabs)
    GUI:Draw(dtabs)

    if (OpenTab) then
        dtabs:SwitchToName("Custom Binds")
        OpenTab = false
    end
end)

function GUI:Draw(dtabs)
    GetTranslation = LANG.GetTranslation
    client = LocalPlayer()
    local padding = dtabs:GetPadding()
    padding = padding * 2
    local dsettings = vgui.Create("DPanelList")
    dsettings:StretchToParent(0, 0, padding, 0)
    dsettings:EnableVerticalScrollbar(true)
    dsettings:SetPadding(10)
    dsettings:SetSpacing(10)

    for _, cat in pairs(TTT_RADIO.Category) do
        local dgui = vgui.Create("DCollapsibleCategory")
        dgui:SetLabel(cat)
        self.DPanelList = vgui.Create("DPanelList")
        self.DPanelList:SetAutoSize(true)
        self.DPanelList:SetSpacing(3)
        self.DPanelList:SetPadding(10)
        dgui:SetContents(self.DPanelList)

        for k, v in pairs(TTT_RADIO.Commands[cat]) do
            if cat ~= "Miscellaneous" then
                self:Row(v.id, v.label, v.tip)
            else
                self:AddCheckbox(v.label, v.convar, v.default_state)
            end
        end

        dsettings:AddItem(dgui)
    end

    dtabs:AddSheet("Custom Binds", dsettings, "icon16/brick.png", false, false, "Set keys to quick access game commands")
end

function GUI:Row(id, label, tip)
    local Panel = vgui.Create("DSizeToContents")
    Panel:SetTall(28)
    local DButton = vgui.Create("DButton", Panel)
    DButton:SetCursor("arrow")
    DButton:SetText("")
    DButton:Dock(LEFT)
    DButton:SetSize(375)

    if (tip) then
        DButton:SetTooltip(tip)
        DButton:SetCursor("hand")
        local Info = vgui.Create("DImage", DButton)
        Info:SetImage("icon16/information.png")
        Info:SizeToContents()
        Info:DockMargin(0, 6, 10, 6)
        Info:Dock(RIGHT)
    end

    if (string.match(label, "quick_") ~= nil) then
        label = GetTranslation(label)
    end

    label = string.gsub(label, "{player}", client:Nick())
    label = string.Capitalize(label)

    function DButton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w + 55, h, Color(54, 57, 62, 255))
        surface.SetDrawColor(32, 34, 37)
        surface.DrawOutlinedRect(0, 0, w + 1, h)
        draw.SimpleText(label, "DermaDefault", 10, h / 2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local keybind = TTT_RADIO:Keybind("GET", id) or KEY_NONE
    local DBinder = vgui.Create("DBinder", Panel)
    DBinder:SetZPos(2)
    function DBinder:UpdateText()
		local str = input.GetKeyName(self:GetSelectedNumber())
		if ( !str ) then str = "NONE" end

		str = language.GetPhrase( str )
		self:SetText(str:upper())
	end
    DBinder:SetValue(keybind)
    DBinder:Dock(FILL)

    function DBinder:OnChange(num)
        TTT_RADIO:Keybind("SETWRITE", id, num)
    end

    local Delete = vgui.Create("DButton", Panel)
    Delete:SetText("")
    Delete:SetSize(40, 26)
    Delete:DockMargin(-1, 0, 0, 0)
    Delete:Dock(RIGHT)

    function Delete:DoClick()
        DBinder:SetValue(KEY_NONE)
        DBinder:SetSelected(KEY_NONE)
    end

    local Cross = vgui.Create("DImage", Delete)
    Cross:SetImage("icon16/cross.png")
    Cross:SizeToContents()
    Cross:Center()

    function Delete:Think()
        if DBinder:GetSelectedNumber() == 0 then
            self:SetEnabled(false)
            Cross:SetImageColor(Color(0, 0, 0, 100))

            if not DBinder.Trapping then
                DBinder:SetText("Set Key")
            end
        else
            self:SetEnabled(true)
            Cross:SetImageColor(Color(255, 255, 255, 255))
        end
    end

    self.DPanelList:AddItem(Panel)
end

function GUI:AddCheckbox(label, convar)
    local Checkbox = vgui.Create("DCheckBoxLabel")
    Checkbox:SetDark(true)
    Checkbox:SetText(label)
    Checkbox:SetConVar(convar)
    self.DPanelList:AddItem(Checkbox)
end

function TTT_RADIO:Keybind(type, id, key)
    for _, v in ipairs(TTT_RADIO.Storage["Data"]) do
        if (v.id == id) then
            if (type == "GET") then
                return tonumber(v.key)
            elseif (type == "SETWRITE") then
                v.key = key
                TTT_RADIO:Write()
            elseif (type == "SET") then
                v.key = key
                v.p = false
            end
        end
    end
end

function TTT_RADIO:Write()
    local JSON = util.TableToJSON(self.Storage)
    file.Write(FILENAME, JSON)
end

function TTT_RADIO:Read()
    if (not file.Exists(FILENAME, "DATA") or file.Size(FILENAME, "DATA") == 0) then
        self:Write()
    else
        local raw = file.Read(FILENAME, "DATA")
        raw = util.JSONToTable(raw)

        for _, v in pairs(raw["Data"]) do
            self:Keybind("SET", v.id, v.key)
        end
    end
end

hook.Add("PlayerButtonDown", "moat.bindinterface.listener", function(pl, k)
    if not (IsFirstTimePredicted()) then return end
    if not (gui.MouseX() == 0 and gui.MouseY() == 0) then return end
    local binds = TTT_RADIO.Storage["Data"]

    for i = 1, #binds do
        if (binds[i].key and binds[i].key == k) then
            if (binds[i].cmd == "quickchat") then
                RADIO:ShowRadioCommands(not RADIO.Show)
            else
                RunConsoleCommand(binds[i].type, binds[i].cmd)
            end
        end
    end
end)

TTT_RADIO:Read()