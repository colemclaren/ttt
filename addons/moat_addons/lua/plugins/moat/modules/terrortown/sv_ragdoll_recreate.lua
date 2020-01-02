
local ragdolls = {}
/*
hook.Add("EntityRemoved", "Ragdoll Recreate", function(e)
    if (not IsValid(e) or e.IsSafeToRemove or not e.PleaseRecreate or GetGlobalStr("MOAT_MINIGAME_ACTIVE", false)) then
        return
    end

    if (e.PleaseRecreate >= 5) then
        print "Ragdoll Recreate tried 5 times for ragdoll, giving up!"
        return
    end

    -- recreate
    local rag = ents.Create "prop_ragdoll"

    rag:SetPos(e:GetPos())
    rag:SetModel(e:GetModel())
    rag:SetAngles(e:GetAngles())
    rag:SetColor(e:GetColor())
    rag.CheckThisShit = true
    rag:SetCustomCollisionCheck(true)
    rag:Spawn()
    rag:Activate()

    
    CORPSE.SetPlayerNick(rag, CORPSE.GetPlayerNick(e))
    CORPSE.SetFound(rag, CORPSE.GetFound(e))
    CORPSE.SetCredits(rag, CORPSE.GetCredits(e))

    -- nonsolid to players, but can be picked up and shot
    rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	_RagdollStorageCount = _RagdollStorageCount and _RagdollStorageCount + 1 or 1
	_RagdollStorage[_RagdollStorageCount] = rag

    if IsValid(rag) then
        rag:CollisionRulesChanged()
    end

    for _, field in pairs { 
        "player_ragdoll", "sid", "uqid", "equipment", "was_role",
        "bomb_wire", "dmgtype", "dmgwep", "was_headshot", "time",
        "kills", "killer_sample", "scene", "trial"
    } do
        rag[field] = e[field]
    end

    for i = 0, rag:GetPhysicsObjectCount() - 1 do
        local bone = rag:GetPhysicsObjectNum(i)

        if IsValid(bone) then
            bone:SetPos(e:GetPos() + vector_up * 50)
            bone:SetAngles(angle_zero)

            -- not sure if this will work:
            bone:SetVelocity(vector_origin)
        end
    end

    rag.PleaseRecreate = e.PleaseRecreate + 1
end)
*/