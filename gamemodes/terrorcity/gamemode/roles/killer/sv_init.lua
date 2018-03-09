function ROLE:TTTBeginRound()
    local count = 0
    for i, p in pairs(player.GetAll()) do
        if (p:IsActive()) then
            count = count + 1
        end
    end

    for k, wep in pairs(self:GetWeapons()) do
        local pammo = wep:GetPrimaryAmmoType()
        self:GiveAmmo(wep:GetMaxClip1() * math.floor(count / 2), pammo)
        print(pammo,wep:GetMaxClip1())
    end
end