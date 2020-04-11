local cookie_name = "ttc-lastplayed"

local lastplayed = cookie.GetNumber(cookie_name, 0)

local changelogs = {
    [1] = {
        "First time playing? Hit F1 to explore the different roles."
    },
    [20180330] = {
        "Hitman target is now purple on radar"
    },
    [20180331] = {
        "Radar is more transparent while you are looking at it",
        "Hitman now can use credits to kill a non-target without losing health",
        "Hitman's target glows",
        "Detective Scanner recharges 2x as fast",

    },
    [20180403] = {
        "Introduced Changelog",
        "Spectating is a better feature",
        "Added F1 Tutorial",
        "Added Witch Doctor role"
    },
    [20180429] = {
        "Phoenix no longer respawns when suiciding",
        "Fixed Phoenix screen displaying Xenomorph",
        "Phoenix will not longer respawn after a slay",
        "When a Jester KOSes another player, they are considered an innocent by the rules",
        "When a Jester destroys a piece of equipment they are not going to be considered breaking the rules.",
        "Doctor cannot revive people who have suicided",
        "Doctor cannot revive people he has killed",
        "Doctors cannot revive non-innocents",
        "Someone purposefully killing themselves so the doctor can prove them is considered metagaming.",
        "FEEDBACK WELCOME ON THE FORUMS"
    },
	[20200411] = {
		"Added karma weight to the Serial Killer"
	}

}

local PANEL = {}

function PANEL:Init()
    self:MakePopup()
    self:SetTitle "TTC Changelog"
    self:SetSize(ScrW() / 2, ScrH()  / 2)
    self.close = vgui.Create("DButton", self)
    self.close:Dock(BOTTOM)
    self.close:SetTall(50)
    self.close:SetText "I've read this!"
    function self.close:DoClick()
        self:GetParent():Remove()
        cookie.Set(cookie_name, gmod.GetGamemode().TTC_Version)
    end
    self.Inner = vgui.Create("TTC_Changelog_Inner", self)
    self:Center()
    self:ShowCloseButton(false)
    self.Inner:SetTall(self:GetTall() - 31 - self.close:GetTall())
end

derma.DefineControl("TTC_Changelog", "", PANEL, "DFrame")


local PANEL = {}

function PANEL:Init()
    self:Dock(BOTTOM)

    local changes = {}
    for i, v in pairs(changelogs) do
        table.insert(changes, {i, v})
    end
    table.sort(changes, function(a, b) return a[1] < b[1] end)

    for _, change in ipairs(changes) do
        if (change[1] > lastplayed) then
            self:InsertColorChange(220, 220, 220, 255)
            self:AppendText "Update "
            self:InsertColorChange(255, 25, 25, 255)
            self:AppendText(tostring(change[1]).."\n")

            for _, log in ipairs(change[2]) do
                self:InsertColorChange(200, 25, 25, 255)
                self:AppendText "    - "
                self:InsertColorChange(220, 220, 220, 255)
                self:AppendText(log.."\n")
            end
        end
    end
end

function PANEL:PerformLayout()
    self:SetFontInternal "DermaDefaultBold"
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(50,50,50,255)
    surface.DrawRect(0, 0, w, h)
end

derma.DefineControl("TTC_Changelog_Inner", "", PANEL, "RichText")


for i, v in pairs(changelogs) do
    if (i > lastplayed) then
        vgui.Create("TTC_Changelog")
        break
    end
end