// Since garry doesn't allow uploading txt-files to the workshop, we'll have to create them when the addon is initialized.
// Stupid as hell, but there's no other way.

file.CreateDir("wrench")
file.CreateDir("wrench/fgd")

local f = "wrench/fgd/skyrim.txt"
if(file.Exists(f,"DATA")) then return end
file.Write(f,[[@include "base.fgd"
@BaseClass base(BaseNPC) color(0 200 200) = BaseNPCSlv
[
	
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/atronachflame.mdl") = npc_atronach_flame : "Flame Atronach"
[
	health(integer) : "Health" : 250 : 
        "Health of this NPC. " +
	"Default: 250"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/atronachfrost.mdl") = npc_atronach_frost : "Frost Atronach"
[
	health(integer) : "Health" : 580 : 
        "Health of this NPC. " +
	"Default: 580"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/chaurus.mdl") = npc_chaurus : "Chaurus"
[
	health(integer) : "Health" : 450 : 
        "Health of this NPC. " +
	"Default: 450"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/chaurusflyer.mdl") = npc_chaurus_flyer : "Chaurus Hunter"
[
	health(integer) : "Health" : 520 : 
        "Health of this NPC. " +
	"Default: 520"
]

@BaseClass base(BaseNPCSlv) color(0 200 200) = BaseNPCDragon
[
	
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragon.mdl") = npc_dragon : "Dragon"
[
	health(integer) : "Health" : 3200 : 
        "Health of this NPC. " +
	"Default: 3200"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonalduin.mdl") = npc_dragon_alduin : "Alduin"
[
	health(integer) : "Health" : 8800 : 
        "Health of this NPC. " +
	"Default: 8800"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonboss.mdl") = npc_dragon_ancient : "Ancient Dragon"
[
	health(integer) : "Health" : 5200 : 
        "Health of this NPC. " +
	"Default: 5200"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonforest.mdl") = npc_dragon_blood : "Blood Dragon"
[
	health(integer) : "Health" : 3800 : 
        "Health of this NPC. " +
	"Default: 3800"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragontundra.mdl") = npc_dragon_blood : "Elder Dragon"
[
	health(integer) : "Health" : 4400 : 
        "Health of this NPC. " +
	"Default: 4400"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonsnow.mdl") = npc_dragon_frost : "Frost Dragon"
[
	health(integer) : "Health" : 3200 : 
        "Health of this NPC. " +
	"Default: 3200"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonodahviing.mdl") = npc_dragon_odahviing : "Odahviing"
[
	health(integer) : "Health" : 3200 : 
        "Health of this NPC. " +
	"Default: 3200"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonparthurnax.mdl") = npc_dragon_paarthurnax : "Paarthurnax"
[
	health(integer) : "Health" : 3200 : 
        "Health of this NPC. " +
	"Default: 3200"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonserpentine.mdl") = npc_dragon_serpentine : "Serpentine"
[
	health(integer) : "Health" : 4800 : 
        "Health of this NPC. " +
	"Default: 4800"
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonicelake.mdl") = npc_dragon_revered : "Revered Dragon"
[
	health(integer) : "Health" : 4800 : 
        "Health of this NPC. " +
	"Default: 4800"
	type(choices) : "Type" : 0 : "" =
	[
		0 : "Purple"
		1 : "Icelake"
	]
]

@NPCClass base(BaseNPCDragon) studio("models/skyrim/dragonskeleton.mdl") = npc_dragon_skeleton : "Skeletal Dragon"
[
	health(integer) : "Health" : 3600 : 
        "Health of this NPC. " +
	"Default: 3600"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/frostbitespider.mdl") = npc_frostbitespider : "Frostbite Spider"
[
	health(integer) : "Health" : 350 : 
        "Health of this NPC. " +
	"Default: 350"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/frostbitespider_small.mdl") = npc_frostbitespider_small : "Small Frostbite Spider"
[
	health(integer) : "Health" : 5 : 
        "Health of this NPC. " +
	"Default: 5"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/horse.mdl") = npc_horse : "Horse"
[
	health(integer) : "Health" : 250 : 
        "Health of this NPC. " +
	"Default: 250"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/shadowmeresoulcairn.mdl") = npc_horse_arvak : "Arvak"
[
	health(integer) : "Health" : 880 : 
        "Health of this NPC. " +
	"Default: 880"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/mudcrab.mdl") = npc_mudcrab : "Mudcrab"
[
	health(integer) : "Health" : 90 : 
        "Health of this NPC. " +
	"Default: 90"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/mudcrab_legendary.mdl") = npc_mudcrab_legendary : "Legendary Mudcrab"
[
	health(integer) : "Health" : 600 : 
        "Health of this NPC. " +
	"Default: 600"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/dwarvenspider.mdl") = npc_dwarven_spider : "Dwarven Spider"
[
	health(integer) : "Health" : 430 : 
        "Health of this NPC. " +
	"Default: 430"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/spherecenturion.mdl") = npc_dwarven_sphere : "Dwarven Sphere"
[
	health(integer) : "Health" : 820 : 
        "Health of this NPC. " +
	"Default: 820"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/steamcenturion.mdl") = npc_dwarven_centurion : "Dwarven Centurion"
[
	health(integer) : "Health" : 2500 : 
        "Health of this NPC. " +
	"Default: 2500"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr : "Draugr"
[
	health(integer) : "Health" : 50 : 
        "Health of this NPC. " +
	"Default: 50"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr_restless : "Restless Draugr"
[
	health(integer) : "Health" : 150 : 
        "Health of this NPC. " +
	"Default: 150"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr_wight : "Draugr Wight"
[
	health(integer) : "Health" : 320 : 
        "Health of this NPC. " +
	"Default: 320"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr_scourge : "Draugr Scourge"
[
	health(integer) : "Health" : 700 : 
        "Health of this NPC. " +
	"Default: 700"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr_overlord : "Draugr Overlord"
[
	health(integer) : "Health" : 1000 : 
        "Health of this NPC. " +
	"Default: 1000"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/draugr.mdl") = npc_draugr_deathlord : "Draugr Deathlord"
[
	health(integer) : "Health" : 1250 : 
        "Health of this NPC. " +
	"Default: 1250"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/falmer.mdl") = npc_falmer : "Falmer"
[
	health(integer) : "Health" : 180 : 
        "Health of this NPC. " +
	"Default: 180"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/falmer.mdl") = npc_falmer_skulker : "Falmer Skulker"
[
	health(integer) : "Health" : 290 : 
        "Health of this NPC. " +
	"Default: 290"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/falmer.mdl") = npc_falmer_gloomlurker : "Falmer Gloomlurker"
[
	health(integer) : "Health" : 410 : 
        "Health of this NPC. " +
	"Default: 410"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/falmer.mdl") = npc_falmer_nightprowler : "Falmer Nightprowler"
[
	health(integer) : "Health" : 550 : 
        "Health of this NPC. " +
	"Default: 550"
]

@NPCClass base(BaseNPCSlv) studio("models/skyrim/falmer.mdl") = npc_falmer_shadowmaster : "Falmer Shadowmaster"
[
	health(integer) : "Health" : 700 : 
        "Health of this NPC. " +
	"Default: 700"
]
]])