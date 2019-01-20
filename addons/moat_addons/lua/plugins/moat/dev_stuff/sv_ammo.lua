concommand.Add("giveammo", function(pl, cmd, args)
	if (not moat.isdev(pl)) then
		return
	end

	for k, v in pairs(pl:GetWeapons()) do
        if (v.Primary.Ammo) then
            pl:GiveAmmo(args[1] or 999, v.Primary.Ammo)
        end
    end
end)