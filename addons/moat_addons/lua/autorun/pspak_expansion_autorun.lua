if GetConVar("pspak_weapon_stripping") == nil then
	CreateConVar("pspak_weapon_stripping", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false.")
	print("Weapon Strip con var created")
end
	
if GetConVar("pspak_disable_penetration_ricochet") == nil then
	CreateConVar("pspak_disable_penetration_ricochet", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false.")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("pspak_dynamic_recoil") == nil then
	CreateConVar("pspak_dynamic_recoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false.")
	print("Recoil con var created")
end
	
if GetConVar("pspak_unique_slots") == nil then
	CreateConVar("pspak_unique_slots", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give the SWEPs unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if GetConVar("pspak_disable_holstering") == nil then
	CreateConVar("pspak_disable_holstering", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable m9k's totally worthless and broken holster system? It won't hurt the creator's feelings anyway. 1 for true, 2 for false. A map change may be required.")
	print("Holster Disable con var created")
end
	
if GetConVar("pspak_ammo_detonation") == nil then
	CreateConVar("pspak_ammo_detonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable m9k ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("pspak_debug_weaponry") == nil then
	CreateConVar("pspak_debug_weaponry", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k base stuff, turning it on won't change much.")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("pspak_gas_effect") == nil then
			CreateClientConVar("pspak_gas_effect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("pspak_gas_effect") == nil then
		CreateConVar("pspak_gas_effect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end

//DSA FAL

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_dsafal/dsa_unsil-1.wav"
soundtbl["name"] = "gunshot_dsa_fal"
sound.Add(soundtbl)

sound.Add({
	name = 			"gunshot_dsa_fal_silenced",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/dsa-1.wav"
})

sound.Add({
	name = 			"DSAFAL.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/magout.wav"
})

sound.Add({
	name = 			"DSAFAL.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/magin.wav"
})

sound.Add({
	name = 			"DSAFAL.shoulder",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/deploy.wav"
})

sound.Add({
	name = 			"DSAFAL.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/boltpull.wav"
})

sound.Add({
	name = 			"DSAFAL.deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/deploy.wav"
})

sound.Add({
	name = 			"DSAFAL.fireselector",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/safety.wav"
})

sound.Add({
	name = 			"DSAFAL.PlaceSilencer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/placesilencer.wav"
})

sound.Add({
	name = 			"DSAFAL.SpinSilencer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_dsafal/silencerspin.wav"
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

//L96A1

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_l96/awp1.wav"
soundtbl["name"] = "gunshot_l96"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_l96.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_boltback.wav"
})

sound.Add({
	name = 			"improv_l96.Boltpush",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_boltpush.wav"
})

sound.Add({
	name = 			"improv_l96.Boltlock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_boltlock.wav"
})

sound.Add({
	name = 			"improv_l96.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_deploy.wav"
})

sound.Add({
	name = 			"improv_l96.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_clipout.wav"
})

sound.Add({
	name = 			"improv_l96.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_clipin.wav"
})

sound.Add({
	name = 			"improv_l96.Cliptap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_l96/awp_cliptap.wav"
})

//Brügger & Thomet MP9

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_mp9/tmp-1.wav"
soundtbl["name"] = "gunshot_bnt_mp9"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_mp9.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mp9/tmp_clipout.wav"
})

sound.Add({
	name = 			"improv_mp9.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mp9/tmp_clipin.wav"
})

sound.Add({
	name = 			"improv_mp9.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_mp9/tmp_deploy.wav"
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

//RU 556

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_ru556/Fire.wav"
soundtbl["name"] = "gunshot_ru_556"
sound.Add(soundtbl)

sound.Add({
	name = 			"ru556.foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/Foley.wav"
})

sound.Add({
	name = 			"ru556.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/MagOut.wav"
})

sound.Add({
	name = 			"ru556.magfix",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/MagFix.wav"
})

sound.Add({
	name = 			"ru556.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/MagIn.wav"
})

sound.Add({
	name = 			"ru556.pull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/Pull.wav"
})

sound.Add({
	name = 			"ru556.retract",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/Retract.wav"
})

sound.Add({
	name = 			"ru556.deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/Deploy.wav"
})

sound.Add({
	name = 			"ru556.drag",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_ru556/Drag.wav"
})

//M14 EBR

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_m14/Shoot.wav"
soundtbl["name"] = "gunshot_m14_ebr"
sound.Add(soundtbl)

sound.Add({
	name = 			"M14.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Boltpull.wav"
})

sound.Add({
	name = 			"M14.MagOut",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Magout.wav"
})

sound.Add({
	name = 			"M14.MagIn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Magin.wav"
})

sound.Add({
	name = 			"M14.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Deploy.wav"
})

sound.Add({
	name = 			"M14.MagDraw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Magdraw.wav"
})

sound.Add({
	name = 			"M14.Shoulder",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m14/Shoulder.wav"
})