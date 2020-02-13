local reload_mats = {
    ["!rm"] = true,
    ["/rm"] = true,
    ["!reloadmaterials"] = true,
    ["/reloadmaterials"] = true,
    ["!reloadmats"] = true,
    ["/reloadmats"] = true,
    ["!materials"] = true,
    ["/materials"] = true,
    ["!textures"] = true,
    ["/textures"] = true,
    ["!m"] = true,
    ["/m"] = true
}

hook.Add("PrePlayerChat", "Moat.ReloadMaterials", function(pl, txt)
    if (pl and IsValid(pl) and pl == LocalPlayer() and reload_mats[txt]) then
		RunConsoleCommand("mat_reloadtexture", "/")
		RunConsoleCommand("mat_reloadmaterial", "/")

        return true
    end
end)