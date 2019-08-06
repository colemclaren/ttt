
local LastTarget, LastTime

function GM:Think()
    local lp = LocalPlayer()
    if (not IsValid(lp)) then
        return
    end

	local tr = lp:GetEyeTrace()

	local ent = tr.Entity

	if (IsValid(ent) and ent:IsPlayer() and (LastTarget ~= ent or LastTime and LastTime < CurTime() - 1)) then
        LastTime = CurTime()
        net.Start "ttt_player_target"
            net.WriteEntity(ent)
        net.SendToServer()
    end
    if (not IsValid(LastTarget) or not LastTarget:IsPlayer()) then
        LastTime = nil
    end
    LastTarget = ent
end