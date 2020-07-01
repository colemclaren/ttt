MOAT_RANKS = MOAT_RANKS or {}
MOAT_RANKS["guest"] = {"", Color(185, 187, 190), true, false, false}
MOAT_RANKS["user"] = {"", Color(255, 255, 255), true, false, false}
MOAT_RANKS["vip"] = {"VIP", Color(0, 255, 67), true, true, false}
MOAT_RANKS["partner"] = {"Moat Partner", Color(255, 249, 30), true, true, false}
MOAT_RANKS["bugboomer"] = {"Bug Boomer", Color(43, 255, 198), true, true, false}
MOAT_RANKS["trialstaff"] = {"Trial Staff", Color(0, 182, 255), true, true, true}
MOAT_RANKS["moderator"] = {"Moderator", Color(31, 139, 76), true, true, true}
MOAT_RANKS["admin"] = {"Administrator", Color(155, 61, 255), true, true, true}
MOAT_RANKS["senioradmin"] = {"Senior Administrator", Color(203, 61, 255), true, true, true}
MOAT_RANKS["headadmin"] = {"Head Administrator", Color(255, 51, 148), true, true, true}
MOAT_RANKS["operationslead"] = {"Operations Lead", Color(255, 51, 148), true, true, true}
MOAT_RANKS["techlead"] = {"Tech Lead", Color(255, 51, 51), true, true, true}
MOAT_RANKS["communitylead"] = {"Community Lead", Color(255, 51, 51), true, true, true}
MOAT_RANKS["owner"] = {"owner", Color(255, 51, 51), true, true, true}
MOAT_RANKS["techartist"] = {"Technical Artist", Color(255, 51, 51), true, true, true}
MOAT_RANKS["audioengineer"] = {"Audio Engineer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["softwareengineer"] = {"Software Engineer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["gamedesigner"] = {"Game Designer", Color(255, 51, 51), true, true, true}
MOAT_RANKS["creativedirector"] = {"Creative Director", Color(255, 51, 51), true, true, true}

MOAT_RANKS["communitylead"].check = true
MOAT_RANKS["techlead"].check = true
MOAT_RANKS["operationslead"].check = true
MOAT_RANKS["headadmin"].check = true

COMMUNITY_LEADS 	= 	COMMUNITY_LEADS or {}
TECH_LEADS 			= 	TECH_LEADS or {}
OPERATION_LEADS 	= 	OPERATION_LEADS or {}
HEAD_ADMINS 		= 	HEAD_ADMINS or {}


/* Community Leads */
COMMUNITY_LEADS["76561198053381832"] 	= true 	-- motato
COMMUNITY_LEADS["76561198109932241"] 	= true 	-- jerry

COMMUNITY_LEADS["76561198245961734"] 	= true 	-- malk
COMMUNITY_LEADS["76561198032375101"] 	= true 	-- leo
HEAD_ADMINS["76561198000900511"] 	= true 	-- leo
HEAD_ADMINS["76561198059864637"] 	= true 	-- siess
/* Tech Leads */
-- TECH_LEADS["76561198106061489"] 		= true 	-- footsies
-- COMMUNITY_LEADS["76561198106061489"] 	= true

-- TECH_LEADS["76561198050165746"] 		= true	-- moat
COMMUNITY_LEADS["76561198050165746"] 	= true

-- TECH_LEADS["76561198154133184"] 		= true	-- velkon
COMMUNITY_LEADS["76561198154133184"] 	= true

-- TECH_LEADS["76561198044542936"] 		= true	-- ling
COMMUNITY_LEADS["76561198044542936"] 	= true

/* Operation Leads */
-- OPERATION_LEADS["76561198009551777"] 	= true	-- poke
-- HEAD_ADMINS["76561198009551777"] 		= true

-- OPERATION_LEADS["76561198039378503"] 	= true	-- george
-- HEAD_ADMINS["76561198039378503"] 		= true


/* Head Admins */
-- HEAD_ADMINS["76561198014504949"]		= true	-- zero
HEAD_ADMINS["76561198245961734"]        = true  -- leo
HEAD_ADMINS["76561198127043333"]        = true  -- jam