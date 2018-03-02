print("Server Hit Reg Loaded")
local moat_val = tostring("m" .. string.char(math.random(97, 122)) .. math.Rand(-999999, 999999) .. string.char(math.random(97, 122)) .. string.char(math.random(97, 122)))
util.AddNetworkString("moatBulletTrace" .. moat_val)
util.AddNetworkString("moat_value")
util.AddNetworkString("moat_hitmarker")
util.AddNetworkString("moat_hitreg_command")
util.AddNetworkString("moat_damage_number")

hook.Add("PlayerInitialSpawn", "moat_charData", function(ply)
    net.Start("moat_value")
    net.WriteString(moat_val)
    net.Send(ply)
end)

timer.Simple(1, function()
    net.Start("moat_value")
    net.WriteString(moat_val)
    net.Broadcast()
end)

hook.Add("EntityTakeDamage", "moat_HitMarkers", function(ply, dmginfo)
    if (ply == dmginfo:GetAttacker()) then return end

    if (ply:IsPlayer() and dmginfo:GetDamage() > 0 and (GetRoundState() == ROUND_ACTIVE or GetRoundState() == ROUND_POST)) then
        local att = dmginfo:GetAttacker()

        if (dmginfo:IsBulletDamage()) then
            ply:SetNWInt("moat_JumpCooldown", CurTime() + MOAT_HITREG.CrouchJumpCooldown)
        end

        if (att:IsPlayer() and tobool(att:GetInfo("moat_hitmarkers"))) then
            net.Start("moat_hitmarker")
            net.Send(att)
        elseif (IsValid(att:GetOwner()) and att:GetOwner():IsPlayer() and tobool(att:GetOwner():GetInfo("moat_hitmarkers"))) then
            net.Start("moat_hitmarker")
            net.Send(att:GetOwner())
        end
    end
end)

net.Receive("moatBulletTrace" .. moat_val, function(len, ply)
    --local trace = net.ReadTable()
    local trace = {}
    trace.trEnt = net.ReadUInt(16)
    trace.trHGrp = net.ReadUInt(4)
    trace.trAtt = ply
    trace.dmgFor = net.ReadVector()
    trace.dmgPos = net.ReadVector()
    trace.dmgType = net.ReadUInt(32)
    trace.dmgInf = net.ReadUInt(16)
    if (not trace.trEnt) then return end
    trace.trEnt = Entity(trace.trEnt)
    if (not trace.dmgInf) then return end
    trace.dmgInf = Entity(trace.dmgInf)

    trace.dmgDmg = 0
    if (IsValid(trace.dmgInf)) then
        if (trace.dmgInf.Primary.Damage) then
            trace.dmgDmg = trace.dmgInf.Primary.Damage
        end
        if (trace.dmgInf.Kind and trace.dmgInf.Kind == WEAPON_MELEE) then
            return
        end
    end

    if (trace.trEnt:IsValid() and trace.trAtt:IsValid() and trace.trAtt:Ping() <= MOAT_HITREG.MaxPing) then
        local ent = trace.trEnt
        local hitgroup = trace.trHGrp
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(trace.trAtt)
        dmginfo:SetDamage(trace.dmgDmg)
        dmginfo:SetDamageForce(trace.dmgFor)
        dmginfo:SetDamagePosition(trace.dmgPos)
        dmginfo:SetDamageType(trace.dmgType)

        local wep = trace.trAtt:GetActiveWeapon()
        
        if (IsValid(trace.dmgInf)) then
            dmginfo:SetInflictor(trace.dmgInf)
        elseif (IsValid(wep)) then
            dmginfo:SetInflictor(wep)
        end

        dmginfo:SetDamageType(DMG_BULLET)

        dmginfo:SetDamageCustom(hitgroup)

        if (ent:IsPlayer()) then
            hook.Call("ScalePlayerDamage", GAMEMODE, trace.trEnt, hitgroup, dmginfo)
            if (ent:Alive() and MOAT_HITREG.AllowKillExchanging) then
                trace.trEnt:TakeDamageInfo(dmginfo)
            elseif (ent:Alive() and trace.trAtt:Alive() and not MOAT_HITREG.AllowKillExchanging) then
                trace.trEnt:TakeDamageInfo(dmginfo)
                if (tobool(trace.trAtt:GetInfo("moat_showdamagenumbers")) and GetRoundState() ~= ROUND_PREP) then
                    net.Start("moat_damage_number")
                    net.WriteUInt(math.Clamp(math.Round(dmginfo:GetDamage()), 1, 256), 8)
                    net.WriteUInt(hitgroup, 4)
                    net.WriteVector(trace.dmgPos)
                    net.Send(trace.trAtt)
                end
            end
        else
            trace.trEnt:TakeDamageInfo(dmginfo)
        end
    else
        trace.trAtt:ChatPrint("Your ping is too high for alternative hit registration!")
    end
end)

local function moat_ReplaceShootBullet()
    local BASE = weapons.GetStored("weapon_tttbase")
    if (not BASE) then return end

    -- replace default shootbullet function to fit the alternative hit reg
    function BASE:ShootBullet(dmg, recoil, numbul, cone)
        self:SendWeaponAnim(self.PrimaryAnim)
        self.Owner:MuzzleFlash()
        self.Owner:SetAnimation(PLAYER_ATTACK1)
        if not IsFirstTimePredicted() then return end
        local sights = self:GetIronsights()
        numbul = numbul or 1
        cone = cone or 0.01
        local bullet = {}
        bullet.Num = numbul
        bullet.Src = self.Owner:GetShootPos()
        bullet.Dir = self.Owner:GetAimVector()
        bullet.Spread = Vector(cone, cone, 0)
        bullet.Tracer = 4
        bullet.TracerName = self.Tracer or "Tracer"
        bullet.Force = 10

        if (tobool(self.Owner:GetInfo("moat_alt_hitreg")) and (self.Owner:Ping() <= MOAT_HITREG.MaxPing) and not m_ActiveBoss()) then
            bullet.Damage = 0
        else
            bullet.Damage = dmg
        end

        self.Owner:FireBullets(bullet)
        -- Owner can die after firebullets
        if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

        if ((game.SinglePlayer() and SERVER) or ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then
            -- reduce recoil if ironsighting
            recoil = sights and (recoil * 0.6) or recoil
            local eyeang = self.Owner:EyeAngles()
            eyeang.pitch = eyeang.pitch - recoil
            self.Owner:SetEyeAngles(eyeang)
        end
    end
end

timer.Simple(0, moat_ReplaceShootBullet)
hook.Add("Initialize", "moat_ReplaceBaseShoot", moat_ReplaceShootBullet)


hook.Add("PlayerSay", "moat_ChatCommand", function(ply, text, team)
    if (table.HasValue(MOAT_HITREG.ChatCommands, text) or table.HasValue(MOAT_HITREG.ChatCommands, text:lower())) then
        net.Start("moat_hitreg_command")
        net.Send(ply)

        return ""
    end
end)