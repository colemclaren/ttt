local function RemoveChildren(ent)
    for i, e in pairs(ent:GetChildren()) do
        --print("Entity removed (child): "..e:GetClass())
        e:SetParent()
        e:Remove()
        RemoveChildren(e)
    end
end

hook.Add("EntityRemoved", "m_TryPreventCrash", RemoveChildren)