local function GetTimeData(time)
    local data = os.date("!*t", time)

    data.s_wday = os.date("%a", time)
    data.s_month = os.date("%b", time)

    return data
end

local function GetTimeFormatted(time)
    local data = GetTimeData(time)
    -- Wed, 19 Jun 2019 07:45:24
    return string.format("%s, %d %s %d %02d:%02d:%02d", data.s_wday, data.day, data.s_month, data.year, data.hour, data.min, data.sec)
end


local TIME = {
    Base = "DPanel"
}

function TIME:OnChange()
    if (self.NoMove) then
        return
    end

    local hour, min, sec = self.TimeOfDay:GetValue():match "(%d+):(%d+):(%d+)"
    
    if (not hour) then
        self:Wrong "TimeOfDay"
        return
    end

    hour = tonumber(hour) or math.huge
    min = tonumber(min) or math.huge
    sec = tonumber(sec) or math.huge

    if (hour > 23 or min > 59 or sec > 59) then
        self:Wrong "TimeOfDay"
        return
    end

    local day = self.Day:GetValue()
    if ("" == day or not tonumber(day)) then
        self:Wrong "Day"
        return
    end
    local year = self.Year:GetValue()
    if ("" == year or not tonumber(year)) then
        self:Wrong "Year"
        return
    end

    local time = os.time {
        month = self.Month:GetSelectedID(),
        day = day,
        year = year,
        hour = hour,
        min = min,
        sec = sec
    }

    if (not time) then
        self:Wrong "Out of range"
        return
    end

    self:OnTimeChanged(time)
end

function TIME:Wrong(reason)
    print(reason)
end

function TIME:Init()
    local function OnChange()
        self:OnChange()
    end

    self.Label = self:Add "DLabel"
    self.Label:Dock(LEFT)
    self.Label:SetZPos(1)

    self.Day = self:Add "DTextEntry"
    self.Day:SetNumeric(true)
    self.Day:Dock(RIGHT)
    self.Day:SetZPos(0)
    self.Day:DockMargin(0, 0, 4, 0)
    self.Day:SetPlaceholderText "Day"
    self.Day:SetValue "1"
    self.Day.OnChange = OnChange

    self.Month = self:Add "DComboBox"
    self.Month:Dock(RIGHT)
    self.Month:SetZPos(-1)
    self.Month:DockMargin(0, 0, 4, 0)
    self.Month:SetSortItems(false)
    self.Months = {}
    for i = 1, 12 do
        local month = os.date("%B", os.time {
            day = 1,
            hour = 1,
            isdst = false, 
            min = 1,
            month = i,
            sec = 1,
            year = 2019
        })
        self.Month:AddChoice(month)
        self.Months[month] = i
    end
    self.Month:ChooseOptionID(1)
    self.Month.OnSelect = OnChange

    self.Year = self:Add "DTextEntry"
    self.Year:Dock(RIGHT)
    self.Year:SetZPos(-2)
    self.Year:DockMargin(0, 0, 14, 0)
    self.Year:SetPlaceholderText "Year"
    self.Year:SetValue "2019"
    self.Year:SetNumeric(true)
    self.Year.OnChange = OnChange

    self.TimeOfDay = self:Add "DTextEntry"
    self.TimeOfDay:Dock(RIGHT)
    self.TimeOfDay:SetZPos(-3)
    self.TimeOfDay:SetValue "00:01:02"
    self.TimeOfDay:SetPlaceholderText "Time"
    self.TimeOfDay.OnChange = OnChange

    self:InvalidateLayout()
end

function TIME:SetTime(time)
    local data = GetTimeData(time)

    self.NoMove = true

    self.Day:SetText(data.day)
    self.Year:SetText(data.year)
    self.Month:ChooseOptionID(data.month)
    self.TimeOfDay:SetValue(string.format("%02i:%02i:%02i", data.hour, data.min, data.sec))

    self.NoMove = false

    self.Time = time
end

function TIME:SetText(text)
    self.Label:SetText(text)
    self.Label:SizeToContents()
end

function TIME:PerformLayout(w, h)
    surface.SetFont(self.Month:GetFont())
    self:SetTall(select(2, surface.GetTextSize "A") + 4)

    local w = 0
    for month, i in pairs(self.Months) do
        w = math.max(w, (surface.GetTextSize(month)))
        w = math.max(w, (surface.GetTextSize(month:upper())))
    end
    self.Month:SetWide(w + 24)

    w = surface.GetTextSize(self.Day:GetPlaceholderText())

    for i = 1, 31 do
        w = math.max(w, (surface.GetTextSize(i)))
    end

    self.Day:SetWide(w + 8)

    w = surface.GetTextSize(self.Year:GetPlaceholderText())
    
    for i = 1970, 2028 do
        w = math.max(w, (surface.GetTextSize(i)))
    end

    self.Year:SetWide(w + 8)

    w = surface.GetTextSize "44:44:44"
    self.TimeOfDay:SetWide(w + 8)
end

function TIME:OnTimeChanged(time)
end


local INTERNAL = {
    Base = "DPanel"
}
function INTERNAL:Init()
    hook.Add("StaffDataReceived", self, self.StaffDataReceived)

    self.EarliestTime = 1559678567
    self.FinalTime = os.time()


    self.SteamIDEntry = self:Add "DTextEntry"
    self.SteamIDEntry:SetPlaceholderText "STEAM_0:0:1"
    self.SteamIDEntry:DockMargin(20, 20, 20, 0)
    self.SteamIDEntry:Dock(TOP)
    self.SteamIDEntry:SetZPos(1)

    self.Slider = self:Add "DMultiSlider"

    self.Slider:DockMargin(20, 10, 20, 0)
    self.Slider:Dock(TOP)
    self.Slider:SetZPos(2)
    self.Slider:SetTall(10)

    self.FromTime = self:Add(TIME)
    self.FromTime:Dock(TOP)
    self.FromTime:SetZPos(3)
    self.FromTime:DockMargin(20, 10, 20, 0)
    self.FromTime:SetText "From:    "
    function self.FromTime:OnTimeChanged(time)
        local parent = self:GetParent()
        local pct = math.Clamp((time - parent.EarliestTime) / (parent.FinalTime - parent.EarliestTime), 0, 1)
        parent.Slider.Knobs[1]:SetSlideX(pct)
        parent.Slider:InvalidateLayout()
    end

    self.ToTime = self:Add(TIME)
    self.ToTime:Dock(TOP)
    self.ToTime:SetZPos(4)
    self.ToTime:DockMargin(20, 10, 20, 0)
    self.ToTime:SetText "To:    "

    function self.ToTime:OnTimeChanged(time)
        local parent = self:GetParent()
        local pct = math.Clamp((time - parent.EarliestTime) / (parent.FinalTime - parent.EarliestTime), 0, 1)
        parent.Slider.Knobs[2]:SetSlideX(pct)
        parent.Slider:InvalidateLayout()
    end


    self.FromTime:SetTime(self.EarliestTime)
    self.ToTime:SetTime(self.FinalTime)

    function self.Slider:NotifyChange(knob, x, y)
        local parent = self:GetParent()

        local is_from = knob == self.Knobs[1]

        local time = math.Round(Lerp(x, parent.EarliestTime, parent.FinalTime))

        if (is_from) then
            parent.FromTime:SetTime(time)
        else
            parent.ToTime:SetTime(time)
        end
    end

    self.Submit = self:Add "DButton"

    self.Submit:SetText "Submit"
    self.Submit:Dock(TOP)
    self.Submit:SetZPos(5)
    self.Submit:DockMargin(20, 10, 20, 0)

    function self.Submit:DoClick()
        self:GetParent():DoSubmit()
    end

    self.TimePlayed = self:Add "DLabel"
    self.TimePlayed:Dock(TOP)
    self.TimePlayed:SetZPos(7)
    self.TimePlayed:SetText ""
    self.TimePlayed:DockMargin(20, 40, 20, 0)

    self.Rounds = self:Add "DLabel"
    self.Rounds:Dock(TOP)
    self.Rounds:SetZPos(8)
    self.Rounds:SetText ""
    self.Rounds:DockMargin(20, 10, 20, 0)

    self.ReportsHandled = self:Add "DLabel"
    self.ReportsHandled:Dock(TOP)
    self.ReportsHandled:SetZPos(9)
    self.ReportsHandled:SetText ""
    self.ReportsHandled:DockMargin(20, 10, 20, 0)
end

local function NiceDuration(seconds)
    local durations = {
        {
            Count = 60,
            Name = "Seconds"
        },
        {
            Count = 60,
            Name = "Minutes"
        },
        {
            Count = 24,
            Name = "Hours"
        },
        {
            Count = math.huge,
            Name = "Days"
        }
    }

    local str = ""

    local left = seconds

    for _, data in ipairs(durations) do
        str = (left % data.Count) .. " " .. data.Name .. " " .. str
        left = math.floor(left / data.Count)
        if (left <= 0) then
            break
        end
    end

    return str
end

function INTERNAL:StaffDataReceived(d)
    PrintTable(d)
    self.SteamIDEntry:SetValue(d.steamid)
    self:SetToTime(d.to)
    self:SetFromTime(d.from)


    self.ReportsHandled:SetText("Reports handled: " .. d.handled)
    self.Rounds:SetText("Rounds Played / Spectator: " .. d.rounds_played .. " / " .. d.rounds_on - d.rounds_played)
    self.TimePlayed:SetText("Time played: " .. string.NiceTime(tonumber(d.time_played))) -- TODO(meep): nice time
end

function INTERNAL:DoSubmit()
    net.Start "ST_UI"
        net.WriteString(self.SteamIDEntry:GetValue())
        net.WriteUInt(self.FromTime.Time, 32)
        net.WriteUInt(self.ToTime.Time, 32)
    net.SendToServer()
end

function INTERNAL:GetFromTime()
    return self.FromTime.Time
end

function INTERNAL:GetToTime()
    return self.ToTime.Time
end

function INTERNAL:SetFromTime(time)
    if (self:GetToTime() and time > self:GetToTime()) then
        print "Error"
        return
    end

    local pct = (time - self.EarliestTime) / (self.FinalTime - self.EarliestTime)
    self.Slider.Knobs[1]:SetSlideX(pct)
    self.FromTime:SetTime(time)
end

function INTERNAL:SetToTime(time)
    if (self:GetFromTime() and time < self:GetFromTime()) then
        print "Error"
        return
    end

    local pct = (time - self.EarliestTime) / (self.FinalTime - self.EarliestTime)
    self.Slider.Knobs[2]:SetSlideX(pct)
    self.ToTime:SetTime(time)
end

function INTERNAL:PerformLayout(w, h)
    surface.SetFont(self.SteamIDEntry:GetFont())
    self.SteamIDEntry:SetTall(select(2, surface.GetTextSize "A") + 4)

    self.FromTime:SizeToContents()
end

local PANEL = {}
function PANEL:Init()
    self:SetTitle "ST UI"
    self:SetSize(400, 400)

    self.Internal = self:Add(INTERNAL)

    self.Internal:SetSize(390, 365)
    self.Internal:SetPos(5, 30)

    self:Center()
    self:MakePopup()
end


vgui.Register("STMainPanel", PANEL, "DFrame")

concommand.Add("moat_test_st_ui", function()
    if (IsValid(ST_UI)) then
        ST_UI:Remove()
    end

    ST_UI = vgui.Create "STMainPanel"
end)

net.Receive("ST_UI", function()
    if (net.ReadBool()) then
        hook.Run("StaffDataReceived", net.ReadTable())
    else
        print(net.ReadString())
    end
end)