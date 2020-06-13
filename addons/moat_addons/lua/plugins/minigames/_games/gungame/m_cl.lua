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

MG_GG = MG_GG or {}
MG_GG.Top = {nick = nil, rank = 1, kills = 0}
MG_GG.CurRank = 1
MG_GG.CurKills = 0
MG_GG.Ladder = {
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
MG_GG.Description = {
	"Each player starts with the same gun. Kill other players",
	"to upgrade to the next weapon. First player to cycle",
	"through all of the weapons, wins!",
}
MG_GG.PlayerInfo = {}
MG_GG.Hooks = {}
MG_GG.TopAvatars = {}
MG_GG.GunGameOver = false
MG_GG.cols = {Color(255, 0, 0), Color(100, 255, 100), Color(100, 255, 100)}

function MG_GG.ResetVars()
	MG_GG.CurRank = 1
	MG_GG.Top = {nick = LocalPlayer():Nick(), rank = 1, kills = 0}
	MG_GG.PlayerInfo = {}
	MG_GG.TopAvatars = {}
	MG_GG.Hooks = {}
	MG_GG.GunGameOver = false
	MG_GG.CurKills = 0
end

local blur = Material("pp/blurscreen")

function MG_GG.DrawBlurScreen(amount)
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

function MG_GG.ActivePaint()
	if (GetRoundState() ~= ROUND_ACTIVE or MG_GG.GunGameOver) then
		hook.Remove("HUDPaint", "MG_GG_ACTIVEPAINT")
		return
	end

    local x = ScrW() / 2
    local y = 50

	draw.SimpleTextOutlined("Current Leader:", "moat_GunGameMedium", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	draw.SimpleTextOutlined(MG_GG.Top["nick"] or LocalPlayer():Nick(), "moat_GunGameMedium", x, y + 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	draw.SimpleTextOutlined(MG_GG.Top["kills"] .. " Kills", "moat_GunGameMedium", x, y + 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))

	draw.SimpleTextOutlined(MG_GG.CurKills .. " Kills", "moat_GunGameMedium", x, y + 150, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	if (MG_GG.CurRank < #MG_GG.Ladder) then
		draw.SimpleTextOutlined("Next Weapon:", "moat_GunGameMedium", x, y + 100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
		draw.SimpleTextOutlined(MG_GG.Ladder[MG_GG.CurRank+1][2], "moat_GunGameMedium", x, y + 125, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end

	local spawn_prot = LocalPlayer():GetNW2Int("MG_GG_SPAWNPROTECTION")

	if (spawn_prot and spawn_prot > CurTime()) then
		draw.SimpleTextOutlined("Spawn Protection: " .. math.ceil(spawn_prot - CurTime()), "moat_GunGameMedium", x, y + 200, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 35))
	end
end

function MG_GG.PrepPaint()
	if (GetRoundState() ~= ROUND_PREP) then
		hook.Remove("HUDPaint", "MG_GG_PREPPAINT")
		return
	end

	MG_GG.DrawBlurScreen(5)

    local x = ScrW() / 2
    local y = ScrH() / 2

    draw.SimpleTextOutlined("GUNGAME ROUND", "moat_GunGameLarge", x, y - 70, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

	draw.SimpleTextOutlined(math.ceil(GetGlobal("ttt_round_end") - CurTime()), "moat_GunGameLarge", x, y - 20, Color(0, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))

	for i = 1, #MG_GG.Description do
		draw.SimpleTextOutlined(MG_GG.Description[i], "moat_GunGameMedium", x, y + (i * 20), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, Color(0, 0, 0, 35))
	end
end

function MG_GG.PrepRound()
	MG_GG.ResetVars()

	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/boss_warning.mp3")

	hook.Add("HUDPaint", "MG_GG_PREPPAINT", MG_GG.PrepPaint)
	hook.Add("TTTBeginRound", "MG_GG_BEGINHOOK", MG_GG.BeginRound)
end

function MG_GG.BeginRound()
	cdn.PlayURL("https://static.moat.gg/servers/tttsounds/happy.mp3")

	hook.Add("HUDPaint", "MG_GG_ACTIVEPAINT", MG_GG.ActivePaint)
	hook.Remove("TTTBeginRound", "MG_GG_BEGINHOOK")
end

function MG_GG.EndPaint()
	if (GetRoundState() ~= ROUND_ACTIVE) then
		hook.Remove("HUDPaint", "MG_GG_ENDPAINT")

		for k, v in pairs(MG_GG.TopAvatars) do
			v:Remove()
		end

		MG_GG.TopAvatars = {}
		return
	end

	draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 100))

	MG_GG.DrawBlurScreen(5)

	local text = "GUNGAME ROUND OVER"
	local textc = Color(0, 255, 0)
	local textc2 = Color(0, 50, 0)

	surface.SetFont("moat_BossWarning")
	local textw, texth = surface.GetTextSize(text)

	m_DrawEnchantedText(text, "moat_BossWarning", (ScrW()/2)-(textw/2), 100, textc, textc2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local size_change = math.abs(math.sin((RealTime() - (1 * 0.1)) * 1.5))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100+texth+15, textw, 10, Color(255, 255, 255, 255*size_change))
	draw.RoundedBox(0, (ScrW()/2)-(textw/2), 100-25, textw, 10, Color(255, 255, 255, 255*size_change))


	if (not MG_GG.PlayerInfo or #MG_GG.PlayerInfo < 1) then return end

	surface.SetFont("moat_BossInfo")
	local num = math.Clamp(#MG_GG.PlayerInfo, 1, 10)
	for i = 1, num do

		if (i == 1) then

			surface.SetFont("moat_BossInfo")
			local txt = "Top Player"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2), 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_GG.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_GG.PlayerInfo[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_GG.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2), 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]) then
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPos((ScrW()/2)-32, 155+(texth*3)-10)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPlayer(Entity(MG_GG.PlayerInfo[i][3]), 64)
			end
			
			continue
		elseif (i == 2) then

			surface.SetFont("moat_BossInfo")
			local txt = "2nd Place"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)-200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_GG.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_GG.PlayerInfo[i][1], "moat_BossInfo2", (ScrW()/2)-(textw/2)-200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_GG.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)-200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]) then
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPos((ScrW()/2)-232, 155+(texth*3)-10)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPlayer(Entity(MG_GG.PlayerInfo[i][3]), 64)
			end
			
			continue
		elseif (i == 3) then

			local txt = "3rd Place"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			surface.SetFont("moat_BossInfo")
			local textw, texth = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo", (ScrW()/2)-(textw/2)+200, 155+(texth*1), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			surface.SetFont("moat_BossInfo2")
			local textw = surface.GetTextSize(MG_GG.PlayerInfo[i][1])
			m_DrawShadowedText(1, MG_GG.PlayerInfo[i][1], "moat_BossInfo2",(ScrW()/2)-(textw/2)+200, 155+(texth*2), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			local txt = string.Comma(math.Round(MG_GG.PlayerInfo[i][2])) .. " Kills"
			local col = Color(255, 255, 255)
			if (MG_GG.cols[i]) then
				col = MG_GG.cols[i]
			end

			surface.SetFont("moat_BossInfo2")
			local textw2 = surface.GetTextSize(txt)
			m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw2/2)+200, 155+(texth*3)+64, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			if (not MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]) then
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]] = vgui.Create("AvatarImage")
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPos((ScrW()/2)+200-32, 155+(texth*3)-10)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetSize(64, 64)
				MG_GG.TopAvatars[MG_GG.PlayerInfo[i][3]]:SetPlayer(Entity(MG_GG.PlayerInfo[i][3]), 64)
			end
			
			continue
		end

		local txt = MG_GG.PlayerInfo[i][1] .. ": " .. string.Comma(math.Round(MG_GG.PlayerInfo[i][2])) .. " Kills"
		local col = Color(255, 255, 255)
		if (MG_GG.cols[i]) then
			col = MG_GG.cols[i]
		end

		surface.SetFont("moat_BossInfo2")

		local textw, texth = surface.GetTextSize(txt)
		m_DrawShadowedText(1, txt, "moat_BossInfo2", (ScrW()/2)-(textw/2), 155+(texth*(i+6)), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

function MG_GG.EndRound()
	MG_GG.GunGameOver = true

	MG_GG.PlayerInfo = net.ReadTable()
	table.sort(MG_GG.PlayerInfo, function(a, b) return a[2] > b[2] end)
	PrintTable(MG_GG.PlayerInfo)

	hook.Add("HUDPaint", "MG_GG_ENDPAINT", MG_GG.EndPaint)
end

function MG_GG.UpdateTopPlayer()
	local top = net.ReadString()
	local lad = net.ReadUInt(5)
	local ks = net.ReadUInt(8)

	MG_GG.Top = {nick = top, rank = lad, kills = ks}
end

function MG_GG.UpdateNextWeapon()
	local rank = net.ReadUInt(5)

	MG_GG.CurRank = rank
end

function MG_GG.IncreaseCurKills()
	MG_GG.CurKills = MG_GG.CurKills + 1
end

net.Receive("MG_GG_LADDER", MG_GG.UpdateNextWeapon)
net.Receive("MG_GG_TOP", MG_GG.UpdateTopPlayer)
net.Receive("MG_GG_PREP", MG_GG.PrepRound)
net.Receive("MG_GG_END", MG_GG.EndRound)
net.Receive("MG_GG_KILLS", MG_GG.IncreaseCurKills)