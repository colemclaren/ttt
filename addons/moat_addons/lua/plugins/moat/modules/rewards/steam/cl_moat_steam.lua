local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local surface_SetFont = surface.SetFont
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local blur = Material("pp/blurscreen")
local rewardsapi = "https://moat.gg/api/steam/rewards/"
local groupapi = "https://moat.gg/api/steam/group/"

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local msg = "Join our steam group and receive 2,500\n inventory credits!"
local function FindMessageBoxWidth(text)
	surface.SetFont("Trebuchet24")
	local tw = surface.GetTextSize(text) 
	return tw + 14
end

local function CheckGroup(id)
	http.Fetch(groupapi .. id, function(b)
		if (not b) then return end
		b = util.JSONToTable(b)
		if (not b) then return end
		if (b.found == 1) then
			net.Start "REWARDS_CheckNewPlayer"
			net.SendToServer()
		elseif (b.found == 0) then
			chat.AddText(Color(255, 0, 0), "We couldn't find you in the steam group? Is Steam down? Try running the !steam command later.")
		end
	end, function() timer.Simple(30, function() CheckGroup(id) end) end)
end

local function GiveRewards()
	local rewardmsg = "Click the button below once\nyou've joined the group!"
	RewardsMainWindow = vgui.Create("DFrame")
	RewardsMainWindow:SetSize(465, 200)
	RewardsMainWindow:SetDraggable(true)
	RewardsMainWindow:Center()
	RewardsMainWindow:ShowCloseButton(false)
	RewardsMainWindow:SetTitle("")
	RewardsMainWindow:MakePopup()
	RewardsMainWindow:DockPadding(0, 6, 0, 6)
	RewardsMainWindow.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 0, w, 0)
		surface_DrawLine(0, h - 1, w, h - 1)
	end

	local p = vgui.Create("DPanel", RewardsMainWindow)
    p:Dock(FILL)
    p.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 200)
        surface_DrawRect(0, 0, w, h)
        DrawBlur(s, 3)

		draw.DrawText(rewardmsg, "Trebuchet24", w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local btn = vgui.Create("DButton", p)
    btn:SetPos(35, 135)
    btn:SetSize(180, 30)
    btn:SetText("")
    btn.LerpNum = 0
    btn.Label = "Open Group!"
    btn.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		surface_SetDrawColor(51, 153, 255)
        surface_DrawOutlinedRect(0, 0, w, h)

        draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
    btn.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    btn.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")
		gui.OpenURL "https://steamcommunity.com/groups/moatgaming"
    end

    local btn2 = vgui.Create("DButton", p)
    btn2:SetPos(250, 135)
    btn2:SetSize(180, 30)
    btn2:SetText("")
    btn2.LerpNum = 0
    btn2.Label = "I Joined!"
    btn2.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		surface_SetDrawColor(50 * s.LerpNum, 255 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(50, 255, 50)
        surface_DrawOutlinedRect(0, 0, w, h)

        draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
    btn2.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    btn2.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")
		local id = LocalPlayer():SteamID64()
		if (not id) then return end
		CheckGroup(id)

		RewardsMainWindow:Remove()
    end

	gui.OpenURL "https://steamcommunity.com/groups/moatgaming"
end

function OpenRewards()
	RewardsMainWindow = vgui.Create("DFrame")
	RewardsMainWindow:SetSize(465, 200)
	RewardsMainWindow:SetDraggable(true)
	RewardsMainWindow:Center()
	RewardsMainWindow:ShowCloseButton(false)
	RewardsMainWindow:SetTitle("")
	RewardsMainWindow:MakePopup()
	RewardsMainWindow:DockPadding(0, 6, 0, 6)
	RewardsMainWindow.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 0, w, 0)
		surface_DrawLine(0, h - 1, w, h - 1)
	end

	local p = vgui.Create("DPanel", RewardsMainWindow)
    p:Dock(FILL)
    p.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 200)
        surface_DrawRect(0, 0, w, h)
        DrawBlur(s, 3)

		draw.DrawText(msg, "Trebuchet24", w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local btn = vgui.Create("DButton", p)
    btn:SetPos(35, 135)
    btn:SetSize(180, 30)
    btn:SetText("")
    btn.LerpNum = 0
    btn.Label = "Sure!"
    btn.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		surface_SetDrawColor(51, 153, 255)
        surface_DrawOutlinedRect(0, 0, w, h)

        draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
    btn.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    btn.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")
		RewardsMainWindow:Remove()
		GiveRewards()
    end

    local btn2 = vgui.Create("DButton", p)
    btn2:SetPos(250, 135)
    btn2:SetSize(180, 30)
    btn2:SetText("")
    btn2.LerpNum = 0
    btn2.Label = "Not Now, Thanks!"
    btn2.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

		surface_SetDrawColor(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(255, 50, 50)
        surface_DrawOutlinedRect(0, 0, w, h)

        draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
    btn2.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    btn2.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")
		RewardsMainWindow:Remove()
    end
end

net.Receive("REWARDS_OpenMenu", OpenRewards)

local function CheckRewards()
	if (cookie.GetNumber("moat_group_rewards", 0) == 1) then return end

	local id = LocalPlayer():SteamID64()
	if (not id) then return end

	http.Fetch(rewardsapi .. id, function(b)
		if (not b) then return end
		b = util.JSONToTable(b)
		if (not b) then return end
		if (b.value == 2) then
			OpenRewards()
		elseif (b.value == 0) then
			timer.Simple(10, function()
				net.Start("REWARDS_CheckNewPlayer")
				net.SendToServer()
			end)
		elseif (b.value == 1) then
			cookie.Set("moat_group_rewards", 1)
		end
	end, function() timer.Simple(30, function() CheckRewards() end) end)
end


hook.Add("InitPostEntity", "Rewards.Steam", function()
	timer.Simple(30, function() CheckRewards() end)
end)



local function RewardsNotify()
	local ply = net.ReadEntity()
	if (not IsValid(ply)) then return end

	chat.AddText(moat_blue, "| ", moat_cyan, ply:Nick(), moat_white, " joined our steam group and received ", moat_green, "2,500 IC", moat_white, "!")

	if (IsValid(LocalPlayer()) and ply == LocalPlayer()) then
		cookie.Set("moat_group_rewards", 1)
	end
end
net.Receive("REWARDS_Notify", RewardsNotify)