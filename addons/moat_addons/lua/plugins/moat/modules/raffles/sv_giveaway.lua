function moat_DetermineRandomWinner()

    local tbl = {}

    for k, v in RandomPairs(player.GetAll()) do
        table.insert(tbl, v)
    end

    for i = 1, #tbl do
        if (i == #tbl) then timer.Simple(i, function() BroadcastLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 0, 255, 0 ), "]]..tbl[i]:Nick()..[[ is the winner!!!!" )]]) end) continue end
        timer.Simple(i, function() BroadcastLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "]]..tbl[i]:Nick()..[[" )]]) end)
    end

end

concommand.Add("moat_test_giveaway", function(ply)
    if (not moat.isdev(ply)) then return end

    moat_DetermineRandomWinner()

end)