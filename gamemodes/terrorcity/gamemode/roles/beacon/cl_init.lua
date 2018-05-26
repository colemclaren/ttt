net.Receive("tc_beacon_pos", function(len, ply)
	local vec = net.ReadVector()

	local data = EffectData()
	data:SetOrigin(vec)
	util.Effect("beacon_lightning", data)

    sound.PlayURL("https://i.moat.gg/DRx6h.mp3", "3d", function(snd)
        if (IsValid(snd)) then
            snd:SetPos(vec)
            snd:Set3DFadeDistance(8000, 1000000000)
            snd:Play()
        end
    end)
end)