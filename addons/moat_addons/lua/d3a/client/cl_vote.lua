D3A.Vote = {}

local math 				= math
local table 			= table
local draw 				= draw
local team 				= team
local IsValid 			= IsValid
local CurTime 			= CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
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

function D3A.Vote.Popup()
	local question = net.ReadString()
	local answers = net.ReadTable()

	if (IsValid(D3A.Vote.Frame)) then
		D3A.Vote.Frame:Remove()
	end

	local frameh = 70 + (#answers * 40)

	surface.SetFont("DermaLarge")
	local framew = math.Clamp(surface.GetTextSize(question), 400, 800) + 40

	D3A.Vote.Frame = vgui.Create("DFrame")
	D3A.Vote.Frame:SetSize(framew, frameh)
	D3A.Vote.Frame:Center()
	D3A.Vote.Frame:MakePopup()
	D3A.Vote.Frame:SetBackgroundBlur(true)
	D3A.Vote.Frame:ShowCloseButton(false)
	D3A.Vote.Frame:SetTitle("")
	D3A.Vote.Frame.Question = question
	D3A.Vote.Frame.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 0, w, 0)
		surface_DrawLine(0, h - 1, w, h - 1)
	end

	local al = vgui.Create("DPanel", D3A.Vote.Frame)
	al:SetPos(0, 3)
	al:SetSize(framew, frameh - 6)
	al.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)

		DrawBlur(s, 2)
		draw_SimpleTextOutlined(question, "DermaLarge", w/2, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end

	for i = 1, #answers do
		local btn = vgui.Create("DButton", al)
		btn:SetPos(20, 55 + ((i * 40) - 40))
		btn:SetSize(framew - 40, 30)
		btn:SetText("")
		btn.LerpNum = 0
		btn.Answer = answers[i]
		btn.Index = i
		btn.Paint = function(s, w, h)
			if (s:IsHovered()) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
			surface_DrawRect(0, 0, w, h)

			draw_SimpleTextOutlined(s.Answer, "Trebuchet24", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")

			net.Start("D3A.CountVote")
			net.WriteUInt(s.Index, 8)
			net.SendToServer()

			chat.AddText(moat_blue, "| ", moat_white, "Thank ", moat_cyan, "you", moat_white, " for voting! You chose: ", moat_green, s.Answer, moat_white, ".")
			D3A.Vote.Frame:Close()
		end
	end
end
net.Receive("D3A.StartVote", D3A.Vote.Popup)

function D3A.Vote.Close()
	if (D3A.Vote and IsValid(D3A.Vote.Frame)) then
		D3A.Vote.Frame:Remove()
	end
end
net.Receive("D3A.EndVote", D3A.Vote.Close)