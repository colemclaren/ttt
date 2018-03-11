speed = {}

function speed.SetGlobalSpeedMultiplierAddend(n)
    SetGlobalFloat("global_speed_mul_addend", n)
end


local function HasHermesBootsActive(ply)
    return ply:HasEquipmentItem(EQUIP_HERMES_BOOTS) and (SERVER and ply:GetInfo("moat_hermes_boots") == "1" or GetConVar "moat_hermes_boots":GetString() == "1")
end

hook.Add("TTTPlayerSpeedModifier", "Moat_PlayerSpeed", function(ply, slowed, mv, multbl)
    local curmul = multbl[1] + GetGlobalFloat "global_speed_mul_addend"

    if (HasHermesBootsActive(ply)) then
        curmul = curmul + 0.3
    end

    local wep = ply:GetActiveWeapon()

    curmul = curmul + 1 - wep:GetNWFloat("weight_mod", 1)

    curmul = curmul + ply:GetNWFloat("SpeedModAddend", 0)

    curmul = curmul + 1 - ply:GetNWFloat("speedforce", 1)

    if (ply:canBeMoatFrozen()) then
        curmul = curmul - ply:GetNWFloat("moatFrozenSpeed", 0)
    end

    curmul = curmul + ply:GetNWFloat("marathon_runner", 0)

    multbl[1] = curmul
end, hook.Priority.NO_RETURN)