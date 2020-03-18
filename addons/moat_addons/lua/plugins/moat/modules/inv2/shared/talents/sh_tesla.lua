local particle = "TeslaHitBoxes"
if CLIENT then
    net.Receive("TeslaEffect",function()
		local ent = net.ReadEntity()
        ent.Tesla = true
    end)

    hook.Add("TTTEndRound","ClearTesla",function()
        for k,v in ipairs(player.GetAll()) do
            v.Tesla = false
        end
    end)
    
    timer.Create("Tesla Effect",10,0,function()
        if MOAT_PH then return end
        for _,ply in ipairs(player.GetAll()) do
            if (ply.Tesla and IsValid(LocalPlayer()) and ply ~= LocalPlayer() and ply:Team() ~= TEAM_SPEC and not ply:IsDormant() and ply:Health() >= 1) then
                local pos = ply:GetPos() + Vector(0,0,50)
                local effect = EffectData()
                effect:SetOrigin(pos)
                effect:SetStart(pos)
                effect:SetMagnitude(5)
                effect:SetScale(2)
                effect:SetEntity(ply)
                for i =1,15 do
                    timer.Simple(0.09 * i,function()
                        if (not IsValid(ply) or ply:Team() == TEAM_SPEC) then
							return
						end

                        effect:SetOrigin(pos - Vector((i) * math.random(-1,1),i * math.random(-1,1),i))
                        util.Effect("TeslaHitBoxes",effect)
                    end)
                end
            end
        end
    end)
else
    util.AddNetworkString("TeslaEffect")
    function mg_tesla(ply)
        net.Start("TeslaEffect")
        net.WriteEntity(ply)
        net.Broadcast()
    end
end
