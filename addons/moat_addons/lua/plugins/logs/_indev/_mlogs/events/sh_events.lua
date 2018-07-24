MLOGS_SHOT = 1
mlogs.events.register(MLOGS_SHOT, {
	type 	= "WPN",
	name 	= "Used Weapon",
	desc	= "when a player shoots or uses a loadout item",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has used {weapon_id}",
	show 	= false,
})

MLOGS_SWITCH_TO = 2
mlogs.events.register(MLOGS_SWITCH_TO, {
	type 	= "SWTCH",
	name 	= "Switched to Weapon",
	desc	= "when a player switches to a traitor weapon",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has switched to {weapon_id}",
	show 	= false,
})

MLOGS_SWITCH_FROM = 3
mlogs.events.register(MLOGS_SWITCH_FROM, {
	type 	= "SWTCH",
	name 	= "Switched from Weapon",
	desc	= "when a player switches from a traitor weapon",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has switched from {weapon_id}",
	show 	= false,
})

MLOGS_AUTOSLAY = 4
mlogs.events.register(MLOGS_AUTOSLAY, {
	type 	= "SLAY",
	name 	= "Player Slain",
	desc	= "when a player is slain",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has been autoslain",
	show 	= true,
})

MLOGS_USED = 5
mlogs.events.register(MLOGS_USED, {
	type 	= "USE",
	name 	= "Used Item",
	desc	= "when a player uses (presses E on) an item",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has used {str_info}",
	show 	= false,
})

MLOGS_BODYFOUND = 6
mlogs.events.register(MLOGS_BODYFOUND, {
	type 	= "BODY",
	name 	= "Body Identified",
	desc	= "when a player identifies a body",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has identified the body of {player_id2}",
	show 	= true,
})

MLOGS_C4_PLANT = 7
mlogs.events.register(MLOGS_C4_PLANT, {
	type 	= "C4",
	name 	= "C4 Planted",
	desc	= "when a player plants a C4",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has planted a C4",
	show 	= true,
})

MLOGS_C4_ARM = 8
mlogs.events.register(MLOGS_C4_ARM, {
	type 	= "C4",
	name 	= "C4 Armed",
	desc	= "when a player arms a C4",
	color 	= Color(0, 0, 0),
	display = "{player_id1} armed the C4 of {player_id2} for {num_info} minutes",
	show 	= true,
})

MLOGS_C4_DISARM = 9
mlogs.events.register(MLOGS_C4_DISARM, {
	type 	= "C4",
	name 	= "C4 Disarmed",
	desc	= "when a player attempts to disarm a C4",
	color 	= Color(0, 0, 0),
	display = "{player_id1} attempted disarm for the C4 of {player_id2}",
	show 	= true,
})

MLOGS_C4_DESTROY = 10
mlogs.events.register(MLOGS_C4_DESTROY, {
	type 	= "C4",
	name 	= "C4 Destroyed",
	desc	= "when a player destroys a C4",
	color 	= Color(0, 0, 0),
	display = "{player_id1} destroyed the C4 of {player_id2}",
	show 	= true,
})

MLOGS_C4_PICKUP = 11
mlogs.events.register(MLOGS_C4_PICKUP, {
	type 	= "C4",
	name 	= "C4 Picked Up",
	desc	= "when a picks up a C4",
	color 	= Color(0, 0, 0),
	display = "{player_id1} picked up the C4 of {player_id2}",
	show 	= true,
})

MLOGS_C4_EXPLODE = 12
mlogs.events.register(MLOGS_C4_EXPLODE, {
	type 	= "C4",
	name 	= "C4 Exploded",
	desc	= "when a C4 explodes from time or a disarm failure",
	color 	= Color(0, 0, 0),
	display = "The C4 planted by {player_id1} has exploded",
	show 	= true,
})

MLOGS_ITEM_DROP = 13
mlogs.events.register(MLOGS_ITEM_DROP, {
	type 	= "DROP",
	name 	= "Item Dropped",
	desc	= "when a player drops/throws an item on to the floor",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has dropped {weapon_id}",
	show 	= false,
})

MLOGS_DNA_RETRIEVE = 14
mlogs.events.register(MLOGS_DNA_RETRIEVE, {
	type 	= "DNA",
	name 	= "DNA Retrieved",
	desc	= "when a player retrieves DNA on a body",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has retrieved the DNA of {player_id2} from {str_info}",
	show 	= true,
})

MLOGS_DNA_SCAN = 15
mlogs.events.register(MLOGS_DNA_SCAN, {
	type 	= "DNA",
	name 	= "DNA Scanned",
	desc	= "when a player scans DNA and can view the position of the player",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has scanned the DNA of {player_id2}",
	show 	= false,
})

MLOGS_DET_REQ = 16
mlogs.events.register(MLOGS_DET_REQ, {
	type 	= "REQ",
	name 	= "Detective Requested",
	desc	= "when a player requests a detective to a body",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has requested a detective to the body of {player_id2}",
	show 	= false,
})

MLOGS_PLY_TBUTTON = 17
mlogs.events.register(MLOGS_PLY_TBUTTON, {
	type 	= "BTN",
	name 	= "Traitor Button",
	desc	= "when a player triggers a traitor button",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has used a traitor button ({str_info})",
	show 	= false,
})

MLOGS_PLY_TELE_START = 18
mlogs.events.register(MLOGS_PLY_TELE_START, {
	type 	= "TELE",
	name 	= "Teleporter Started",
	desc	= "when a player starts a teleporter",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has started a teleport",
	show 	= false,
})

MLOGS_PLY_TELE_END = 19
mlogs.events.register(MLOGS_PLY_TELE_END, {
	type 	= "TELE",
	name 	= "Teleporter Finished",
	desc	= "when a player finished using a teleporter",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has finished a teleport",
	show 	= false,
})

MLOGS_NADE_TRIGGER = 20
mlogs.events.register(MLOGS_NADE_TRIGGER, {
	type 	= "NADE",
	name 	= "Nade Triggered",
	desc	= "when a player triggers a nade",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has triggered {weapon_id}",
	show 	= false,
})

MLOGS_NADE_THROW = 21
mlogs.events.register(MLOGS_NADE_THROW, {
	type 	= "NADE",
	name 	= "Nade Thrown",
	desc	= "when a player throws a nade",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has thrown {weapon_id}",
	show 	= false,
})

MLOGS_NADE_EXPLODE = 22
mlogs.events.register(MLOGS_NADE_EXPLODE, {
	type 	= "NADE",
	name 	= "Nade Explode",
	desc	= "when a nade explodes",
	color 	= Color(0, 0, 0),
	display = "{str_info} triggered by {player_id1} has exploded",
	show 	= true,
})

MLOGS_TEXT_CHAT = 23
mlogs.events.register(MLOGS_TEXT_CHAT, {
	type 	= "CHAT",
	name 	= "Chat Message",
	desc	= "when a message is displayed in chat",
	color 	= Color(0, 0, 0),
	display = "{player_id1} said {str_info}",
	show 	= false,
})

MLOGS_VOICE_CHAT_BEGIN = 24
mlogs.events.register(MLOGS_VOICE_CHAT_BEGIN, {
	type 	= "VOICE",
	name 	= "Voice Chat Start",
	desc	= "when a player starts using voice chat",
	color 	= Color(0, 0, 0),
	display = "{player_id1} started using voice comms",
	show 	= false,
})

MLOGS_VOICE_CHAT_END = 25
mlogs.events.register(MLOGS_VOICE_CHAT_END, {
	type 	= "VOICE",
	name 	= "Voice Chat End",
	desc	= "when a player stops using voice chat",
	color 	= Color(0, 0, 0),
	display = "{player_id1} stopped using voice comms",
	show 	= false,
})

MLOGS_KOS = 26
mlogs.events.register(MLOGS_KOS, {
	type 	= "KOS",
	name 	= "Player KOS",
	desc	= "when a player initiates a KOS on another",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has KOS'd {player_id2}",
	show 	= true,
})

MLOGS_ORDER = 27
mlogs.events.register(MLOGS_ORDER, {
	type 	= "EQ",
	name 	= "Ordered Equipment",
	desc	= "when a player orders equipment",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has bought {str_info}",
	show 	= true,
})

MLOGS_DISGUISE_ON = 28
mlogs.events.register(MLOGS_DISGUISE_ON, {
	type 	= "HIDE",
	name 	= "Disguise Enabled",
	desc	= "when a player enables the disguiser",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has enabled their disguise",
	show 	= false,
})

MLOGS_DISGUISE_OFF = 29
mlogs.events.register(MLOGS_DISGUISE_OFF, {
	type 	= "HIDE",
	name 	= "Disguise Disabled",
	desc	= "when a player disables the disguiser",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has disabled their disguise",
	show 	= false,
})

MLOGS_WACKY_ROUND = 30
mlogs.events.register(MLOGS_WACKY_ROUND, {
	type 	= "INFO",
	name 	= "Wacky Round",
	desc	= "when a wacky round is actived",
	color 	= Color(0, 0, 0),
	display = "Wacky Round - {str_info}",
	show 	= true,
})

MLOGS_MAGNETO_START = 31
mlogs.events.register(MLOGS_MAGNETO_START, {
	type 	= "MGNTO",
	name 	= "Magneto Stick Pickup",
	desc	= "when a player picks up something with their magneto stick",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has picked up {str_info}",
	show 	= false,
})

MLOGS_MAGNETO_END = 32
mlogs.events.register(MLOGS_MAGNETO_END, {
	type 	= "MGNTO",
	name 	= "Magneto Stick Drop",
	desc	= "when a player drops something with their magneto stick",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has dropped {str_info}",
	show 	= false,
})

MLOGS_MAGNETO_END = 33
mlogs.events.register(MLOGS_MAGNETO_END, {
	type 	= "HANG",
	name 	= "Magneto Stick Hang",
	desc	= "when a hangs a body with their magneto stick",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has hung the body of {player_id2}",
	show 	= true,
})

MLOGS_BODY_SEE = 34
mlogs.events.register(MLOGS_BODY_SEE, {
	type 	= "BODY",
	name 	= "Unidentified Body Seen",
	desc	= "when a player looks at an unidentified body",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has seen the unidentified body of {player_id2}",
	show 	= false,
})

MLOGS_PUSH = 35
mlogs.events.register(MLOGS_PUSH, {
	type 	= "PUSH",
	name 	= "Player Pushed",
	desc	= "when a player is pushed",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has pushed {player_id2}",
	show 	= true,
})

MLOGS_DMG_BULLET = 36
mlogs.events.register(MLOGS_DMG_BULLET, {
	type 	= "DMG",
	name 	= "Player Damaged by Bullets",
	desc	= "when a player takes damage from bullets",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with {weapon_id}",
	show 	= true,
})

MLOGS_DMG_BLAST = 37
mlogs.events.register(MLOGS_DMG_BLAST, {
	type 	= "DMG",
	name 	= "Player Damaged by Explosion",
	desc	= "when a player takes damage from an explosion",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with an explosion",
	show 	= true,
})

MLOGS_DMG_BURN = 38
mlogs.events.register(MLOGS_DMG_BURN, {
	type 	= "DMG",
	name 	= "Player Damaged by Fire",
	desc	= "when a player takes damage from fire",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with fire",
	show 	= true,
})

MLOGS_DMG_CRUSH = 39
mlogs.events.register(MLOGS_DMG_CRUSH, {
	type 	= "DMG",
	name 	= "Player Damaged by Prop",
	desc	= "when a player takes damage from a prop",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a prop",
	show 	= true,
})

MLOGS_DMG_SLASH = 40
mlogs.events.register(MLOGS_DMG_SLASH, {
	type 	= "DMG",
	name 	= "Player Damaged by Sharp Object",
	desc	= "when a player takes damage from a sharp object",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a sharp object",
	show 	= true,
})

MLOGS_DMG_CLUB = 41
mlogs.events.register(MLOGS_DMG_CLUB, {
	type 	= "DMG",
	name 	= "Player Damaged by Crowbar",
	desc	= "when a player takes damage from a crowbar",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a crowbar",
	show 	= true,
})

MLOGS_DMG_SHOCK = 42
mlogs.events.register(MLOGS_DMG_SHOCK, {
	type 	= "DMG",
	name 	= "Player Damaged by Shock",
	desc	= "when a player takes damage from an electric shock",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with an electric shock",
	show 	= true,
})

MLOGS_DMG_ENERGYBEAM = 43
mlogs.events.register(MLOGS_DMG_ENERGYBEAM, {
	type 	= "DMG",
	name 	= "Player Damaged by Laser",
	desc	= "when a player takes damage from a laser",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a laser",
	show 	= true,
})

MLOGS_DMG_SONIC = 44
mlogs.events.register(MLOGS_DMG_SONIC, {
	type 	= "DMG",
	name 	= "Player Damaged by Collision",
	desc	= "when a player takes damage from a teleport collision",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a teleport collision",
	show 	= true,
})

MLOGS_DMG_PHYSGUN = 45
mlogs.events.register(MLOGS_DMG_PHYSGUN, {
	type 	= "DMG",
	name 	= "Player Damaged by Massive Bulk",
	desc	= "when a player takes damage from a massive bulk",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with a massive bulk",
	show 	= true,
})

MLOGS_DMG_FALL = 46
mlogs.events.register(MLOGS_DMG_FALL, {
	type 	= "DMG",
	name 	= "Player Damaged by Falling",
	desc	= "when a player takes damage from falling",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with fallling",
	show 	= true,
})

MLOGS_DMG_DROWN = 47
mlogs.events.register(MLOGS_DMG_DROWN, {
	type 	= "DMG",
	name 	= "Player Damaged by Drowning",
	desc	= "when a player takes damage from drowning",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with drowning",
	show 	= true,
})

MLOGS_DMG_DROWN = 48
mlogs.events.register(MLOGS_DMG_DROWN, {
	type 	= "DMG",
	name 	= "Player Damaged by Drowning",
	desc	= "when a player takes damage from drowning",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP with drowning",
	show 	= true,
})

MLOGS_DMG_OTHER = 49
mlogs.events.register(MLOGS_DMG_OTHER, {
	type 	= "DMG",
	name 	= "Player Damaged by Something",
	desc	= "when a player takes damage from something",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has damaged {player_id2} for {num_info} HP",
	show 	= true,
})

MLOGS_KILL = 50
mlogs.events.register(MLOGS_KILL, {
	type 	= "KILL",
	name 	= "Player Killed",
	desc	= "when a player is killed",
	color 	= Color(0, 0, 0),
	display = "{player_id1} has killed {player_id2}",
	show 	= true,
})