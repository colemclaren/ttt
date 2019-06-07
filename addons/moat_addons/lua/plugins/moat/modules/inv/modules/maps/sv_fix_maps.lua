local fixes = {
    ttt_innocentmotel_v1 = function()
        return {
            CreationIDs = {
                1550, 1551, 1593, 1594
            }
        }
    end
}

if (fixes[game.GetMap()]) then
    local data = fixes[game.GetMap()]()
    if (data.CreationIDs) then
        local eids = {}
        for _, v in pairs(data.CreationIDs) do
            eids[v] = true
        end
        hook.Add("OnEntityCreated", "Fix Map", function(e)
            timer.Simple(0, function()
                if (IsValid(e) and eids[e:MapCreationID()]) then
                    e:Remove()
                end
            end)
        end)
    end
end