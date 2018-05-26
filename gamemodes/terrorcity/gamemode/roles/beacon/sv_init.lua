InstallRoleHook("DoPlayerDeath", 1)

util.AddNetworkString "tc_beacon_pos"

function ROLE:DoPlayerDeath()
    CustomMsg(nil, "The beacon has parished!", Color(255, 200, 0))
	if (not IsValid(self)) then return end

    net.Start "tc_beacon_pos"
        net.WriteVector(self:GetPos())
    net.Broadcast()
end