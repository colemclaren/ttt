MODS = MODS or {
    Accessors = {}
}

local mt = {}

local function Accessor(internal, name, type, callback, default, fnname)
    MODS.Accessors[internal] = {
        Internal = internal,
        Name = name,
        FunctionName = fnname or name,
        Type = type,
        Callback = callback or function() end,
        Default = default or 0
    }
end

Accessor("l", "Level", "Int")
Accessor("x", "XP", "Int")
Accessor("k", "Kick", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.k = wep._Cached.k or wep.Primary.Recoil

    wep.Primary.Recoil = wep.Primary.Recoil * (1 + wep:GetKick() / 100)
end)
Accessor("f",  "Firerate",  "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.f = wep._Cached.f or {
        Delay = wep.Primary.Delay
    }

    wep.Primary.Delay = wep._Cached.f.Delay * (1 - wep:GetFirerate() / 100)
end)
Accessor("d", "Damage", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.d = wep._Cached.d or {
        Damage = wep.Primary.Damage
    }

    wep.Primary.Damage = math.Round(wep._Cached.d.Damage * (1 + wep:GetDamage() / 100), 1)
end)
Accessor("r", "Range", "Double")
Accessor("w", "Weight", "Double", nil, nil, "WeightMod")
Accessor("v", "Force", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.v = wep._Cached.v or wep.PushForce or 1
    wep.PushForce = wep._Cached.v * (1 + wep:GetPushForceMod() / 100)
end, nil, "PushForceMod")
Accessor("p", "Pushrate", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.p = wep._Cached.p or wep.Secondary.Delay
    wep.Secondary.Delay = wep._Cached.p * (1 - wep:GetPushRateMod() / 100)
end, nil, "PushRateMod")
Accessor("a", "Accuracy", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.a = wep._Cached.a or {
        Cone = wep.Primary.Cone,
        ConeX = wep.Primary.ConeX,
        ConeY = wep.Primary.ConeY
    }

    local mult = 1 - wep:GetAccuracy() / 100

    wep.Primary.Cone = wep._Cached.a.Cone * mult
    if (wep.Primary.ConeX) then
        wep.Primary.ConeX = wep._Cached.a.ConeX * mult
    end
    if (wep.Primary.ConeY) then
        wep.Primary.ConeY = wep._Cached.a.ConeY * mult
    end
end)
Accessor("y", "Reloadrate", "Double")
Accessor("c", "Chargerate", "Double")
Accessor("z", "Deployrate", "Double", function(self, wep)
    self._Cached = self._Cached or {}
    self._Cached.z = self._Cached.z or wep.DeploySpeed

    wep:SetDeploySpeed(self._Cached.z * (1 + wep:GetDeployrate() / 100))
end)
Accessor("m", "Magazine", "Double", function(self, wep)
    wep._Cached = wep._Cached or {}
    wep._Cached.m = wep._Cached.m or {
        ClipSize = wep.Primary.ClipSize,
        DefaultClip = wep.Primary.DefaultClip,
        ClipMax = wep.Primary.ClipMax
    }

    local mult = wep:GetMagazine() / 100 + 1

    local ClipSize = wep._Cached.m.ClipSize
    wep.Primary.ClipSize = math.Round(ClipSize * mult)
    wep.Primary.DefaultClip = wep.Primary.ClipSize
    wep.Primary.ClipMax = wep.Primary.ClipSize * 3
end)

function MODS.UpdateCosmetics(self, wep)
	if (SERVER) then
        return
    end

	if (not wep.ItemStats) then
		wep.ItemStats = {}
	end

	local has_look = false
    if (MOAT_PAINT.Paints[wep:GetPaintID()]) then
        MOAT_LOADOUT.ApplyPaint(wep, wep:GetPaintID())
		wep.ItemStats.p2 = wep:GetPaintID()
        has_look = true
    elseif (MOAT_PAINT.Tints[wep:GetTintID()] or wep:GetPaintID() == -2 and wep:GetTintID() ~= -1) then
        MOAT_LOADOUT.ApplyTint(wep, wep:GetTintID())
		wep.ItemStats.p = wep:GetTintID()
        has_look = true
    end

    if (MOAT_PAINT.Skins[wep:GetSkinID()]) then
        MOAT_LOADOUT.ApplySkin(wep, wep:GetSkinID())
		wep.ItemStats.p3 = wep:GetSkinID()
        has_look = true
    end

    if (has_look) then
        MOAT_LOADOUT.UpdateDrawViewModel(wep)
    end
end

Accessor("p0", "PaintID", "Int", MODS.UpdateCosmetics, -1)
Accessor("p1", "TintID", "Int", MODS.UpdateCosmetics, -1)
Accessor("p2", "SkinID", "Int", MODS.UpdateCosmetics, -1)
Accessor("n", "RealPrintName", "String", function(self, wep)
    wep.ItemName = wep:GetRealPrintName()
    wep.PrintName = wep.ItemName
end)

if (SERVER) then
    include "_sv_mods.lua"
end