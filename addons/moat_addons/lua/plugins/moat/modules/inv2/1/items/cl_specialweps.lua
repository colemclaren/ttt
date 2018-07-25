local propspec_outline = Material("models/props_combine/portalball001_sheet")

hook.Add("PostDrawTranslucentRenderables", "moat_DrawLegendEffects", function()
    cam.Start3D(EyePos(), EyeAngles())
    render.MaterialOverride(propspec_outline)
    render.SuppressEngineLighting(true)
    render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)

    for i = 1, #MOAT_SPECIAL_WEAPONS do
        if (not MOAT_SPECIAL_WEAPONS[i]:IsValid() or not IsValid(MOAT_SPECIAL_WEAPONS[i])) then continue end
        MOAT_SPECIAL_WEAPONS[i]:SetModelScale(1.05, 0)
        MOAT_SPECIAL_WEAPONS[i]:DrawModel()
    end

    render.SetColorModulation(1, 1, 1)
    render.SuppressEngineLighting(false)
    render.MaterialOverride(nil)
    cam.End3D()
end)

hook.Add("PostDrawViewModel", "moat_DrawLegendEffectsViewModel", function(ent, pl, wpn)
    if (MOAT_SPECIAL_WEAPONS and MOAT_SPECIAL_WEAPONS[wpn]) then
        if (not wpn.SheetEffect or not wpn.SheetEffect:IsValid()) then
            wpn.SheetEffect = ClientsideModel(wpn:GetWeaponViewModel(), RENDERGROUP_TRANSLUCENT)
            wpn.SheetEffect:AddEffects(EF_BONEMERGE)
        end

        wpn.SheetEffect:SetParent(ent)
        wpn.SheetEffect:SetNoDraw(true)
        wpn.SheetEffect:SetCycle(ent:GetCycle())
        wpn.SheetEffect:SetSequence(ent:GetSequence())
        local ang = ent:GetAngles()
        local pos = ent:GetPos() + (pl:EyeAngles():Right() * -0.01) + pl:GetAimVector() * -0.01
        render.MaterialOverride(propspec_outline)
        render.SetColorModulation(rarity_names[9][2].r / 255, rarity_names[9][2].g / 255, rarity_names[9][2].b / 255)
        wpn.SheetEffect:DrawModel()
        render.SetColorModulation(1, 1, 1)
        render.MaterialOverride(nil)
    end
end)