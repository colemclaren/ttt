-- dev realms for code testing
-- called after realm config is loaded

if (true) then
	return
end

local function BuildCSVArgument(name, getter, stat)
    return {
        Name = name,
        Get = getter,
        StatIndex = stat
    }
end

local NamesToField = {}
for idx, mod in pairs(MODS.Networked) do
    NamesToField[mod.Name] = idx
end

local Fields = {}

local BaseWeaponCSVFields = {
    BuildCSVArgument("Name", function(w, i)
        return i and i.Name or w.PrintName
    end),
    BuildCSVArgument("Class", function(w)
        return w.ClassName
    end),
    BuildCSVArgument("Ammo Type", function(w)
        return w.Primary.Ammo
    end),
    BuildCSVArgument("Magazine", function(w)
        return w.Primary.ClipSize
    end),
    BuildCSVArgument("Recoil", function(w)
        return w.Primary.Recoil or 1.5
    end, "Kick"),
    BuildCSVArgument("Damage", function(w)
        return w.Primary.Damage
    end),
    BuildCSVArgument("Pellets", function(w)
        return w.Primary.NumShots or 1
    end),
    BuildCSVArgument("Delay", function(w)
        return w.ChargeSpeed or w.Primary.Delay
    end, "Firerate"),
    BuildCSVArgument("Cone", function(w)
        return w.Primary.Cone or 0.02
    end, "Accuracy"),
    BuildCSVArgument("Range", function(w, i)
        local RANGE_NUMBER = 30
        local optimal_range = w.Primary.Range

        if (not optimal_range) then
            if (w.Primary.Ammo and w.Primary.Ammo == "Buckshot") then
                optimal_range = 50 / Fields.Cone(w, i)
            else
                optimal_range = RANGE_NUMBER / Fields.Cone(w, i)
            end
        end

        return optimal_range
    end, "Range")
}

for _, field in pairs(BaseWeaponCSVFields) do
    Fields[field.Name] = function(w, i)
        local val = field.Get(w) 
        
        if (i and i.Stats and i.Stats[field.StatIndex or field.Name]) then
            local thing = MODS.Settable[NamesToField[field.StatIndex or field.Name]]
            if (thing) then
                print(field.StatIndex or field.Name)
                val = val * thing.getmult(i.Stats, 0)
            end
        end

        return val
    end
end

local function EscapeCSVField(x)
    if (type(x) == "number") then
        x = string.format("%.02f", x)
    end
    if (x:find "[\"\r\n,]" or x:find "^ " or x:find " $") then
        x = "\"" .. x:gsub("\"", "\"\"") .. "\""
    end
    return x
end

local function ProcessWeaponToCSV(f, wep, item)
    local data = {}
    for i, field in ipairs(BaseWeaponCSVFields) do
        data[i] = EscapeCSVField(Fields[field.Name](wep, item))
    end

    f:Write("\n" .. table.concat(data, ","))
end


concommand.Add("moat_export_base_weapons", function()
    local f = file.Open("base_weapons.csv.txt", "wb", "DATA")

    -- Header
    local data = {}
    for i, field in ipairs(BaseWeaponCSVFields) do
        data[i] = EscapeCSVField(field.Name)
    end

    f:Write(table.concat(data, ","))

    for _, wep in pairs(weapons.GetList()) do
        if (not wep.AutoSpawnable or wep.Base ~= "weapon_tttbase") then
            continue
        end

        ProcessWeaponToCSV(f, wep)
    end

    for _, item in pairs(MOAT_DROPTABLE) do
        if (item.Kind ~= "Unique") then
            continue
        end

        local wep = weapons.GetStored(item.WeaponClass)
        if (not wep or wep.AutoSpawnable) then
            continue
        end

        ProcessWeaponToCSV(f, wep, item)
    end

    f:Close()
end)