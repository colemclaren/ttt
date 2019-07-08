local Category = "Arkham City Catwoman"

local NPC = {
    Name = "Arkham City Catwoman",
    Class = "npc_citizen",
    Model = "models/player/bobert/ACCatwoman_npc.mdl",
    Health = "150",
    KeyValues = {
        citizentype = 4
    },
    Category = Category
}

list.Set("NPC", "npc_ACCatwoman", NPC)
player_manager.AddValidModel("Arkham City Catwoman", "models/player/bobert/ACCatwoman.mdl")
list.Set("PlayerOptionsModel", "Arkham City Catwoman", "models/player/bobert/ACCatwoman.mdl")
player_manager.AddValidModel("Amazing Spider-Man 2", "models/player/tasm2spider.mdl")
player_manager.AddValidHands("Amazing Spider-Man 2", "models/weapons/c_arms_hev.mdl", 0, "00000000")
list.Set("PlayerOptionsModel", "Amazing Spider-Man 2", "models/player/tasm2spider.mdl")
player_manager.AddValidModel("Arkham Origins Blackmask", "models/player/bobert/AOBlackmask.mdl")
list.Set("PlayerOptionsModel", "Arkham Origins Blackmask", "models/player/bobert/AOBlackmask.mdl")
player_manager.AddValidModel("bigsmoke", "models/bigsmoke/smoke.mdl")
player_manager.AddValidHands("bigsmoke", "models/weapons/c_arms_smoke.mdl", 0, "00000000")
--[[
	Broke Models
]]
player_manager.AddValidModel("jack_sparrow", "models/burd/player/jack_sparrow.mdl")
player_manager.AddValidModel("altair", "models/burd/player/altair.mdl")
player_manager.AddValidModel("eastertrooper", "models/burd/player/eastertrooper/eastertrooper.mdl")
player_manager.AddValidModel("deathstroke_valvebiped", "models/burd/norpo/arkhamorigins/assassins/deathstroke_valvebiped.mdl")
player_manager.AddValidHands("deathstroke_valvebiped", "models/burd/norpo/arkhamorigins/assassins/viewmodel/deathstroke_valvebiped_handmodel.mdl", 0, "00000000")
--[[
	Addon by Voikanaa
]]
player_manager.AddValidModel("Santa Claus", "models/player/christmas/santa.mdl")
player_manager.AddValidHands("Santa Claus", "models/player/christmas/santa_arms.mdl", 0, "00000000")
list.Set("PlayerOptionsModel", "Santa Claus", "models/player/christmas/santa.mdl")
player_manager.AddValidModel("Deathclaw Alpha", "models/deathclaw_player/deathclaw_player_alpha.mdl")
player_manager.AddValidHands("Deathclaw Alpha", "models/weapons/arms/deathclaw_alpha_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Deathclaw", "models/deathclaw_player/deathclaw_player.mdl")
player_manager.AddValidHands("Deathclaw", "models/weapons/arms/deathclaw_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Deathclaw Savage", "models/deathclaw_player/deathclaw_player_savage.mdl")
player_manager.AddValidHands("Deathclaw Savage", "models/weapons/arms/deathclaw_savage_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Deathclaw Albino", "models/deathclaw_player/deathclaw_player_albino.mdl")
player_manager.AddValidHands("Deathclaw Albino", "models/weapons/arms/deathclaw_albino_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Deathclaw Glowing", "models/deathclaw_player/deathclaw_player_glowing.mdl")
player_manager.AddValidHands("Deathclaw Glowing", "models/weapons/arms/deathclaw_glowing_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Deathclaw Matriarch", "models/deathclaw_player/deathclaw_player_matriarch.mdl")
player_manager.AddValidHands("Deathclaw Matriarch", "models/weapons/arms/deathclaw_matriarch_arms.mdl", 0, "00000000")
--[[
	Addon by Voikanaa
]]
player_manager.AddValidModel("Faith Connors", "models/player/faith.mdl")
player_manager.AddValidHands("Faith Connors", "models/player/faith_hands.mdl", 0, "00000000")
list.Set("PlayerOptionsModel", "Faith Connors", "models/player/faith.mdl")
player_manager.AddValidModel("Ghostface", "models/player/screamplayermodel/scream/scream.mdl")
list.Set("PlayerOptionsModel", "Ghostface", "models/player/screamplayermodel/scream/scream.mdl")

if SERVER then
    AddCSLuaFile()
end

local function AddPlayerModel(name, model, hands)
    list.Set("PlayerOptionsModel", name, model)
    player_manager.AddValidModel(name, model)

    if hands then
        player_manager.AddValidHands(name, hands, 0, "00000000")
    end
end

AddPlayerModel("normal", "models/player/normal.mdl") -- Used in Duels and PVP Battle!
AddPlayerModel("teslapower", "models/player/teslapower.mdl")
AddPlayerModel("spytf2", "models/player/drpyspy/spy.mdl")
AddPlayerModel("shaun", "models/player/shaun.mdl")
AddPlayerModel("isaac", "models/player/security_suit.mdl")
AddPlayerModel("midna", "models/player/midna.mdl")
AddPlayerModel("maskedbreen", "models/player/Sunabouzu.mdl")
AddPlayerModel("zoey", "models/player/zoey.mdl")
AddPlayerModel("sniper", "models/player/robber.mdl")
AddPlayerModel("spacesuit", "models/player/spacesuit.mdl")
AddPlayerModel("scarecrow", "models/player/scarecrow.mdl")
AddPlayerModel("smith", "models/player/smith.mdl")
AddPlayerModel("libertyprime", "models/player/sam.mdl")
AddPlayerModel("rpcop", "models/player/azuisleet1.mdl")
AddPlayerModel("altair", "models/player/altair.mdl")
AddPlayerModel("dinosaur", "models/player/foohysaurusrex.mdl")
AddPlayerModel("rorschach", "models/player/rorschach.mdl")
AddPlayerModel("aphaztech", "models/player/aphaztech.mdl")
AddPlayerModel("faith", "models/player/faith.mdl")
AddPlayerModel("robot", "models/player/robot.mdl")
AddPlayerModel("niko", "models/player/niko.mdl")
AddPlayerModel("zelda", "models/player/zelda.mdl")
AddPlayerModel("dude", "models/player/dude.mdl")
AddPlayerModel("leon", "models/player/leon.mdl")
AddPlayerModel("chris", "models/player/chris.mdl")
AddPlayerModel("gmen", "models/player/gmen.mdl")
AddPlayerModel("joker", "models/player/joker.mdl")
AddPlayerModel("hunter", "models/player/hunter.mdl")
AddPlayerModel("steve", "models/player/mcsteve.mdl")
AddPlayerModel("gordon", "models/player/gordon.mdl")
AddPlayerModel("masseffect", "models/player/masseffect.mdl")
AddPlayerModel("scorpion", "models/player/scorpion.mdl")
AddPlayerModel("subzero", "models/player/subzero.mdl")
AddPlayerModel("undeadcombine", "models/player/clopsy.mdl")
AddPlayerModel("boxman", "models/player/nuggets.mdl")
AddPlayerModel("classygentleman", "models/player/macdguy.mdl")
AddPlayerModel("rayman", "models/player/rayman.mdl")
AddPlayerModel("raz", "models/player/raz.mdl")
AddPlayerModel("knight", "models/player/knight.mdl")
AddPlayerModel("bobafett", "models/player/bobafett.mdl")
AddPlayerModel("chewbacca", "models/player/chewbacca.mdl")
AddPlayerModel("assassin", "models/player/dishonored_assassin1.mdl")
AddPlayerModel("haroldlott", "models/player/haroldlott.mdl")
AddPlayerModel("harry_potter", "models/player/harry_potter.mdl")
AddPlayerModel("jack_sparrow", "models/player/jack_sparrow.mdl")
AddPlayerModel("jawa", "models/player/jawa.mdl")
AddPlayerModel("marty", "models/player/martymcfly.mdl")
AddPlayerModel("samuszero", "models/player/samusz.mdl")
AddPlayerModel("skeleton", "models/player/skeleton.mdl")
AddPlayerModel("stormtrooper", "models/player/stormtrooper.mdl")
AddPlayerModel("luigi", "models/player/suluigi_galaxy.mdl")
AddPlayerModel("mario", "models/player/sumario_galaxy.mdl")
AddPlayerModel("zero", "models/player/lordvipes/MMZ/Zero/zero_playermodel_cvp.mdl")
AddPlayerModel("yoshi", "models/player/yoshi.mdl")
AddPlayerModel("grayfox", "models/player/lordvipes/Metal_Gear_Rising/gray_fox_playermodel_cvp.mdl")
AddPlayerModel("crimsonlance", "models/player/lordvipes/bl_clance/crimsonlanceplayer.mdl", "models/player/lordvipes/bl_clance/Arms/crimsonlanceamrs.mdl")
AddPlayerModel("walterwhite", "models/Agent_47/agent_47.mdl")
AddPlayerModel("jackskellington", "models/vinrax/player/Jack_player.mdl", "models/vinrax/weapons/c_arms_jack.mdl") -- by Vinrax
AddPlayerModel("deadpool", "models/player/deadpool.mdl")
AddPlayerModel("deathstroke", "models/norpo/ArkhamOrigins/Assassins/Deathstroke_ValveBiped.mdl", "models/norpo/ArkhamOrigins/Assassins/Viewmodel/Deathstroke_ValveBiped_HandModel.mdl")
AddPlayerModel("carley", "models/nikout/carleypm.mdl")
AddPlayerModel("solidsnake", "models/player/big_boss.mdl", "models/player/big_boss_hands.mdl")
AddPlayerModel("tronanon", "models/player/anon/anon.mdl", "models/weapons/arms/anon_arms.mdl") -- by Rokay "Rambo"
AddPlayerModel("alice", "models/player/alice.mdl")
AddPlayerModel("windrunner", "models/heroes/windrunner/windrunner.mdl", "models/heroes/windrunner/c_arms_windrunner.mdl")
AddPlayerModel("ash", "models/player/red.mdl")
AddPlayerModel("megaman", "models/vinrax/player/megaman64_no_gun_player.mdl")
AddPlayerModel("kilik", "models/player/hhp227/kilik.mdl")
AddPlayerModel("bond", "models/player/bond.mdl")
AddPlayerModel("ironman", "models/Avengers/Iron Man/mark7_player.mdl")
AddPlayerModel("masterchief", "models/player/lordvipes/haloce/spartan_classic.mdl")
AddPlayerModel("doomguy", "models/ex-mo/quake3/players/doom.mdl")
AddPlayerModel("freddykruger", "models/player/freddykruger.mdl")
AddPlayerModel("linktp", "models/player/linktp.mdl")
AddPlayerModel("roman", "models/player/romanbellic.mdl")
list.Set("PlayerOptionsModel", "James Bond", "models/player/bond.mdl")
player_manager.AddValidModel("James Bond", "models/player/bond.mdl")
--[[
	Addon by Rokay "Rambo"
]]
player_manager.AddValidModel("Jesus", "models/player/jesus/jesus.mdl")
list.Set("PlayerOptionsModel", "Jesus", "models/player/jesus/jesus.mdl")
player_manager.AddValidModel("Inferno Armour", "models/Mass Effect 2/player/inferno_armour.mdl")
player_manager.AddValidModel("Inferno Armour Colour", "models/Mass Effect 2/player/inferno_armour_colour.mdl")
list.Set("PlayerOptionsModel", "Inferno Armour", "models/Mass Effect 2/player/inferno_armour.mdl")
list.Set("PlayerOptionsModel", "Inferno Armour Colour", "models/Mass Effect 2/player/inferno_armour_colour.mdl")
player_manager.AddValidModel("morgan_freeman", "models/rottweiler/freeman.mdl")
player_manager.AddValidHands("morgan_freeman", "models/rottweiler/freeman_hands.mdl", 0, "0000000")
player_manager.AddValidModel("Ninja", "models/vinrax/player/ninja_player.mdl")
player_manager.AddValidModel("Obama", "models/Obama/Obama.mdl")
list.Set("PlayerOptionsModel", "Obama", "models/Obama/Obama.mdl")
list.Set("PlayerOptionsModel", "osamaplayer", "models/code_gs/osama/osamaplayer.mdl")
player_manager.AddValidModel("osamaplayer", "models/code_gs/osama/osamaplayer.mdl")
player_manager.AddValidHands("osamaplayer", "models/weapons/c_arms_refugee.mdl", 1, "00000000")
list.Set("PlayerOptionsModel", "osamaplayer", "models/code_gs/osama/osamaplayer.mdl")
player_manager.AddValidModel("osamaplayer", "models/code_gs/osama/osamaplayer.mdl")
player_manager.AddValidHands("osamaplayer", "models/weapons/c_arms_refugee.mdl", 1, "00000000")
-- Created by DasBoost
player_manager.AddValidModel("Batman", "models/player/superheroes/batman.mdl")
list.Set("PlayerOptionsModel", "Batman", "models/player/superheroes/batman.mdl")
player_manager.AddValidModel("Superman", "models/player/superheroes/superman.mdl")
list.Set("PlayerOptionsModel", "Superman", "models/player/superheroes/superman.mdl")
player_manager.AddValidModel("Green Lantern", "models/player/superheroes/greenlantern.mdl")
list.Set("PlayerOptionsModel", "Green Lantern", "models/player/superheroes/greenlantern.mdl")
player_manager.AddValidModel("Flash", "models/player/superheroes/flash.mdl")
list.Set("PlayerOptionsModel", "Flash", "models/player/superheroes/flash.mdl")
--[[
	Addon by Rokay "Rambo"
]]
player_manager.AddValidModel("Zack Halloween", "models/player/zack/zackhalloween.mdl")
list.Set("PlayerOptionsModel", "Zack Halloween", "models/player/zack/zackhalloween.mdl")
player_manager.AddValidHands("Zack Halloween", "models/weapons/arms/zackhalloween_arms.mdl", 0, "00000000")
local Category = "Arkham Origins Blackmask"

local NPC = {
    Name = "Arkham Origins Blackmask",
    Class = "npc_citizen",
    Model = "models/player/bobert/AOBlackmask_npc.mdl",
    Health = "150",
    KeyValues = {
        citizentype = 4
    },
    Category = Category
}

list.Set("NPC", "npc_AOBlackmask", NPC)
local Category = "Soldiers + Armaments"

local NPC = {
    Name = "MIB Black Helicopter",
    Class = "npc_apache",
    Category = Category
}

list.Set("NPC", NPC.Class, NPC)
local Category = "Soldiers + Armaments"

local NPC = {
    Name = "Black Helicopter Static",
    Class = "npc_apache_s",
    Category = Category
}

list.Set("NPC", NPC.Class, NPC)
local Category = "Deathclaw humanoids"

local NPC = {
    Name = "Deathclaw Alpha",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player_alpha.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_ap", NPC)

local NPC = {
    Name = "Deathclaw",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_p", NPC)

local NPC = {
    Name = "Deathclaw Alpha hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player_alpha.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_aph", NPC)

local NPC = {
    Name = "Deathclaw hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_ph", NPC)

local NPC = {
    Name = "Deathclaw Glowing",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player_glowing.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_gp", NPC)

local NPC = {
    Name = "Deathclaw Glowing hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player_glowing.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_gph", NPC)

local NPC = {
    Name = "Deathclaw Matriarch",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player_matriarch.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_mp", NPC)

local NPC = {
    Name = "Deathclaw Matriarch hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player_matriarch.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_mph", NPC)

local NPC = {
    Name = "Deathclaw Albino",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player_albino.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_alp", NPC)

local NPC = {
    Name = "Deathclaw Albino hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player_albino.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_alph", NPC)

local NPC = {
    Name = "Deathclaw Savage",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/deathclaw_player/deathclaw_player_savage.mdl",
    Health = "350",
    Category = Category
}

list.Set("NPC", "npc_deathclaw_sp", NPC)

local NPC = {
    Name = "Deathclaw Savage hostile",
    Class = "npc_combine_s",
    Category = Category,
    Model = "models/deathclaw_player/deathclaw_player_savage.mdl",
    Weapons = {"weapon_crowbar"},
    KeyValues = {
        SquadName = "overwatch"
    }
}

list.Set("NPC", "npc_deathclaw_sph", NPC)
local Category = "Mass Effect"

local NPC = {
    Name = "Inferno Armour",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/Mass Effect 2/player/inferno_armour.mdl",
    Health = "250",
    Category = Category
}

list.Set("NPC", "npc_inferno_armour", NPC)
local Category = "Mass Effect"

local NPC = {
    Name = "Inferno Armour",
    Class = "npc_citizen",
    KeyValues = {
        citizentype = 4
    },
    Model = "models/Mass Effect 2/player/inferno_armour.mdl",
    Health = "250",
    Category = Category
}

list.Set("NPC", "npc_inferno_armour", NPC)
local Category = "Skyrim"

local NPC = {
    Name = "Serpentine Dragon",
    Class = "npc_dragon_serpentine",
    Category = Category
}

list.Set("NPC", NPC.Class, NPC)

/*
+ models/player/azuisleet1.mdl
- models/player/blockdude.mdl
+ models/player/doomguy.mdl
- models/player/foohysaurusrex.mdl
+ models/player/gmen.mdl
- models/player/harry_potter.mdl
- models/player/jawa.mdl
- models/player/leon.mdl
- models/player/linktp.mdl
- models/player/macdguy.mdl
- models/player/martymcfly.mdl
+ models/player/nuggets.mdl
- models/player/rayman.mdl
+ models/player/raz.mdl
+ models/player/red.mdl
- models/player/robot.mdl
+ models/player/stormtrooper.mdl
+ models/player/suluigi_galaxy.mdl
+ models/player/sumario_galaxy.mdl
+ models/player/yoshi.mdl
+ models/player/zelda.mdl
+ models/player/tasm2spider.mdl
- models/vinrax/player/megaman64_player.mdl
+ models/ex-mo/quake3/players/doom.mdl
+ models/player/lordvipes/bl_clance/crimsonlanceplayer.mdl
*/