AddCSLuaFile()

//SHOTGUN GROUP

// *********************************
// *********************************
// *                               *
// *         Remington 870         *
// *                               *
// *********************************
// *********************************
local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/shotgun_rem870/rem870_fire1.wav","weapons/shotgun_rem870/rem870_fire2.wav","weapons/shotgun_rem870/rem870_fire3.wav","weapons/shotgun_rem870/rem870_fire4.wav","weapons/shotgun_rem870/rem870_fire5.wav"}
fastbl["name"] = "Weapof_REM870.Shoot"

sound.Add({
	name = "Weapof_REM870.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/shotgun_rem870/rem870_fire1.wav", ")weapons/shotgun_rem870/rem870_fire2.wav", ")weapons/shotgun_rem870/rem870_fire3.wav", ")weapons/shotgun_rem870/rem870_fire4.wav", ")weapons/shotgun_rem870/rem870_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_rem870/rem870_insert1.wav",")weapons/shotgun_rem870/rem870_insert2.wav",")weapons/shotgun_rem870/rem870_insert3.wav"}
fastbl["name"] = "Weapof_REM870.Insert"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_draw.wav"
fastbl["name"] = "Weapof_REM870.Draw"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_holster.wav"
fastbl["name"] = "Weapof_REM870.Holster"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_start.wav"
fastbl["name"] = "Weapof_REM870.Start"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump1.wav"
fastbl["name"] = "Weapof_REM870.Pump1"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump2.wav"
fastbl["name"] = "Weapof_REM870.Pump2"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump_end.wav"
fastbl["name"] = "Weapof_REM870.Pump_End"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_nopump_end.wav"
fastbl["name"] = "Weapof_REM870.NoPump_End"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *         M3 Super 90 P         *
// *                               *
// *********************************
// *********************************

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/shotgun_m3s90p/m3s90_fire1.wav","weapons/shotgun_m3s90p/m3s90_fire2.wav","weapons/shotgun_m3s90p/m3s90_fire3.wav","weapons/shotgun_m3s90p/m3s90_fire4.wav","weapons/shotgun_m3s90p/m3s90_fire5.wav"}
fastbl["name"] = "Weapof_M3S90.Shoot"

sound.Add({
	name = "Weapof_M3S90.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/shotgun_m3s90p/m3s90_fire1.wav", ")weapons/shotgun_m3s90p/m3s90_fire2.wav", ")weapons/shotgun_m3s90p/m3s90_fire3.wav", ")weapons/shotgun_m3s90p/m3s90_fire4.wav", ")weapons/shotgun_m3s90p/m3s90_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_m3s90p/m3s90_load1.wav",")weapons/shotgun_m3s90p/m3s90_load2.wav",")weapons/shotgun_m3s90p/m3s90_load3.wav",")weapons/shotgun_m3s90p/m3s90_load4.wav",")weapons/shotgun_m3s90p/m3s90_load5.wav",")weapons/shotgun_m3s90p/m3s90_load6.wav",")weapons/shotgun_m3s90p/m3s90_load7.wav",")weapons/shotgun_m3s90p/m3s90_load8.wav"}
fastbl["name"] = "Weapof_M3S90.Load"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_m3s90p/m3s90_getammo1.wav",")weapons/shotgun_m3s90p/m3s90_getammo2.wav",")weapons/shotgun_m3s90p/m3s90_getammo3.wav"}
fastbl["name"] = "Weapof_M3S90.Getammo"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_m3s90p/m3s90_boltcatch.wav"
fastbl["name"] = "Weapof_M3S90.Boltcatch"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/pistol_m1911a1/1911_fire1.wav","weapons/pistol_m1911a1/1911_fire2.wav","weapons/pistol_m1911a1/1911_fire3.wav","weapons/pistol_m1911a1/1911_fire4.wav","weapons/pistol_m1911a1/1911_fire5.wav"}
fastbl["name"] = "Weapof_1911.Shoot"

sound.Add({
	name = "Weapof_1911.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_m1911a1/1911_fire1.wav", ")weapons/pistol_m1911a1/1911_fire2.wav", ")weapons/pistol_m1911a1/1911_fire3.wav", ")weapons/pistol_m1911a1/1911_fire4.wav", ")weapons/pistol_m1911a1/1911_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_m1911a1/1911_magin.wav"
fastbl["name"] = "Weapof_1911.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_m1911a1/1911_magout.wav"
fastbl["name"] = "Weapof_1911.MagOut"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/pistol_glock20/glock20_fire1.wav","weapons/pistol_glock20/glock20_fire2.wav","weapons/pistol_glock20/glock20_fire3.wav","weapons/pistol_glock20/glock20_fire4.wav","weapons/pistol_glock20/glock20_fire5.wav"}
fastbl["name"] = "Weapof_Glock20.Shoot"

sound.Add({
	name = "Weapof_Glock20.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_glock20/glock20_fire5.wav", ")weapons/pistol_glock20/glock20_fire4.wav", ")weapons/pistol_glock20/glock20_fire3.wav", ")weapons/pistol_glock20/glock20_fire2.wav", ")weapons/pistol_glock20/glock20_fire1.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_glock20/glock20_magout.wav"
fastbl["name"] = "Weapof_Glock20.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_glock20/glock20_magin.wav"
fastbl["name"] = "Weapof_Glock20.MagIn"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/pistol_ots33/ots33_fire1.wav","weapons/pistol_ots33/ots33_fire2.wav","weapons/pistol_ots33/ots33_fire3.wav","weapons/pistol_ots33/ots33_fire4.wav","weapons/pistol_ots33/ots33_fire5.wav"}
fastbl["name"] = "Weapof_OTs33.Shoot"

sound.Add({
	name = "Weapof_OTs33.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_ots33/ots33_fire1.wav", ")weapons/pistol_ots33/ots33_fire2.wav", ")weapons/pistol_ots33/ots33_fire3.wav", ")weapons/pistol_ots33/ots33_fire4.wav", ")weapons/pistol_ots33/ots33_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_ots33/ots33_magout.wav"
fastbl["name"] = "Weapof_OTs33.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_ots33/ots33_magin.wav"
fastbl["name"] = "Weapof_OTs33.MagIn"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.40"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/pistol_beretta92fs/m9_fire1.wav", "weapons/pistol_beretta92fs/m9_fire2.wav","weapons/pistol_beretta92fs/m9_fire3.wav","weapons/pistol_beretta92fs/m9_fire4.wav","weapons/pistol_beretta92fs/m9_fire5.wav"}
fastbl["name"] = "Weapof_Beretta92fs.Shoot"

sound.Add({
	name = "Weapof_Beretta92fs.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_beretta92fs/m9_fire1.wav", ")weapons/pistol_beretta92fs/m9_fire2.wav", ")weapons/pistol_beretta92fs/m9_fire3.wav", ")weapons/pistol_beretta92fs/m9_fire4.wav", ")weapons/pistol_beretta92fs/m9_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "100"
fastbl["CompatibilityAttenuation"] = "0.4"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_silenced_fire1.wav"
fastbl["name"] = "Weapof_Beretta92fss.Shoot"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_magout.wav"
fastbl["name"] = "Weapof_m9.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_beretta92fs/m9_magin.wav"
fastbl["name"] = "Weapof_m9.MagIn"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/pistol_deserteagle/de_fire1.wav","weapons/pistol_deserteagle/de_fire2.wav","weapons/pistol_deserteagle/de_fire3.wav","weapons/pistol_deserteagle/de_fire4.wav","weapons/pistol_deserteagle/de_fire5.wav"}
fastbl["name"] = "Weapof_DEagle.Shoot"

sound.Add({
	name = "Weapof_DEagle.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/pistol_deserteagle/de_fire1.wav", ")weapons/pistol_deserteagle/de_fire2.wav", ")weapons/pistol_deserteagle/de_fire3.wav", ")weapons/pistol_deserteagle/de_fire4.wav", ")weapons/pistol_deserteagle/de_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_deserteagle/de_magout.wav"
fastbl["name"] = "Weapof_DEagle.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/pistol_deserteagle/de_magin.wav"
fastbl["name"] = "Weapof_DEagle.MagIn"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sub_mp5/mp5_fire1.wav","weapons/sub_mp5/mp5_fire2.wav","weapons/sub_mp5/mp5_fire3.wav","weapons/sub_mp5/mp5_fire4.wav","weapons/sub_mp5/mp5_fire5.wav"}
fastbl["name"] = "Weapof_MP5.Shoot"

sound.Add({
	name = "Weapof_MP5.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_mp5/mp5_fire1.wav", ")weapons/sub_mp5/mp5_fire2.wav", ")weapons/sub_mp5/mp5_fire3.wav", ")weapons/sub_mp5/mp5_fire4.wav", ")weapons/sub_mp5/mp5_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_magout.wav"
fastbl["name"] = "Weapof_MP5.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_magin.wav"
fastbl["name"] = "Weapof_MP5.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mp5/mp5_boltback.wav"
fastbl["name"] = "Weapof_MP5.Boltback"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sub_sterling/sterling_fire1.wav","weapons/sub_sterling/sterling_fire2.wav","weapons/sub_sterling/sterling_fire3.wav"}
fastbl["name"] = "Weapof_STERLING.Shoot"

sound.Add({
	name = "Weapof_STERLING.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_sterling/sterling_fire1.wav", ")weapons/sub_sterling/sterling_fire2.wav", ")weapons/sub_sterling/sterling_fire3.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_sterling/reload.mp3"
fastbl["name"] = "Weapof_STERLING.Reload"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_sterling/reload_empty.mp3"
fastbl["name"] = "Weapof_STERLING.ReloadEmpty"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *        CF05 Changefeng        *
// *                               *
// *********************************
// *********************************
local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sub_cf05/cf05_fire1.wav","weapons/sub_cf05/cf05_fire2.wav","weapons/sub_cf05/cf05_fire3.wav","weapons/sub_cf05/cf05_fire4.wav","weapons/sub_cf05/cf05_fire5.wav"}
fastbl["name"] = "Weapof_CF05.Shoot"

sound.Add({
	name = "Weapof_CF05.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/sub_cf05/cf05_fire1.wav", ")weapons/sub_cf05/cf05_fire2.wav", ")weapons/sub_cf05/cf05_fire3.wav", ")weapons/sub_cf05/cf05_fire4.wav", ")weapons/sub_cf05/cf05_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_cf05/cf05_magout.wav"
fastbl["name"] = "Weapof_CF05.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_cf05/cf05_magin.wav"
fastbl["name"] = "Weapof_CF05.MagIn"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_magout.wav"
fastbl["name"] = "Weapof_MAC11.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_magin.wav"
fastbl["name"] = "Weapof_MAC11.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sub_mac11/mac11_boltback.wav"
fastbl["name"] = "Weapof_MAC11.Boltpull"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_famas/famas_fire1.wav","weapons/ar_famas/famas_fire2.wav","weapons/ar_famas/famas_fire3.wav","weapons/ar_famas/famas_fire4.wav","weapons/ar_famas/famas_fire5.wav"}
fastbl["name"] = "Weapof_FAMAS.Shoot"

sound.Add({
	name = "Weapof_FAMAS.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_famas/famas_fire1.wav", ")weapons/ar_famas/famas_fire2.wav", ")weapons/ar_famas/famas_fire3.wav", ")weapons/ar_famas/famas_fire4.wav", ")weapons/ar_famas/famas_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_famas/famas_magout.wav"
fastbl["name"] = "Weapof_FAMAS.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_famas/famas_magin.wav"
fastbl["name"] = "Weapof_FAMAS.MagIn"

sound.Add(fastbl)

local fastbl = {}
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
local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_m4a1/m4_fire1.wav","weapons/ar_m4a1/m4_fire1.wav","weapons/ar_m4a1/m4_fire1.wav","weapons/ar_m4a1/m4_fire1.wav","weapons/ar_m4a1/m4_fire1.wav"}
fastbl["name"] = "Weapof_M4A1.Shoot"

sound.Add({
	name = "Weapof_M4A1.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_m4a1/m4_fire1.wav", ")weapons/ar_m4a1/m4_fire2.wav", ")weapons/ar_m4a1/m4_fire3.wav", ")weapons/ar_m4a1/m4_fire4.wav", ")weapons/ar_m4a1/m4_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_magout.wav"
fastbl["name"] = "Weapof_M4A1.Magout"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_magin.wav"
fastbl["name"] = "Weapof_M4A1.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_boltcatch.wav"
fastbl["name"] = "Weapof_M4A1.BoltCatch"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_stock.wav"
fastbl["name"] = "Weapof_M4A1.Stockpull"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_check.wav"
fastbl["name"] = "Weapof_M4A1.Check"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_forwardassist.wav"
fastbl["name"] = "Weapof_M4A1.Forwardassist"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_dustcover.wav"
fastbl["name"] = "Weapof_M4A1.Dustcover"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/switch.wav"
fastbl["name"] = "Weapof_M4A1.switch"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m4a1/m4_charge.wav"
fastbl["name"] = "Weapof_M4A1.Boltpull"

sound.Add(fastbl)

local fastbl = {}
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
// *         M16A2		   		   *	
// *                               *
// *********************************
// *********************************

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_m16a2/m16a2_fire1.wav","weapons/ar_m16a2/m16a2_fire2.wav","weapons/ar_m16a2/m16a2_fire3.wav","weapons/ar_m16a2/m16a2_fire4.wav","weapons/ar_m16a2/m16a2_fire5.wav"}
fastbl["name"] = "Weapof_M16A2.Shoot"

sound.Add({
	name = "Weapof_M16A2.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_m16a2/m16a2_fire1.wav", ")weapons/ar_m16a2/m16a2_fire2.wav", ")weapons/ar_m16a2/m16a2_fire3.wav", ")weapons/ar_m16a2/m16a2_fire4.wav", ")weapons/ar_m16a2/m16a2_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m16a2/m16a2_magin.wav"
fastbl["name"] = "Weapof_M16A2.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m16a2/m16a2_magout.wav"
fastbl["name"] = "Weapof_M16A2.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m16a2/m16a2_charge.wav"
fastbl["name"] = "Weapof_M16A2.SlideStop"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *             SG550             *
// *                               *
// *********************************
// *********************************

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_sg550/sg550_fire1.wav","weapons/ar_sg550/sg550_fire2.wav","weapons/ar_sg550/sg550_fire3.wav","weapons/ar_sg550/sg550_fire4.wav","weapons/ar_sg550/sg550_fire5.wav"}
fastbl["name"] = "Weapof_sg550.Shoot"

sound.Add({
	name = "Weapof_sg550.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_sg550/sg550_fire1.wav", ")weapons/ar_sg550/sg550_fire2.wav", ")weapons/ar_sg550/sg550_fire3.wav", ")weapons/ar_sg550/sg550_fire4.wav", ")weapons/ar_sg550/sg550_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sg550/sg550_magout.wav"
fastbl["name"] = "Weapof_sg550.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sg550/sg550_magin.wav"
fastbl["name"] = "Weapof_sg550.MagIn"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_g36c/g36c_fire1.wav","weapons/ar_g36c/g36c_fire2.wav","weapons/ar_g36c/g36c_fire3.wav","weapons/ar_g36c/g36c_fire4.wav","weapons/ar_g36c/g36c_fire5.wav"}
fastbl["name"] = "Weapof_G36.Shoot"

sound.Add({
	name = "Weapof_G36.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_g36c/g36c_fire1.wav", ")weapons/ar_g36c/g36c_fire2.wav", ")weapons/ar_g36c/g36c_fire3.wav", ")weapons/ar_g36c/g36c_fire4.wav", ")weapons/ar_g36c/g36c_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_magout.wav"
fastbl["name"] = "Weapof_G36.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_magin.wav"
fastbl["name"] = "Weapof_G36.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_cock.wav"
fastbl["name"] = "Weapof_G36.BoltPull"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_handle.wav"
fastbl["name"] = "Weapof_G36.BoltHandle"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_boltcatch.wav"
fastbl["name"] = "Weapof_G36.BoltRelease"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_stock.wav"
fastbl["name"] = "Weapof_G36.Stock"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g36c/g36c_switch.wav"
fastbl["name"] = "Weapof_G36.Switch"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_sako92/sako_fire1.wav","weapons/ar_sako92/sako_fire2.wav","weapons/ar_sako92/sako_fire3.wav","weapons/ar_sako92/sako_fire4.wav","weapons/ar_sako92/sako_fire5.wav"}
fastbl["name"] = "Weapof_Sako.Shoot"

sound.Add({
	name = "Weapof_Sako.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_sako92/sako_fire1.wav", ")weapons/ar_sako92/sako_fire2.wav", ")weapons/ar_sako92/sako_fire3.wav", ")weapons/ar_sako92/sako_fire4.wav", ")weapons/ar_sako92/sako_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sako92/sako_cock.wav"
fastbl["name"] = "Weapof_Sako.BoltPull"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_sako92/sako_magin.wav"
fastbl["name"] = "Weapof_Sako.MagIn"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_ak47/ak47_fire1.wav","weapons/ar_ak47/ak47_fire2.wav","weapons/ar_ak47/ak47_fire3.wav","weapons/ar_ak47/ak47_fire4.wav","weapons/ar_ak47/ak47_fire5.wav"}
fastbl["name"] = "Weapof_AK47.Shoot"

sound.Add({
	name = "Weapof_AK47.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_ak47/ak47_fire1.wav", ")weapons/ar_ak47/ak47_fire2.wav", ")weapons/ar_ak47/ak47_fire3.wav", ")weapons/ar_ak47/ak47_fire4.wav", ")weapons/ar_ak47/ak47_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_ak47/ak47_cock.wav"
fastbl["name"] = "Weapof_AK47.BoltPull"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_ak47/ak47_magin.wav"
fastbl["name"] = "Weapof_AK47.MagIn"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_m14/m14_fire1.wav","weapons/ar_m14/m14_fire2.wav","weapons/ar_m14/m14_fire3.wav","weapons/ar_m14/m14_fire4.wav","weapons/ar_m14/m14_fire5.wav"}
fastbl["name"] = "Weapof_M14.Shoot"

sound.Add({
	name = "Weapof_M14.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_m14/m14_fire1.wav", ")weapons/ar_m14/m14_fire2.wav", ")weapons/ar_m14/m14_fire3.wav", ")weapons/ar_m14/m14_fire4.wav", ")weapons/ar_m14/m14_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_boltcatch.wav"
fastbl["name"] = "Weapof_M14.BoltCatch"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_magout.wav"
fastbl["name"] = "Weapof_M14.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_magin.wav"
fastbl["name"] = "Weapof_M14.MagIn"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m14/m14_charge.wav"
fastbl["name"] = "Weapof_M14.Boltpull"

sound.Add(fastbl)

local fastbl = {}
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

local fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/ar_g3a3/g3_fire1.wav","weapons/ar_g3a3/g3_fire2.wav","weapons/ar_g3a3/g3_fire3.wav","weapons/ar_g3a3/g3_fire4.wav","weapons/ar_g3a3/g3_fire5.wav"}
fastbl["name"] = "Weapof_G3.Shoot"

sound.Add({
	name = "Weapof_G3.Shoot",
	channel = CHAN_WEAPON,
    volume = 1.0,
	pitch = {95, 105},
	sound = {")weapons/ar_g3a3/g3_fire1.wav", ")weapons/ar_g3a3/g3_fire2.wav", ")weapons/ar_g3a3/g3_fire3.wav", ")weapons/ar_g3a3/g3_fire4.wav", ")weapons/ar_g3a3/g3_fire5.wav"}
})

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_boltpull.wav"
fastbl["name"] = "Weapof_G3.BoltPull"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_boltforward.wav"
fastbl["name"] = "Weapof_G3.BoltForward"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_magout.wav"
fastbl["name"] = "Weapof_G3.MagOut"

sound.Add(fastbl)

local fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_g3a3/g3_magin.wav"
fastbl["name"] = "Weapof_G3.MagIn"

sound.Add(fastbl)

