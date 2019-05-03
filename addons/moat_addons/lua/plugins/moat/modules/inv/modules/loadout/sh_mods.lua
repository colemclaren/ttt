local invalids = {
    Float = -math.huge,
    String = "",
    Int = 0x7fffffff
}

local function build(name, getter, Type, internal, always_valid)
    return {
        network = function(wep)
            return wep["Set" .. name](wep, getter(wep)[internal or name] or invalids[Type])
        end,
        valid = function(wep)
            return always_valid or (pcall(getter, wep)) and getter(wep) and getter(wep)[internal or name] or false
        end,
        receive = function(wep)
            if (wep["Get" .. name](wep) == invalids[Type]) then
                return
            end

            getter(wep)[internal or name] = wep["Get" .. name](wep)
        end,
        Name = name,
        Type = Type
    }
end

MODS = MODS or {}
MODS.Invalids = invalids
MODS.Networked = {
    k = build("Kick", function(w) return w.Primary end, "Float"),
    f = build("Firerate", function(w) return w.Primary end, "Float", "Delay"),
    d = build("Damage", function(w) return w.Primary end, "Float"),
    r = build("Range", function(w) return w end, "Float", "range_mod", true),
    w = build("Weight", function(w) return w end, "Float", "weight_mod", true),
    v = build("PushForce", function(w) return w end, "Float"),
    p = build("Pushrate", function(w) return w.Secondary end, "Float", "Delay"),
    a = build("Accuracy", function(w) return w.Primary end, "Float", "Cone"),
    a1 = build("AccuracyX", function(w) return w.Primary end, "Float", "ConeX"),
    a2 = build("AccuracyY", function(w) return w.Primary end, "Float", "ConeY"),
    m = {
        network = function(wep)
            return wep:SetMagazine(wep.Primary.ClipSize or invalids.Float)
        end,
        valid = function(wep)
            return wep.Primary and wep.Primary.ClipSize and wep.Primary.ClipSize > 0
        end,
        receive = function(wep)
            if (wep:GetMagazine() == invalids[Type]) then
                return
            end

            wep.Primary.ClipSize = wep:GetMagazine()
            wep.Primary.DefaultClip = wep.Primary.ClipSize
            wep.Primary.ClipMax = wep.Primary.DefaultClip * 3
        end,
        Name = "Magazine",
        Type = "Float"
    }
}


hook.Add("TTTInitializeWeaponVars", "moat_InitializeWeapon", function(wep)
    wep:NetworkVar("String", nil, "RealPrintName")
    wep:NetworkVar("Int", nil, "PaintID", nil, invalids.Int)
    wep:NetworkVar("Int", nil, "TintID", nil, invalids.Int)
    wep:NetworkVar("Int", nil, "SkinID", nil, invalids.Int)

    for _, mod in pairs(MODS.Networked) do
        wep:NetworkVar(mod.Type, nil, mod.Name, nil, invalids[mod.Type])
    end
end)

