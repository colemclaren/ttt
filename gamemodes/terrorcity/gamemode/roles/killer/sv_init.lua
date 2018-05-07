

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
    end

    self:GiveEquipmentItem(EQUIP_ARMOR)
    self.SK_Kills = 0
end

local rewards = {
    EQUIP_RADAR,
    EQUIP_HERMES_BOOTS
}


InstallRoleHook("PlayerDeath", 3)
function ROLE:PlayerDeath(vic, inflic, attac)
    self.SK_Kills = self.SK_Kills + 1
    local k = self.SK_Kills
    print(k)
    if (rewards[k]) then
        self:GiveEquipmentItem(rewards[k])
        net.Start("TTT_BoughtItem")
        net.WriteBit(1)
        net.WriteUInt(rewards[k], 16)
        net.Send(self)
    else
        for _, wep in RandomPairs(weapons.GetList()) do
            local wepclass = wep.ClassName
            if (wep.CanBuy and table.HasValue(wep.CanBuy, ROLE_TRAITOR) and not self:HasWeapon(wepclass)) then
                self:Give(wepclass)
                if (self:HasWeapon(wepclass)) then
                    break
                end
            end
        end
    end
end

InstallRoleHook("ScalePlayerDamage", 1)
function ROLE:ScalePlayerDamage(ply, hitgroup, dmginfo)
    local atk = dmginfo:GetAttacker()
    dmginfo:ScaleDamage(IsValid(atk) and atk:IsPlayer() and atk:IsTraitor() and 0.75 or 0.9)
end