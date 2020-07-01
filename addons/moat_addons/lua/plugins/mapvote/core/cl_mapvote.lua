surface.CreateFont("RAM_VoteFont", {
    font = "Trebuchet MS",
    size = 19,
    weight = 700,
    antialias = true,
    shadow = true
})

surface.CreateFont("RAM_VoteFontCountdown", {
    font = "Tahoma",
    size = 32,
    weight = 700,
    antialias = true,
    shadow = true
})

surface.CreateFont("RAM_VoteSysButton", 
{    font = "Marlett",
    size = 13,
    weight = 0,
    symbol = true,
})
if IsValid(MapVote.Panel) then MapVote.Panel:Remove() end
MapVote.EndTime = 0
MapVote.Panel = false

/*
MOAT_INV_BG_W = 400 + 350
MOAT_INV_BG_H = 550
*/

MapVote.Feedback = MapVote.Feedback or {}
net.Receive("RAM_MapVoteStart", function()
    MapVote.CurrentMaps = {}
    MapVote.Allow = true
    MapVote.Votes = {}
    
    local amt = net.ReadUInt(5)
    
    for i = 1, amt do
        local map = net.ReadString()
        local pos = net.ReadUInt(12)
		local neg = net.ReadUInt(12)

        MapVote.CurrentMaps[#MapVote.CurrentMaps + 1] = map
		MapVote.Feedback[map] = {
			Positive = pos,
			Negative = neg,
			Count = pos + neg,
		}
    end
    
    MapVote.EndTime = CurTime() + net.ReadUInt(8)

    if(IsValid(MapVote.Panel)) then
        MapVote.Panel:Remove()
    end
    
    MapVote.Show()

    if (m_isUsingInv()) then
        RunConsoleCommand("inventory")
    end
end)

local map_vote = {
    ["!mapvote"] = true,
    ["/mapvote"] = true,
    ["!mv"] = true,
    ["/mv"] = true
}

hook.Add("PrePlayerChat", "Moat.Mapvote.Reopen", function(pl, txt)
    if (IsValid(pl) and pl == LocalPlayer() and map_vote[txt]) then
        if (IsValid(MapVote.Panel)) then
            MapVote.Show()
        end

        return true
    end
end)

local group_images = {
	["vip"] = "icon16/star.png",
	["partner"] = "icon16/star.png",
   	["bugboomer"] = "icon16/bomb.png",
   	["trialstaff"] = "icon16/shield.png",
   	["moderator"] = "icon16/shield_add.png",
   	["admin"] = "icon16/lightning.png",
   	["senioradmin"] = "icon16/lightning_add.png",
   	["headadmin"] = "icon16/world.png",
   	["communitylead"] = "icon16/application_xp_terminal.png",
	["owner"] = "icon16/application_xp_terminal.png",
	["techartist"] = "icon16/application_xp_terminal.png",
	["audioengineer"] = "icon16/application_xp_terminal.png",
	["softwareengineer"] = "icon16/application_osx_terminal.png",
	["gamedesigner"] = "icon16/application_xp_terminal.png",
	["creativedirector"] = "icon16/application_xp_terminal.png",
}

local function vote_user(ply)
	local info = (not ply:GetNW2Bool("adminmode", false)) and MOAT_RANKS[ply:GetUserGroup()] or {"User", Color(255, 255, 255)}

    return Material((not ply:GetNW2Bool("adminmode", false)) and group_images[ply:GetUserGroup()] or "icon16/group.png"), info[2], ply:GetUserGroup() ~= "user" and 2 or 1, ply:GetUserGroup() ~= "user" and Color(0, 255, 255) or Color(255, 255, 0) 	
end

net.Receive("RAM_MapVoteUpdate", function()
    local update_type = net.ReadUInt(3)
    
    if(update_type == MapVote.UPDATE_VOTE) then
        local ply = net.ReadEntity()

        if(IsValid(ply)) then
            local map_id = net.ReadUInt(32)
            if MapVote.Votes[ply:SteamID()] then
                if MapVote.Votes[ply:SteamID()][1] == map_id then return end
            end
            local mat,name_color,am,am_color = vote_user(ply)
			chat.AddText(moat_blue, "| ", moat_cyan, ply:Nick(), moat_white," placed ", 
			am == 1 and moat_green or moat_pink, tostring(am), 
			moat_white, " vote" .. (am == 1 and "" or "s") .. " on ", 
			moat_green, MapVote.CurrentMaps[map_id], moat_white, ".")
			--chat.AddText(mat,name_color,ply:Nick(),Color(255,255,255)," placed ",am_color, tostring(am),Color(255,255,255), " vote" .. (am == 1 and "" or "s") .. " on ", Color(0,255,0), MapVote.CurrentMaps[map_id])

            MapVote.Votes[ply:SteamID()] = {map_id,am}
        end
    elseif(update_type == MapVote.UPDATE_WIN) then      
        if(IsValid(MapVote.Panel)) then
            MapVote.Panel:Flash(net.ReadUInt(32))
        end
    end
end)

net.Receive("RAM_MapVoteCancel", function()
    if IsValid(MapVote.Panel) then
        MapVote.Panel:Remove()
    end
end)

net.Receive("RTV_Delay", function()
    chat.AddText(Color( 102,255,51 ), "[RTV Overkill]", Color( 255,255,255 ), " The vote has been rocked, map vote will begin on round end")
end)

local gradient_d = Material("vgui/gradient-d")

local function tm(s,self)
    MOAT_THEME.Themes["Original"][s](self,self:GetWide(),self:GetTall())
end
surface.CreateFont("moat_Feedback",{
    size = 20,
    font = "Roboto",
    weight = 500,
})
surface.CreateFont("moat_mVotes",{
    size = 30,
    font = "GModNotify",
    weight = 800,
})
surface.CreateFont("moat_mFeed",{
    size = 22,
    font = "GModNotify",
    weight = 1000,
})

surface.CreateFont("moat_mTitle",{
    size = 22,
    font = "GModNotify",
    weight = 800,
})

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

function MapVote.Show()
    /*if IsValid(MapVote.Panel) then
        MapVote.Panel:Show()
        return
    end*/
    MapVote.Panel = vgui.Create("DFrame")
    MapVote.Panel:SetSize(750,550)
    MapVote.Panel:MakePopup()
    --MapVote.Panel:SetPos(ScrW()/2 - (750/2),ScrH()/2 - 300)
    MapVote.Panel:Center()
    MapVote.Panel:SetTitle("")
    MapVote.Panel:ShowCloseButton(false)
    --MapVote.Panel:ParentToHUD()
    function MapVote.Panel:Paint(w,h)
        /*surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)
        surface.SetDrawColor(Color(100, 100, 100, 50))
        surface.DrawLine(0, 25, self:GetWide(), 25)
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawLine(0, 26, self:GetWide(), 26)*/

        DrawBlur(self, 3)

        cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 245))

        surface.SetDrawColor(183, 183, 183)
        DisableClipping(true)
            surface.DrawLine(0, -4, w, -4)
            surface.DrawLine(0, h + 3, w, h + 3)
        DisableClipping(false)

        m_DrawShadowedText(1, "Where to next?", "moat_mTitle", 8, 4, Color(225, 225, 225, 255), TEXT_ALIGN_LEFT)
    end
    MapVote.Panel.Winner = -1
    function MapVote.Panel:Flash(i)
        MapVote.Panel.Winner = i
    end
    MapVote.Panel:DockPadding(5,30,5,5)

    local bottom_panel = vgui.Create("DPanel",MapVote.Panel)
    bottom_panel:SetSize(0,50)
    bottom_panel:DockMargin(0,5,0,0)
    bottom_panel:Dock(BOTTOM)
    --https://i.imgur.com/Goblq9b.png
    local hasvoted = false
    local like = vgui.Create("DButton",bottom_panel)
    like:SetSize(40,40)
    like:SetPos(270,5)
    like:SetText("")
    function like:Paint(w,h)
        cdn.DrawImage("https://static.moat.gg/f/E3Fa8uDCgNzzL6iAoITcNk4nUDye.png",0,0,w,h,Color(0,255,0,50))
    end
    function like:DoClick()
        hasvoted = true
        net.Start("MapVote.Feedback")
        net.WriteBool(true)
        net.SendToServer()
		sfx.Agree()
    end
	sfx.SoundEffects(like)

    --https://i.imgur.com/QFKkVtt.png
    local like = vgui.Create("DButton",bottom_panel)
    like:SetSize(40,40)
    like:SetPos(320,5)
    like:SetText("")
    function like:Paint(w,h)
        cdn.DrawImageRotated("https://static.moat.gg/f/unE9uyhsKtr835pF3Zigc71KozFU.png",0,0,w,h,Color(255,0,0,50),180,50)
    end
    function like:DoClick()
        hasvoted = true
        net.Start("MapVote.Feedback")
        net.WriteBool(false)
        net.SendToServer()
		sfx.Decline()
    end
	sfx.SoundEffects(like)

    function bottom_panel:Paint(w,h)
		local timeLeft = math.Round(math.Clamp(MapVote.EndTime - CurTime(), 0, math.huge))
        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.DrawLine(w/2,1,w/2,h-2)
        --(tostring(timeLeft or 0).." seconds")
        m_DrawShadowedText(1,"Time remaining: " .. tostring(timeLeft or 0), "moat_mVotes", (w/4 * 3), 8, Color(255,255,255, 255), TEXT_ALIGN_CENTER)
        m_DrawShadowedText(1,(hasvoted and "Thanks for your feedback!") or "Do you like this map?", "moat_mFeed", 10, h/2 - (11), (hasvoted and Color(255,255,255, 255)) or HSVToColor((SysTime()*100)%360,0.65,0.9), TEXT_ALIGN_LEFT)
    end

    local top_panel = vgui.Create("DPanel",MapVote.Panel)
    top_panel:SetSize(0,228)
    top_panel:DockMargin(0,0,0,5)
    top_panel:Dock(TOP)
    function top_panel:Paint() end
    -- upvotes / totalvotes
    local mid_panel = vgui.Create("DPanel",MapVote.Panel)
    mid_panel:Dock(FILL)
    function mid_panel:Paint() end

    for i = 1,8 do
        local map = MapVote.CurrentMaps[i]
        local top_panel = top_panel
        if i > 4 then top_panel = mid_panel end
        local a = vgui.Create("DButton",top_panel)
		sfx.SoundEffects(a)
        a:SetSize(182)
        if (i ~= 4) and (i ~= 8) then
            a:DockMargin(0,0,4,0)
        end
        a:Dock(LEFT)
        local url = "https://static.moat.gg/f/3ecf354904aa3d512f22f3b5d53d4079.png"
        a:SetText("")
        local ispic = false
        http.Fetch("https://image.gametracker.com/images/maps/160x120/garrysmod/" .. map .. ".jpg",function(_,_,_,c) 
            if not tostring(c):match("^2") then 
                url = "https://static.moat.gg/f/3ecf354904aa3d512f22f3b5d53d4079.png"
            else
                url = "https://image.gametracker.com/images/maps/160x120/garrysmod/" .. map .. ".jpg"
            end 
        end,function() url = "https://static.moat.gg/f/3ecf354904aa3d512f22f3b5d53d4079.png" end)
        function a:Paint(w,h)
            local votes = 0
            local mine = false
            for k,v in pairs(MapVote.Votes) do
                if v[1] == i then
                    if k == LocalPlayer():SteamID() then
                        mine = true
                    end
                    votes = votes + v[2]
                end
            end
            if MapVote.Panel.Winner == i then
                surface.SetDrawColor((HSVToColor((SysTime()*100)%360,0.65,0.9)))
            else
                surface.SetDrawColor(62, 62, 64, 255)
            end
            surface.DrawOutlinedRect(0, 0, w, h)
            surface.DrawLine(1,147,w-2,147)
            surface.DrawLine(1,187,w-2,187)

            if (url == "https://static.moat.gg/f/3ecf354904aa3d512f22f3b5d53d4079.png") then
                cdn.DrawImage(url,5,5,256,256)
            else
                cdn.DrawImage(url,5,5,w-10,120)
            end

            surface.SetDrawColor(62, 62, 64, 255)
            surface.DrawOutlinedRect(5, 5, w-10, 120)

            --(MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or

            m_DrawShadowedText(1, map, "moat_ItemDesc", w/2, 128, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_CENTER)
			if MapVote.Feedback[map] and MapVote.Feedback[map].Positive and MapVote.Feedback[map].Count then
                local x = (w-2) * (MapVote.Feedback[map].Positive/MapVote.Feedback[map].Count)
                draw.RoundedBox(0,1,148,x,39,Color(0,255,0,10))
				 local y = (w-2) - x + 1
                draw.RoundedBox(0,x+1,148,y,39,Color(255,0,0,10))
                m_DrawShadowedText(1,math.Round(((MapVote.Feedback[map].Positive/MapVote.Feedback[map].Count) * 100), 0) .. "%", "moat_Feedback", w/2, 165, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_CENTER)
			end
            /*if (MapVote.Feedback[map] and MapVote.Feedback[map].Positive and MapVote.Feedback[map].Negative) then
                local x = (w-2) * (MapVote.Feedback[map].Positive/MapVote.Feedback[map].Count)
                draw.RoundedBox(0,1,148 + 29,x,10,Color(0,255,0,10))
                local y = (w-2) - x + 1
                draw.RoundedBox(0,x+1,148 + 29,y,10,Color(255,0,0,10))
                m_DrawShadowedText(1,string.Friendly(MapVote.Feedback[map].Positive), "moat_Feedback", 35, 148 + 9, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_LEFT)
				m_DrawShadowedText(1,string.Friendly(MapVote.Feedback[map].Negative), "moat_Feedback", (w/2)+35, 148 + 9, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_LEFT)
        		cdn.DrawImage("https://static.moat.gg/f/E3Fa8uDCgNzzL6iAoITcNk4nUDye.png",10,148 + 9,20,20,Color(255,255,255,25))
				cdn.DrawImageRotated("https://static.moat.gg/f/unE9uyhsKtr835pF3Zigc71KozFU.png",(w/2)+10,148 + 9,20,20,Color(255,255,255,25),180,50)
            else
                m_DrawShadowedText(1,"None", "moat_Feedback", w/2, 165, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_CENTER)
            end
			*/

            m_DrawShadowedText(1, "Average feedback:", "moat_ItemDesc", w/2, 150, (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255), TEXT_ALIGN_CENTER)
            local c = (MapVote.Panel.Winner == i and HSVToColor((SysTime()*100)%360,0.65,0.9)) or Color(255,255,255, 255)
            local vote_s = "s"
            if (votes == 1) then vote_s = "" end
            m_DrawShadowedText(1,votes .. " Vote" .. vote_s, "moat_mVotes", w/2, 192, (mine and Color(0,255,0)) or c, TEXT_ALIGN_CENTER)
		end

        function a:DoClick()
            --MapVote.Votes[LocalPlayer():SteamID()] = i
            net.Start("RAM_MapVoteUpdate")
                net.WriteUInt(MapVote.UPDATE_VOTE, 3)
                net.WriteUInt(i, 32)
            net.SendToServer()
        end
    end

    local cl = vgui.Create("DButton", MapVote.Panel)
    cl:SetPos(MapVote.Panel:GetWide() - 22, 5)
    cl:SetSize(17, 17)
    cl:SetText("")
    cl.LerpNum = 0
    cl.Paint = function(s, w, h)
        if (not s.LerpNum) then s.LerpNum = 0 end

        if (s:IsHovered() or s:IsDown()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        draw.RoundedBox(4, 0, 0, w, h, Color(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum)))

        draw.SimpleText("r", "marlett", 8 + 1, 8, Color(255 - (55 * s.LerpNum), 50 + (150 * s.LerpNum), 50 + (150 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
	sfx.SoundEffects(cl)
    cl.DoClick = function()
        MapVote.Panel:Hide()
    end
end

concommand.Add("mpsh",function()
    MapVote.CurrentMaps = {
        "ttt_minecraft_b5",
        "ttt_67thway_v14",
        "ttt_terraria",
        "ttt_minecraftcity_v4",
        "ttt_clue_se",
        "ttt_experimental_shapes",
        "ttt_minecraft_haven",
        "ttt_waterworld"
    }
    MapVote.Feedback = {}
    for i = 1,8 do
        if i == 6 then continue end
		local pos, neg = math.Round(math.random() * 10000), math.Round(math.random() * 10000)
        MapVote.Feedback[MapVote.CurrentMaps[i]] = {Positive = pos, Negative = neg, Count = pos + neg}
    end
    MapVote.Show()
end)

/*

local PANEL = {}

function PANEL:Init()
    self:ParentToHUD()
    
    self.Canvas = vgui.Create("Panel", self)
    self.Canvas:MakePopup()
    self.Canvas:SetKeyboardInputEnabled(false)
    
    self.countDown = vgui.Create("DLabel", self.Canvas)
    self.countDown:SetTextColor(color_white)
    self.countDown:SetFont("RAM_VoteFontCountdown")
    self.countDown:SetText("")
    self.countDown:SetPos(0, 14)
    
    self.mapList = vgui.Create("DPanelList", self.Canvas)
    self.mapList:SetDrawBackground(false)
    self.mapList:SetSpacing(4)
    self.mapList:SetPadding(4)
    self.mapList:EnableHorizontal(true)
    self.mapList:EnableVerticalScrollbar()
    
    self.closeButton = vgui.Create("DButton", self.Canvas)
    self.closeButton:SetText("")

    self.closeButton.Paint = function(panel, w, h)
        derma.SkinHook("Paint", "WindowCloseButton", panel, w, h)
    end

    self.closeButton.DoClick = function()
        self:SetVisible(false)
    end

    self.maximButton = vgui.Create("DButton", self.Canvas)
    self.maximButton:SetText("")
    self.maximButton:SetDisabled(true)

    self.maximButton.Paint = function(panel, w, h)
        derma.SkinHook("Paint", "WindowMaximizeButton", panel, w, h)
    end

    self.minimButton = vgui.Create("DButton", self.Canvas)
    self.minimButton:SetText("")
    self.minimButton:SetDisabled(true)

    self.minimButton.Paint = function(panel, w, h)
        derma.SkinHook("Paint", "WindowMinimizeButton", panel, w, h)
    end

    self.Voters = {}
end

function PANEL:PerformLayout()
    local cx, cy = chat.GetChatBoxPos()
    
    self:SetPos(0, 0)
    self:SetSize(ScrW(), ScrH())
    
    local extra = math.Clamp(300, 0, ScrW() - 640)
    self.Canvas:StretchToParent(0, 0, 0, 0)
    self.Canvas:SetWide(640 + extra)
    self.Canvas:SetTall(cy -60)
    self.Canvas:SetPos(0, 0)
    self.Canvas:CenterHorizontal()
    self.Canvas:SetZPos(0)
    
    self.mapList:StretchToParent(0, 90, 0, 0)

    local buttonPos = 640 + extra - 31 * 3

    self.closeButton:SetPos(buttonPos - 31 * 0, 4)
    self.closeButton:SetSize(31, 31)
    self.closeButton:SetVisible(true)

    self.maximButton:SetPos(buttonPos - 31 * 1, 4)
    self.maximButton:SetSize(31, 31)
    self.maximButton:SetVisible(true)

    self.minimButton:SetPos(buttonPos - 31 * 2, 4)
    self.minimButton:SetSize(31, 31)
    self.minimButton:SetVisible(true)
    
end

local heart_mat = Material("icon16/heart.png")
local star_mat = Material("icon16/star.png")
local shield_mat = Material("icon16/shield.png")

function PANEL:AddVoter(voter)
    for k, v in pairs(self.Voters) do
        if(v.Player and v.Player == voter) then
            return false
        end
    end
    
    
    local icon_container = vgui.Create("Panel", self.mapList:GetCanvas())
    local icon = vgui.Create("AvatarImage", icon_container)
    icon:SetSize(16, 16)
    icon:SetZPos(1000)
    icon:SetTooltip(voter:Name())
    icon_container.Player = voter
    icon_container:SetTooltip(voter:Name())
    icon:SetPlayer(voter, 16)

    if MapVote.HasExtraVotePower(voter) then
        icon_container:SetSize(40, 20)
        icon:SetPos(21, 2)
        icon_container.img = star_mat
    else
        icon_container:SetSize(20, 20)
        icon:SetPos(2, 2)
    end
    
    icon_container.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0, 80))
        
        if(icon_container.img) then
            surface.SetMaterial(icon_container.img)
            surface.SetDrawColor(Color(255, 255, 255))
            surface.DrawTexturedRect(2, 2, 16, 16)
        end
    end
    
    table.insert(self.Voters, icon_container)
end

function PANEL:Think()
    for k, v in pairs(self.mapList:GetItems()) do
        v.NumVotes = 0
    end
    
    for k, v in pairs(self.Voters) do
        if(not IsValid(v.Player)) then
            v:Remove()
        else
            if(not MapVote.Votes[v.Player:SteamID()]) then
                v:Remove()
            else
                local bar = self:GetMapButton(MapVote.Votes[v.Player:SteamID()])
                
                if(MapVote.HasExtraVotePower(v.Player)) then
                    bar.NumVotes = bar.NumVotes + 2
                else
                    bar.NumVotes = bar.NumVotes + 1
                end
                
                if(IsValid(bar)) then
                    local CurrentPos = Vector(v.x, v.y, 0)
                    local NewPos = Vector((bar.x + bar:GetWide()) - 21 * bar.NumVotes - 2, bar.y + (bar:GetTall() * 0.5 - 10), 0)
                    
                    if(not v.CurPos or v.CurPos ~= NewPos) then
                        v:MoveTo(NewPos.x, NewPos.y, 0.3)
                        v.CurPos = NewPos
                    end
                end
            end
        end
        
    end
    
    local timeLeft = math.Round(math.Clamp(MapVote.EndTime - CurTime(), 0, math.huge))
    
    self.countDown:SetText(tostring(timeLeft or 0).." seconds")
    self.countDown:SizeToContents()
    self.countDown:CenterHorizontal()
end

function PANEL:SetMaps(maps)
    self.mapList:Clear()
    
    for k, v in RandomPairs(maps) do
        local button = vgui.Create("DButton", self.mapList)
        button.ID = k
        button:SetText(v)
        
        button.DoClick = function()
            net.Start("RAM_MapVoteUpdate")
                net.WriteUInt(MapVote.UPDATE_VOTE, 3)
                net.WriteUInt(button.ID, 32)
            net.SendToServer()
        end
        
        do
            local Paint = button.Paint
            button.Paint = function(s, w, h)
                local col = Color(255, 255, 255, 10)
                
                if(button.bgColor) then
                    col = button.bgColor
                end
                
                draw.RoundedBox(4, 0, 0, w, h, col)
                Paint(s, w, h)
            end
        end
        
        button:SetTextColor(color_white)
        button:SetContentAlignment(4)
        button:SetTextInset(8, 0)
        button:SetFont("RAM_VoteFont")
        
        local extra = math.Clamp(300, 0, ScrW() - 640)
        
        button:SetDrawBackground(false)
        button:SetTall(24)
        button:SetWide(285 + (extra / 2))
        button.NumVotes = 0
        
        self.mapList:AddItem(button)
    end
end

function PANEL:GetMapButton(id)
    for k, v in pairs(self.mapList:GetItems()) do
        if(v.ID == id) then return v end
    end
    
    return false
end

function PANEL:Paint()
    --Derma_DrawBackgroundBlur(self)
    
    local CenterY = ScrH() / 2
    local CenterX = ScrW() / 2
    
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(0, 0, ScrW(), ScrH())
end

function PANEL:Flash(id)
    self:SetVisible(true)

    local bar = self:GetMapButton(id)
    
    if(IsValid(bar)) then
        timer.Simple( 0.0, function() bar.bgColor = Color( 0, 255, 255 ) surface.PlaySound( "hl1/fvox/blip.wav" ) end )
        timer.Simple( 0.2, function() bar.bgColor = nil end )
        timer.Simple( 0.4, function() bar.bgColor = Color( 0, 255, 255 ) surface.PlaySound( "hl1/fvox/blip.wav" ) end )
        timer.Simple( 0.6, function() bar.bgColor = nil end )
        timer.Simple( 0.8, function() bar.bgColor = Color( 0, 255, 255 ) surface.PlaySound( "hl1/fvox/blip.wav" ) end )
        timer.Simple( 1.0, function() bar.bgColor = Color( 100, 100, 100 ) end )
    end
end

derma.DefineControl("RAM_VoteScreen", "", PANEL, "DPanel")
*/