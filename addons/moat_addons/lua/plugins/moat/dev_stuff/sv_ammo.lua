concommand.Add("giveammo", function(ply, cmd, args)
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	for k, v in pairs(ply:GetWeapons()) do
        if (v.Primary.Ammo) then
            ply:GiveAmmo(999, v.Primary.Ammo)
        end
    end
end)