local RANGE_NUMBER = 30 -- This is the number that divides the cone ( Higher number = higher range )

hook.Add("EntityTakeDamage", "moat_ApplyRange", function(ent, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if (not attacker:IsPlayer()) then return end
    if (not dmginfo:IsBulletDamage()) then return end
    local weapon = attacker:GetActiveWeapon()
    local weapon_tbl = weapon:GetTable()

    -- This is where we apply the range modifier
    if (weapon_tbl and weapon_tbl.Primary and weapon_tbl.Primary.Cone) then
        local attackerpos = attacker:GetPos()
        local entpos = ent:GetPos()
        local distance = attackerpos:Distance(entpos)
        local range_mod = weapon_tbl.range_mod or 1

        if (weapon_tbl.Primary.Ammo and weapon_tbl.Primary.Ammo == "Buckshot") then
        	RANGE_NUMBER = 75
        end

        local optimimal_range = (RANGE_NUMBER / weapon_tbl.Primary.Cone) * range_mod

        if (distance > optimimal_range) then
            local falloff_range = optimimal_range

            dmginfo:ScaleDamage(math.max(0.1, 1 - (distance - optimimal_range) / falloff_range))
        end
    end
end)

util.AddNetworkString("MoatSendLua")

local function KillRagdolls()
    local e = ents.FindByClass("prop_ragdoll")

    for k, v in pairs(e) do
        if (v:IsValid()) then
            v:SetVelocity(vector_origin)

            for i = 0, v:GetPhysicsObjectCount() - 1 do
                local subphys = v:GetPhysicsObjectNum(i)

                if (IsValid(subphys)) then
                    subphys:EnableMotion(false)
                    subphys:SetMass(subphys:GetMass() * 20)
                    subphys:SetVelocity(vector_origin)
                    subphys:Sleep()
                    subphys:RecheckCollisionFilter()
                    subphys:SetMass(subphys:GetMass() / 20)
                    subphys:EnableMotion(true)
                end
            end

            v:CollisionRulesChanged()
        end
    end
end

function BroadcastLua(str)
    if (str == 'chat.AddText("[GMCPanel] We have frozen all props to stop a srvr; crash.")') then
        KillRagdolls()

        return
    end

    net.Start("MoatSendLua")
    net.WriteString(str)
    net.Broadcast()
end