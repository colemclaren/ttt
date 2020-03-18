mlogs.Colors = mlogs.Colors or {}
mlogs.Colors.White 		= Color(255, 255, 255, 255)
mlogs.Colors.Green 		= Color(0, 255, 0, 255)
mlogs.Colors.Blue 		= Color(51, 153, 255, 255)
mlogs.Colors.Cyan 		= Color(0, 200, 255, 255)
mlogs.Colors.Pink 		= Color(255, 0, 255, 255)
mlogs.Colors.Red 		= Color(255, 0, 0, 255)
mlogs.Colors.Black 		= Color(0, 0, 0, 255)
mlogs.Colors.LightRed 	= Color(255, 100, 100, 255)

mlogs.Colors.moat_white = Color(255, 255, 255, 255)
mlogs.Colors.moat_green = Color(0, 255, 0, 255)
mlogs.Colors.moat_blue = Color(51, 153, 255, 255)
mlogs.Colors.moat_cyan = Color(0, 200, 255, 255)
mlogs.Colors.moat_pink = Color(255, 0, 255, 255)
mlogs.Colors.moat_red = Color(255, 0, 0, 255)

function mlogs:Print(msg, stopnl)
	MsgC(self.Colors.Red, "mLogs", self.Colors.Green, " | ", msg)
	if (stopnl) then return end
	MsgC "\n"
end

local border = "=================================="
function mlogs:PrintH(msg)
	self:Print(border)
	self:Print(msg)
	self:Print(border)
end

MLOG_DAMAGE 		= 0
MLOG_OTHER 			= 1
MLOG_SHOTS 			= 2
MLOG_PLAYER 		= 3
MLOG_PLAYERS 		= 4
MLOG_WITNESS 		= 5

MLOGS_WITNESS 		= 0
MLOGS_SWITCH_TO 	= 1
MLOGS_SWITCH_FROM	= 2
MLOGS_FIRE			= 3

/*
local e = {}
e.EVENT_PLY_WITNESS 	= 0
e.EVENT_PLY_SWITCH 		= 1 P1 W1
e.EVENT_PLY_SHOT 		= 2 P1 W1

e.EVENT_AUTOSLAY 		= 3 P1
e.EVENT_BODY_FOUND 		= 4 P1 P2
e.EVENT_CREDITS_FOUND 	= 5 P1 P2 N

e.EVENT_C4_PLANT		= 6 P1
e.EVENT_C4_ARM 			= 7 P1 P2 N
e.EVENT_C4_DISARM 		= 8 P1 P2
e.EVENT_C4_DESTROY 		= 9 P1 P2
e.EVENT_C4_PICKUP 		= 10 P1 P2
e.EVENT_C4_EXPLODE 		= 11 P1 P2

e.EVENT_CREDITS_GIVE	= 12 P1 P2 N
e.EVENT_CREDITS_GET		= 13 P1 N

e.EVENT_DNA_FOUND		= 14 P1 P2
e.EVENT_DNA_SCAN		= 15 P1 P2
e.EVENT_DET_REQ			= 16 P1 P2

e.EVENT_PLY_HURT		= 17 P1 P2 W1 N

e.EVENT_PLY_HURT		= 17 
e.EVENT_PLY_DROWN		= 18
e.EVENT_PLY_FALL		= 19
e.EVENT_PLY_PUSH		= 20

e.EVENT_PLY_HEAL		= 21 P1 N
e.EVENT_PLY_KILL		= 22 P1 P2 W1

e.EVENT_PLY_TBUTTON		= 23 P1 ST
e.EVENT_PLY_TELEPORT	= 24 P1
e.EVENT_PLY_USE			= 25 P1 W1

e.EVENT_PLY_NADE_USE	= 26 P1 W1
e.EVENT_PLY_NADE_THROW	= 27 P1 W1
e.EVENT_PLY_NADE_IMPACT	= 28 P1 W1

e.EVENT_PLY_SUICIDE		= 29

e.EVENT_PLY_RADIO		= 30
e.EVENT_PLY_KOS			= 31
e.EVENT_PLY_CHAT		= 32
e.EVENT_PLY_VOICE		= 33

e.EVENT_PLY_ORDER		= 34
e.EVENT_WACKY			= 35
e.EVENT_SEE_UNID		= 36
e.EVENT_WALK_UNID		= 37

e.EVENT_PLY_MAGNETO		= 38
e.EVENT_PLY_HANG		= 39
e.EVENT_PLY_THROW		= 40


mlogs.eventids = e*/