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

util.PrecacheSound "BO2_PEACE_FIRE"
util.PrecacheSound "BO2_PEACE_FIRE_SILENCED"
util.PrecacheSound "BO2_PEACE_MAGOUT"
util.PrecacheSound "BO2_PEACE_MAGIN"
util.PrecacheSound "BO2_PEACE_CHARGE"

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

///////////////////////////////////////////////
sound.Add(
{
    name = "Bullet.Concrete",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/concrete/concrete_impact_bullet1.wav",
		"physics/concrete/concrete_impact_bullet2.wav",
		"physics/concrete/concrete_impact_bullet3.wav",
		"physics/concrete/concrete_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Flesh",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/flesh/flesh_impact_bullet1.wav",
		"physics/flesh/flesh_impact_bullet2.wav",
		"physics/flesh/flesh_impact_bullet3.wav",
		"physics/flesh/flesh_impact_bullet4.wav",
		"physics/flesh/flesh_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Bullet.Glass",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/glass/glass_impact_bullet1.wav",
		"physics/glass/glass_impact_bullet2.wav",
		"physics/glass/glass_impact_bullet3.wav",
		"physics/glass/glass_impact_bullet4.wav",
		"physics/glass/glass_largesheet_break1.wav",
		"physics/glass/glass_largesheet_break2.wav",
		"physics/glass/glass_largesheet_break3.wav"
		}
})
sound.Add(
{
    name = "Bullet.Metal",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/metal/metal_solid_impact_bullet1.wav",
		"physics/metal/metal_solid_impact_bullet2.wav",
		"physics/metal/metal_solid_impact_bullet3.wav",
		"physics/metal/metal_solid_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Tile",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/plastic/plastic_box_impact_bullet1.wav",
		"physics/plastic/plastic_box_impact_bullet2.wav",
		"physics/plastic/plastic_box_impact_bullet3.wav",
		"physics/plastic/plastic_box_impact_bullet4.wav",
		"physics/plastic/plastic_box_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Bullet.Dirt",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/surfaces/sand_impact_bullet1.wav",
		"physics/surfaces/sand_impact_bullet2.wav",
		"physics/surfaces/sand_impact_bullet3.wav",
		"physics/surfaces/sand_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Wood",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/wood/wood_solid_impact_bullet1.wav",
		"physics/wood/wood_solid_impact_bullet2.wav",
		"physics/wood/wood_solid_impact_bullet3.wav",
		"physics/wood/wood_solid_impact_bullet4.wav",
		"physics/wood/wood_solid_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Explosion.Boom",
    channel = CHAN_EXPLOSION,
    volume = 1.0,
    soundlevel = SNDLVL_150dB,
    sound = 	"GDC/ExplosionBoom.wav"

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

-- game.AddParticles("particles/smoke_trail.pcf")

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



local icol = Color(255, 255, 255, 255)

--
if CLIENT then
	-- killicon.Add("m9k_thrown_harpoon", "vgui/hud/m9k_harpoon", icol)
    language.Add("Harpoon_ammo", "Harpoon")
end

sound.Add({
    name = "EX41.Pump",
    channel = CHAN_ITEM,
    volume = 1,
    sound = "weapons/ex41/m3_pump.mp3"
})

sound.Add({
    name = "EX41.Insertshell",
    channel = CHAN_ITEM,
    volume = 1,
    sound = "weapons/ex41/m3_insertshell.mp3"
})

sound.Add({
    name = "EX41.Draw",
    channel = CHAN_ITEM,
    volume = 1,
    sound = "weapons/ex41/draw.mp3"
})

--RPG
sound.Add({
    name = "RPGF.single",
    channel = CHAN_USER_BASE + 10,
    volume = 1.0,
    soundlevel = 155,
    sound = "GDC/Rockets/RPGF.wav"
})

sound.Add({
    name = "M202F.single",
    channel = CHAN_USER_BASE + 10,
    volume = 1.0,
    soundlevel = 155,
    sound = {"GDC/Rockets/M202F.wav", "gdc/rockets/m202f2.wav"}
})

sound.Add({
    name = "MATADORF.single",
    channel = CHAN_USER_BASE + 10,
    volume = 1.0,
    soundlevel = 155,
    sound = "GDC/Rockets/MATADORF.wav"
})

--Suicide bomb
sound.Add({
    name = "sb.click",
    channel = CHAN_USER_BASE + 10,
    volume = "1",
    sound = "weapons/suicidebomb/c4_click.mp3"
})

-- m79 grenade launcher
sound.Add({
    name = "M79_launcher.close",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/M79/m79_close.mp3"
})

sound.Add({
    name = "M79_glauncher.barrelup", --GET THIS SOUND!
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/M79/barrelup.mp3"
})

sound.Add({
    name = "M79_glauncher.InsertShell", --GET THIS SOUND!
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/M79/xm_insert.mp3"
})

sound.Add({
    name = "M79_launcher.draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/M79/m79_close.mp3"
})

sound.Add({
    name = "40mmGrenade.Single",
    channel = CHAN_USER_BASE + 10,
    volume = 1.0,
    sound = "weapons/M79/40mmthump.wav"
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

if GetConVar("pspak_weapon_stripping") == nil then
	CreateConVar("pspak_weapon_stripping", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false.")
end
	
if GetConVar("pspak_disable_penetration_ricochet") == nil then
	CreateConVar("pspak_disable_penetration_ricochet", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false.")
end
	
if GetConVar("pspak_dynamic_recoil") == nil then
	CreateConVar("pspak_dynamic_recoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false.")
end
	
if GetConVar("pspak_unique_slots") == nil then
	CreateConVar("pspak_unique_slots", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give the SWEPs unique slots? 1 for true, 2 for false. A map change may be required.")
end
	
if GetConVar("pspak_disable_holstering") == nil then
	CreateConVar("pspak_disable_holstering", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable m9k's totally worthless and broken holster system? It won't hurt the creator's feelings anyway. 1 for true, 2 for false. A map change may be required.")
end
	
if GetConVar("pspak_ammo_detonation") == nil then
	CreateConVar("pspak_ammo_detonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable m9k ammo crates? 1 for true, 0 for false.")
end

if GetConVar("pspak_debug_weaponry") == nil then
	CreateConVar("pspak_debug_weaponry", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k base stuff, turning it on won't change much.")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("pspak_gas_effect") == nil then
			CreateClientConVar("pspak_gas_effect", "1", true, true)
		end
	end

else
	if GetConVar("pspak_gas_effect") == nil then
		CreateConVar("pspak_gas_effect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
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

//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then

	-- killicon.Add(  "test_rifle",		"vgui/hud/test_rifle", icol  )
	--			weapon name			location of weapon's kill icon, I just used the hud icon

end

//these are some variables we need to keep for stuff to work
//that means don't delete them
if SERVER then

	if GetConVar("M9KWeaponStrip") == nil then
		CreateConVar("M9KWeaponStrip", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	end
	
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
	end
	
	if GetConVar("M9KDisablePenetration") == nil then
		CreateConVar("M9KDisablePenetration", "0", { FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	end
	
end

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

//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then

	-- killicon.Add(  "test_rifle",		"vgui/hud/test_rifle", icol  )
	--			weapon name			location of weapon's kill icon, I just used the hud icon

end

//these are some variables we need to keep for stuff to work
//that means don't delete them
if SERVER then

	if GetConVar("M9KWeaponStrip") == nil then
		CreateConVar("M9KWeaponStrip", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	end
	
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
	end
	
	if GetConVar("M9KDisablePenetration") == nil then
		CreateConVar("M9KDisablePenetration", "0", { FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	end
	
end

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

sound.Add(instbl)

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

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/shotgun_rem870/rem870_insert1.wav",")weapons/shotgun_rem870/rem870_insert2.wav",")weapons/shotgun_rem870/rem870_insert3.wav"}
fastbl["name"] = "Weapof_REM870.Insert"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_draw.wav"
fastbl["name"] = "Weapof_REM870.Draw"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_holster.wav"
fastbl["name"] = "Weapof_REM870.Holster"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_start.wav"
fastbl["name"] = "Weapof_REM870.Start"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump1.wav"
fastbl["name"] = "Weapof_REM870.Pump1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump2.wav"
fastbl["name"] = "Weapof_REM870.Pump2"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/shotgun_rem870/rem870_pump_end.wav"
fastbl["name"] = "Weapof_REM870.Pump_End"

sound.Add(fastbl)

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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
fastbl = {}
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
fastbl = {}
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
fastbl = {}
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

fastbl = {}
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
fastbl = {}
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
fastbl = {}
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
fastbl = {}
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
// *         M16A2		   		   *	
// *                               *
// *********************************
// *********************************

fastbl = {}
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

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m16a2/m16a2_magin.wav"
fastbl["name"] = "Weapof_M16A2.MagIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/ar_m16a2/m16a2_magout.wav"
fastbl["name"] = "Weapof_M16A2.MagOut"

sound.Add(fastbl)

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

fastbl = {}
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

AddCSLuaFile()

//MACHINE GUN GROUP

// *********************************
// *********************************
// *                               *
// *          MC51 VOLLMER         *
// *                               *
// *********************************
// *********************************

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/mg_vollmer/vollmer_fire1.wav","weapons/mg_vollmer/vollmer_fire2.wav","weapons/mg_vollmer/vollmer_fire3.wav","weapons/mg_vollmer/vollmer_fire4.wav","weapons/mg_vollmer/vollmer_fire5.wav"}
fastbl["name"] = "Weapof_Vollmer.Shoot"

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

// *********************************
// *********************************
// *                               *
// *             M249              *
// *                               *
// *********************************
// *********************************

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/mg_m249/m249_fire1.wav","weapons/mg_m249/m249_fire2.wav","weapons/mg_m249/m249_fire3.wav","weapons/mg_m249/m249_fire4.wav","weapons/mg_m249/m249_fire5.wav"}
fastbl["name"] = "Weapof_M249.Shoot"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_fire_empty.wav"
fastbl["name"] = "Weapof_M249.fire_empty"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt1.wav"
fastbl["name"] = "Weapof_M249.Belt1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt2.wav"
fastbl["name"] = "Weapof_M249.Belt2"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt3.wav"
fastbl["name"] = "Weapof_M249.Belt3"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt4.wav"
fastbl["name"] = "Weapof_M249.Belt4"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt5.wav"
fastbl["name"] = "Weapof_M249.Belt5"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "0.3"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_belt6.wav"
fastbl["name"] = "Weapof_M249.Belt6"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_beltload.wav"
fastbl["name"] = "Weapof_M249.BeltLoad"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_beltpull.wav"
fastbl["name"] = "Weapof_M249.Beltpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_beltremove.wav"
fastbl["name"] = "Weapof_M249.Beltremove"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_boxinsert.wav"
fastbl["name"] = "Weapof_M249.Boxinsert"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_boxremove.wav"
fastbl["name"] = "Weapof_M249.Boxremove"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_charge.wav"
fastbl["name"] = "Weapof_M249.Charge"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_bipod.wav"
fastbl["name"] = "Weapof_M249.Bipod"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_lidopen.wav"
fastbl["name"] = "Weapof_M249.Lidopen"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m249/m249_lidclose.wav"
fastbl["name"] = "Weapof_M249.Lidclose"

sound.Add(fastbl)


// *********************************
// *********************************
// *                               *
// *             M60               *
// *                               *
// *********************************
// *********************************

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/mg_m60/m60_fire1.wav","weapons/mg_m60/m60_fire2.wav","weapons/mg_m60/m60_fire3.wav","weapons/mg_m60/m60_fire4.wav","weapons/mg_m60/m60_fire5.wav"}
fastbl["name"] = "Weapof_M60.Shoot"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_fire_empty.wav"
fastbl["name"] = "Weapof_M60.Fire_Empty"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt1.wav"
fastbl["name"] = "Weapof_M60.belt1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt2.wav"
fastbl["name"] = "Weapof_M60.belt2"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt3.wav"
fastbl["name"] = "Weapof_M60.belt3"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt4.wav"
fastbl["name"] = "Weapof_M60.belt4"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt_insert.wav"
fastbl["name"] = "Weapof_M60.belt_insert"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_belt_remove.wav"
fastbl["name"] = "Weapof_M60.belt_remove"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_bipod.wav"
fastbl["name"] = "Weapof_M60.bipod"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_charge.wav"
fastbl["name"] = "Weapof_M60.charge"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_cardboard_insert.wav"
fastbl["name"] = "Weapof_M60.cardboard_insert"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_cardboard_remove.wav"
fastbl["name"] = "Weapof_M60.cardboard_remove"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_cardboard_remove_full.wav"
fastbl["name"] = "Weapof_M60.cardboard_remove_full"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_cardboard_rip1.wav"
fastbl["name"] = "Weapof_M60.cardboard_rip1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_cardboard_rip2.wav"
fastbl["name"] = "Weapof_M60.cardboard_rip2"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_feeding_mechanism.wav"
fastbl["name"] = "Weapof_M60.feeding_mechanism"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_feeding_tray.wav"
fastbl["name"] = "Weapof_M60.feeding_tray"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_flipsights.wav"
fastbl["name"] = "Weapof_M60.flipsights"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_open.wav"
fastbl["name"] = "Weapof_M60.open"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_carryinghandle.wav"
fastbl["name"] = "Weapof_M60.carryinghandle"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_close.wav"
fastbl["name"] = "Weapof_M60.close"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_shoulderrest.wav"
fastbl["name"] = "Weapof_M60.shoulderrest"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_startertab.wav"
fastbl["name"] = "Weapof_M60.startertab"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_velcro_close.wav"
fastbl["name"] = "Weapof_M60.velcro_close"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_velcro_rip1.wav"
fastbl["name"] = "Weapof_M60.velcro_rip1"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/mg_m60/m60_velcro_rip2.wav"
fastbl["name"] = "Weapof_M60.velcro_rip2"

sound.Add(fastbl)


//SNIPER RIFLE GROUP

// *********************************
// *********************************
// *                               *
// *            SR25	           *
// *                               *
// *********************************
// *********************************

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sniper_sr25/sr25_fire1.wav","weapons/sniper_sr25/sr25_fire2.wav","weapons/sniper_sr25/sr25_fire3.wav","weapons/sniper_sr25/sr25_fire4.wav","weapons/sniper_sr25/sr25_fire5.wav"}
fastbl["name"] = "Weapof_SR25.Shoot"

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
fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.27"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sniper_m24/m24_fire1.wav","weapons/sniper_m24/m24_fire2.wav","weapons/sniper_m24/m24_fire3.wav","weapons/sniper_m24/m24_fire4.wav","weapons/sniper_m24/m24_fire5.wav"}
fastbl["name"] = "Weapof_M24.Shoot"

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

// *********************************
// *********************************
// *                               *
// *         M82 Light .50         *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "150"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.15"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/sniper_m82/m82_fire1.wav","weapons/sniper_m82/m82_fire2.wav","weapons/sniper_m82/m82_fire3.wav","weapons/sniper_m82/m82_fire4.wav","weapons/sniper_m82/m82_fire5.wav"}
fastbl["name"] = "Weapof_M82.Shoot"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/accessories/harrisbipod_up1.wav",")weapons/accessories/harrisbipod_up2.wav"}
fastbl["name"] = "Weapof_M82.BipodUp"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {")weapons/accessories/harrisbipod_down1.wav",")weapons/accessories/harrisbipod_down2.wav"}
fastbl["name"] = "Weapof_M82.BipodDown"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m82/m82_magout.wav"
fastbl["name"] = "Weapof_M82.MagOut"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m82/m82_magin.wav"
fastbl["name"] = "Weapof_M82.Magin"

sound.Add(fastbl)

fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/sniper_m82/m82_boltpull.wav"
fastbl["name"] = "Weapof_M82.BoltPull"

sound.Add(fastbl)

//EXPLOSIVES GROUP


// *********************************
// *********************************
// *                               *
// *   M79 40mm Grenade Launcher   *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.4"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/m79_fire1.wav"
fastbl["name"] = "Weapof_M79.Shoot"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.2"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/40mmgren_explode.wav"
fastbl["name"] = "Weapof_M79.Explode"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/m79_open.wav"
fastbl["name"] = "Weapof_M79.Open"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/m79_insert.wav"
fastbl["name"] = "Weapof_M79.ShellIn"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/m79_out.wav"
fastbl["name"] = "Weapof_M79.ShellOut"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m79/m79_latch.wav"
fastbl["name"] = "Weapof_M79.Close"

sound.Add(fastbl)


// *********************************
// *********************************
// *                               *
// *       Smoke Grenade	       *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "SNDLVL_90dB"
fastbl["volume"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m18smoke/sg_explode.wav"
fastbl["name"] = "Weapof_SmokeGrenade.Explode"

sound.Add(fastbl)
// *********************************
// *********************************
// *                               *
// *       Flashbang		   	   *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "140"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.7"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/flashbang/flashbang_explode1.wav"
fastbl["name"] = "Weapof_Flashbang.Explode"

sound.Add(fastbl)

// *********************************
// *********************************
// *                               *
// *             Frag              *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "150"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.2"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/explosive_m67/m67_explode_1.wav","weapons/explosive_m67/m67_explode_2.wav","weapons/explosive_m67/m67_explode_3.wav","weapons/explosive_m67/m67_explode_4.wav","weapons/explosive_m67/m67_explode_5.wav","weapons/explosive_m67/m67_explode_6.wav"}
fastbl["name"] = "BaseGrenadf.Explode"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m67/m67_pinpull.wav"
fastbl["name"] = "Grenadf.Pinpull"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m67/m67_primer.wav"
fastbl["name"] = "Grenadf.Primer"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m67/m67_safety.wav"
fastbl["name"] = "Grenadf.Safety"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m67/m67_spoon1.wav"
fastbl["name"] = "Grenadf.Spoon"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/explosive_m67/m67_hit1.wav","weapons/explosive_m67/m67_hit2.wav","weapons/explosive_m67/m67_hit3.wav"}
fastbl["name"] = "Grenadf.Bounce"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/explosive_m67/m67_impact.wav"
fastbl["name"] = "Grenadf.Hit"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "3"
fastbl["level"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = ")weapons/explosive_m67/m67_combine.wav"
fastbl["name"] = "Default.PullPin.Grenadf"

sound.Add(fastbl)

//HAND WEAPONS GROUP

// *********************************
// *********************************
// *                               *
// *   Knife 					   *
// *                               *
// *********************************
// *********************************
fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.5"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/knife_fas/knife_hit1.wav","weapons/knife_fas/knife_hit2.wav","weapons/knife_fas/knife_hit3.wav","weapons/knife_fas/knife_hit4.wav"}
fastbl["name"] = "Weapof_Knife.Hit"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "0.5"
fastbl["pitch"] = "95,105"
fastbl["sound"] = {"weapons/knife_fas/knife_slash1.wav","weapons/knife_fas/knife_slash2.wav"}
fastbl["name"] = "Weapof_Knife.Slash"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "1"
fastbl["soundlevel"] = "75"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1.0"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/knife_fas/knife_deploy1.wav"
fastbl["name"] = "Weapof_Knife.Deploy"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/knife_fas/knife_hitwall1.wav"
fastbl["name"] = "Weapof_Knife.HitWall"

sound.Add(fastbl)

fastbl = {}
fastbl["channel"] = "1"
fastbl["level"] = "100"
fastbl["volume"] = "1.0"
fastbl["CompatibilityAttenuation"] = "1"
fastbl["pitch"] = "95,105"
fastbl["sound"] = "weapons/knife_fas/knife_stab.wav"
fastbl["name"] = "Weapof_Knife.Stab"

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

sound.Add({
	name = 			"Weapon_Spas.Insertshell",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/spas12/spas12insertshell.wav"	
})

sound.Add({
	name = 			"Weapon_Spas.Pump",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/spas12/spas12pump.wav"	
})

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

--- Grenade Launcher ---

sound.Add({
	name = 			"Weapon_NadeL.Deploy",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/grenadelauncher/grenadelauncherdeploy.wav"	
})

sound.Add({
	name = 			"Weapon_NadeL.Insert",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/grenadelauncher/grenadelauncherinsert.wav"	
})

sound.Add({
	name = 			"Weapon_NadeL.Pump",			
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/grenadelauncher/grenadelauncherpump.wav"	
})

sound.Add({
	name = 			"Weapon_NadeL.Fire",			
	channel = 		CHAN_WEAPON,
	level = 135,
	volume = 		1.0,
	pitch = { 95, 105 },
	sound = 			 ")weapons/grenadelauncher/grenadelauncherfire.wav"	
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

sound.Add(
{
    name = "Weapon_Enfield.BoltRelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_boltrelease.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.BoltLatch",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_boltlatch.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_boltback.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Boltforward",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_boltforward.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_bulletin_1.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_bulletin_2.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_bulletin_3.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Roundin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_bulletin_4.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.Rattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_rattle.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.MagIn",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_MagIn.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.RoundsIn",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_RoundsIn.wav"
})
sound.Add(
{
    name = "Weapon_Enfield.ClipRemove",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/enfield/handling/enfield_clipremove.wav"
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



/*
sound.Add(
{
    name = "ump45.foley",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/cliptap.wav"
})
sound.Add(
{
    name = "ump45.foley",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/magrelease.wav"
})
sound.Add(
{
    name = "ump45.foley",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/hkump/magslap.wav"
})*/

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