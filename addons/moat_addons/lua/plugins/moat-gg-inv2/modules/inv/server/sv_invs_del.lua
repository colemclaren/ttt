function m_RemoveInventoryItem(ply, _, class, crate)
    assert(_ == nil, "slot is deprecated")
    local ply_inv = MOAT_INVS[ply]

    for k, v in pairs(ply_inv) do
        if (type(v) == "table" and v.c == class) then
            ply:RemoveItem(class, function()
                local item_enum = MOAT_INVS[ply][k].u
                ply_inv[k] = mi:Blank()

                net.Start("Moat.RemInvItem")
                    net.WriteUInt(class, 32)
                net.Send(ply)

                if (crate and crate == 1) then return end
                hook.Run("PlayerDeconstructedItem", ply, item_enum)
            end)
            break
        end
    end
end

net.ReceiveNoLimit("Moat.RemInvItem", function(len, ply)
    local class = net.ReadUInt(32)
    local crate = net.ReadByte()

    if (crate and crate == 3) then ply.Deconing = true end
    if (crate and crate == 2) then ply.Deconing = false end

    m_RemoveInventoryItem(ply, nil, class, crate)
end)