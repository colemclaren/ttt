local function DisableShadow(e)
    if (GetConVar "moat_EnableShadows":GetBool()) then
        return
    end

    e:DrawShadow(false)
end

local function DisableShadows()
    for _, ent in pairs(ents.GetAll()) do
        DisableShadow(ent)
    end
end


hook.Add("TTTEndRound", "moat_DisableShadows", DisableShadows)
hook.Add("TTTPrepareRound", "moat_DisableShadows", DisableShadows)
hook.Add("TTTBeginRound", "moat_DisableShadows", DisableShadows)
hook.Add("OnEntityCreated", "moat_DisableShadows", DisableShadow)
hook.Add("InitPostEntity", "moat_DisableShadows", DisableShadows)