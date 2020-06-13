surface.CreateFont("moat_GunGameMedium", {
    font = "DermaLarge",
    size = 28,
    weight = 800,
    italic = true
})
surface.CreateFont("moat_GunGameSmall", {
    font = "DermaLarge",
    size = 18,
    weight = 800
})
surface.CreateFont("moat_GunGameLarge", {
    font = "DermaLarge",
    size = 52,
    weight = 800,
    italic = true
})

MG_OC = MG_OC or {}
MG_OC.Top = {nick = nil, rank = 1, kills = 0}
MG_OC.CurRank = 1
MG_OC.CurKills = 0
MG_OC.Ladder = {
    {"weapon_ttt_m16", "M16"},
    {"weapon_ttt_ak47", "AK47"},
    {"weapon_ttt_famas", "Famas"},
    {"weapon_zm_mac10", "MAC 10"},
    {"weapon_ttt_galil", "Galil"},
    {"weapon_ttt_mp5", "MP5"},
    {"weapon_ttt_p90", "P90"},
    {"weapon_ttt_sg552", "SG552"},
    {"weapon_ttt_aug", "AUG"},
    {"weapon_zm_rifle", "Rifle"},
    {"weapon_zm_sledge", "HUGE"},
    {"weapon_ttt_shotgun", "Shotgun"},
    {"weapon_zm_shotgun", "Benelli M3"},
    {"weapon_ttt_sipistol", "Silenced Pistol"},
    {"weapon_zm_pistol", "Pistol"},
    {"weapon_ttt_glock", "Glock"},
	{"weapon_zm_revolver", "Deagle"},
    {"weapon_ttt_cardboardknife", "Knife"}
}

MG_OC.Description = {
	"Each player is given a one shot pistol. Eliminate wisely.",
	"If you miss, you're limited to your knife.",
	"Last man standing is the winner! (Most Kills gets best drop)",
}

MG_OC.PlayerInfo = {}
MG_OC.Hooks = {}
MG_OC.TopAvatars = {}
MG_OC.GunGameOver = false
MG_OC.cols = {Color(255, 0, 0), Color(100, 255, 100), Color(100, 255, 100)}
MG_OC.CurDeaths = 0

function MG_OC.ResetVars()
	MG_OC.CurRank = 1
	MG_OC.Top = {nick = LocalPlayer():Nick(), rank = 1, kills = 0}
	MG_OC.PlayerInfo = {}
	MG_OC.TopAvatars = {}
	MG_OC.Hooks = {}
	MG_OC.GunGameOver = false
	MG_OC.CurKills = 0
	MG_OC.CurDeaths = 0
	MG_OC.HaloPlayers = {}
end

local blur = Material("pp/blurscreen")

function MG_OC.DrawBlurScreen(amount)
    local x, y = 0, 0
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

function MG_OC.ActivePaint()
	if (GetRoundState() ~= ROUND_ACTIVE or MG_OC.GunGameOver) then
		hook.Remove("HUDPaint", "MG_OC_ACTIVEPAINT")
		return
	end

    local x = ScrW() / 2
    local y = 50

	draw.SimpleTextOutlined("Current Leader:", "moat_GunGameMedium", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	draw.SimpleTextOutlined(MG_OC.Top["nick"] or LocalPlayer():Nick(), "moat_GunGameMedium", x, y + 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	draw.SimpleTextOutlined(MG_OC.Top["kills"] .. " Kills", "moat_GunGameMedium", x, y + 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

	draw.SimpleTextOutlined(MG_OC.CurKills .. " Kills", "moat_GunGameMedium", x, y + 150, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	local s = " Lives"
	if (MG_OC.CurDeaths == 2) then
		s = " Life"
	end

	if (MG_OC.CurDeaths > 3) then
		draw.SimpleTextOutlined("Dead - Waiting For Round", "moat_GunGameMedium", x, y + 175, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	else
		draw.SimpleTextOutlined(3 - MG_OC.CurDeaths .. s .. " Left", "moat_GunGameMedium", x, y + 175, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end

	local spawn_prot = LocalPlayer():GetNW2Int("MG_OC_SPAWNPROTECTION")

	if (spawn_prot and spawn_prot > CurTime()) then
		draw.SimpleTextOutlined("Spawn Protection: " .. math.ceil(spawn_prot - CurTime()), "moat_GunGameMedium", x, y + 225, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
		draw.SimpleTextOutlined("YOU CANNOT FIRE WITH SPAWN PROTECTION", "moat_GunGameMedium", x, y + 250, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end
end

function MG_OC.PrepPaint()
	if (GetRoundState() ~= ROUND_PREP) then
		hook.Remove("HUDPaint", "MG_OC_PREPPAINT")
		return
	end

	--MG_OC.DrawBlurScreen(5)

    local x = ScrW() / 2
    local y = ScrH() / 2

    draw.SimpleTextOutlined("ONE IN THE CHAMBER", "moat_GunGameLarge", x, y - 70, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

    local time = math.ceil(GetGlobal("ttt_round_end") - CurTime())

    if (time < 1) then
    	time = "BEGIN"
    end

	draw.SimpleTextOutlined(time, "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

	for i = 1, #MG_OC.Description do
		draw.SimpleTextOutlined(MG_OC.Description[i], "moat_GunGameMedium", x, y + (i * 23), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
	end
end

function MG_OC.PrepRound()
	MG_OC.ResetVars()

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

	hook.Add("HUDPaint", "MG_OC_PREPPAINT", MG_OC.PrepPaint)
	hook.Add("TTTBeginRound", "MG_OC_BEGINHOOK", MG_OC.BeginRound)
end

function MG_OC.DrawHalos()
	if (GetRoundState() ~= ROUND_ACTIVE or MG_OC.GunGameOver) then
		hook.Remove("PreDrawHalos", "MG_OC_HALOS")
		return
	end

	local pls = {}

	for i = 1, #MG_OC.HaloPlayers do
		if (IsValid(MG_OC.HaloPlayers[i]) and MG_OC.HaloPlayers[i]:Team() ~= TEAM_SPEC) then
			local plyspn = MG_OC.HaloPlayers[i]:GetNW2Int("MG_OC_SPAWNPROTECTION")

    		if (plyspn and plyspn > CurTime()) then
        		continue
    		end

			table.insert(pls, MG_OC.HaloPlayers[i])
		end
	end

	halo.Add(pls, Color(0, 255, 255, 255), 2, 2, 1, true, true)
end

function MG_OC.BeginRound()
	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/stayin_alive.mp3")

	hook.Add("HUDPaint", "MG_OC_ACTIVEPAINT", MG_OC.ActivePaint)
	hook.Remove("TTTBeginRound", "MG_OC_BEGINHOOK")

	hook.Add("PreDrawHalos", "MG_OC_HALOS", MG_OC.DrawHalos)
end

function MG_OC.EndPaint()
	if (GetRoundState() ~= ROUND_ACTIVE) then
		hook.Remove("HUDPaint", "MG_OC_ENDPAINT")

		for k, v in pairs(MG_OC.TopAvatars) do
			v:Remove()
		end

		MG_OC.TopAvatars = {}
		return
	end

	draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	MG_OC.DrawBlurScreen(5)

	local text = "ONE IN THE CHAMBER OVER"
	local textc = Color(0, 255, 0)
	local textc2 = Color(0, 50, 0)

	surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))


	if (not MG_OC.PlayerInfo or #MG_OC.PlayerInfo < 1) then return end

	surface.SetFont("moat_BossInfo")
	local num = math.Clamp(#MG_OC.PlayerInfo, 1, 10)
	for i = 1, num do

		if (i == 1) then

			surface.SetFont("moat_BossInfo")
			local txt = "Top Player"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_OC.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_OC.PlayerInfo[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_OC.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2), 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]) then
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPos((ScrW()/2)-32, 155+(texth*3)-10)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPlayer(Entity(MG_OC.PlayerInfo[i][3]), 64)
			end
			
			continue
		elseif (i == 2) then

			surface.SetFont("moat_BossInfo")
			local txt = "2nd Place"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)-200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_OC.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_OC.PlayerInfo[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2)-200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_OC.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)-200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]) then
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPos((ScrW()/2)-232, 155+(texth*3)-10)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPlayer(Entity(MG_OC.PlayerInfo[i][3]), 64)
			end
			
			continue
		elseif (i == 3) then

			local txt = "3rd Place"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			surface.SetFont("moat_BossInfo")
			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)+200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_OC.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_OC.PlayerInfo[i][1], "moat_BossInfo2",(ScrW()/2)-(textw/2)+200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_OC.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_OC.cols[i]) then
				col = MG_OC.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)+200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]) then
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPos((ScrW()/2)+200-32, 155+(texth*3)-10)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_OC.TopAvatars[MG_OC.PlayerInfo[i][3]]:SetPlayer(Entity(MG_OC.PlayerInfo[i][3]), 64)
			end
			
			continue
		end

		local txt = MG_OC.PlayerInfo[i][1] .. ": " .. string.Comma(math.Round(MG_OC.PlayerInfo[i][2])) .. " Kills"
		local col = Color(255, 255, 255)
		if (MG_OC.cols[i]) then
			col = MG_OC.cols[i]
		end

		surface.SetFont("moat_BossInfo2")

		local textw, texth = surface.GetTextSize(txt)
		m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*(i+6)), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

function MG_OC.EndRound()
	MG_OC.GunGameOver = true
	MG_OC.HaloPlayers = {}
	MG_OC.PlayerInfo = net.ReadTable()
	table.sort(MG_OC.PlayerInfo, function(a, b) return a[2] > b[2] end)
	PrintTable(MG_OC.PlayerInfo)

	hook.Add("HUDPaint", "MG_OC_ENDPAINT", MG_OC.EndPaint)
end

function MG_OC.UpdateTopPlayer()
	local top = net.ReadString()
	local ks = net.ReadUInt(8)

	MG_OC.Top = {nick = top, rank = lad, kills = ks}
end

function MG_OC.IncreaseCurKills()
	MG_OC.CurKills = MG_OC.CurKills + 1
end

function MG_OC.IncreaseDeaths()
	MG_OC.CurDeaths = MG_OC.CurDeaths + 1
end

function MG_OC.HalosAdd()
	local tbl = net.ReadTable()

	MG_OC.HaloPlayers = tbl
end

--net.Receive("MG_OC_LADDER", MG_OC.UpdateNextWeapon
net.Receive("MG_OC_TOP", MG_OC.UpdateTopPlayer)
net.Receive("MG_OC_PREP", MG_OC.PrepRound)
net.Receive("MG_OC_END", MG_OC.EndRound)
net.Receive("MG_OC_KILLS", MG_OC.IncreaseCurKills)
net.Receive("MG_OC_DEATHS", MG_OC.IncreaseDeaths)
net.Receive("MG_OC_HALOS", MG_OC.HalosAdd)