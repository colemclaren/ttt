--Modern Rewards Main Client Dist
if REWARDS then REWARDS = REWARDS
else REWARDS = {} end

REWARDS.DrawHeight = 300
REWARDS.ControlHeight = 27
REWARDS.CurrentAlpha = 0
REWARDS.DisplayType = 1
REWARDS.MessageBoxPadding = 14
include('cl_rewardfonts.lua')
include('sh_rewardsconfig.lua')

--Include panels
include('sgrpanels/cl_menubutton.lua')

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

function REWARDS.OpenRewards( settings )
	if not LocalPlayer() then return end

	REWARDS.MainWindowOpen = true
	REWARDS.JoinCheckWidth = 0
	REWARDS.DisplayType = 1
	steam_group_started_remove_timer = false

	if !RewardsMainWindow then
		REWARDS.CurrentAlpha = 0
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

			//Draw message box
			local cin = (math.sin(CurTime()) + 1) / 2
	
			//Display SHOW ONLY
			if REWARDS.DisplayType == 1 then
				surface.SetDrawColor(REWARDS.ColorWithCurrentAlpha(REWARDS.Theme.MessageBoxBackColor))
				surface.DrawRect(35, 135, REWARDS.FindMessageBoxWidth(REWARDS.Settings.RewardsMessage), 30)

				draw.DrawText(REWARDS.Settings.RewardsMessage, REWARDS.Theme.Font, w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			//Display JOIN CHECK DELAY 
			elseif REWARDS.DisplayType == 2 then
				local width = 395
				surface.SetDrawColor(51, 153, 255)
				surface.DrawOutlinedRect(35, 135, width, 30)
		
				REWARDS.JoinCheckWidth = math.Approach( REWARDS.JoinCheckWidth, width, FrameTime() * ((width / REWARDS.Settings.JoinCheckDelay)))
				surface.SetDrawColor(35, 153, 255, 200)
				surface.DrawRect(35, 135, REWARDS.JoinCheckWidth, 30)

				if (REWARDS.JoinCheckWidth == width and not steam_group_started_remove_timer) then
					steam_group_started_remove_timer = true

					timer.Simple(7, function()
						REWARDS.CloseRewards() gui.EnableScreenClicker(false)
					end)
				end
				draw.DrawText(REWARDS.Settings.RewardsJoinCheckMessage, REWARDS.Theme.Font, w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			//Display REWARDS SUCCESS
			elseif REWARDS.DisplayType == 3 then
				if REWARDS.Theme.SuccessColorEffect then
					surface.SetDrawColor(cin * 255,255 - (cin * 255),255,REWARDS.CurrentAlpha)
				else
					surface.SetDrawColor(REWARDS.ColorWithCurrentAlpha(REWARDS.Theme.MessageBoxSuccessBackColor))
				end
				surface.DrawRect(35, 135, REWARDS.FindMessageBoxWidth(REWARDS.Settings.RewardsSuccessMessage), 30)
	
				draw.DrawText(REWARDS.Settings.RewardsSuccessMessage, REWARDS.Theme.Font, w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			else
				surface.SetDrawColor(REWARDS.ColorWithCurrentAlpha(REWARDS.Theme.MessageBoxBackColor))
				surface.DrawRect(35, 135, REWARDS.FindMessageBoxWidth(REWARDS.Settings.RewardsMessage), 30)
	
				draw.DrawText(REWARDS.Settings.RewardsMessage, REWARDS.Theme.Font, w/2, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
    	end

        local btn = vgui.Create("DButton", p)
        btn:SetPos(35, 135)
        btn:SetSize(180, 30)
        btn:SetText("")
        btn.LerpNum = 0
        btn.Label = "Sure!"
        btn.Paint = function(s, w, h)
        	if (REWARDS.CurrentAlpha == 255) then
        		s:SetTall(0)
        		return
        	end

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

			LocalPlayer():ConCommand("rewards_joinsteam")
			REWARDS.DisplayType = 2
			REWARDS.CurrentAlpha = 255
			gui.OpenURL(REWARDS.Settings.SteamGroupPage)
			gui.EnableScreenClicker(false)
        end

        local btn2 = vgui.Create("DButton", p)
        btn2:SetPos(250, 135)
        btn2:SetSize(180, 30)
        btn2:SetText("")
        btn2.LerpNum = 0
        btn2.Label = "Not Now, Thanks!"
        btn2.Paint = function(s, w, h)
        	if (REWARDS.CurrentAlpha == 255) then
        		s:SetTall(0)
        		return
        	end

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

			REWARDS.CloseRewards() gui.EnableScreenClicker(false)
        end
	else
		REWARDS.CloseRewards()
	end
end
concommand.Add("rewards", REWARDS.OpenRewards)

//local FKeyReleased = false

function REWARDS.ColorWithCurrentAlpha(c)
	local r,g,b = c.r,c.g,c.b
	return Color(r,g,b,REWARDS.CurrentAlpha)
end

function REWARDS.FindMessageBoxWidth(text)
	surface.SetFont(REWARDS.Theme.Font)
	local tw = surface.GetTextSize(text) 
	return tw + REWARDS.MessageBoxPadding
end

local function RewardsOpenCommand(msg)
	//Open steam rewards network command
	local autoclosetime = msg:ReadLong()
	local settings = {}
	if autoclosetime and autoclosetime > 0 then
		settings.autoclosetime = tonumber(autoclosetime)
	else gui.EnableScreenClicker(true) end
	REWARDS.OpenRewards( settings )
end
usermessage.Hook("REWARDS_Open", RewardsOpenCommand)

local function RewardsSuccessCommand(msg)
	//Success steam rewards network command
	local settings = {}
	if not RewardsMainWindow then REWARDS.OpenRewards( settings ) end
	REWARDS.DisplayType = 3
	if REWARDS.Settings.PlaySounds then surface.PlaySound(REWARDS.Settings.SuccessSound) end
	timer.Simple(REWARDS.Settings.SuccessCloseTime or 5, function()
		REWARDS.CloseRewards()
	end)
end
usermessage.Hook("REWARDS_Success", RewardsSuccessCommand)

function REWARDS.CloseRewards()
	if RewardsMainWindow then
		RewardsMainWindow:Remove()
		RewardsMainWindow = nil
		REWARDS.AutoCloseTime = nil
	end
	REWARDS.MainWindowOpen = false
end
usermessage.Hook("REWARDS_Close", REWARDS.CloseRewards)

--BindKey
local Binds = {
	["gm_showhelp"] = "F1",
	["gm_showteam"] = "F2",
	["gm_showspare1"] = "F3",
	["gm_showspare2"] = "F4"
}

local ShowCursor
function REWARDS.PlayerBindPress( ply, bind, down )
	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")
	if bnd and Binds[bnd] and Binds[bnd] == REWARDS.Settings.FKeyShowCursor then
		local settings = {}
			ShowCursor = !ShowCursor
			gui.EnableScreenClicker(ShowCursor)
	end
end
hook.Add("PlayerBindPress","REWARDS_PlayerBindPress",REWARDS.PlayerBindPress)

local function RewardsNotify()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end

	chat.AddText(moat_blue, "| ", moat_cyan, ply:Nick(), moat_white, " joined our steam group and received ", moat_green, "2,500 IC", moat_white, "!")
end
net.Receive("REWARDS_Notify", RewardsNotify)