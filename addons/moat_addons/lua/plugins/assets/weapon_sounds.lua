if (not sound.Add_) then
	sound.Add_ = sound.Add
end

WEAPON_SOUNDS = WEAPON_SOUNDS or {}

function sound.Add(data)
	table.insert(WEAPON_SOUNDS, data)

	if (data.sound and type(data.sound) == "table") then
		for k, v in pairs(data.sound) do
			util.PrecacheSound(v)
		end
	elseif (data.sound) then
		util.PrecacheSound(data.sound)
	end

	return sound.Add_(data)
end

sound.Add({
	name = "vape_inhale",
	channel = CHAN_WEAPON,
	volume = 0.24,
	level = 60,
	pitch = { 95 },
	sound = "vapeinhale.wav"
})

sound.Add {
    name = "Bat.Swing",
    channel = CHAN_STATIC,
    volume = 1,
    level = 40,
    pitch = 100,
    sound = "weapons/iceaxe/iceaxe_swing1.wav"
}

sound.Add{
    name = "Bat.Sound",
    channel = CHAN_STATIC,
    volume = 1,
    level = 65,
    pitch = 100,
    sound = "nessbat/gamefreak/bat_sound.wav"
}

sound.Add {
    name = "Bat.HomeRun",
    channel = CHAN_STATIC,
    volume = 1,
    level = 120,
    pitch = 100,
    sound = "nessbat/gamefreak/homerun.wav"
}

sound.Add ({
   name = "Weapon_DetRev.Single",
   channel = CHAN_USER_BASE + 10,
   volume = 1.0,
   sound = "weapons/det_revolver/revolver-fire.wav"
})

/*

	Scorpion EVO

*/

sound.Add({
    name = "CW_EVO3_FIRE",
    channel = CHAN_WEAPON,
    volume = 1.0,
    pitch = {95, 105},
    sound = ")weapons/evo3/ump45_fp.wav"
})

sound.Add({
    name = "CW_EVO3_FIRE_SUPPRESSED",
    channel = CHAN_WEAPON,
    volume = 1.0,
    pitch = {95, 105},
    sound = {")weapons/evo3/ump45_suppressed_fp.wav", ")weapons/evo3/ump45_suppressed_fp.wav", ")weapons/evo3/ump45_suppressed_fp.wav", ")weapons/evo3/ump45_suppressed_fp.wav"}
})

sound.Add({
	name = "CW_EVO3_CLIPOUT",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/evo3/ump45_magout.wav"
})

sound.Add({
	name = "CW_EVO3_CLIPIN",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/evo3/ump45_magin.wav"
})

sound.Add({
	name = "CW_EVO3_BOLTPULL",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/evo3/ump45_boltback.wav"
})

sound.Add({
	name = "CW_EVO3_BOLTRELEASE",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/evo3/ump45_boltrelease.wav"
})

/*

	BO2 Peacekeeper

*/

sound.Add({
    name = "BO2_PEACE_FIRE",
    channel = CHAN_WEAPON,
    volume = 1.0,
    pitch = {95, 105},
    sound = {")weapons/peacekeeper/fire.wav", ")weapons/peacekeeper/fire.wav", ")weapons/peacekeeper/fire.wav", ")weapons/peacekeeper/fire.wav"}
})
sound.Add({
	name = "BO2_PEACE_FIRE_SILENCED",
	channel = CHAN_WEAPON,
    volume = 0.5,
    pitch = {95, 105},
	sound = ")weapons/mp7/silenced.wav"
})

sound.Add({
	name = "BO2_PEACE_MAGOUT",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/m27/magout.wav"
})

sound.Add({
	name = "BO2_PEACE_MAGIN",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/m27/magin.wav"
})

sound.Add({
	name = "BO2_PEACE_CHARGE",
	channel = CHAN_WEAPON,
	volume = 0.8,
	sound = "weapons/peacekeeper/button.wav"
})

sound.Add({
	name = 			"Weapon_cm1911.imout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/colt/magout.wav"
})

sound.Add({
	name = 			"Weapon_cm1911.igetone",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/colt/magin.wav"
})

sound.Add({
	name = 			"Weapon_cm1911.kachow",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/colt/slide.wav"
})

sound.Add({
	name = 			"Weapon_cm1911.seethis",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/colt/draw.wav"
})

sound.Add({
    name = "Golden_Deagle.Single",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = {")weapons/golden_deagle/deagle-1.wav", ")weapons/golden_deagle/deagle-1.wav", ")weapons/golden_deagle/deagle-1.wav", ")weapons/golden_deagle/deagle-1.wav"}
})

sound.Add({
	name = "Golden_Deagle.Clipout",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/golden_deagle/clipout.wav"
})

sound.Add({
	name = "Golden_Deagle.Clipin",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/golden_deagle/clipin.wav"
})

sound.Add({
	name = "Golden_Deagle.Sliderelease",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/golden_deagle/sliderelease.wav"
})

sound.Add({
	name = "Golden_Deagle.Slideback",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/golden_deagle/slideback.wav"
})

sound.Add({
	name = "Golden_Deagle.Slideforward",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/golden_deagle/slideforward.wav"
})


sound.Add({
	name = "Weapof_357Golden.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/357_golden/357_fire.wav"}
})


sound.Add({
    name = "Weapon_CM4.Single",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = {")weapons/cod4_m4/fire.wav", ")weapons/cod4_m4/fire.wav", ")weapons/cod4_m4/fire.wav", ")weapons/cod4_m4/fire.wav"}
})
sound.Add({
	name = 			"Weapon_CM4.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cod4_m4/reload_clipout.wav"
})

sound.Add({
	name = 			"Weapon_CM4.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cod4_m4/reload_clipin.wav"
})

sound.Add({
	name = 			"Weapon_CM4.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/cod4_m4/reload_chamber.wav"
})

sound.Add({
	name = "Predator_Blade.Taunt",
	channel = CHAN_VOICE,
	volume = 1.0,
	sound = {"weapons/predator_blade/taunt-1.wav",
			 "weapons/predator_blade/taunt-2.wav"}
})

sound.Add({
	name = "Predator_Blade.Hit",
	channel = CHAN_VOICE,
	volume = 1.0,
	sound = {"weapons/predator_blade/hit-1.wav",
			 "weapons/predator_blade/hit-2.wav",
			 "weapons/predator_blade/hit-3.wav",
			 "weapons/predator_blade/hit-4.wav"}
})

sound.Add({
	name = "Predator_Blade.Slash",
	channel = CHAN_VOICE,
	volume = 1.0,
	sound = {"weapons/predator_blade/slash-1.wav",
			 "weapons/predator_blade/slash-2.wav"}
})

sound.Add({
	name = "Predator_Blade.Hitwall",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = {"weapons/predator_blade/hitwall.wav"}
})

sound.Add({
	name = "Predator_Blade.Stab",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = {"weapons/predator_blade/stab.wav"}
})

sound.Add({
	name = "Predator_Blade.Select",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/predator_blade/select.wav"
})

sound.Add({
	name = "Predator_Blade.Deselect",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = {"weapons/predator_blade/deselect.wav"}
})

sound.Add({
	name = "Predator_Blade.Open",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/predator_blade/open.wav"
})

sound.Add({
	name = "Predator_Blade.Button",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/predator_blade/button.wav"
})

sound.Add({
	name = "Predator_Blade.Ok",
	channel = CHAN_WEAPON,
	volume = 1.0,
	sound = "weapons/predator_blade/ok.wav"
})

//SIG P228

sound.Add({
	name = "gunshot_p228",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/gunshot_p228/p228-1.wav", ")weapons/gunshot_p228/p228-1.wav", ")weapons/gunshot_p228/p228-1.wav", ")weapons/gunshot_p228/p228-1.wav", ")weapons/gunshot_p228/p228-1.wav"}
})

sound.Add({
	name = 			"improv_p228.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_p228/magout.wav"
})

sound.Add({
	name = 			"improv_p228.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_p228/magin.wav"
})

sound.Add({
	name = 			"improv_p228.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_p228/sliderelease.wav"
})

sound.Add({
	name = 			"improv_p228.Shift",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_p228/shift.wav"
})

//HK MP5K

sound.Add({
    name = "gunshot_tact_mp5k",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_tact_mp5k/mp5-1.wav"
})
sound.Add({
	name = 			"improv_mp5.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_tact_mp5k/mp5_boltpull.wav"
})

sound.Add({
	name = 			"improv_mp5.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_tact_mp5k/mp5_clipout.wav"
})

sound.Add({
	name = 			"improv_mp5.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_tact_mp5k/mp5_clipin.wav"
})

sound.Add({
	name = 			"improv_mp5.boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_tact_mp5k/mp5_boltslap.wav"
})

//Mossberg 590A1

sound.Add({
    name = "gunshot_moss_590",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_moss_590/m3-1.wav"
})
sound.Add({
	name = 			"improv_M5.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_moss_590/m3_pump.wav"
})

sound.Add({
	name = 			"improv_M5.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_moss_590/m3_insertshell.wav"
})

sound.Add({
    name = "gunshot_cz75",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_cz_75/p228-1.wav"
})
sound.Add({
	name = 			"improv_cz75.Shift",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/shift.wav"
})

sound.Add({
	name = 			"improv_cz75.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/magout.wav"
})

sound.Add({
	name = 			"improv_cz75.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/magin.wav"
})

sound.Add({
	name = 			"improv_cz75.MagShove",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/magshove.wav"
})

sound.Add({
	name = 			"improv_cz75.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/sliderelease.wav"
})

sound.Add({
	name = 			"improv_cz75.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_cz_75/cloth.wav"
})

//Manurhin MR 96

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_mr_96/deagle-1.wav"
soundtbl["name"] = "gunshot_mr96"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_mmr_96.Chamber_out",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mr_96/chamber_out.wav"
})

sound.Add({
	name = 			"improv_mmr_96.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mr_96/de_clipout.wav"
})

sound.Add({
	name = 			"improv_mmr_96.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mr_96/de_clipin.wav"
})

sound.Add({
	name = 			"improv_mmr_96.Chamber_in",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mr_96/chamber_in.wav"
})

sound.Add({
	name = 			"improv_mmr_96.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mr_96/de_deploy.wav"
})

//HK USP Match

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_usp_match/usp_unsil-1.wav"
soundtbl["name"] = "gunshot_hk_usp_mtch"
sound.Add(soundtbl)

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_usp_match/usp1.wav"
soundtbl["name"] = "gunshot_hk_usp_mtch_silenced"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_usp.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_clipout.wav"
})

sound.Add({
	name = 			"improv_usp.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_clipin.wav"
})

sound.Add({
	name = 			"improv_usp.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_slideback.wav"
})

sound.Add({
	name = 			"improv_usp.Slideforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_sliderelease.wav"
})

sound.Add({
	name = 			"improv_usp.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_cloth.wav"
})

sound.Add({
	name = 			"improv_usp.AttachSilencer1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_silencer_on_1.wav"
})

sound.Add({
	name = 			"improv_usp.AttachSilencer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_usp_match/usp_silencer_on.wav"
})

//MSBS Radon
/*
sound.Add({
	name = 			"gunshot_msbs_radon",
	channel = 		CHAN_WEAPON, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	CompatibilityAttenuation = 0.27,
	level = 140,
	pitch = {95, 105},
	sound = "weapons/gunshot_msbs/shoot.wav"
})*/
/*
local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_msbs/shoot.wav"
soundtbl["name"] = "gunshot_msbs_radon"
sound.Add(soundtbl)*/

sound.Add({
	name = "gunshot_msbs_radon",
	channel = CHAN_WEAPON,
    volume = 0.8,
	pitch = {95, 105},
	sound = ")weapons/gunshot_msbs/shoot.wav"
})

sound.Add({
	name = 			"MSBS.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/Magout.wav"
})

sound.Add({
	name = 			"MSBS.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/Magin.wav"
})

sound.Add({
	name = 			"MSBS.Magtap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/Magtap.wav"
})

sound.Add({
	name = 			"MSBS.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/BoltPull.wav"
})

sound.Add({
	name = 			"MSBS.BoltRelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/BoltRel.wav"
})

sound.Add({
	name = 			"MSBS.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_msbs/Deploy.wav"
})

//I always leave a note reminding me which weapon these sounds are for
//weapon name
sound.Add({
	name = 			"stalker_lr300_shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/LR-300/sg552-1.wav"
})

sound.Add({
	name = 			"Weapon_LR-300.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/LR-300/sg552_clipout.wav"
})

sound.Add({
	name = 			"Weapon_LR-300.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/LR-300/sg552_clipin.wav"
})

sound.Add({
	name = 			"Weapon_LR-300.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/LR-300/sg552_boltpull.wav"
})


sound.Add({
    name = "TFA_FO4_DELIVERER.2",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/tfa_fo4/10mm/WPN_Pistol10mm_Fire_2D.wav"
})

sound.Add({
    name = "TFA_FO4_DELIVERER.1",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/tfa_fo4/10mm/WPN_Pistol10mm_Fire_2D_Silenced.wav"
})
sound.Add({
	name = 			"TFA_FO4_DELIVERER.Clipout",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			{ "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_MagOut_01.wav", "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_MagOut_02.wav"}
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.Clipin",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			{ "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_MagIn_01_Short.wav", "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_MagIn_02_Short.wav"}
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.BoltForward",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			{ "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_BoltClose_01.wav", "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_BoltClose_02.wav"}
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.BoltBack",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			{ "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_BoltOpen_01.wav", "weapons/tfa_fo4/10mm/WPN_Pistol10mm_Reload_BoltOpen_02.wav"}
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.Draw",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_draw.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrew1",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw1.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrew2",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw2.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrew3",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw3.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrew4",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw4.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrew5",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw5.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrewOnStart",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw_on_start.wav"
})

sound.Add({
	name = 			"TFA_FO4_DELIVERER.SilencerScrewOffEnd",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/tfa_fo4/10mm/usp_silencer_screw_off_end.wav"
})

//VSS

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552-1.wav"
instbl["name"] = "Weapoz_vss.Single"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552_cloth.wav"
instbl["name"] = "Weapoz_SG552.Cloth"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552_clipout.wav"
instbl["name"] = "Weapoz_SG552.Clipout"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552_clipout1.wav"
instbl["name"] = "Weapoz_SG552.Clipout1"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552_clipin.wav"
instbl["name"] = "Weapoz_SG556.Clipin"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons_nc/vss/sg552_boltpull.wav"
instbl["name"] = "Weapoz_SG552.Boltpull"

sound.Add(instbl)

// *********************************
// *********************************
// *                               *
// *         M3 Super 90 P         *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_M3S90.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/shotgun_m3s90p/m3s90_fire1.wav", ")weapons/shotgun_m3s90p/m3s90_fire2.wav", ")weapons/shotgun_m3s90p/m3s90_fire3.wav", ")weapons/shotgun_m3s90p/m3s90_fire4.wav", ")weapons/shotgun_m3s90p/m3s90_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_m3s90p/m3s90_load1.wav",")weapons/shotgun_m3s90p/m3s90_load2.wav",")weapons/shotgun_m3s90p/m3s90_load3.wav",")weapons/shotgun_m3s90p/m3s90_load4.wav",")weapons/shotgun_m3s90p/m3s90_load5.wav",")weapons/shotgun_m3s90p/m3s90_load6.wav",")weapons/shotgun_m3s90p/m3s90_load7.wav",")weapons/shotgun_m3s90p/m3s90_load8.wav"}
fastbl["name"] = "Weapof_M3S90.Load"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_m3s90p/m3s90_getammo1.wav",")weapons/shotgun_m3s90p/m3s90_getammo2.wav",")weapons/shotgun_m3s90p/m3s90_getammo3.wav"}
fastbl["name"] = "Weapof_M3S90.Getammo"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_m3s90p/m3s90_boltcatch.wav"
fastbl["name"] = "Weapof_M3S90.Boltcatch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_m3s90p/m3s90_restock.wav"
fastbl["name"] = "Weapof_M3S90.Restock"

sound.Add(fastbl)

//PISTOL GROUP

// *********************************
// *********************************
// *                               *
// *             M1911             *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_1911.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_m1911a1/1911_fire1.wav", ")weapons/pistol_m1911a1/1911_fire2.wav", ")weapons/pistol_m1911a1/1911_fire3.wav", ")weapons/pistol_m1911a1/1911_fire4.wav", ")weapons/pistol_m1911a1/1911_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_m1911a1/1911_magin.wav"
fastbl["name"] = "Weapof_1911.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_m1911a1/1911_magout.wav"
fastbl["name"] = "Weapof_1911.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_m1911a1/1911_slidestop.wav"
fastbl["name"] = "Weapof_1911.SlideStop"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *        	 Glock20	   	   *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_Glock20.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_glock20/glock20_fire5.wav", ")weapons/pistol_glock20/glock20_fire4.wav", ")weapons/pistol_glock20/glock20_fire3.wav", ")weapons/pistol_glock20/glock20_fire2.wav", ")weapons/pistol_glock20/glock20_fire1.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_glock20/glock20_magout.wav"
fastbl["name"] = "Weapof_Glock20.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_glock20/glock20_magin.wav"
fastbl["name"] = "Weapof_Glock20.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_glock20/glock20_sliderelease.wav"
fastbl["name"] = "Weapof_Glock20.SlideForward"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *           OTs-33              *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_OTs33.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_ots33/ots33_fire1.wav", ")weapons/pistol_ots33/ots33_fire2.wav", ")weapons/pistol_ots33/ots33_fire3.wav", ")weapons/pistol_ots33/ots33_fire4.wav", ")weapons/pistol_ots33/ots33_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_ots33/ots33_magout.wav"
fastbl["name"] = "Weapof_OTs33.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_ots33/ots33_magin.wav"
fastbl["name"] = "Weapof_OTs33.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_ots33/ots33_slidestop.wav"
fastbl["name"] = "Weapof_OTs33.SlideForward"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *         Beretta 92FS          *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_Beretta92fs.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_beretta92fs/m9_fire1.wav", ")weapons/pistol_beretta92fs/m9_fire2.wav", ")weapons/pistol_beretta92fs/m9_fire3.wav", ")weapons/pistol_beretta92fs/m9_fire4.wav", ")weapons/pistol_beretta92fs/m9_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_magout.wav"
fastbl["name"] = "Weapof_m9.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_magin.wav"
fastbl["name"] = "Weapof_m9.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_slidestop.wav"
fastbl["name"] = "Weapof_m9.SlideStop"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *        Desert Eagle .50       *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_DEagle.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_deserteagle/de_fire1.wav", ")weapons/pistol_deserteagle/de_fire2.wav", ")weapons/pistol_deserteagle/de_fire3.wav", ")weapons/pistol_deserteagle/de_fire4.wav", ")weapons/pistol_deserteagle/de_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_deserteagle/de_magout.wav"
fastbl["name"] = "Weapof_DEagle.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_deserteagle/de_magin.wav"
fastbl["name"] = "Weapof_DEagle.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_deserteagle/de_slidestop.wav"
fastbl["name"] = "Weapof_DEagle.SlideStop"

sound.Add(fastbl)

//SMG GROUP

// *********************************
// *********************************
// *                               *
// *             MP5               *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_MP5.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_mp5/mp5_fire1.wav", ")weapons/sub_mp5/mp5_fire2.wav", ")weapons/sub_mp5/mp5_fire3.wav", ")weapons/sub_mp5/mp5_fire4.wav", ")weapons/sub_mp5/mp5_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_magout.wav"
fastbl["name"] = "Weapof_MP5.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_magin.wav"
fastbl["name"] = "Weapof_MP5.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_boltback.wav"
fastbl["name"] = "Weapof_MP5.Boltback"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_boltforward.wav"
fastbl["name"] = "Weapof_MP5.Boltforward"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *          STERLING             *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_STERLING.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_sterling/sterling_fire1.wav", ")weapons/sub_sterling/sterling_fire2.wav", ")weapons/sub_sterling/sterling_fire3.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_sterling/reload.mp3"
fastbl["name"] = "Weapof_STERLING.Reload"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_sterling/reload_empty.mp3"
fastbl["name"] = "Weapof_STERLING.ReloadEmpty"

sound.Add(fastbl)

sound.Add({
	name = "Weapof_Beretta92fss.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_beretta92fs/m9_silenced_fire1.wav", ")weapons/pistol_beretta92fs/m9_silenced_fire1.wav", ")weapons/pistol_beretta92fs/m9_silenced_fire1.wav", ")weapons/pistol_beretta92fs/m9_silenced_fire1.wav"}
})

// *********************************
// *********************************
// *                               *
// *        CF05 Changefeng        *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_CF05.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_cf05/cf05_fire1.wav", ")weapons/sub_cf05/cf05_fire2.wav", ")weapons/sub_cf05/cf05_fire3.wav", ")weapons/sub_cf05/cf05_fire4.wav", ")weapons/sub_cf05/cf05_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_cf05/cf05_magout.wav"
fastbl["name"] = "Weapof_CF05.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_cf05/cf05_magin.wav"
fastbl["name"] = "Weapof_CF05.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_cf05/cf05_boltback.wav"
fastbl["name"] = "Weapof_CF05.BoltPull"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *            MAC11              *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sub_mac11/mac11_fire1.wav","weapons/sub_mac11/mac11_fire2.wav","weapons/sub_mac11/mac11_fire3.wav","weapons/sub_mac11/mac11_fire4.wav","weapons/sub_mac11/mac11_fire5.wav"}
fastbl["name"] = "Weapof_MAC11.Shoot"

sound.Add({
	name = "Weapof_MAC11.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_mac11/mac11_fire1.wav", ")weapons/sub_mac11/mac11_fire2.wav", ")weapons/sub_mac11/mac11_fire3.wav", ")weapons/sub_mac11/mac11_fire4.wav", ")weapons/sub_mac11/mac11_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_magout.wav"
fastbl["name"] = "Weapof_MAC11.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_magin.wav"
fastbl["name"] = "Weapof_MAC11.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_boltback.wav"
fastbl["name"] = "Weapof_MAC11.Boltpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_boltforward.wav"
fastbl["name"] = "Weapof_MAC11.Boltforward"

sound.Add(fastbl)

//ASSAULT RIFLE GROUP

// *********************************
// *********************************
// *                               *
// *             FAMAS             *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_FAMAS.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_famas/famas_fire1.wav", ")weapons/ar_famas/famas_fire2.wav", ")weapons/ar_famas/famas_fire3.wav", ")weapons/ar_famas/famas_fire4.wav", ")weapons/ar_famas/famas_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_famas/famas_magout.wav"
fastbl["name"] = "Weapof_FAMAS.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_famas/famas_magin.wav"
fastbl["name"] = "Weapof_FAMAS.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_famas/famas_cock.wav"
fastbl["name"] = "Weapof_FAMAS.BoltPull"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *             M4A1              *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_M4A1.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_m4a1/m4_fire1.wav", ")weapons/ar_m4a1/m4_fire2.wav", ")weapons/ar_m4a1/m4_fire3.wav", ")weapons/ar_m4a1/m4_fire4.wav", ")weapons/ar_m4a1/m4_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_magout.wav"
fastbl["name"] = "Weapof_M4A1.Magout"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_magin.wav"
fastbl["name"] = "Weapof_M4A1.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_boltcatch.wav"
fastbl["name"] = "Weapof_M4A1.BoltCatch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_stock.wav"
fastbl["name"] = "Weapof_M4A1.Stockpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_check.wav"
fastbl["name"] = "Weapof_M4A1.Check"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_forwardassist.wav"
fastbl["name"] = "Weapof_M4A1.Forwardassist"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_dustcover.wav"
fastbl["name"] = "Weapof_M4A1.Dustcover"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/switch.wav"
fastbl["name"] = "Weapof_M4A1.switch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_charge.wav"
fastbl["name"] = "Weapof_M4A1.Boltpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4a1_deploy.wav"
fastbl["name"] = "Weapof_M4A1.Deploy"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *             SG550             *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_sg550.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_sg550/sg550_fire1.wav", ")weapons/ar_sg550/sg550_fire2.wav", ")weapons/ar_sg550/sg550_fire3.wav", ")weapons/ar_sg550/sg550_fire4.wav", ")weapons/ar_sg550/sg550_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sg550/sg550_magout.wav"
fastbl["name"] = "Weapof_sg550.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sg550/sg550_magin.wav"
fastbl["name"] = "Weapof_sg550.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sg550/sg550_boltpull.wav"
fastbl["name"] = "Weapof_sg550.BoltPull"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *             G36C              *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_G36.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_g36c/g36c_fire1.wav", ")weapons/ar_g36c/g36c_fire2.wav", ")weapons/ar_g36c/g36c_fire3.wav", ")weapons/ar_g36c/g36c_fire4.wav", ")weapons/ar_g36c/g36c_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_magout.wav"
fastbl["name"] = "Weapof_G36.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_magin.wav"
fastbl["name"] = "Weapof_G36.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_cock.wav"
fastbl["name"] = "Weapof_G36.BoltPull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_handle.wav"
fastbl["name"] = "Weapof_G36.BoltHandle"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_boltcatch.wav"
fastbl["name"] = "Weapof_G36.BoltRelease"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_stock.wav"
fastbl["name"] = "Weapof_G36.Stock"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_switch.wav"
fastbl["name"] = "Weapof_G36.Switch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_deploy.wav"
fastbl["name"] = "Weapof_G36.Deploy"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *           Sako 92             *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_Sako.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_sako92/sako_fire1.wav", ")weapons/ar_sako92/sako_fire2.wav", ")weapons/ar_sako92/sako_fire3.wav", ")weapons/ar_sako92/sako_fire4.wav", ")weapons/ar_sako92/sako_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sako92/sako_cock.wav"
fastbl["name"] = "Weapof_Sako.BoltPull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sako92/sako_magin.wav"
fastbl["name"] = "Weapof_Sako.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sako92/sako_magout.wav"
fastbl["name"] = "Weapof_Sako.MagOut"

sound.Add(fastbl)


// *********************************
// *********************************
// *                               *
// *             AK47              *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_AK47.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_ak47/ak47_fire1.wav", ")weapons/ar_ak47/ak47_fire2.wav", ")weapons/ar_ak47/ak47_fire3.wav", ")weapons/ar_ak47/ak47_fire4.wav", ")weapons/ar_ak47/ak47_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_ak47/ak47_cock.wav"
fastbl["name"] = "Weapof_AK47.BoltPull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_ak47/ak47_magin.wav"
fastbl["name"] = "Weapof_AK47.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_ak47/ak47_magout.wav"
fastbl["name"] = "Weapof_AK47.MagOut"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *              M14              *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_M14.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_m14/m14_fire1.wav", ")weapons/ar_m14/m14_fire2.wav", ")weapons/ar_m14/m14_fire3.wav", ")weapons/ar_m14/m14_fire4.wav", ")weapons/ar_m14/m14_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_boltcatch.wav"
fastbl["name"] = "Weapof_M14.BoltCatch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_magout.wav"
fastbl["name"] = "Weapof_M14.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_magin.wav"
fastbl["name"] = "Weapof_M14.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_charge.wav"
fastbl["name"] = "Weapof_M14.Boltpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_check.wav"
fastbl["name"] = "Weapof_M14.Check"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *              G3               *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_G3.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_g3a3/g3_fire1.wav", ")weapons/ar_g3a3/g3_fire2.wav", ")weapons/ar_g3a3/g3_fire3.wav", ")weapons/ar_g3a3/g3_fire4.wav", ")weapons/ar_g3a3/g3_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_boltpull.wav"
fastbl["name"] = "Weapof_G3.BoltPull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_boltforward.wav"
fastbl["name"] = "Weapof_G3.BoltForward"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_magout.wav"
fastbl["name"] = "Weapof_G3.MagOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_magin.wav"
fastbl["name"] = "Weapof_G3.MagIn"

sound.Add(fastbl)

//MACHINE GUN GROUP

// *********************************
// *********************************
// *                               *
// *          MC51 VOLLMER         *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_Vollmer.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/mg_vollmer/vollmer_fire1.wav",")weapons/mg_vollmer/vollmer_fire2.wav",")weapons/mg_vollmer/vollmer_fire3.wav",")weapons/mg_vollmer/vollmer_fire4.wav",")weapons/mg_vollmer/vollmer_fire5.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.5"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_belt1.wav"
fastbl["name"] = "Weapof_vollmer.Belt1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_startertab.wav"
fastbl["name"] = "Weapof_vollmer.StarterTab"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.5"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_belt2.wav"
fastbl["name"] = "Weapof_vollmer.Belt2"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.5"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_belt3.wav"
fastbl["name"] = "Weapof_vollmer.Belt3"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_beltload.wav"
fastbl["name"] = "Weapof_vollmer.Beltload"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_beltpull.wav"
fastbl["name"] = "Weapof_vollmer.Beltpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_beltremove.wav"
fastbl["name"] = "Weapof_vollmer.Beltremove"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_boltback.wav"
fastbl["name"] = "Weapof_vollmer.boltback"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_boltforward.wav"
fastbl["name"] = "Weapof_vollmer.boltforward"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_box.wav"
fastbl["name"] = "Weapof_vollmer.box"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_boxin.wav"
fastbl["name"] = "Weapof_vollmer.boxin"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_boxout.wav"
fastbl["name"] = "Weapof_vollmer.boxout"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_close.wav"
fastbl["name"] = "Weapof_vollmer.close"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_open.wav"
fastbl["name"] = "Weapof_vollmer.open"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_rip.wav"
fastbl["name"] = "Weapof_vollmer.rip"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_vollmer/vollmer_stock.wav"
fastbl["name"] = "Weapof_vollmer.stock"

sound.Add(fastbl)

//SNIPER RIFLE GROUP

// *********************************
// *********************************
// *                               *
// *            SR25	           *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_SR25.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sniper_sr25/sr25_fire1.wav", ")weapons/sniper_sr25/sr25_fire1.wav", ")weapons/sniper_sr25/sr25_fire1.wav", ")weapons/sniper_sr25/sr25_fire1.wav"}
})

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/accessories/harrisbipod_up1.wav","weapons/accessories/harrisbipod_up2.wav"}
fastbl["name"] = "Weapof_HarrisBipod_Up"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/accessories/harrisbipod_down1.wav","weapons/accessories/harrisbipod_down2.wav"}
fastbl["name"] = "Weapof_HarrisBipod_Down"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_magout.wav"
fastbl["name"] = "Weapof_SR25.Magout"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_magin.wav"
fastbl["name"] = "Weapof_SR25.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_magslap.wav"
fastbl["name"] = "Weapof_SR25.MagSlap"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_charge.wav"
fastbl["name"] = "Weapof_SR25.Charge"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_boltcatch.wav"
fastbl["name"] = "Weapof_SR25.Boltcatch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_boltcatchslap.wav"
fastbl["name"] = "Weapof_SR25.BoltcatchSlap"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_boltcatchhandle.wav"
fastbl["name"] = "Weapof_SR25.BoltcatchHandle"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_supressorOn.wav"
fastbl["name"] = "Weapof_SR25.SupressorOn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_supressorlock.wav"
fastbl["name"] = "Weapof_SR25.SupressorLock"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_stockunlock.wav"
fastbl["name"] = "Weapof_SR25.StockUnlock"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_stockpull.wav"
fastbl["name"] = "Weapof_SR25.StockPull"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_stocklock.wav"
fastbl["name"] = "Weapof_SR25.StockLock"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_sr25/sr25_safety.wav"
fastbl["name"] = "Weapof_SR25.Safety"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *           M24A2 SWS           *
// *                               *
// *********************************
// *********************************

sound.Add({
	name = "Weapof_M24.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sniper_m24/m24_fire1.wav", ")weapons/sniper_m24/m24_fire2.wav", ")weapons/sniper_m24/m24_fire3.wav", ")weapons/sniper_m24/m24_fire4.wav", ")weapons/sniper_m24/m24_fire5.wav"}
})

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/sniper_m24/m24_Load1.wav",")weapons/sniper_m24/m24_Load2.wav",")weapons/sniper_m24/m24_Load3.wav",")weapons/sniper_m24/m24_Load4.wav",")weapons/sniper_m24/m24_Load5.wav"}
fastbl["name"] = "Weapof_M24.Load"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m24/m24_bolt_up.wav"
fastbl["name"] = "Weapof_M24.Boltup"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m24/m24_bolt_back.wav"
fastbl["name"] = "Weapof_M24.Boltback"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m24/m24_bolt_forward.wav"
fastbl["name"] = "Weapof_M24.Boltforward"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m24/m24_bolt_down.wav"
fastbl["name"] = "Weapof_M24.Boltdown"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m24/m24_butt.wav"
fastbl["name"] = "Weapof_M24.Butt"

sound.Add(fastbl)

//EXTRAS

fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/switch1.wav",")weapons/switch2.wav",")weapons/switch3.wav",")weapons/switch4.wav",")weapons/switch5.wav"}
fastbl["name"] = "Weapof_Misc.Switch"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ClipEmpty_Pistol.wav"
fastbl["name"] = "Default.ClipEmpty_Pistol"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ClipEmpty_Rifle.wav"
fastbl["name"] = "Default.ClipEmpty_Rifle"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/zoom.wav"
fastbl["name"] = "Default.Zoom"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/universal/iron_out.wav"
fastbl["name"] = "Defaulf.Iron_Out"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/universal/iron_in.wav"
fastbl["name"] = "Defaulf.Iron_In"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/universal/uni-draw.wav"
fastbl["name"] = "Defaulf.Draw"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/universal/uni-holster.wav"
fastbl["name"] = "Defaulf.Holster"

sound.Add(fastbl)

--- MG - XM8 ---
sound.Add({
	name = 			"Weapon_XM.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/xm8/deploy.wav"	
})

sound.Add({
	name = 			"Weapon_XM.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/xm8/reload.wav"	
})


sound.Add({
	name = 			"Weapon_XM.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = ")weapons/xm8/xm8fire.wav"
})

--- Akimbo --
sound.Add({
	name = 			"Weapon_akimbo.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ ")weapons/akimbo/akimbofire1.wav", ")weapons/akimbo/akimbofire2.wav" }
})

--- Semi-Auto ---
sound.Add({
	name = 			"Weapon_Semi.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ ")weapons/semiauto/semifire1.wav", ")weapons/semiauto/semifire1.wav" }
})

sound.Add({
	name = 			"Weapon_Semi.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/semiauto/semideploy.wav"	
})

sound.Add({
	name = 			"Weapon_Semi.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/semiauto/semireload.wav"	
})

--- Zapper ---
sound.Add({
	name = 			"Weapon_Zap.fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ ")weapons/neszapper/neszap1.wav", ")weapons/neszapper/neszap2.wav", ")weapons/neszapper/neszap3.wav" }
})



--- Stealth ---
sound.Add({
	name = 			"Weapon_Stealth.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/stealthpistol/stealthpistolfire.wav"
})

--- Raging Bull ---
sound.Add({
	name = 			"Weapon_RagBull.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			"weapons/ragingbull/deagle-1.wav"
})

sound.Add({
	name = 			"Weapon_RagBull.Draw",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ragingbull/bulldraw.wav"	
})


sound.Add({
	name = 			"Weapon_Ragbull.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ragingbull/bullreload.wav"	
})


--- Super Shotty ---

sound.Add({
	name = 			"Weapon_Super.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/supershotty/ssgfire.wav"
})

--- Double Barrel --

sound.Add({
	name = 			"Weapon_Double.InsertShell",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/doublebarrel/shell_insert.wav"	
})

sound.Add({
	name = 			"Weapon_Double.Barreldown",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/doublebarrel/Barreldown.wav"	
})

sound.Add({
	name = 			"Weapon_Double.Barrelup",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/doublebarrel/Barrelup.wav"	
})

sound.Add({
	name = 			"Weapon_Double.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/doublebarrel/shoot.wav"
})
--- SPAS-12 ---

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons/spas12/spas12insertshell.wav"
instbl["name"] = "Weapon_Spas.Insertshell"

sound.Add(instbl)

local instbl = {}
instbl["channel"] = "3"
instbl["level"] = "75"
instbl["volume"] = "1.0"
instbl["CompatibilityAttenuation"] = "1"
instbl["pitch"] = "95,105"
instbl["sound"] = "weapons/spas12/spas12pump.wav"
instbl["name"] = "Weapon_Spas.Pump"

sound.Add(instbl)

sound.Add({
	name = 			"Weapon_Spas.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/spas12/spas12fire.wav"
	})
	
--- Thompson ---
sound.Add({
	name = 			"Weapon_Tom.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/thompson/thompsondeploy.wav"	
})

sound.Add({
	name = 			"Weapon_Tom.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/thompson/thompsonreload.wav"	
})

sound.Add({
	name = 			"Weapon_Tom.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/thompson/thompsonfire.wav"
	})
	

--- Patriot ---
sound.Add({
	name = 			"Weapon_Pat.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/patriot/patriotdeploy.wav"	
})

sound.Add({
	name = 			"Weapon_Pat.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/patriot/patriotfire.wav"
	})
	
--- RCP120 ---

sound.Add({
	name = 			"Weapon_RCP120.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/RCP120/deploy.wav"	
})

sound.Add({
	name = 			"Weapon_RCP120.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/RCP120/reload.wav"	
})

sound.Add({
	name = 			"Weapon_RCP120.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/RCP120/shoot.wav"
	})
	
--- Flak Gun ---

sound.Add({
	name = 			"Weapon_Magnuf.Draw",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/flakhandgun/deploy.wav"	
})

sound.Add({
	name = 			"Weapon_Magnuf.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/flakhandgun/reload.wav"	
})

sound.Add({
	name = 			"Weapon_Flak.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/flakhandgun/shoot.wav"
	})
	
--- Sword ---

sound.Add({
	name = 			"Weapon_Sword.Swing",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ ")weapons/sword/swordmiss1.wav", ")weapons/sword/swordmiss2.wav" }	
})

sound.Add({
	name = 			"Weapon_Sword.SwingV",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ ")weapons/sword/swordvswing1.wav", ")weapons/sword/swordvswing2.wav", ")weapons/sword/swordvswing3.wav" }	
})

sound.Add({
	name = 			"Weapon_Sword.SwingVB",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			{ "weapons/sword/swordvbigswing1.wav", "weapons/sword/swordvbigswing2.wav", }	
})

sound.Add({
	name = 			"Weapon_Sword.Flesh",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			{ "weapons/sword/swordflesh1.wav", "weapons/sword/swordflesh2.wav", "weapons/sword/swordflesh3.wav", "weapons/sword/swordflesh4.wav" }	
})

sound.Add({
	name = 			"Weapon_Sword.Hit",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sword/swordhit.wav"	
})

sound.Add({
	name = 			"Weapon_Sword.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sword/sworddeploy.wav"	
})

--- Pulse Pen ---

sound.Add({
	name = 			"Weapon_Pen.Swing",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 80, 90 },
	sound = 			{ ")weapons/sword/swordmiss1.wav", ")weapons/sword/swordmiss2.wav" }	
})

sound.Add({
	name = 			"Weapon_Pen.Hit",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 105 },
	sound = 			{ ")weapons/pulsesmartpen/write1.wav", ")weapons/pulsesmartpen/write2.wav"}	
})

--- Toy Hammer ---

sound.Add({
	name = 			"Weapon_Toy.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/toyhammer/toydeploy.wav"	
})

sound.Add({
	name = 			"Weapon_Toy.Hit",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 105 },
	sound = 			{ ")weapons/toyhammer/toyhit1.wav", ")weapons/toyhammer/toyhit2.wav", ")weapons/toyhammer/toyhit3.wav" }	
})


--- Stealth Box ---

sound.Add({
	name = 			"Weapon_Box.Taunt",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 105 },
	sound = 			{ ")weapons/taunts/tauntbox1.wav", ")weapons/taunts/tauntbox2.wav", ")weapons/taunts/tauntbox3.wav", ")weapons/taunts/tauntbox4.wav", ")weapons/taunts/tauntbox5.wav", ")weapons/taunts/tauntbox6.wav"}	
})

--- Babynade ---

sound.Add({
	name = 			"Weapon_Bade.Everything",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 105 },
	sound = 			 ")ambient/creatures/teddy.wav"	
})


--- Double Silencers ---
sound.Add({
	name = 			"Weapon_VirSil.Fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			 ")weapons/dualsilencer/shoot.wav" 
})

sound.Add({
	name = 			"Weapon_VirSil.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dualsilencer/deploy.wav"	
})

sound.Add({
	name = 			"Weapon_VirSil.Reload",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dualsilencer/reload.wav"	
})

--- 9mm Pistol ---
sound.Add({
	name = 			"Weapon_9mm.fire",
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			")weapons/9mm/shoot.wav"
})

--- TNT ---
sound.Add({
	name = 			"Weapon_TNT.Throw",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tnt/Throw.wav"	
})

sound.Add({
	name = 			"Weapon_TNT.Draw",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tnt/draw.wav"	
})

sound.Add({
    name = "Weapon_Springfield.Shoot",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/springfield/springfield_fp.wav"
})

sound.Add(
{
    name = "Weapon_Springfield.Rattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/Springfield_rattle.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.MagFetch",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/Springfield_fetchmag.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.BoltRelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_boltrelease.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.BoltLatch",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_boltlatch.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_boltback.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Boltforward",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_boltforward.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_bulletin_1.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_bulletin_2.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_bulletin_3.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_bulletin_4.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.MagIn",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_MagIn.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.RoundsIn",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/springfield_RoundsIn.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.BoltforwardStripperClip",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/Springfield_boltforward_stripperclip.wav"
})
sound.Add(
{
    name = "Weapon_Springfield.StripperClipEject",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/springfield/handling/Springfield_stripperclip_eject.wav"
})


sound.Add({
    name = "Weapon_UMP45.Single",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/hkump/hkump-1.wav"
})
sound.Add(
{
    name = "ump45.boltpull",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/boltpull.wav"
})
sound.Add(
{
    name = "ump45.boltcatch",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/catch.wav"
})
sound.Add(
{
    name = "ump45.foley",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/foley.wav"
})
sound.Add(
{
    name = "ump45.deploy",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/deploy.wav"
})
sound.Add(
{
    name = "ump45.clipin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/clipin.wav"
})
sound.Add(
{
    name = "ump45.clipout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/clipout.wav"
})

sound.Add(
{
    name = "ump45.cliptap",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/cliptap.wav"
})
sound.Add(
{
    name = "ump45.magrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/magrelease.wav"
})
sound.Add(
{
    name = "ump45.magslap",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/magslap.wav"
})

sound.Add(
{
    name = "Weapon_ump45.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/clipin.wav"
})
sound.Add(
{
    name = "Weapon_ump45.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/clipout.wav"
})
sound.Add(
{
    name = "Weapon_ump45.MagRelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/magrelease.wav"
})

sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_01.wav"
})
sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_02.wav"
})
sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_03.wav"
})
sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_04.wav"
})
sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_05.wav"
})
sound.Add(
{
    name = "Universal.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_draw_06.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_01.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_02.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_03.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_04.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_05.wav"
})
sound.Add(
{
    name = "Universal.Holster",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/universal/uni_weapon_holster_06.wav"
})

-- sound.Add = sound.Add_

sound.Add({
    name = "Meep.Laser.Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    pitch = {95, 105},
    sound = ")moat_laser1.mp3"
})

sound.Add({
    name = "Meep.Paintball.Fire",
    channel = CHAN_BODY,
    volume = 1.0,
    pitch = {95, 105},
    sound = {")moat_paintball1.mp3", ")moat_paintball2.mp3", ")moat_paintball3.mp3"}
})

sound.Add({
	name = "Meep.Paintball.Hit",
	channel = CHAN_BODY,
	volume = 1.0,
	pitch = {95, 105},
	sound = ")moat_paintballhit.mp3"
})

sound.Add({
    name = "gunshot_benli_m4",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_benli_m4/xm1014-1.wav"
})

sound.Add({
	name = 			"improv_ben_m4.insert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_benli_m4/xm1014_insertshell.wav"
})

sound.Add({
	name = 			"improv_ben_m4.cock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_benli_m4/xm1014_boltpull.wav"
})


//MAC-10

sound.Add({
    name = "gunshot_ops_mac10",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_mac10/mac10-1.wav"
})
sound.Add({
	name = 			"improv_MAC10.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mac10/mac10_clipout.wav"
})

sound.Add({
	name = 			"improv_MAC10.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mac10/mac10_clipin.wav"
})

sound.Add({
	name = 			"improv_MAC10.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mac10/mac10_boltpull.wav"
})

-- MP40 --
fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/request cod waw/mp40 slap.wav"
fastbl["name"] = "MP40.boltslap"
sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/request cod waw/mp40 deploy.wav"
fastbl["name"] = "MP40.deploy"
sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/request cod waw/mp40 back.wav"
fastbl["name"] = "MP40.boltback"
sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/request cod waw/mp40 out.wav"
fastbl["name"] = "MP40.clipout"
sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/request cod waw/mp40 in.wav"
fastbl["name"] = "MP40.clipin"
sound.Add(fastbl)

hook("InitPostEntity", function()
	for k, v in ipairs(WEAPON_SOUNDS) do
		util.PrecacheSound(v.name)
	end
end)