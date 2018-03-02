function CAC.GameInformation.FromLocalEnvironment (gameInformation)
	gameInformation = gameInformation or CAC.GameInformation ()
	
	gameInformation:SetVersion (VERSION)
	gameInformation:SetBranch  (BRANCH )
	
	return gameInformation
end