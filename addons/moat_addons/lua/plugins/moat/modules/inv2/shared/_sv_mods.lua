local mt = {
    __index = {
        ValidForWeapon = function()
            return true
        end,
        GetFromStats = function(self, Stats, mult)
            local Stat = Stats[self.Name]
            local min, max
            if (Stat) then
                min, max = Stat.min, Stat.max
            else
                min, max = 0, 0
            end
            return min + (max - min) * mult
        end,
        Get = function(self, wep)
            return wep["Get" .. self.FunctionName](wep)
        end,
        Set = function(self, wep, val)
            wep["Set" .. self.FunctionName](wep, val)
        end
    }
}

local Validities = {
    d = function(wep)
        return wep.Primary and wep.Primary.Damage
    end,
    k = function(wep)
        return wep.Primary and wep.Primary.Recoil
    end,
    f = function(wep)
        return wep.Primary and wep.Primary.Delay
    end,
    m = function(wep)
        return wep.Primary and wep.Primary.ClipSize and wep.Primary.ClipSize ~= -1
    end,
    a = function(wep)
        return wep.Primary and (wep.Primary.Cone or wep.Primary.ConeX or wep.Primary.ConeY)
    end,
    v = function(wep)
        return wep.PushForce
    end,
    p = function(wep)
        return wep.Secondary and wep.Secondary.Delay
    end,
    n = function(wep)
        return wep.Primary and wep.Primary.ClipSize and wep.Primary.ClipMax and wep.Primary.DefaultClip and wep.Primary.DefaultClip > -1
    end,
    y = function(wep)
        return wep.ReloadSpeed
    end,
    z = function(wep)
        return wep.DeploySpeed
    end,
    c = function(wep)
        return wep.ChargeSpeed
    end
}

for id, MOD in pairs(MODS.Accessors) do
    if (Validities[id]) then
        MOD.ValidForWeapon = function(self, wep)
            return Validities[id](wep)
        end
    else
        print("No validity for id" .. id)
    end
    setmetatable(MOD, mt)
end