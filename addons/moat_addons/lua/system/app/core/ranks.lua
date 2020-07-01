------------------------------------
--
-- 	Moat Ranks
--	
------------------------------------

moat.Ranks.Register(1, "user", "User")
	:SetColor {185, 187, 190, 0}
	:SetWeight(1)
	:ForumSync(3)

moat.Ranks.Register(2, "vip", "VIP")
	:SetColor {0, 255, 67}
	:SetIcon "icon16/shield.png"
	:SetFlags "+"
	:SetWeight(10)
	:ForumSync(23)

moat.Ranks.Register(3, "partner", "Moat Partner")
	:SetWeight(20)
	:ForumSync(24)
	:SetColor {255, 249, 30}
	:SetIcon "icon16/star.png"
	:SetFlags "+$"

moat.Ranks.Register(4, "bugboomer", "Bug Boomer")
	:SetWeight(30)
	:ForumSync(31)
	:SetColor {43, 255, 198}
	:SetIcon "icon16/bomb.png"
	:SetFlags "+"

moat.Ranks.Register(5, "trialstaff", "Trial Staff")
	:SetWeight(40)
	:ForumSync(9)
	:SetColor {0, 182, 255}
	:SetIcon "icon16/wand.png"
	:SetFlags "+T"

moat.Ranks.Register(6, "moderator", "Moderator")
	:SetWeight(50)
	:ForumSync(10)
	:SetColor {31, 139, 76}
	:SetIcon "icon16/wand.png"
	:SetFlags "+TM"

moat.Ranks.Register(7, "admin", "Administrator")
	:SetWeight(60)
	:ForumSync(11)
	:SetColor {155, 61, 255}
	:SetIcon "icon16/wand.png"
	:SetFlags "+TMA"

moat.Ranks.Register(8, "senioradmin", "Senior Administrator")
	:SetWeight(70)
	:ForumSync(12)
	:SetColor {203, 61, 255}
	:SetIcon "icon16/wand.png"
	:SetFlags "+TMAS"

moat.Ranks.Register(9, "headadmin", "Head Administrator")
	:SetWeight(80)
	:ForumSync(13)
	:SetColor {255, 51, 148}
	:SetIcon "icon16/wand.png"
	:SetFlags "+TMASH"

moat.Ranks.Register(10, "communitylead", "Community Lead")
	:SetWeight(90)
	:ForumSync(14)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/wrench.png"
	:SetFlags "*"

moat.Ranks.Register(11, "owner", "owner")
	:SetWeight(100)
	:ForumSync(25)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/tux.png"
	:SetFlags "*"

moat.Ranks.Register(12, "techartist", "Technical Artist")
	:SetWeight(35)
	:ForumSync(26)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/camera.png"
	:SetFlags "+TMA"

moat.Ranks.Register(13, "audioengineer", "Audio Engineer")
	:SetWeight(35)
	:ForumSync(27)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/bell.png"
	:SetFlags "+TMA"

moat.Ranks.Register(14, "softwareengineer", "Software Engineer")
	:SetWeight(35)
	:ForumSync(28)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/application_osx_terminal.png"
	:SetFlags "+TMA"

moat.Ranks.Register(15, "gamedesigner", "Game Designer")
	:SetWeight(35)
	:ForumSync(29)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/cog.png"
	:SetFlags "+TMA"

moat.Ranks.Register(16, "creativedirector", "Creative Director")
	:SetWeight(35)
	:ForumSync(30)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/weather_rain.png"
	:SetFlags "+TMA"