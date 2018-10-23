
local c = GetConVar "moat_alt_hitreg"
local b

hook.Add("EntityFireBullets", "‍a", function(e, t)
    if (not IsValid(t.Attacker) or t.Attacker ~= LocalPlayer() or not c:GetBool() or not IsFirstTimePredicted() or MOAT_ACTIVE_BOSS) then
        return
    end

    local cb = t.Callback

    local num = 1
    t.Callback = function(a, tr, d)
        if (d and tr.HitGroup and IsValid(tr.Entity)) then
            net.Start "shr"
                net.WriteUInt(b, 32)
                net.WriteBool(true)
                net.WriteEntity(tr.Entity)

                net.WriteVector(tr.StartPos)
                net.WriteVector(tr.HitPos)
                net.WriteVector(d:GetDamageForce())

                net.WriteUInt(tr.HitGroup, 4)
                net.WriteUInt(num, 8)
            net.SendToServer()
        else
            net.Start "shr"
                net.WriteUInt(b, 32)
                net.WriteBool(false)
            net.SendToServer()
        end

        num = num + 1

        if (cb) then
            return cb(a, tr, d)
        end
    end
    return true
end)

net.Receive("shr", function() b = net.ReadUInt(32) end)