local function s(t, k, m)
    t[k] = t[k] * m
end
local function getmult(k)
    return function(Stats, mult)
        return 1 + (Stats[k].min + (Stats[k].max - Stats[k].min) * mult) / 100
    end
end
local function sub_getmult(k)
    return function(Stats, mult)
        return 1 - (Stats[k].min + (Stats[k].max - Stats[k].min) * mult) / 100
    end
end

MODS = MODS or {}
MODS.Settable = {
    l = {valid = function() return true end, set = function() end, getmult = function() end},
    x = {valid = function() return true end, set = function() end, getmult = function() end},
    d = {
        valid = function(wep)
            return wep.Primary and wep.Primary.Damage
        end,
        set = function(wep, mult)
            s(wep.Primary, "Damage", mult)
        end,
        getmult = getmult "Damage",
        network = function(wep)
            wep:SetDamage(wep.Primary.Damage)
        end
    },
    k = {
        valid = function(wep)
            return wep.Primary and wep.Primary.Recoil
        end,
        set = function(wep, mult)
            s(wep.Primary, "Recoil", mult)
        end,
        getmult = getmult "Kick",
        network = function(wep)
            wep:SetRecoil(wep.Primary.Recoil)
        end
    },
    f = {
        valid = function(wep)
            return wep.Primary and wep.Primary.Delay
        end,
        set = function(wep, mult)
            s(wep.Primary, "Delay", mult)
        end,
        getmult = sub_getmult "Firerate"
    },
    m = {
        valid = function(wep)
            return wep.Primary and wep.Primary.ClipSize and wep.Primary.DefaultClip and wep.Primary.ClipMax
        end,
        set = function(wep, mult)
            wep.Primary.ClipSize = math.Round(wep.Primary.ClipSize * mult)
            wep.Primary.DefaultClip = wep.Primary.ClipSize
            wep.Primary.ClipMax = wep.Primary.DefaultClip * 3
        end,
        getmult = getmult "Magazine"
    },
    a = {
        valid = function(wep)
            return wep.Primary and (wep.Primary.Cone or wep.Primary.ConeX or wep.Primary.ConeY)
        end,
        set = function(wep, mult)
            local p = wep.Primary
            if (p.Cone) then
                s(p, "Cone", mult)
            end
            if (p.ConeX) then
                s(p, "ConeX", mult)
            end
            if (p.ConeY) then
                s(p, "ConeY", mult)
            end
        end,
        getmult = sub_getmult "Accuracy"
    },
    w = {
        valid = function()
            return true
        end,
        set = function(wep, mult)
            wep.weight_mod = mult
        end,
        getmult = getmult "Weight"
    },
    r = {
        valid = function()
            return true
        end,
        set = function(wep, mult)
            wep.range_mod = mult
        end,
        getmult = getmult "Range"
    },
    v = {
        valid = function(wep)
            return wep.PushForce
        end,
        set = function(wep, mult)
            s(wep, "PushForce", mult)
        end,
        getmult = getmult "Force"
    },
    p = {
        valid = function(wep)
            return wep.Secondary and wep.Secondary.Delay
        end,
        set = function(wep, mult)
            s(wep.Secondary, "Delay", mult)
        end,
        getmult = sub_getmult "Pushrate"
    },
    y = {
        valid = function(wep)
            return wep.Primary and wep.Primary.ClipSize and wep.Primary.ClipMax and wep.Primary.DefaultClip and wep.Primary.DefaultClip > -1
        end,
        set = function(wep, mult)
            s(wep, "ReloadSpeed", mult)
        end,
        getmult = getmult "Reloadrate"
    },
    z = {
        valid = function(wep)
            return true
        end,
        set = function(wep, mult)
            s(wep, "DeploySpeed", mult)
			wep:SetDeploySpeed(wep.DeploySpeed)
        end,
        getmult = getmult "Deployrate"
    }
}