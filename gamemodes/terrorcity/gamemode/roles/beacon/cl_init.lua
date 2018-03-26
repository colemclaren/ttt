net.Receive("tc_beacon_pos", function(len, ply)
    local data = EffectData()
    data:SetOrigin(net.ReadVector())
    util.Effect("beacon_lightning", data)
    print "reee?"
    EmitSound("ambient/atmosphere/thunder1.wav", data:GetOrigin(), 0, CHAN_STATIC, 1, 130)
end)
