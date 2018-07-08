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

//SIG SG 552

sound.Add({
    name = "gunshot_sg_552",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_sg552/sg552-1.wav"
})
sound.Add({
	name = 			"improv_SG552.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_sg552/sg552_clipout.wav"
})

sound.Add({
	name = 			"improv_SG552.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_sg552/sg552_clipin.wav"
})

sound.Add({
	name = 			"improv_SG552.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_sg552/sg552_boltpull.wav"
})

//Benelli M3

sound.Add({
    name = "gunshot_benli_m3",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_m3/m3-1.wav"
})
sound.Add({
	name = 			"improv_M3.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m3/m3_insertshell.wav"
})

sound.Add({
	name = 			"improv_M3.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m3/m3_pump.wav"
})

//SIG P228

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_p228/p228-1.wav"
soundtbl["name"] = "gunshot_p228"
sound.Add(soundtbl)

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

//PP-19 Bizon

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_pp_bizon/Shoot.wav"
soundtbl["name"] = "gunshot_bizon"
sound.Add(soundtbl)

sound.Add({
	name = 			"PP19.Magout1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Magout1.wav"
})

sound.Add({
	name = 			"PP19.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Magout.wav"
})

sound.Add({
	name = 			"PP19.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Magin.wav"
})

sound.Add({
	name = 			"PP19.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Boltpull.wav"
})

sound.Add({
	name = 			"PP19.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Foley.wav"
})

sound.Add({
	name = 			"PP19.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_pp_bizon/Foley.wav"
})

//AR-15

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_m4a1/m4a1_unsil-1.wav"
soundtbl["name"] = "gunshot_ris_m4a1"
sound.Add(soundtbl)

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_m4a1/m4a1-1.wav"
soundtbl["name"] = "gunshot_ris_m4a1_silenced"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_M4A1.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_clipout.wav"
})

sound.Add({
	name = 			"improv_M4A1.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_clipin.wav"
})

sound.Add({
	name = 			"improv_M4A1.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_deploy.wav"
})

sound.Add({
	name = 			"improv_M4A1.Boltrelease1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_boltpull.wav"
})

sound.Add({
	name = 			"improv_M4A1.Silencer_On",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_silencer_on.wav"
})

sound.Add({
	name = 			"improv_M4A1.Silencer_Off",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4a1/m4a1_silencer_off.wav"
})

//HK 416

sound.Add({
    name = "gunshot_hk_416",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_416/aug-1.wav"
})
sound.Add({
	name = 			"416.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/draw.wav"
})

sound.Add({
	name = 			"416.clothfast1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/clothfast.wav"
})

sound.Add({
	name = 			"416.magout1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/magout.wav"
})

sound.Add({
	name = 			"416.maginfail1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/magfail.wav"
})

sound.Add({
	name = 			"416.magin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/magin.wav"
})

sound.Add({
	name = 			"416.boltrelease1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_416/boltrelease.wav"
})

//M4A1

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_m4hy/m4a1_unsil-1.wav"
soundtbl["name"] = "gunshot_m4hy"
sound.Add(soundtbl)

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_m4hy/m4a1-1.wav"
soundtbl["name"] = "gunshot_m4hy_silenced"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_M4HY.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_boltpull.wav"
})

sound.Add({
	name = 			"improv_M4HY.Boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_boltrelease.wav"
})

sound.Add({
	name = 			"improv_M4HY.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_deploy.wav"
})

sound.Add({
	name = 			"improv_M4HY.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_Magout.wav"
})

sound.Add({
	name = 			"improv_M4HY.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_magin.wav"
})

sound.Add({
	name = 			"improv_M4HY.Magdrop",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_magdrop.wav"
})

sound.Add({
	name = 			"improv_M4HY.Gungrab",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_gungrab.wav"
})

sound.Add({
	name = 			"improv_M4HY.Gunmove",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_gunmove.wav"
})

sound.Add({
	name = 			"improv_M4HY.Silencer_On",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_silencer_on.wav"
})

sound.Add({
	name = 			"improv_M4HY.Silencer_Off",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m4hy/m4a1_silencer_off.wav"
})

//AK-47

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_irq_ak47/ak47-1.wav"
soundtbl["name"] = "gunshot_irq_ak47"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_AK47.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_irq_ak47/ak47_boltpull.wav"
})

sound.Add({
	name = 			"improv_AK47.BoltRelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_irq_ak47/ak47_boltrelease.wav"
})

sound.Add({
	name = 			"improv_AK47.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_irq_ak47/ak47_clipout.wav"
})

sound.Add({
	name = 			"improv_AK47.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_irq_ak47/ak47_clipin.wav"
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

//M60

sound.Add({
    name = "gunshot_m60",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/gunshot_m60/m249-1.wav"
})
sound.Add({
	name = 			"improv_MM60.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_boltpull.wav"
})

sound.Add({
	name = 			"improv_MM60.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_boxout.wav"
})

sound.Add({
	name = 			"improv_MM60.Boxin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_boxin.wav"
})

sound.Add({
	name = 			"improv_MM60.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_coverup.wav"
})

sound.Add({
	name = 			"improv_MM60.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_chain.wav"
})

sound.Add({
	name = 			"improv_MM60.Click",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_click.wav"
})

sound.Add({
	name = 			"improv_MM60.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_coverdown.wav"
})

sound.Add({
	name = 			"improv_MM60.Chaindraw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_m60/m249_chaindraw.wav"
})

//Benelli M4

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_benli_m4/xm1014-1.wav"
soundtbl["name"] = "gunshot_benli_m4"
sound.Add(soundtbl)

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

//Walther 2000

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_waltr_2000/walther.wav"
soundtbl["name"] = "gunshot_waltr_2000"
sound.Add(soundtbl)

sound.Add({
	name = 			"Walther.Lightcloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Lightcloth.wav"
})

sound.Add({
	name = 			"Walther.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Magout.wav"
})

sound.Add({
	name = 			"Walther.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Magin.wav"
})

sound.Add({
	name = 			"Walther.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Boltback.wav"
})

sound.Add({
	name = 			"Walther.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Boltforward.wav"
})

sound.Add({
	name = 			"Walther.Heavycloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/Heavycloth.wav"
})

sound.Add({
	name = 			"Walther.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_waltr_2000/foley.wav"
})

//FN FAL

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_fn_fal/galil-1.wav"
soundtbl["name"] = "gunshot_fn_fal"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_fnfal.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_fn_fal/galil_clipout.wav"
})

sound.Add({
	name = 			"improv_fnfal.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_fn_fal/galil_clipin.wav"
})

sound.Add({
	name = 			"improv_fnfal.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_fn_fal/galil_boltpull.wav"
})

//CZ 75

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

//HK G36C

local soundtbl = {}
soundtbl["channel"] = "1"
soundtbl["level"] = "135"
soundtbl["volume"] = "1.0"
soundtbl["CompatibilityAttenuation"] = "0.48"
soundtbl["pitch"] = "95,105"
soundtbl["sound"] = ")weapons/gunshot_g36c/G36C_Fire.wav"
soundtbl["name"] = "gunshot_hk_g36c"
sound.Add(soundtbl)

sound.Add({
	name = 			"improv_g36c.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_g36c/boltpull.wav"
})

sound.Add({
	name = 			"improv_g36c.Handle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_g36c/handle.wav"
})

sound.Add({
	name = 			"improv_g36c.Maghit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_g36c/maghit.wav"
})

sound.Add({
	name = 			"improv_g36c.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_g36c/magout.wav"
})

sound.Add({
	name = 			"improv_g36c.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/gunshot_g36c/magin.wav"
})