local hud_convar = GetConVar "moat_DisableCustomHUD"
hook.Add("HUDPaint", "menuDemoMode", function()
	if (not hud_convar) then
		hud_convar = GetConVar "moat_DisableCustomHUD"
	
		if (not hud_convar) then
			return
		end
	end

	if (hud_convar:GetInt() > 1) then
		--draw.WebImage(hud_convar:GetInt() == 2 and "https://cdn.moat.gg/f/4mwRXg.png" or "https://cdn.moat.gg/f/jryUE3.png", 0, 0, 2048, 2048)
	end
end)