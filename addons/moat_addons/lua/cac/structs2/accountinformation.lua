function CAC.AccountInformation.FromPlayer (player, accountInformation)
	accountInformation = accountInformation or CAC.AccountInformation ()
	
	accountInformation:SetSteamId     (player:SteamID   ())
	accountInformation:SetCommunityId (player:SteamID64 ())
	accountInformation:SetDisplayName (player:Name      ())
	
	return accountInformation
end