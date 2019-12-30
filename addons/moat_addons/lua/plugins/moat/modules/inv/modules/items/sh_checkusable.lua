local PassUsables = CLIENT and GetConVar "moat_pass_usable"

local equipables = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true, 
    ["powerup"] = true,
	["power-up"] = true,
	["hat"] = true, 
    ["special"] = true, 
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true, 
    ["effect"] = true, 
    ["model"] = true
}

local paintable = {
    ["tier"] = true,
    ["unique"] = true,
    ["melee"] = true,
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true, 
    ["model"] = true
}
/*
local tintable = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true,
    ["head"] = true, 
    ["mask"] = true, 
    ["body"] = true,
    ["hat"] = true
}

local textureable = {
    ["tier"] = true, 
    ["unique"] = true, 
    ["melee"] = true,
}
*/
local mdl_check_cache = {}
local pass_check = function(i, pl)
	PassUsables = PassUsables or CLIENT and GetConVar "moat_pass_usable"

	return (PassUsables and PassUsables:GetInt() > 0) or (SERVER and tonumber(pl:GetInfo "moat_pass_usable") > 0)
end

MOAT_ITEM_CHECK = {}
MOAT_ITEM_CHECK[1] = {function(i)
	return (i.item and equipables[i.item.Kind:lower()]) or (i.Kind and equipables[i.Kind:lower()])
end, "Item must be equippable!"}
MOAT_ITEM_CHECK[2] = {function(i)
	return (((i.Rarity and i.Rarity <= 7) or (i.item and i.item.Rarity and i.item.Rarity <= 7)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Cosmic with talents!"}
MOAT_ITEM_CHECK[3] = {function(i)
	return (((i.Rarity and i.Rarity <= 6) or (i.item and i.item.Rarity and i.item.Rarity <= 6)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Ascended with talents!"}
MOAT_ITEM_CHECK[4] = {function(i)
	return (((i.Rarity and i.Rarity <= 5) or (i.item and i.item.Rarity and i.item.Rarity <= 5)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be High-End with talents!"}
MOAT_ITEM_CHECK[5] = {function(i)
	return (((i.Rarity and i.Rarity <= 9) or (i.item and i.item.Rarity and i.item.Rarity <= 9)) and (i.Talents or i.t or (i.item and i.item.Talents)))
end, "Item must be Planetary with talents!"}
MOAT_ITEM_CHECK[6] = {function(i)
	return (((i.Rarity and i.Rarity <= 7) or (i.item and i.item.Rarity and i.item.Rarity <= 7)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Cosmic with stats!"}
MOAT_ITEM_CHECK[7] = {function(i)
	return (((i.Rarity and i.Rarity <= 6) or (i.item and i.item.Rarity and i.item.Rarity <= 6)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Ascended with stats!"}
MOAT_ITEM_CHECK[8] = {function(i)
	return (((i.Rarity and i.Rarity <= 5) or (i.item and i.item.Rarity and i.item.Rarity <= 5)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be High-End with stats!"}
MOAT_ITEM_CHECK[9] = {function(i)
	return (((i.Rarity and i.Rarity <= 9) or (i.item and i.item.Rarity and i.item.Rarity <= 9)) and (i.Stats or (i.item and i.item.Stats)))
end, "Item must be Planetary with stats!"}
MOAT_ITEM_CHECK[10] = {function(i, pl)
	if (CLIENT and ((i.item and i.item.Kind:lower() == "model") or (i.Kind and i.Kind:lower() == "model"))) then
		local itm = i.item
		if (i.Kind) then itm = i end

		if (not mdl_check_cache[itm.Model]) then
			mdl_check_cache[itm.Model] = MODELS_COLORABLE[itm.Model]
		end

		return mdl_check_cache[itm.Model] or pass_check(i, pl)
	end

	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end

	return (i.item and paintable[i.item.Kind:lower()]) or (i.Kind and paintable[i.Kind:lower()]) or pass_check(i, pl)
end, "Item cannot be painted!"}
MOAT_ITEM_CHECK[11] = {function(i, pl)

	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end

	return (i.item and paintable[i.item.Kind:lower()]) or (i.Kind and paintable[i.Kind:lower()]) or pass_check(i, pl)
end, "Item cannot be painted!"}
MOAT_ITEM_CHECK[12] = {function(i, pl)
	if (i.item and i.item.Name == "Fists") or (i.Name == i.Name == "Fists") then
		return false
	end

	return (i.item and paintable[i.item.Kind:lower()]) or (i.Kind and paintable[i.Kind:lower()]) or pass_check(i, pl)
end, "Item cannot be painted!"}
MOAT_ITEM_CHECK[13] = {function(i)
	return i.u ~= 7820 and i.u ~= 7821
end, "You can't wrap gift packages, sorry."}
MOAT_ITEM_CHECK[14] = {function(i)
	return i.p3 ~= nil
end, "Item must have a skin!"}

MODELS_COLORABLE = {
['models/burd/norpo/arkhamorigins/assassins/deathstroke_valvebiped.mdl']=true,
['models/burd/player/altair.mdl']=true,
['models/custom_prop/moatgaming/alien/alien.mdl']=true,
['models/custom_prop/moatgaming/anonymous/anonymous.mdl']=true,
['models/custom_prop/moatgaming/apeescape/apeescape.mdl']=true,
['models/custom_prop/moatgaming/arkham/arkham.mdl']=true,
['models/custom_prop/moatgaming/bane/bane.mdl']=true,
['models/custom_prop/moatgaming/bender/bender.mdl']=true,
['models/custom_prop/moatgaming/billy/billy.mdl']=true,
['models/custom_prop/moatgaming/bondrewd/bondrewd.mdl']=true,
['models/custom_prop/moatgaming/bunnyhood/bunnyhood.mdl']=true,
['models/custom_prop/moatgaming/crusaders/crusaders.mdl']=true,
['models/custom_prop/moatgaming/daft/daft.mdl']=true,
['models/custom_prop/moatgaming/darthvader/darthvader.mdl']=true,
['models/custom_prop/moatgaming/demonshank/demonshank.mdl']=true,
['models/custom_prop/moatgaming/doctorfez/doctorfez.mdl']=true,
['models/custom_prop/moatgaming/duck/duck.mdl']=true,
['models/custom_prop/moatgaming/dundee/dundee.mdl']=true,
['models/custom_prop/moatgaming/evilplant/evilplant.mdl']=true,
['models/custom_prop/moatgaming/falcon/falcon.mdl']=true,
['models/custom_prop/moatgaming/fate/fate.mdl']=true,
['models/custom_prop/moatgaming/foolish/foolish.mdl']=true,
['models/custom_prop/moatgaming/galactus/galactus.mdl']=true,
['models/custom_prop/moatgaming/gasmask/gasmask.mdl']=true,
['models/custom_prop/moatgaming/greyfox/greyfox.mdl']=true,
['models/custom_prop/moatgaming/hannibal/hannibal.mdl']=true,
['models/custom_prop/moatgaming/hollow/hollow.mdl']=true,
['models/custom_prop/moatgaming/isaac/isaac.mdl']=true,
['models/custom_prop/moatgaming/lvl3/lvl3.mdl']=true,
['models/custom_prop/moatgaming/magneto/magneto.mdl']=true,
['models/custom_prop/moatgaming/marshmello/marshmello.mdl']=true,
['models/custom_prop/moatgaming/megaman/megaman.mdl']=true,
['models/custom_prop/moatgaming/miraak/miraak.mdl']=true,
['models/custom_prop/moatgaming/monstro/monstro.mdl']=true,
['models/custom_prop/moatgaming/moon/moon.mdl']=true,
['models/custom_prop/moatgaming/olimar/olimar.mdl']=true,
['models/custom_prop/moatgaming/ori/ori.mdl']=true,
['models/custom_prop/moatgaming/pennywise/pennywise.mdl']=true,
['models/custom_prop/moatgaming/princess/princess.mdl']=true,
['models/custom_prop/moatgaming/psycho/psycho.mdl']=true,
['models/custom_prop/moatgaming/pumpkin/pumpkin.mdl']=true,
['models/custom_prop/moatgaming/redead/redead.mdl']=true,
['models/custom_prop/moatgaming/robocop/robocop.mdl']=true,
['models/custom_prop/moatgaming/saiyanvisor/saiyanvisor.mdl']=true,
['models/custom_prop/moatgaming/sauron/sauron.mdl']=true,
['models/custom_prop/moatgaming/scream/scream.mdl']=true,
['models/custom_prop/moatgaming/shark/shark.mdl']=true,
['models/custom_prop/moatgaming/shovel/shovel.mdl']=true,
['models/custom_prop/moatgaming/shredder/shredder.mdl']=true,
['models/custom_prop/moatgaming/skullgirl/skullgirl.mdl']=true,
['models/custom_prop/moatgaming/sortinghat/sortinghat.mdl']=true,
['models/custom_prop/moatgaming/spawn/spawn.mdl']=true,
['models/custom_prop/moatgaming/strawhat/strawhat.mdl']=true,
['models/custom_prop/moatgaming/thundergod/thundergod.mdl']=true,
['models/custom_prop/moatgaming/trapper/trapper.mdl']=true,
['models/custom_prop/moatgaming/trihelmet/trihelmet.mdl']=true,
['models/custom_prop/moatgaming/trooperhelmet/trooperhelmet.mdl']=true,
['models/custom_prop/moatgaming/vaultboy/vaultboy.mdl']=true,
['models/custom_prop/moatgaming/zero/zero.mdl']=true,
['models/custom_prop/moatgaming/zhariisos/zhariisos.mdl']=true,
['models/effects/combineball.mdl']=true,
['models/gmod_tower/balloonicorn_nojiggle.mdl']=true,
['models/lordvipes/daftpunk/thomas.mdl']=true,
['models/moat/mg_clout_goggles.mdl']=true,
['models/moat/mg_fedora.mdl']=true,
['models/moat/mg_glasses_reindeer.mdl']=true,
['models/moat/mg_glasses_santa.mdl']=true,
['models/moat/mg_glasses_santahat.mdl']=true,
['models/moat/mg_glasses_stars.mdl']=true,
['models/moat/mg_glasses_xmas.mdl']=true,
['models/moat/mg_glasses_xmastree.mdl']=true,
['models/moat/mg_hat_checkered_top.mdl']=true,
['models/moat/mg_hat_chicken.mdl']=true,
['models/moat/mg_hat_crown.mdl']=true,
['models/moat/mg_hat_darkerthenblack.mdl']=true,
['models/moat/mg_hat_drummer.mdl']=true,
['models/moat/mg_hat_estilomuerto.mdl']=true,
['models/moat/mg_hat_goofygoober.mdl']=true,
['models/moat/mg_hat_killerskabuto.mdl']=true,
['models/moat/mg_hat_krustykrab.mdl']=true,
['models/moat/mg_hat_kunglao.mdl']=true,
['models/moat/mg_hat_law.mdl']=true,
['models/moat/mg_hat_lightb.mdl']=true,
['models/moat/mg_hat_madhatter.mdl']=true,
['models/moat/mg_hat_multi.mdl']=true,
['models/moat/mg_hat_narutosleeping.mdl']=true,
['models/moat/mg_hat_neptune.mdl']=true,
['models/moat/mg_hat_packman.mdl']=true,
['models/moat/mg_hat_robloxmoney.mdl']=true,
['models/moat/mg_hat_robotchicken.mdl']=true,
['models/moat/mg_hat_skullcage.mdl']=true,
['models/moat/mg_hat_spinny.mdl']=true,
['models/moat/mg_hat_sun.mdl']=true,
['models/moat/mg_hat_teemo.mdl']=true,
['models/moat/mg_hat_unbrella.mdl']=true,
['models/moat/mg_helmet_iron.mdl']=true,
['models/moat/mg_mask_hattington.mdl']=true,
['models/moat/player/bobafett.mdl']=true,
['models/moat/player/chewbacca.mdl']=true,
['models/moat/player/normal.mdl']=true,
['models/moat/player/spacesuit.mdl']=true,
['models/moat/player/spy.mdl']=true,
['models/models/moat/mg_hat_catinthehat.mdl']=true,
['models/models/moat/mg_hat_elf.mdl']=true,
['models/models/moat/mg_hat_elf2.mdl']=true,
['models/models/moat/mg_hat_rudolph.mdl']=true,
['models/models/moat/mg_xmasfestive01.mdl']=true,
['models/player/alyx.mdl']=true,
['models/player/barney.mdl']=true,
['models/player/breen.mdl']=true,
['models/player/combine_super_soldier.mdl']=true,
['models/player/corpse1.mdl']=true,
['models/player/dishonored_assassin1.mdl']=true,
['models/player/dude.mdl']=true,
['models/player/eli.mdl']=true,
['models/player/freddykruger.mdl']=true,
['models/player/gman_high.mdl']=true,
['models/player/Group01/female_01.mdl']=true,
['models/player/Group01/female_02.mdl']=true,
['models/player/Group01/female_03.mdl']=true,
['models/player/Group01/female_04.mdl']=true,
['models/player/Group01/female_05.mdl']=true,
['models/player/Group01/female_06.mdl']=true,
['models/player/Group01/male_01.mdl']=true,
['models/player/Group01/male_02.mdl']=true,
['models/player/Group01/male_03.mdl']=true,
['models/player/Group01/male_04.mdl']=true,
['models/player/Group01/male_05.mdl']=true,
['models/player/Group01/male_06.mdl']=true,
['models/player/Group01/male_07.mdl']=true,
['models/player/Group01/male_08.mdl']=true,
['models/player/Group01/male_09.mdl']=true,
['models/player/Group03/female_01.mdl']=true,
['models/player/Group03/female_02.mdl']=true,
['models/player/Group03/female_03.mdl']=true,
['models/player/Group03/female_04.mdl']=true,
['models/player/Group03/female_05.mdl']=true,
['models/player/Group03/female_06.mdl']=true,
['models/player/Group03/male_01.mdl']=true,
['models/player/Group03/male_02.mdl']=true,
['models/player/Group03/male_03.mdl']=true,
['models/player/Group03/male_04.mdl']=true,
['models/player/Group03/male_05.mdl']=true,
['models/player/Group03/male_06.mdl']=true,
['models/player/Group03/male_07.mdl']=true,
['models/player/Group03/male_08.mdl']=true,
['models/player/Group03/male_09.mdl']=true,
['models/player/guerilla.mdl']=true,
['models/player/haroldlott.mdl']=true,
['models/player/hunter.mdl']=true,
['models/player/kleiner.mdl']=true,
['models/player/leet.mdl']=true,
['models/player/lordvipes/bl_clance/crimsonlanceplayer.mdl']=true,
['models/player/lordvipes/haloce/spartan_classic.mdl']=true,
['models/player/macdguy.mdl']=true,
['models/player/magnusson.mdl']=true,
['models/player/monk.mdl']=true,
['models/player/mossman.mdl']=true,
['models/player/odessa.mdl']=true,
['models/player/p2_chell.mdl']=true,
['models/player/phoenix.mdl']=true,
['models/player/police.mdl']=true,
['models/player/police_fem.mdl']=true,
['models/player/smith.mdl']=true,
['models/player/zack/zackhalloween.mdl']=true,
['models/player/zoey.mdl']=true,
['models/props_foliage/tree_springers_card_01_skybox.mdl']=true,
['models/roblox_assets/bellegg.mdl']=true,
['models/roblox_assets/tiny_egg_of_nonexistence.mdl']=true,
['models/sterling/mg_hat_number1.mdl']=true,
['models/sterling/mg_hat_punk.mdl']=true,
}