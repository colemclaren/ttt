moat.ranks.add "communitylead"
	:name "Community Lead"
	:color(Color(255, 0, 0))
	:weight(100)
	:dev(true)
	:flags "*"

moat.ranks.add "techlead"
	:name "Tech Lead"
	:color(Color(255, 0, 0))
	:weight(95)
	:dev(true)
	:flags "*"

moat.ranks.add "operationslead"
	:name "Operations Lead"
	:color(Color(255, 0, 0))
	:weight(90)
	:management(true)
	:flags "mtcahs"

moat.ranks.add "headadmin"
	:name "Head Administrator"
	:color(Color(51, 0, 51))
	:weight(35)
	:management(true)
	:flags "mtcahs"

moat.ranks.add "senioradmin"
	:name "Senior Administrator"
	:color(Color(102, 0, 102))
	:weight(30)
	:staff(true)
	:flags "mtcas"

moat.ranks.add "admin"
	:name "Administrator"
	:color(Color(102, 0, 204))
	:weight(25)
	:staff(true)
	:flags "mtca"

moat.ranks.add "moderator"
	:name "Moderator"
	:color(Color(0, 102, 0))
	:weight(20)
	:staff(true)
	:flags "mtc"

moat.ranks.add "trialstaff"
	:name "Trial Staff"
	:color(Color(51, 204, 255))
	:weight(15)
	:staff(true)
	:flags "tc"

moat.ranks.add "credibleclub"
	:name "Credible Club"
	:color(Color(255, 128, 0))
	:weight(10)
	:vip(true)
	:flags "c"

moat.ranks.add "vip"
	:name "VIP"
	:color(Color(0, 255, 0))
	:weight(5)
	:vip(true)
	:flags "c"

moat.ranks.add "user"
	:name "User"
	:weight(0)
	:flags ""