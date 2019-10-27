------------------------------------
--
-- 	Moat.GG Ranks
--	
------------------------------------

moat.Ranks.Register(1, "user", "User")
	:SetColor {185, 187, 190, 0}
	:SetWeight(1)
	:ForumSync(3)

moat.Ranks.Register(2, "vip", "VIP")
	:SetColor {0, 255, 67}
	:SetIcon "icon16/star.png"
	:SetFlags "+"
	:SetWeight(10)
	:ForumSync(23)

moat.Ranks.Register(3, "starplayer", "Star Player")
	:SetWeight(20)
	:ForumSync(24)
	:SetColor {255, 249, 30}
	:SetIcon "icon16/heart.png"
	:SetFlags "+$"

moat.Ranks.Register(4, "hoodninja", "Hood Ninja")
	:SetWeight(30)
	:ForumSync(8)
	:SetColor {103, 152, 235}
	:SetIcon "icon16/heart.png"
	:SetFlags "+"

moat.Ranks.Register(5, "trialstaff", "Trial Staff")
	:SetWeight(40)
	:ForumSync(9)
	:SetColor {0, 182, 255}
	:SetIcon "icon16/shield.png"
	:SetFlags "+T"

moat.Ranks.Register(6, "moderator","Moderator")
	:SetWeight(50)
	:ForumSync(10)
	:SetColor {31, 139, 76}
	:SetIcon "icon16/shield_add.png"
	:SetFlags "+TM"

moat.Ranks.Register(7, "admin", "Administrator")
	:SetWeight(60)
	:ForumSync(11)
	:SetColor {155, 61, 255}
	:SetIcon "icon16/lightning.png"
	:SetFlags "+TMA"

moat.Ranks.Register(8, "senioradmin", "Senior Administrator")
	:SetWeight(70)
	:ForumSync(12)
	:SetColor {203, 61, 255}
	:SetIcon "icon16/lightning_add.png"
	:SetFlags "+TMAS"

moat.Ranks.Register(9, "headadmin", "Head Administrator")
	:SetWeight(80)
	:ForumSync(13)
	:SetColor {255, 51, 148}
	:SetIcon "icon16/user_gray.png"
	:SetFlags "+TMASH"

moat.Ranks.Register(10, "operationslead", "Operations Lead")
	:SetWeight(90)
	:ForumSync(20)
	:SetColor {255, 51, 148}
	:SetIcon "icon16/user_gray.png"
	:SetFlags "+TMASH"

moat.Ranks.Register(11, "communitylead", "Community Lead")
	:SetWeight(100)
	:ForumSync(14)
	:SetColor {255, 51, 51}
	:SetIcon "icon16/application_xp_terminal.png"
	:SetFlags "*"