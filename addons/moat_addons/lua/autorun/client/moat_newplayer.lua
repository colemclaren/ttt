local moat_new = CreateClientConVar("moat_new_player", "1", true, false)

if (moat_new:GetInt() == 1) then
	local color_black = Color(0, 0, 0)
	local color_red = Color(255, 0, 0)
	local color_yellow = Color(255, 255, 0)
	hook.Add("HUDPaint", "moat_PressIToOpenInventory", function()
		if (moat_new:GetInt() == 1) then
			draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), color_black)
			draw.SimpleText("Press I to open your inventory", "DermaLarge", ScrW()/2, ScrH()/2, color_yellow, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Right click your starter crates to open them!", "DermaLarge", ScrW()/2, (ScrH()/2) + 30, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.SimpleText("(Pressing I will remove this screen and you will never see it again)", "Trebuchet24", ScrW()/2, (ScrH()/2) + 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end)

	hook.Add("Think", "moat_PressIToOpenInventory", function()
		if (input.IsKeyDown(KEY_I) and moat_new:GetInt() == 1) then
			RunConsoleCommand("moat_new_player", "0")
		end
	end)

	local allowed = { ["CHudChat"] = true, ["CHudGMod"] = true, ["CHudWeaponSelection"] = true, ["CHudMenu"] = true }
	hook.Add("HUDShouldDraw", "moat_PressIToOpenInventoryHUDDraw", function(str) if not allowed[str] and moat_new:GetInt() == 1 then return false end end)
end