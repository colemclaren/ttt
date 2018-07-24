hook.Add("TTTPrepareRound", "TTT_PortableTester_FIX", function()
    for k, v in pairs(player.GetAll()) do
        v.Tested = false
    end
end)