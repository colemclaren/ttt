hook.Add("TTTWeaponVarsInitialized", "moat_InitializeWeapon", function(wep)
    if (wep:GetRealPrintName() ~= "") then
        wep.PrintName = wep:GetRealPrintName()
        wep.ItemName = wep.PrintName
    end
    
    for _, mod in pairs(MODS.Networked) do
        if (not mod.valid(wep)) then
            continue
        end

        mod.receive(wep)
    end

    local has_look = false

    if (MOAT_PAINT.Skins[wep:GetSkinID()]) then
        MOAT_LOADOUT.ApplySkin(wep, wep:GetSkinID())
        has_look = true
    end
    if (MOAT_PAINT.Paints[wep:GetPaintID()]) then
        MOAT_LOADOUT.ApplyPaint(wep, wep:GetPaintID())
        has_look = true
    elseif (MOAT_PAINT.Tints[wep:GetTintID()] or wep:GetPaintID() == -2) then
        MOAT_LOADOUT.ApplyTint(wep, wep:GetTintID())
        has_look = true
    end

    if (has_look) then
        function wep:PreDrawViewModel(vm, wpn, pl)
            PrePaintViewModel(wpn)
        end

        function wep:PostDrawViewModel(vm, wpn, pl)
            PostPaintViewModel(wpn)
        end
    end
end)