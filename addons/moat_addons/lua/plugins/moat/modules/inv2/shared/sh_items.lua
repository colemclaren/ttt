local meta = FindMetaTable("Player")
MOAT_DROPTABLE = MOAT_DROPTABLE or {}
MOAT_BODY_ITEMS = MOAT_BODY_ITEMS or {}
MOAT_COLLECT = {}

if (CLIENT) then
    COSMETIC_ITEMS = {}
	MOAT_BODY_ITEMS = {}
    function m_AddCosmeticItem(item_tbl, item_kind)
        local tbl = item_tbl
        tbl.Kind = item_kind
		if (item_kind == "Body") then
			MOAT_BODY_ITEMS[tbl.ID] = true 
		end

		if (tbl.Model) then
            util.PrecacheModel(tbl.Model)
        end

        COSMETIC_ITEMS[tbl.ID] = tbl
    end

    function m_GetCosmeticItemFromEnum(item_id)
        return table.Copy(COSMETIC_ITEMS[item_id])
    end
end

function m_AddDroppableItem(item_table, item_kind)
    local tbl = {}
    tbl = item_table
    tbl.Kind = item_kind

	if (tbl.Name and not tbl.NameExact) then
		tbl.Name = string.Title(tbl.Name)
	end

	if (tbl.Description and not tbl.DescExact) then
		tbl.Description = string.Grammarfy(tbl.Description, not (tbl.Description:EndsWith"!" or tbl.Description:EndsWith"?" or tbl.Description:EndsWith"."))
	end

	if (SERVER and item_table.Collection) then
		if (not MOAT_COLLECT[item_table.Collection]) then MOAT_COLLECT[item_table.Collection] = {} end
		tbl.Rarity = (tbl.Rarity == 9 and 9) or (tbl.Rarity == 8 and 8) or tbl.Rarity
		tbl.Kind = (tbl.Kind == "tier" and "tier") or tbl.Kind

		local str = string ("\n",
			"mi.Item(" .. tbl.ID .. ")\n",
			"	" .. ":SetRarity (" .. tbl.Rarity .. ")\n",
			"	" .. ":SetType \"" .. tbl.Kind .. "\"\n",
			"	" .. ":SetName \"" .. tbl.Name .. "\"\n")
		
		if (tbl.NameColor) then
			str = string (str, "	" .. ":SetColor {", tbl.NameColor.r, ", ", tbl.NameColor.g, ", ", tbl.NameColor.b, "}\n")
		end

		if (tbl.NameEffect) then
			str = string (str, "	" .. ":SetEffect \"", tbl.NameEffect, "\"\n")
		end

		if (tbl.Description) then
			str = string (str, "	" .. ":SetDesc \"", tbl.Description, "\"\n")
		end

		if (tbl.Image) then
			str = string (str, "	" .. ":SetImage \"", tbl.Image, "\"\n")
		end

		if (tbl.Model) then
			str = string (str, "	" .. ":SetModel \"", tbl.Model, "\"\n")
		end

		if (tbl.Skin) then
			str = string (str, "	" .. ":SetSkin (", tbl.Skin, ")\n")
		end

		if (tbl.WeaponClass) then
			str = string (str, "	" .. ":SetWeapon \"", tbl.WeaponClass, "\"\n")
		end

		if (tbl.Stats) then
			str = string (str, "	" .. ":SetStats (", tbl.MinStats or table.Count(tbl.Stats), ", ", tbl.MaxStats or table.Count(tbl.Stats), ")\n")

			local def = tbl.Kind == "Melee" and "Melee" or "Gun"
			for k, v in pairs(tbl.Stats) do
				if ((tbl.Kind == "tier" or tbl.Kind == "Tier" or tbl.Kind == "Unique") and mi.Stat.Roster[k]) then
					if (mi.Stat.Roster[k].Defaults[def] and mi.Stat.Roster[k].Defaults[def][tbl.Rarity]) then
						if (mi.Stat.Roster[k].Defaults[def][tbl.Rarity].Min == v.min and mi.Stat.Roster[k].Defaults[def][tbl.Rarity].Max == v.max) then
							continue
						end
					end
				end

				str = string (str, "		" .. ":SetStat (", isnumber(k) and k or '"' .. k .. '"', ", ", v.min, ", ", v.max, ")\n")
			end
		end

		if (tbl.Talents) then
			str = string (str, "	" .. ":SetTalents (", tbl.MinTalents or table.Count(tbl.Talents), ", ", tbl.MaxTalents or table.Count(tbl.Talents), ")\n")

			for k, v in pairs(tbl.Talents) do
				if (v == "random") then continue end
				str = string (str, "		" .. ":SetTalent (", k, ", \"", v, "\")\n")
			end
		end

		if (tbl.ModifyClientsideModel and file_str) then
			local par = tbl.Bone or tbl.Attachment

			local needle = "ITEM:ModifyClientsideModel"
			local sf = string.find(file_str, needle)

			local ms = string.sub(file_str, sf + string.len(needle), string.len(file_str))
			ms = string.Replace(ms, "( ", "(")
			ms = string.Replace(ms, " )", ")")

			local tb, fs = string.Split(ms, "\n"), ""
			for i = 1, #tb do
				tb[i] = string.Trim(tb[i])

				if (string.len(tb[i]) <= 1) then
					continue
				end

				fs = fs .. "		" .. tb[i] .. "\n"
			end

			fs = string.sub(fs, 1, -2) .. ")"
			fs = string.Replace(fs, "		end)", "	" .. "end)")
			fs = string.Replace(fs, "		(", "(")
			
			str = string (str, "	" .. ":SetRender (\"", par, "\", function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.Collection) then
			str = string (str, "	" .. ":SetCollection \"", tbl.Collection, "\"\n\n")
		end

		if (tbl.Price) then
			str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ")\n")
			MOAT_COLLECT[item_table.Collection].Crate = str
		else
			table.insert(MOAT_COLLECT[item_table.Collection], {String = str, Rarity = tbl.Rarity})
		end
	end

	if (item_kind == "Body") then
		MOAT_BODY_ITEMS[tbl.ID] = true 
	end

	MOAT_DROPTABLE[tbl.ID] = tbl
end

local MOAT_ITEM_FOLDER = "plugins/moat/modules/_items/items"

local MOAT_ITEM_FOLDERS = {
    ["tier"] = {"tiers", {
		"30speed.lua",
		"a_legend.lua",
		"accelerated.lua",
		"airy.lua",
		"amateur.lua",
		"america1.lua",
		"america10.lua",
		"america102.lua",
		"america11.lua",
		"america112.lua",
		"america12.lua",
		"america2.lua",
		"america22.lua",
		"america3.lua",
		"america32.lua",
		"america4.lua",
		"america42.lua",
		"america5.lua",
		"america52.lua",
		"america6.lua",
		"america62.lua",
		"america7.lua",
		"america72.lua",
		"america8.lua",
		"america82.lua",
		"america9.lua",
		"america92.lua",
		"ammofull.lua",
		"angelic.lua",
		"apprentice.lua",
		"april_fools_gun.lua",
		"astral.lua",
		"blissful.lua",
		"blooming.lua",
		"boston.lua",
		"bright.lua",
		"busted.lua",
		"celestial.lua",
		"chaotic.lua",
		"charismatic.lua",
		"click.lua",
		"cloudless.lua",
		"coal.lua",
		"community.lua",
		"cozy.lua",
		"crisp.lua",
		"dashin.lua",
		"dashing.lua",
		"decorated.lua",
		"deranged.lua",
		"devoted.lua",
		"divine.lua",
		"dual.lua",
		"dynamic.lua",
		"eccentric.lua",
		"eggcellent.lua",
		"eggciting.lua",
		"eggsposed.lua",
		"eggstraodinary.lua",
		"eggstravaganza.lua",
		"eggstreme.lua",
		"energized.lua",
		"erratic.lua",
		"eternal.lua",
		"evergreen.lua",
		"expert.lua",
		"fair.lua",
		"faulty.lua",
		"fearful.lua",
		"feeble.lua",
		"festive.lua",
		"floral.lua",
		"flourishing.lua",
		"fluffy.lua",
		"free.lua",
		"free2.lua",
		"fresh.lua",
		"friendly.lua",
		"frisky.lua",
		"giftwrapped.lua",
		"giving.lua",
		"global.lua",
		"godd.lua",
		"halloween_tier50.lua",
		"halloween_tier51.lua",
		"halloween_tier52.lua",
		"halloween_tier53.lua",
		"halloween_tier55.lua",
		"halloween_tier56.lua",
		"halloween_tier57.lua",
		"halloween_tier60.lua",
		"halloween_tier61.lua",
		"halloween_tier62.lua",
		"halloween_tier63.lua",
		"halloween_tier70.lua",
		"halloween_tier71.lua",
		"halloween_tier80.lua",
		"harmful.lua",
		"haywire.lua",
		"heavenly.lua",
		"heroic.lua",
		"hippity.lua",
		"holiday.lua",
		"hoppity.lua",
		"immortal.lua",
		"incredible.lua",
		"infringed.lua",
		"intimidating.lua",
		"jolly.lua",
		"joyful.lua",
		"junky.lua",
		"kosher.lua",
		"legend.lua",
		"legendary.lua",
		"lightweight.lua",
		"limited2.lua",
		"limited3.lua",
		"limited4.lua",
		"limited5.lua",
		"limited6.lua",
		"lovely.lua",
		"lush.lua",
		"magical.lua",
		"marvelous.lua",
		"master.lua",
		"mediocre.lua",
		"meepentest.lua",
		"meme1.lua",
		"meme10.lua",
		"meme11.lua",
		"meme12.lua",
		"meme13.lua",
		"meme14.lua",
		"meme15.lua",
		"meme16.lua",
		"meme17.lua",
		"meme18.lua",
		"meme19.lua",
		"meme2.lua",
		"meme3.lua",
		"meme4.lua",
		"meme5.lua",
		"meme6.lua",
		"meme7.lua",
		"meme8.lua",
		"meme9.lua",
		"merry.lua",
		"moderate.lua",
		"mythical.lua",
		"new_year_2018_giveaway.lua",
		"novice.lua",
		"odd.lua",
		"ordinary.lua",
		"partisan.lua",
		"passable.lua",
		"passable2.lua",
		"peppy.lua",
		"petty.lua",
		"pleasent.lua",
		"precise.lua",
		"priceless.lua",
		"professional.lua",
		"pure.lua",
		"quaint.lua",
		"rapid.lua",
		"recycled.lua",
		"remarkable.lua",
		"retracted.lua",
		"righteous.lua",
		"rough.lua",
		"sacred.lua",
		"saintlike.lua",
		"santa.lua",
		"satanic.lua",
		"selfmade.lua",
		"shabby.lua",
		"shiny.lua",
		"snowy.lua",
		"soft.lua",
		"spectacular.lua",
		"stable.lua",
		"steady.lua",
		"stock.lua",
		"strange.lua",
		"stunning.lua",
		"summer1.lua",
		"summer10.lua",
		"summer11.lua",
		"summer12.lua",
		"summer13.lua",
		"summer14.lua",
		"summer15.lua",
		"summer16.lua",
		"summer17.lua",
		"summer18.lua",
		"summer19.lua",
		"summer2.lua",
		"summer20.lua",
		"summer21.lua",
		"summer3.lua",
		"summer4.lua",
		"summer5.lua",
		"summer6.lua",
		"summer7.lua",
		"summer8.lua",
		"summer9.lua",
		"sunny.lua",
		"sustainable.lua",
		"sweet.lua",
		"talenttest.lua",
		"tattered.lua",
		"titan_t_0.lua",
		"titan_t_1.lua",
		"titan_t_2.lua",
		"titan_t_3.lua",
		"titan_t_4.lua",
		"tolerable.lua",
		"touted.lua",
		"trifling.lua",
		"turbid.lua",
		"uncanny.lua",
		"unusual.lua",
		"valentine_tier50.lua",
		"valentine_tier51.lua",
		"valentine_tier52.lua",
		"valentine_tier53.lua",
		"valentine_tier54.lua",
		"valentine_tier55.lua",
		"valentine_tier56.lua",
		"valentine_tier57.lua",
		"valentine_tier58.lua",
		"valentine_tier59.lua",
		"valentine_tier60.lua",
		"valentine_tier61.lua",
		"valentine_tier62.lua",
		"valentine_tier63.lua",
		"valentine_tier64.lua",
		"valentine_tier65.lua",
		"valentine_tier70.lua",
		"valentine_tier71.lua",
		"valentine_tier72.lua",
		"valentine_tier73.lua",
		"valentine_tier80.lua",
		"vibrant.lua",
		"virtuous.lua",
		"warm.lua",
		"weak.lua",
		"wicked.lua",
		"zesty.lua",
		"cincodemayo1.lua",
		"cincodemayo2.lua",
		"cincodemayo3.lua",
		"cincodemayo4.lua",
		"cincodemayo5.lua",
	}},
    ["Unique"] = {"uniques", {
		"akimbonators.lua",
		"akimbonitos.lua",
		"alienpoo90.lua",
		"autocatis.lua",
		"beachnclear.lua",
		"beta_unique1.lua",
		"beta_unique2.lua",
		"beta_unique3.lua",
		"bondsdoublefriend.lua",
		"bondsworstfriend.lua",
		"bunnynclyde.lua",
		"christmas_unique1.lua",
		"christmas_unique10.lua",
		"christmas_unique11.lua",
		"christmas_unique12.lua",
		"christmas_unique13.lua",
		"christmas_unique14.lua",
		"christmas_unique15.lua",
		"christmas_unique16.lua",
		"christmas_unique2.lua",
		"collectinator.lua",
		"compactachi.lua",
		"dbmonster.lua",
		"deadshot.lua",
		"deagle07.lua",
		"doombringer.lua",
		"dualdeagles.lua",
		"dualglocks.lua",
		"dualglocks2.lua",
		"dualhuge.lua",
		"dualhuge2.lua",
		"dualm16.lua",
		"dualmac10.lua",
		"dualmac102.lua",
		"dualpistols.lua",
		"dualrifles.lua",
		"dualsg550.lua",
		"dualsg5502.lua",
		"dualshotgun.lua",
		"dualtmp.lua",
		"dualtmp2.lua",
		"dualump.lua",
		"dualump2.lua",
		"easter90.lua",
		"easternator.lua",
		"ecopati.lua",
		"energizing_ak47.lua",
		"energizing_mac10.lua",
		"energizing_mp40.lua",
		"energizing_sg550.lua",
		"energizing_switchpa.lua",
		"executioner.lua",
		"fazetrickshotter.lua",
		"gauntlet.lua",
		"goognsta.lua",
		"goongsto.lua",
		"hawkeye.lua",
		"hedgeshooter.lua",
		"hippityhoppity.lua",
		"holukis.lua",
		"intruderkiller.lua",
		"jellyparade.lua",
		"juantap.lua",
		"kahtinga.lua",
		"kickback.lua",
		"lemmings.lua",
		"loyalist.lua",
		"m4alover.lua",
		"m4alover1.lua",
		"m4alover2.lua",
		"misericordia.lua",
		"mohtuanica.lua",
		"nintendoswitchpa.lua",
		"oldcomrade.lua",
		"onetap.lua",
		"paintball_famas.lua",
		"paintball_galil.lua",
		"paintball_m16.lua",
		"paintball_mp40.lua",
		"paintball_stealthano.lua",
		"patriot.lua",
		"patriot2.lua",
		"pocketier.lua",
		"raginator.lua",
		"ratisaci.lua",
		"ruscelena.lua",
		"semiglock17.lua",
		"shoopan.lua",
		"slentog.lua",
		"slowihux.lua",
		"space90.lua",
		"spasinator.lua",
		"spraynpray.lua",
		"stealthano.lua",
		"taluhoo.lua",
		"the_apprentice.lua",
		"the_hand.lua",
		"the_master.lua",
		"thedeliverer.lua",
		"trenchinator.lua",
		"trustysteed.lua",
		"unique_4_1.lua",
		"unique_4_2.lua",
		"unique_4_3.lua",
		"unique_4_4.lua",
		"unique_4_5.lua",
		"unique_5_1.lua",
		"unique_5_2.lua",
		"unique_5_3.lua",
		"unique_5_4.lua",
		"unique_5_5.lua",
		"unique_5_6.lua",
		"unique_6_1.lua",
		"unique_6_2.lua",
		"unique_6_3.lua",
		"unique_6_4.lua",
		"unique_6_5.lua",
		"unique_6_6.lua",
		"unique_7_1.lua",
		"unique_7_2.lua",
		"unique_7_3.lua",
		"unique_7_4.lua",
		"unique_7_5.lua",
		"unique_7_6.lua",
		"unique_8_1.lua",
		"unique_8_2.lua",
		"volcanica.lua",
		"westernaci.lua",
		"zeusitae.lua",
	}},
    ["Power-Up"] = {"powerups", {
		"ammohoarder.lua",
		"catsense.lua",
		"credithoarder.lua",
		"flamepacked.lua",
		"froghopper.lua",
		"hardhat.lua",
		"healthbloom.lua",
		"marathonrunner.lua",
		"xplover.lua",
	}},
    ["Hat"] = {"hats", {
		"a_crown.lua",
		"afro.lua",
		"afro2.lua",
		"astronauthelmet.lua",
		"baseballcap.lua",
		"bearhat.lua",
		"bearhat2.lua",
		"beerhat0.lua",
		"beerhat02.lua",
		"beerhat1.lua",
		"beerhat12.lua",
		"beerhat2.lua",
		"beerhat22.lua",
		"beerhat3.lua",
		"beerhat32.lua",
		"beerhat4.lua",
		"beerhat42.lua",
		"beerhat5.lua",
		"beerhat52.lua",
		"billyhatcherhat.lua",
		"blackmage_hat.lua",
		"bucket.lua",
		"bunny_hood.lua",
		"bunnyears.lua",
		"cakehat.lua",
		"cat_in_the_hat.lua",
		"catears.lua",
		"catears2.lua",
		"cathat.lua",
		"chicken_hat.lua",
		"cowboyhat.lua",
		"crocodile_dundee_hat.lua",
		"deadmau5.lua",
		"devhat.lua",
		"doctor_fez_cap.lua",
		"dr_suess_santa_hat.lua",
		"drinkcap.lua",
		"duncehat.lua",
		"easter_bunny.lua",
		"easter_icon.lua",
		"elf_hat.lua",
		"elf_santa_hat.lua",
		"estilo_muerto.lua",
		"evil_plant_head.lua",
		"fedorahat.lua",
		"floral_giggle.lua",
		"foolish_topper.lua",
		"froghat.lua",
		"galactus_helmet.lua",
		"generalpepperhat.lua",
		"hat01_fix.lua",
		"hat01_fix_1.lua",
		"hat01_fix_2.lua",
		"hat01_fix_3.lua",
		"hat01_fix_4.lua",
		"hat01_fix_5.lua",
		"hat01_fix_6.lua",
		"hat01_fix_7.lua",
		"hat03.lua",
		"hat03_1.lua",
		"hat03_2.lua",
		"hat03_3.lua",
		"hat03_4.lua",
		"hat04.lua",
		"hat04_1.lua",
		"hat04_2.lua",
		"hat04_3.lua",
		"hat04_4.lua",
		"hat06.lua",
		"hat07.lua",
		"hat07_1.lua",
		"hat07_10.lua",
		"hat07_2.lua",
		"hat07_3.lua",
		"hat07_4.lua",
		"hat07_5.lua",
		"hat07_6.lua",
		"hat07_7.lua",
		"hat07_8.lua",
		"hat07_9.lua",
		"hat08_0.lua",
		"hat08_1.lua",
		"hat08_2.lua",
		"hat08_3.lua",
		"hat08_4.lua",
		"hat08_5.lua",
		"hat08_6.lua",
		"hatching_noob.lua",
		"headcrab.lua",
		"headphones.lua",
		"heartband.lua",
		"heartband2.lua",
		"hearthat.lua",
		"hearthat2.lua",
		"holy_cuteness.lua",
		"kfcbucket.lua",
		"king_neptunes_crown.lua",
		"kingbooscrown.lua",
		"kittyhat.lua",
		"klonoahat.lua",
		"krusty_krab_hat.lua",
		"kung_lao.lua",
		"linkhat.lua",
		"luigihat.lua",
		"mad_hatter.lua",
		"mariohat.lua",
		"midnahat.lua",
		"monocle.lua",
		"narutos_sleeping_cap.lua",
		"nightmarehat.lua",
		"olimars_helmet.lua",
		"pac-man_helmet.lua",
		"partyhat.lua",
		"philosophy_bulb.lua",
		"pilgrimhat.lua",
		"pimp_hat.lua",
		"pipo_helmet.lua",
		"playboy_parti_bunni.lua",
		"pot_head.lua",
		"pot_head2.lua",
		"princess_peachs_crown.lua",
		"redshat.lua",
		"robot_chicken_hat.lua",
		"rudolph_hat.lua",
		"santahat.lua",
		"santascap.lua",
		"seusshat.lua",
		"sharky_hat.lua",
		"shredder_helmet.lua",
		"smore_chef.lua",
		"sombrero.lua",
		"sombrero2.lua",
		"sorting_hat.lua",
		"spinny_hat.lua",
		"starband.lua",
		"steampunk_tophat.lua",
		"straw_hat.lua",
		"strawhat.lua",
		"sunhat.lua",
		"teamrockethat.lua",
		"teemo_hat.lua",
		"the_goofy_goober.lua",
		"the_ic_warrior.lua",
		"the_number_one_hat.lua",
		"the_stout_shako.lua",
		"thors_helmet.lua",
		"top_hat_of_bling_bling.lua",
		"tophat.lua",
		"towering_pillar_of_hats.lua",
		"turkey.lua",
		"turtle.lua",
		"umbrella_hat.lua",
		"viewtifuljoehelmet.lua",
		"witchhat.lua",
		"zeppeli_hat.lua",
		"zhat.lua",
	}},
    ["Mask"] = {"masks", {
		"3dglasses.lua",
		"3dglasses2.lua",
		"aku_aku_mask.lua",
		"alien_head.lua",
		"androssmask.lua",
		"anonymous_mask.lua",
		"arkham_knight_helmet_.lua",
		"arnoldmask.lua",
		"aviators.lua",
		"aviators2.lua",
		"bag0.lua",
		"bag1.lua",
		"bag10.lua",
		"bag11.lua",
		"bag12.lua",
		"bag13.lua",
		"bag14.lua",
		"bag15.lua",
		"bag16.lua",
		"bag17.lua",
		"bag18.lua",
		"bag19.lua",
		"bag2.lua",
		"bag20.lua",
		"bag21.lua",
		"bag22.lua",
		"bag23.lua",
		"bag24.lua",
		"bag25.lua",
		"bag26.lua",
		"bag3.lua",
		"bag4.lua",
		"bag5.lua",
		"bag6.lua",
		"bag7.lua",
		"bag8.lua",
		"bag9.lua",
		"bane_mask.lua",
		"batmanmask.lua",
		"bear.lua",
		"bender_head.lua",
		"biblethump_mask.lua",
		"billy_mask.lua",
		"blackhorsiemask.lua",
		"bloodybirdmask.lua",
		"bloodybutterflymask.lua",
		"bloodycatmask.lua",
		"bloodyrabbitmask.lua",
		"bombermanhelmet.lua",
		"bondrewds_helmet.lua",
		"brownhorsiemask.lua",
		"captain_falcons_helmet.lua",
		"cat.lua",
		"chuckmask.lua",
		"clout_goggles.lua",
		"colorfulbirdmask.lua",
		"confined_cranium.lua",
		"crusaders_helment.lua",
		"cuboneskull.lua",
		"daft_punk_helmet.lua",
		"darth_vader_helmet.lua",
		"demon_shank.lua",
		"doctor0.lua",
		"doctor1.lua",
		"doctor2.lua",
		"dolphmask.lua",
		"duck_mask.lua",
		"egg_alien.lua",
		"egg_blue.lua",
		"egg_lava.lua",
		"egg_money.lua",
		"egg_myster.lua",
		"egg_slime.lua",
		"egg_stained.lua",
		"egg_wire.lua",
		"egg_wooden.lua",
		"eggmask_9000.lua",
		"eggmask_9001.lua",
		"eggmask_9002.lua",
		"eggmask_9003.lua",
		"eggmask_9004.lua",
		"eggmask_9005.lua",
		"eggmask_9006.lua",
		"eggmask_9007.lua",
		"eggmask_9008.lua",
		"eggmask_9009.lua",
		"eggmask_9010.lua",
		"eggmask_9011.lua",
		"eggmask_9012.lua",
		"eggmask_9013.lua",
		"eggmask_9014.lua",
		"eggmask_9015.lua",
		"eggmask_9016.lua",
		"eggmask_9017.lua",
		"eggmask_9018.lua",
		"eggmask_9019.lua",
		"eggmask_9020.lua",
		"eggmask_9021.lua",
		"eggmask_9022.lua",
		"eggmask_9023.lua",
		"eggmask_9024.lua",
		"eggmask_9025.lua",
		"eggmask_9026.lua",
		"eggmask_9027.lua",
		"eggmask_9028.lua",
		"eggmask_9029.lua",
		"eggmask_9030.lua",
		"eggmask_9031.lua",
		"eggmask_9032.lua",
		"eggmask_9033.lua",
		"eggmask_9034.lua",
		"eggmask_9035.lua",
		"eggmask_9036.lua",
		"eggmask_9037.lua",
		"eggmask_9038.lua",
		"eggmask_9039.lua",
		"eggmask_9040.lua",
		"eggmask_9041.lua",
		"eggmask_9042.lua",
		"eggmask_9043.lua",
		"eggmask_9044.lua",
		"eggmask_9045.lua",
		"eggmask_9046.lua",
		"eggmask_9047.lua",
		"eggmask_9048.lua",
		"eggmask_9049.lua",
		"eggmask_9050.lua",
		"eggmask_9051.lua",
		"eggmask_9052.lua",
		"eggmask_9053.lua",
		"eggmask_9054.lua",
		"eggmask_9055.lua",
		"eggmask_9056.lua",
		"eggmask_9057.lua",
		"eggmask_9058.lua",
		"eggmask_9059.lua",
		"eggmask_9060.lua",
		"eggmask_9061.lua",
		"eggmask_9062.lua",
		"eggmask_9063.lua",
		"eggmask_9064.lua",
		"eggmask_9065.lua",
		"eggmask_9066.lua",
		"eggmask_9067.lua",
		"eggmask_9068.lua",
		"eggmask_9069.lua",
		"eggmask_9070.lua",
		"eggmask_9071.lua",
		"eggmask_9072.lua",
		"eggmask_9073.lua",
		"eggmask_9074.lua",
		"eggmask_9075.lua",
		"eggmask_9077.lua",
		"eggmask_9078.lua",
		"eggmask_9079.lua",
		"eggmask_9080.lua",
		"eggmask_9081.lua",
		"eggmask_9082.lua",
		"eggmask_9083.lua",
		"eggmask_9084.lua",
		"eggmask_9085.lua",
		"eggmask_9086.lua",
		"eggmask_9087.lua",
		"eggmask_9088.lua",
		"eggmask_9089.lua",
		"eggmask_9090.lua",
		"eggmask_9091.lua",
		"eggmask_9092.lua",
		"eggmask_9093.lua",
		"eggmask_9094.lua",
		"eggmask_9095.lua",
		"eggmask_9096.lua",
		"eggmask_9097.lua",
		"eggmask_9098.lua",
		"eggmask_9099.lua",
		"eggmask_9100.lua",
		"eggmask_9101.lua",
		"eggmask_9102.lua",
		"eggmask_9103.lua",
		"eggmask_9104.lua",
		"eggmask_9105.lua",
		"eggmask_9106.lua",
		"eggmask_9107.lua",
		"eggmask_9108.lua",
		"eggmask_9109.lua",
		"eggmask_9110.lua",
		"eggmask_9111.lua",
		"eggmask_9112.lua",
		"eggmask_9113.lua",
		"eggmask_9114.lua",
		"eggmask_9115.lua",
		"eggmask_9116.lua",
		"eggmask_9117.lua",
		"eggmask_9118.lua",
		"eggmask_9119.lua",
		"eggmask_9120.lua",
		"eggmask_9121.lua",
		"eggmask_9122.lua",
		"eggmask_9123.lua",
		"eggmask_9124.lua",
		"eggmask_9125.lua",
		"eggmask_9126.lua",
		"eggmask_9127.lua",
		"eggmask_9128.lua",
		"eggmask_9129.lua",
		"eggmask_9130.lua",
		"eggmask_9131.lua",
		"eggmask_9132.lua",
		"eggmask_9133.lua",
		"eggmask_9134.lua",
		"eggmask_9135.lua",
		"eggmask_9136.lua",
		"eggmask_9137.lua",
		"eggmask_9138.lua",
		"eggmask_9139.lua",
		"eggmask_9140.lua",
		"eggmask_9141.lua",
		"eggmask_9142.lua",
		"eggmask_9143.lua",
		"eggmask_9144.lua",
		"eggmask_9145.lua",
		"eggmask_9146.lua",
		"eggmask_9147.lua",
		"eggmask_9148.lua",
		"eggmask_9149.lua",
		"eggmask_9150.lua",
		"eggmask_9151.lua",
		"eggmask_9152.lua",
		"eggmask_9153.lua",
		"eggmask_9154.lua",
		"eggmask_9155.lua",
		"eggmask_9156.lua",
		"eggmask_9157.lua",
		"eggmask_9158.lua",
		"eggmask_9159.lua",
		"eggmask_9160.lua",
		"eggmask_9161.lua",
		"eggmask_9162.lua",
		"eggmask_9163.lua",
		"eggmask_9164.lua",
		"eggmask_9165.lua",
		"eggmask_9166.lua",
		"eggmask_9167.lua",
		"eggmask_9168.lua",
		"eggmask_9169.lua",
		"eggmask_9170.lua",
		"eggmask_9171.lua",
		"eggmask_9172.lua",
		"eggmask_9173.lua",
		"eggmask_9174.lua",
		"eggmask_9175.lua",
		"eggmask_9176.lua",
		"eggmask_9177.lua",
		"eggmask_9178.lua",
		"eggmask_9179.lua",
		"eggmask_9180.lua",
		"eggmask_9181.lua",
		"eggmask_9182.lua",
		"eggmask_9183.lua",
		"eggmask_9184.lua",
		"eggmask_9185.lua",
		"eggmask_9186.lua",
		"eggmask_9187.lua",
		"eggmask_9188.lua",
		"eggmask_9189.lua",
		"eggmask_9190.lua",
		"elmoustache.lua",
		"fox.lua",
		"gas_mask.lua",
		"gingerbread_mask.lua",
		"glasses01.lua",
		"glasses01_1.lua",
		"glasses01_2.lua",
		"glasses01_3.lua",
		"glasses01_4.lua",
		"glasses01_5.lua",
		"glasses02.lua",
		"glasses02_1.lua",
		"glasses02_2.lua",
		"glasses02_3.lua",
		"glasses02_4.lua",
		"grandmaglasses.lua",
		"gray_fox_mask.lua",
		"halloween_mask.lua",
		"halloween_mask10.lua",
		"halloween_mask11.lua",
		"halloween_mask12.lua",
		"halloween_mask13.lua",
		"halloween_mask14.lua",
		"halloween_mask15.lua",
		"halloween_mask16.lua",
		"halloween_mask17.lua",
		"halloween_mask18.lua",
		"halloween_mask19.lua",
		"halloween_mask2.lua",
		"halloween_mask20.lua",
		"halloween_mask21.lua",
		"halloween_mask22.lua",
		"halloween_mask23.lua",
		"halloween_mask24.lua",
		"halloween_mask25.lua",
		"halloween_mask26.lua",
		"halloween_mask27.lua",
		"halloween_mask28.lua",
		"halloween_mask29.lua",
		"halloween_mask3.lua",
		"halloween_mask30.lua",
		"halloween_mask31.lua",
		"halloween_mask32.lua",
		"halloween_mask4.lua",
		"halloween_mask5.lua",
		"halloween_mask6.lua",
		"halloween_mask7.lua",
		"halloween_mask8.lua",
		"halloween_mask9.lua",
		"hannibal_mask.lua",
		"hattington_anxious.lua",
		"hattington_ecstatic.lua",
		"hattington_impartial.lua",
		"hattington_liberal.lua",
		"hattington_pensive.lua",
		"hattington_weeping.lua",
		"hawk1.lua",
		"hawk12.lua",
		"hawk2.lua",
		"hawk22.lua",
		"headwrap1_0.lua",
		"headwrap1_1.lua",
		"headwrap1_2.lua",
		"headwrap1_3.lua",
		"headwrap2_0.lua",
		"headwrap2_1.lua",
		"headwrap2_2.lua",
		"headwrap2_3.lua",
		"heartweldermask.lua",
		"heartweldermask2.lua",
		"hei_mask.lua",
		"helmet_of_fate.lua",
		"holday_star_glasses.lua",
		"hollow_knight_mask.lua",
		"iron_helmet.lua",
		"jack-o-lantern_mask.lua",
		"jasonmask.lua",
		"kawaii_dozer_mask.lua",
		"keatonmask.lua",
		"legohead.lua",
		"level_3_helmet.lua",
		"magnetos_helmet.lua",
		"majoramask.lua",
		"majoras_moon_mask.lua",
		"makarmask.lua",
		"marshmellos_helmet.lua",
		"mask_2_0.lua",
		"mask_2_1.lua",
		"mask_2_10.lua",
		"mask_2_11.lua",
		"mask_2_12.lua",
		"mask_2_13.lua",
		"mask_2_14.lua",
		"mask_2_2.lua",
		"mask_2_3.lua",
		"mask_2_4.lua",
		"mask_2_5.lua",
		"mask_2_6.lua",
		"mask_2_7.lua",
		"mask_2_8.lua",
		"mask_2_9.lua",
		"mask_4_0.lua",
		"mask_4_1.lua",
		"mask_4_2.lua",
		"mask_4_3.lua",
		"mask_4_4.lua",
		"mask_4_5.lua",
		"mask_4_6.lua",
		"mask_4_7.lua",
		"mask_4_8.lua",
		"mask_5.lua",
		"mask_6_0.lua",
		"mask_6_1.lua",
		"mask_6_2.lua",
		"mask_6_3.lua",
		"mega_man_helmet.lua",
		"merry_xmas_glasses.lua",
		"metaknight.lua",
		"metroid_hat.lua",
		"miraaks_mask.lua",
		"monkey0.lua",
		"monkey1.lua",
		"monkey2.lua",
		"monkey3.lua",
		"monocle.lua",
		"monstro_head.lua",
		"night_vision_goggles.lua",
		"ninja0.lua",
		"ninja1.lua",
		"ninja10.lua",
		"ninja102.lua",
		"ninja2.lua",
		"ninja3.lua",
		"ninja4.lua",
		"ninja5.lua",
		"ninja6.lua",
		"ninja7.lua",
		"ninja8.lua",
		"ninja9.lua",
		"noentry.lua",
		"noface.lua",
		"ori_mask.lua",
		"owl.lua",
		"peacockbutterflymask.lua",
		"pennywise_mask.lua",
		"pig0.lua",
		"pig1.lua",
		"pomask.lua",
		"psycho_mask.lua",
		"pumpkin.lua",
		"redead_mask.lua",
		"reindeer_glasses.lua",
		"robocop_helmet.lua",
		"royalcatmask.lua",
		"royalrabbitmask.lua",
		"royalspidermask.lua",
		"rubikscube.lua",
		"saiyan_scouter.lua",
		"samushelmet.lua",
		"santa_glasses.lua",
		"santa_hat_glasses.lua",
		"saurons_helmet.lua",
		"scream_mask.lua",
		"servbothead.lua",
		"shovel_knight_helmet.lua",
		"shutterglasses.lua",
		"shutterglasses2.lua",
		"skull0.lua",
		"skull1.lua",
		"skull2.lua",
		"skull3.lua",
		"snowboardgoggles.lua",
		"snowman_mask.lua",
		"spawn_mask.lua",
		"starglasses.lua",
		"stormtrooper_helmet.lua",
		"stylishglasses.lua",
		"thomas.lua",
		"toromask.lua",
		"trappers_mask.lua",
		"trash_bag.lua",
		"turqoisebirdmask.lua",
		"vault_boy_mask.lua",
		"wolf.lua",
		"xmas_tree_glasses.lua",
		"zahkriisos_mask.lua",
		"zer0s_mask.lua",
		"zombie0.lua",
		"zombie1.lua",
	}},
    ["Model"] = {"models", {
		"agent47.lua",
		"altair.lua",
		"alyx.lua",
		"barney.lua",
		"bobafett.lua",
		"breen.lua",
		"bugsbunny.lua",
		"chewbacca.lua",
		"chris.lua",
		"civ1.lua",
		"civ2.lua",
		"civ3.lua",
		"civ4.lua",
		"civ5.lua",
		"civ6.lua",
		"classy_gentleman.lua",
		"deadpool.lua",
		"deathstroke.lua",
		"dino.lua",
		"dishonored_assassin.lua",
		"drunksanta.lua",
		"dude.lua",
		"eastertrooper.lua",
		"elftrooper.lua",
		"eli.lua",
		"f_civ1r.lua",
		"f_civ2r.lua",
		"f_civ3r.lua",
		"f_civ4r.lua",
		"f_civ5r.lua",
		"f_civ6r.lua",
		"faith.lua",
		"freddykruger.lua",
		"gingerfast.lua",
		"gman.lua",
		"gordon.lua",
		"grayfox.lua",
		"halloweenking.lua",
		"haroldlott.lua",
		"hostage1.lua",
		"hostage2.lua",
		"hostage3.lua",
		"hostage4.lua",
		"hunter.lua",
		"ironman.lua",
		"isaac_clarke.lua",
		"jack_sparrow.lua",
		"joker.lua",
		"jollysanta.lua",
		"kliener.lua",
		"knight.lua",
		"m_civ1.lua",
		"m_civ19r.lua",
		"m_civ1r.lua",
		"m_civ2.lua",
		"m_civ2r.lua",
		"m_civ3.lua",
		"m_civ3r.lua",
		"m_civ4.lua",
		"m_civ4r.lua",
		"m_civ5.lua",
		"m_civ5r.lua",
		"m_civ6.lua",
		"m_civ6r.lua",
		"m_civ7.lua",
		"m_civ7r.lua",
		"m_civ8.lua",
		"m_civ8r.lua",
		"m_civ9.lua",
		"magnusson.lua",
		"masked_breen.lua",
		"masseffect.lua",
		"master_chief.lua",
		"monk.lua",
		"mossman.lua",
		"niko.lua",
		"normal.lua",
		"odessa.lua",
		"reindeertrooper.lua",
		"robber.lua",
		"romanbellic.lua",
		"rorschach.lua",
		"rudolph.lua",
		"santatrooper.lua",
		"scarecrow.lua",
		"scorpion.lua",
		"screammodel.lua",
		"shaun.lua",
		"skeleton.lua",
		"smith.lua",
		"soldier_stripped.lua",
		"solid_snake.lua",
		"spacesuit.lua",
		"spy.lua",
		"subzero.lua",
		"summerclimb1.lua",
		"summerclimb2.lua",
		"summerclimb3.lua",
		"summerclimb4.lua",
		"summerclimb5.lua",
		"terrorist1.lua",
		"terrorist10.lua",
		"terrorist11.lua",
		"terrorist12.lua",
		"terrorist13.lua",
		"terrorist14.lua",
		"terrorist2.lua",
		"terrorist3.lua",
		"terrorist4.lua",
		"terrorist5.lua",
		"terrorist6.lua",
		"terrorist7.lua",
		"terrorist8.lua",
		"terrorist9.lua",
		"teslapower.lua",
		"wciv1.lua",
		"wciv2.lua",
		"wciv3.lua",
		"wciv4.lua",
		"wciv5.lua",
		"wciv6.lua",
		"zero_samus.lua",
		"zoey.lua",
	}},
    ["Crate"] = {"crates", {
		"alphacrate.lua",
		"betacrate.lua",
		"boxofchoclates.lua",
		"cosmeticcrate.lua",
		"crescentcrate.lua",
		"crimsoncrate.lua",
		"easter_basket.lua",
		"easter_basket_2019.lua",
		"easter_basket_2019_gold.lua",
		"easter_basket_2020.lua",
		"easteregg.lua",
		"effectcrate.lua",
		"fiftyfiftycrate.lua",
		"holidaycrate.lua",
		"hypecrate.lua",
		"independencecrate.lua",
		"meleecrate.lua",
		"memecrate.lua",
		"modelcrate.lua",
		"paint.lua",
		"pumpkin.lua",
		"springcrate.lua",
		"titan_crate.lua",
		"urbancrate.lua",
		"cincodemayo.lua"
	}},
    ["Melee"] = {"melees", {
		"baseballbat.lua",
		"baton.lua",
		"baton2.lua",
		"candycane.lua",
		"cardboardknife.lua",
		"chair.lua",
		"deepfryingpan.lua",
		"diamondpick.lua",
		"fish.lua",
		"fists.lua",
		"fryingpan.lua",
		"katana.lua",
		"keyboard.lua",
		"lightsaber.lua",
		"mcsword.lua",
		"meatcleaver.lua",
		"pipewrench.lua",
		"rollingpin.lua",
		"smartpen.lua",
		"sword.lua",
		"tomahawk.lua",
		"toyhammer.lua",
	}},
    ["Effect"] = {"effects", {
		"blackhole.lua",
		"blackice.lua",
		"bluedata.lua",
		"burger.lua",
		"carry.lua",
		"combineball.lua",
		"confusion.lua",
		"dechimera.lua",
		"developer.lua",
		"diamondskull.lua",
		"donut.lua",
		"drdanger.lua",
		"drdanger2.lua",
		"duhaf.lua",
		"dungo.lua",
		"editor.lua",
		"gman.lua",
		"goldenfish.lua",
		"holylight.lua",
		"horse.lua",
		"hotdog.lua",
		"hulladoll.lua",
		"icehead.lua",
		"illin.lua",
		"lamarr.lua",
		"lapiz.lua",
		"lifesaver.lua",
		"littleone.lua",
		"lovd.lua",
		"m.lua",
		"magedisc.lua",
		"math.lua",
		"metrocop.lua",
		"money.lua",
		"nature.lua",
		"naturee.lua",
		"pantom.lua",
		"paradigm.lua",
		"pinkybar.lua",
		"questionmark.lua",
		"redscan.lua",
		"rocket.lua",
		"scanner.lua",
		"smallparticle.lua",
		"spinlava.lua",
		"spintoxin.lua",
		"spirits.lua",
		"stoneking.lua",
		"tesla.lua",
		"tinygordon.lua",
		"tornado.lua",
		"turtle.lua",
		"valve.lua",
		"whitesnake.lua",
		"yellowacid.lua",
		"yellowdata.lua",
	}},
    ["Body"] = {"body", {
		"backpack1.lua",
		"backpack1_1.lua",
		"backpack1_2.lua",
		"backpack2.lua",
		"backpack2_1.lua",
		"backpack2_2.lua",
		"backpack3.lua",
		"backpack3_1.lua",
		"balloonicorn.lua",
		"balloonicorn2.lua",
		"bandana.lua",
		"ducktube.lua",
		"scarf0.lua",
		"scarf1.lua",
		"scarf2.lua",
		"scarf3.lua",
		"scarf4.lua",
		"scarf5.lua",
		"scarf6.lua",
	}},
    ["Special"] = {"other", {
		"angryshoe.lua",
		"babynade.lua",
		"contagio.lua",
		"discombob.lua",
		"frozen_snowball.lua",
		"glacies.lua",
		"ignis.lua",
		"molitov.lua",
		"random_vape_limited.lua",
		"smoke.lua",
		"snowball.lua",
		"stealthbox.lua",
		"taunt_agree.lua",
		"taunt_beacon.lua",
		"taunt_bow.lua",
		"taunt_cheer.lua",
		"taunt_dab.lua",
		"taunt_disagree.lua",
		"taunt_flail.lua",
		"taunt_hands.lua",
		"taunt_laugh.lua",
		"taunt_lay.lua",
		"taunt_robot.lua",
		"taunt_salute.lua",
		"taunt_sexy.lua",
		"taunt_wave.lua",
		"taunt_zombie.lua",
		"tnt.lua",
		"vape_american.lua",
		"vape_american2.lua",
		"vape_butterfly.lua",
		"vape_custom.lua",
		"vape_dragon.lua",
		"vape_golden.lua",
		"vape_hallucionogenic.lua",
		"vape_helium.lua",
		"vape_juicy.lua",
		"vape_medical.lua",
		"vape_mega.lua",
		"vape_normal.lua",
		"xmas_flash.lua",
		"xmas_frag.lua",
		"xmas_smoke.lua",
	}},
    ["Usable"] = {"usables", {
		"ascended_stats.lua",
		"ascended_talents.lua",
		"cosmic_stats.lua",
		"cosmic_talents.lua",
		"d_usable.lua",
		"dog_mutator.lua",
		"gift_package.lua",
		"gift_package_empty.lua",
		"gift_usable.lua",
		"highend_stats.lua",
		"highend_talents.lua",
		"minigames_token1.lua",
		"minigames_token10.lua",
		"minigames_token11.lua",
		"minigames_token12.lua",
		"minigames_token13.lua",
		"minigames_token2.lua",
		"minigames_token3.lua",
		"minigames_token4.lua",
		"minigames_token5.lua",
		"minigames_token6.lua",
		"minigames_token7.lua",
		"minigames_token8.lua",
		"minigames_token9.lua",
		"moat_old_easter_egg.lua",
		"moat_old_easter_egg2.lua",
		"moat_old_easter_egg3.lua",
		"name_mutator.lua",
		"planetary_stats.lua",
		"planetary_talents.lua",
		"t_usable.lua",
		"vip_token.lua"
	}}
}

function m_CreatePaints()
	for k , v in pairs(MOAT_PAINT.Tints) do
		local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this tint to use it on a weapon"
        tbl.Rarity = v[3]
        tbl.Clr = v[2]
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 1
        tbl.Image = v[4] or "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
        tbl.ItemCheck = 11
        function tbl:ItemUsed(pl, slot, item)
            m_TintItem(pl, slot, item, self.ID)
        end

		if (tbl.Name and tbl.Name == "Pure White Tint") then
			tbl.NotDroppable = true
		end

        m_AddDroppableItem(tbl, "Usable")
	end

	for k, v in pairs(MOAT_PAINT.Paints) do
		local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this paint to use it on an item"
        tbl.Rarity = v[3]
        tbl.Clr = v[2]
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = v[4] or "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
        tbl.ItemCheck = 10
        function tbl:ItemUsed(pl, slot, item)
            m_PaintItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")
	end

	for k, v in pairs(MOAT_PAINT.Skins) do
        local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this skin to use it on a weapon"
        tbl.Rarity = v[3]
        tbl.Texture = v[2]
        tbl.Collection = v[5] or "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = v[4] or "https://cdn.moat.gg/f/2198b5d9d5c8a1e35fe2a4c833556fd6.png"
        tbl.ItemCheck = 12
        function tbl:ItemUsed(pl, slot, item)
            m_TextureItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")
    end
end

local COSMETIC_TYPES = {
    ["Hat"] = true,
    ["Mask"] = true, 
    ["Model"] = true, 
    ["Effect"] = true, 
    ["Body"] = true,
}

function m_InitializeItems()
    for type, folder in pairs(MOAT_ITEM_FOLDERS) do
		for _, filename in ipairs(folder[2]) do
            ITEM = {}

			if (SERVER) then
				AddCSLuaFile(MOAT_ITEM_FOLDER .. "/" .. folder[1] .. "/" .. filename)
			end

            include(MOAT_ITEM_FOLDER .. "/" .. folder[1] .. "/" .. filename)
			if (ITEM.ID) then
				m_AddDroppableItem(ITEM, type)
			end

			if (CLIENT and COSMETIC_TYPES[type]) then
				m_AddCosmeticItem(ITEM, type)
			end

			if (type == "Melee" and ITEM.Collection and ITEM.Collection ~= "Melee Collection") then
				if (ITEM.Collection == "Independence Collection" or ITEM.Collection == "Holiday Collection") then
					continue
				end

				local Melee = table.Copy(ITEM)
				if (Melee.Name == "Deep Frying Ban") then
					Melee.NotDroppable = true
				end


				Melee.Collection = "Melee Collection"
				Melee.ID = ITEM.ID + 10000

				m_AddDroppableItem(Melee, type)
			end
        end
    end

	if (SERVER) then
		AddCSLuaFile(MOAT_ITEM_FOLDER .. "/paints/load.lua")
	end

    include(MOAT_ITEM_FOLDER .. "/paints/load.lua")
    m_CreatePaints()
    -- boom beep items loooooaded
end
m_InitializeItems()

concommand.Add("_reloaditems", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
	m_InitializeItems()
end)

concommand.Add("moat_finditemid",function(ply)
    if (IsValid(ply)) then return end

	local id = 0
    for i = 1,10000 do
        if (not MOAT_DROPTABLE[i] and id <= 100) then
            print("Unused: ITEM.ID = " .. i)
			id = id + 1
        end
    end
end)

concommand.Add("_reloadtalents", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
end)

local crate_cache = {}

function GetCrateContents(crate_collection)
    if (crate_cache[crate_collection]) then
        return crate_cache[crate_collection]
    end

    local contents = {}

    for k, v in pairs(MOAT_DROPTABLE) do
        if (v.Collection == crate_collection and v.Kind ~= "Crate") then
            if (not contents[tostring(v.Kind)]) then
                contents[tostring(v.Kind)] = {}
            end

            local title = v.Name or "NAME ERROR"
            local col = v.NameColor or nil
            local eff = v.NameEffect or nil
            local rar = v.Rarity or 1
            local mdl = v.Model or nil
            local skn = v.Skin or nil
            local iid = v.ID or nil

            table.insert(contents[tostring(v.Kind)], {
                name = title,
                color = col,
                effect = eff,
                rarity = rar,
                model = mdl,
                iskin = skn,
                id = iid
            })
        end
    end

    crate_cache[crate_collection] = contents

    return contents
end

local item_cache = {}
function GetItemFromEnum(ienum)
    if (ienum and item_cache[ienum]) then
		return item_cache[ienum]
    end

    local item_tbl = ienum and table.Copy(MOAT_DROPTABLE[ienum]) or {}
	if (ienum and not item_tbl.Kind) then
		local try = string.gsub(ienum, "2", "1", 1)

		if (MOAT_DROPTABLE[tonumber(try)]) then
			item_tbl = table.Copy(MOAT_DROPTABLE[tonumber(try)]) or {}
		end
	end

    item_tbl.OnPlayerSpawn = nil
    item_tbl.ModifyClientsideModel = nil
    item_tbl.DynamicModifyClientsideModel = nil
    item_tbl.EffectColor = nil
    item_tbl.EffectSize = nil
    item_tbl.OnDamageTaken = nil
    item_tbl.OnBeginRound = nil
    item_tbl.ScalePlayerDamage = nil
    item_tbl.ItemUsed = nil

    if (item_tbl.Kind == "Crate" and CLIENT) then
        item_tbl.Contents = GetCrateContents(item_tbl.Collection)
    end

    if (ienum) then
        item_cache[ienum] = item_tbl
    end
    
    return item_tbl
end

local item_cache2 = {}
function GetItemFromEnumWithFunctions(ienum)
    if (ienum and item_cache2[ienum]) then
        return item_cache2[ienum]
    end

    local item_tbl = table.Copy(MOAT_DROPTABLE[ienum]) or {}
	if (not item_tbl.Kind) then
		local try = string.gsub(ienum, "2", "1", 1)

		if (MOAT_DROPTABLE[tonumber(try)]) then
			item_tbl = table.Copy(MOAT_DROPTABLE[tonumber(try)]) or {}
		end
	end

    if (CLIENT and item_tbl.Kind == "Crate") then
        item_tbl.Contents = GetCrateContents(item_tbl.Collection)
    end

    if (ienum) then item_cache2[ienum] = item_tbl end

    return item_tbl
end

function GetItemName(data)
	local ITEM_NAME_FULL = ""

	if (data and data.u and (not data.item or not data.item.Kind)) then
		data.item = GetItemFromEnum(data.u)
	end

    if (data and data.item and data.item.Kind == "tier") then
        local ITEM_NAME = util.GetWeaponName(data.w or "weapon_ttt_m16")

        if (string.EndsWith(ITEM_NAME, "_name")) then
            ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
            ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
        end

        ITEM_NAME_FULL = data.item.Name .. " " .. ITEM_NAME

        if ((data.item and data.item.Rarity or 0) == 0 and data.item.ID and data.item.ID ~= 7820 and data.item.ID ~= 7821) then
            ITEM_NAME_FULL = ITEM_NAME
        end
    else
        ITEM_NAME_FULL = data.item and data.item.Name or "Error with Item Name"
    end
	
	-- if (data and data.item and data.item.Kind ~= "Unique" and data.Talents and data.Talents[1] and (data.Talents[1].Suffix or data.Talents[1].Name)) then
	-- 	local suffix = (data.Talents[5] and (data.Talents[5].Suffix or data.Talents[5].Name)) or (data.Talents[4] and (data.Talents[4].Suffix or data.Talents[4].Name)) or (data.Talents[3] and (data.Talents[3].Suffix or data.Talents[3].Name)) or (data.Talents[2] and (data.Talents[2].Suffix or data.Talents[2].Name)) or (data.Talents[1].Suffix or data.Talents[1].Name)
	-- 	ITEM_NAME_FULL = ITEM_NAME_FULL .. " of " .. suffix
	-- end

	if (data.n) then
		ITEM_NAME_FULL = data.n:Replace("''", "'") -- "\"" .. data.n:Replace("''", "'") .. "\""
	end

	ITEM_NAME_FULL = string.format(ITEM_NAME_FULL, "@", "#")

	return ITEM_NAME_FULL
end