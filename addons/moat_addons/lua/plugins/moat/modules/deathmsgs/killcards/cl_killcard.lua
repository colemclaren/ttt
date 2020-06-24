MOAT_KILLCARDS = MOAT_KILLCARDS or {}
MOAT_KILLCARDS.CardQueue = {}
MOAT_KILLCARDS.CardInfo = {
	w = 450,
	h = 150
}
MOAT_KILLCARDS.CardInfo.Pnl = {
	w = MOAT_KILLCARDS.CardInfo.w,
	h = MOAT_KILLCARDS.CardInfo.h - 50,
	x = 0,
	y = 35
}
MOAT_KILLCARDS.TimeDisplayed = 7

MOAT_KILLCARDS.Strings = {
	{"Killed By", 91},
	{"Killed", 61}
}

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

local gradient_u = Material("vgui/gradient-u")

local scrw = ScrW()
local scrh = ScrH()

MOAT_KILLCARDS.CardInfoF = {
	x = (scrw / 2) - (MOAT_KILLCARDS.CardInfo.w / 2),
	y = scrh - 250
}
MOAT_KILLCARDS.Colors = {
	shadow = Color(0, 0, 0, 30),
	white = Color(255, 255, 255),
	red = Color(255, 0, 0),
	blue = Color(0, 0, 255),
	green = Color(0, 255, 0),
	black = Color(0, 0, 0),
	kname = {
		["Traitor"] = Color(220, 25, 25),
		["Innocent"] = Color(25, 220, 25),
		["Detective"] = Color(25, 25, 220),
		["Enviroment"] = Color(255, 255, 255),
		["Player"] = Color(255, 255, 255),
		["Jester"]    = Color(253, 158, 255, 255),
  		["Serial Killer"]    = Color(255, 145, 0, 255),
   		["Doctor"]    = Color(0, 200, 255, 255),
   		["Beacon"]    = Color(255, 200, 0, 255),
   		["Survivor"]  = Color(128, 142, 0, 255),
   		["Hitman"]    = Color(40, 42, 47, 255),
   		["Bodyguard"] = Color(0, 153, 153, 255),
   		["Veteran"]   = Color(179, 0, 255, 255),
   		["Phoenix"] = Color(0, 249, 199, 255)
	}
}

MOAT_KILLCARDS.DeathTypes = {
	"Unknown Weapon",
	"Drowned to Death",
	"Prop Killed",
	"Fell to Death",
	"Burned to Death",
	"Explosion",
	"Hit n' Run",
	"Shocked to Death",
	"Unknown Death"
}

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

function MOAT_KILLCARDS:DrawDeathCard(rnd_state, role, id, name, wpn, hp, max_hp)
	self.CardInfo.x = (scrw / 2) - (self.CardInfo.w / 2)
	self.CardInfo.y = scrh

	if (IsValid(self.CurCard)) then
		self.CurCard:Remove()
	end

	self.CurCard = vgui.Create("DFrame")
	self.CurCard.EndTime = CurTime() + self.TimeDisplayed
	self.CurCard:SetPos(self.CardInfo.x, self.CardInfo.y)
	self.CurCard:SetSize(self.CardInfo.w, self.CardInfo.h)
	self.CurCard:ShowCloseButton(false)
	self.CurCard:SetTitle("")
	self.CurCard.kstr = MOAT_KILLCARDS.Strings[1]
	self.CurCard.kname = LANG.GetRawTranslation(GetRoleStringRaw(role)) or role

	local role_color = GetRoleColor(role) or Color(255, 255, 255)
	role_color.a = 255

	local inactive, round_str = rnd_state ~= ROUND_ACTIVE, rnd_state == ROUND_PREP and "Killed During Preparing" or "Killed After Round"
	self.CurCard.Paint = function(s, w, h)
		surface_SetDrawColor(180, 180, 180, 200)
		surface_DrawLine(0, 30, w, 30)
		surface_DrawLine(0, h-11, w, h-11)

		if (inactive) then 
			draw_SimpleTextOutlined(round_str, "moat_Trebuchet", 0, 0, self.Colors.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, self.Colors.shadow)
			return
		end

		draw_SimpleTextOutlined(s.kstr[1], "moat_Trebuchet", 0, 0, self.Colors.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, self.Colors.shadow)

		surface.SetFont "moat_Trebuchet"
		local wide = surface.GetTextSize(s.kstr[1] .. " ")

		if (s.kname) then
			draw_SimpleTextOutlined(s.kname, "moat_Trebuchet", wide, 0, role_color or self.Colors.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, self.Colors.shadow)
		end
	end

	self.CurCard.Pnl = vgui.Create("DPanel", self.CurCard)
	self.CurCard.Pnl:SetPos(self.CardInfo.Pnl.x, self.CardInfo.Pnl.y)
	self.CurCard.Pnl:SetSize(self.CardInfo.Pnl.w, self.CardInfo.Pnl.h)
	self.CurCard.Pnl.Paint = nil

	self.CurCard.PnlAva = vgui.Create("AvatarImage", self.CurCard.Pnl)
	self.CurCard.PnlAva:SetPos(0, -200)
	self.CurCard.PnlAva:SetSize(450, 450)
	self.CurCard.PnlAva:SetSteamID(id, 184)
	self.CurCard.PnlAva:SetAlpha(150)

	self.CurCard.Blur = vgui.Create("DPanel", self.CurCard.Pnl)
	self.CurCard.Blur:SetPos(0, 0)
	self.CurCard.Blur:SetSize(self.CardInfo.Pnl.w, self.CardInfo.Pnl.h)
	self.CurCard.Blur.Paint = function(s, w, h)
		DrawBlur(s, 1.5)

		surface_SetDrawColor(28, 28, 36, 150)
		surface_DrawRect(0, 0, w, h)
	end

	self.CurCard.KAva = vgui.Create("AvatarImage", self.CurCard.Pnl)
	self.CurCard.KAva:SetPos(10, 10)
	self.CurCard.KAva:SetSize(80, 80)
	self.CurCard.KAva:SetSteamID(id, 84)

    local health_ratio = 0
    local health_string = "Dead"
    local att_name = name

	if (hp > 0 and max_hp ~= 0) then
    	health_string = "HP: " .. hp .. "/" .. max_hp
    	health_ratio = math.Clamp(hp / max_hp, 0, 1)
	end

    local health_green = 255 * health_ratio
    local health_red = 255 - (255 * health_ratio)

    local weapon_str, weapon_col, weapon_eff, weapon_rainbow = isstring(wpn) and wpn or "Unknown Cause of Death", Color(255, 255, 255)
	if (not isstring(wpn)) then
		weapon_str = wpn.ItemName or wpn.PrintName or wpn:GetPrintName() or "Something Strange"

		if (wpn.ItemStats and wpn.ItemStats.item) then
			weapon_col = wpn.ItemStats.item.NameColor or rarity_names[wpn.ItemStats.item.Rarity][2]:Copy()
			weapon_col.a = 255
			weapon_eff = wpn.ItemStats.item.NameEffect or nil
			weapon_rainbow = wpn.ItemStats.item.Rarity == 9
		end
	end

	self.CurCard.KInfo = vgui.Create("DPanel", self.CurCard.Pnl)
	self.CurCard.KInfo:SetSize(self.CardInfo.Pnl.w - 110, self.CardInfo.Pnl.h - 20)
	self.CurCard.KInfo:SetPos(100, 10)
	self.CurCard.KInfo.Paint = function(s, w, h)
		draw_SimpleTextOutlined(att_name, "moat_Trebuchet", 0, -4, role_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, self.Colors.shadow)

		if (weapon_eff and weapon_eff == "glow") then
			local da_col = weapon_col

			if (weapon_rainbow) then
				da_col = rarity_names[9][2]:Copy()
			end

            m_DrawGlowingText(false, weapon_str, "moat_Trebuchet", 0, 20, da_col, nil, nil, true)
        else
			local da_col = weapon_col

			if (weapon_rainbow) then
				da_col = rarity_names[9][2]:Copy()
			end
			
            emoji.SimpleTextOutlined(weapon_str, "moat_Trebuchet", 0, 20, da_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, self.Colors.shadow)
        end
		
		surface_SetDrawColor(28, 28, 36, 200)
		surface_DrawRect(0, 50, w, 30)

		surface_SetDrawColor(0, 0, 0, 255)
		surface_DrawRect(1, 51, w - 2, 28)

		surface_SetDrawColor(health_red / 5, health_green / 5, 0)
		surface_DrawRect(1, 51, w - 2, 28)

		surface_SetDrawColor(health_red, health_green, 0, 60)
		surface_SetMaterial(gradient_u)
		surface_DrawTexturedRect(1, 51, (w - 2) * health_ratio, 28)

		draw_SimpleTextOutlined(health_string, "TimeLeft", w / 2, 52, self.Colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, self.Colors.shadow)
	end

	self.CurCard.Think = function(s)
		if (s.EndTime <= CurTime() and not s.ExitingScreen) then
			s.ExitingScreen = true

			s:MoveTo(self.CardInfoF.x, self.CardInfoF.y - 10, 0.1, 0, -1, function(a, p)
				p:MoveTo(self.CardInfo.x, self.CardInfo.y, 0.2, 0, -1, function(a2, p2)
					s:Remove()
					self.CurCard = nil
				end)
			end)
		end
	end

	self.CurCard:MoveTo(self.CardInfoF.x, self.CardInfoF.y - 10, 0.3, 0, -1, function(a, p)
		p:MoveTo(self.CardInfoF.x, self.CardInfoF.y, 0.1, 0, -1)
	end)
end

function MOAT_KILLCARDS.ReceiveDeath(l)
	if (not LocalPlayer() or not IsValid(LocalPlayer())) then return end
	local info = {role = "Something?", id = LocalPlayer():SteamID64(), name = LocalPlayer():Nick(), wpn = "Unknown Weapon", hp = 0, max_hp = 0}
	local att = net.ReadEntity()
	local round_state = net.ReadUInt(4)
	
	if (l and l == "testing") then att = LocalPlayer() end
	if (not IsValid(att)) then return end

	if (att == Entity(0)) then
		info.id = att:SteamID64()
		info.name = att:Nick()
	elseif (att:IsPlayer()) then
		local r = net.ReadUInt(8)
		if (not r) then r = "Something?" end
		info.role = att == LocalPlayer() and "Yourself" or r
		info.id = att:SteamID64()
		info.name = att:Nick()
		info.hp = net.ReadUInt(32) or 0
		info.max_hp = net.ReadUInt(32) or 100
	end

	info.wpn = net.ReadString()
	local wpn = net.ReadEntity()
	local stats = net.ReadBool()

	if (wpn and IsValid(wpn) and wpn:IsWeapon()) then
		info.wpn = wpn
		if (stats and not wpn.ItemStats) then
			local indx = wpn:EntIndex()
			timer.Create("stat_wait_" .. indx, 0.5, 6, function()
				if (wpn.ItemStats) then
					info.wpn = wpn
					MOAT_KILLCARDS:DrawDeathCard(round_state, info.role, info.id, info.name, info.wpn, info.hp, info.max_hp)
					timer.Remove("stat_wait_" .. indx)
				end
			end)
			return
		end
	end

	if (info.hp > 999999999) then info.hp = 0 end
	
	MOAT_KILLCARDS:DrawDeathCard(round_state, info.role, info.id, info.name, info.wpn, info.hp, info.max_hp)
end
net.Receive("moat_killcard_kill", MOAT_KILLCARDS.ReceiveDeath)

/*
concommand.Add("moat_test_deathcard", function() 
	MOAT_KILLCARDS.ReceiveDeath("testing")

	--MOAT_KILLCARDS:DrawDeathCard(1, LocalPlayer():SteamID64(), LocalPlayer():Nick(), "Unknown Weapon", 80, LocalPlayer():GetMaxHealth())
end)
*/