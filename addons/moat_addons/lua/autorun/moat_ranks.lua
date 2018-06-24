MOAT_RANKS = MOAT_RANKS or {}
MOAT_RANKS["guest"] = {"", Color(255, 255, 255), true, false, false}
MOAT_RANKS["user"] = {"", Color(255, 255, 255), true, false, false}
MOAT_RANKS["vip"] = {"VIP", Color(0, 255, 0), true, true, false}
MOAT_RANKS["credibleclub"] = {"Credible Club", Color(255, 128, 0), true, true, false}
MOAT_RANKS["trialstaff"] = {"Trial Staff", Color(51, 204, 255), true, true, true}
MOAT_RANKS["moderator"] = {"Moderator", Color(0, 102, 0), true, true, true}
MOAT_RANKS["admin"] = {"Administrator", Color(102, 0, 204), true, true, true}
MOAT_RANKS["senioradmin"] = {"Senior Administrator", Color(102, 0, 102), true, true, true}
MOAT_RANKS["headadmin"] = {"Head Administrator", Color(51, 0, 51), true, true, true}
MOAT_RANKS["operationslead"] = {"Operations Lead", Color(255, 0, 0), true, true, true}
MOAT_RANKS["techlead"] = {"Tech Lead", Color(255, 0, 0), true, true, true}
MOAT_RANKS["communitylead"] = {"Community Lead", Color(255, 0, 0), true, true, true}

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


/* Tech Leads */
TECH_LEADS["76561198106061489"] 		= true 	-- footsies
COMMUNITY_LEADS["76561198106061489"] 	= true

TECH_LEADS["76561198050165746"] 		= true	-- meepen
COMMUNITY_LEADS["76561198050165746"] 	= true

TECH_LEADS["76561198154133184"] 		= true	-- velkon
COMMUNITY_LEADS["76561198154133184"] 	= true


/* Operation Leads */
OPERATION_LEADS["76561198009551777"] 	= true	-- poke
HEAD_ADMINS["76561198009551777"] 		= true

OPERATION_LEADS["76561198098542457"] 	= true	-- dante
HEAD_ADMINS["76561198098542457"] 		= true

OPERATION_LEADS["76561198039378503"] 	= true	-- george
HEAD_ADMINS["76561198039378503"] 		= true


/* Head Admins */
HEAD_ADMINS["76561198059864637"] 		= true	-- the suess
HEAD_ADMINS["76561198014504949"]		= true	-- zero