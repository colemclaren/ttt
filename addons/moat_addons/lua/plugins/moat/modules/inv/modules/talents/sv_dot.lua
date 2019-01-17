
local pl = FindMetaTable("Player")

function pl:ApplyDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    local id = dmgtype .. self:EntIndex() .. att:EntIndex()
    local wep = att:GetActiveWeapon()

    timer.Create(id, delay, reps, function()
        if (not IsValid(self) or self:Team() == TEAM_SPEC or not IsValid(att) or GetRoundState() ~= ROUND_ACTIVE) then
            timer.Remove(id)

            return
        end

        if (onhit) then
            onhit(self, att)
        end

        if (dmg and dmg > 0) then
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(dmg)
            dmginfo:SetAttacker(att)
			if (not IsValid(wep)) then wep = att end
            dmginfo:SetInflictor(wep)
            self:TakeDamageInfo(dmginfo)
        end
        
        if (timer.RepsLeft(id) < 1 and onend) then
            onend(self, att)
        end
    end)

    if (onstart) then
        onstart(self, att)
    end
end

function pl:IncreaseDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    local id = dmgtype .. self:EntIndex() .. att:EntIndex()
    local newreps = timer.RepsLeft(id) + reps
    local wep = att:GetActiveWeapon()

    net.Start("moat.dot.adjust")
    net.WriteString(id)
    net.WriteUInt(newreps * delay, 16)
    net.Send(self)

    timer.Adjust(id, delay, newreps, function()
		if (not IsValid(self) or self:Team() == TEAM_SPEC or not IsValid(att) or GetRoundState() ~= ROUND_ACTIVE) then
            timer.Remove(id)

            return
        end

        if (onhit) then
            onhit(self, att)
        end

        if (dmg and dmg > 0) then
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(dmg)
            dmginfo:SetAttacker(att)
			if (not IsValid(wep)) then wep = att end
            dmginfo:SetInflictor(wep)
            self:TakeDamageInfo(dmginfo)
        end
        
        if (timer.RepsLeft(id) < 1 and onend) then
            onend(self, att)
        end
    end)
end

function pl:ApplyDOT(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    if (GetRoundState() ~= ROUND_ACTIVE) then return end

    if (timer.Exists(dmgtype .. self:EntIndex() .. att:EntIndex())) then
        self:IncreaseDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    else
        self:ApplyDOTTimer(dmgtype, dmg, att, delay, reps, onhit, onstart, onend)
    end
end