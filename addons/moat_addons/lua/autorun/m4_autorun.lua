--this part is for making kill icons
local icol = Color( 255, 255, 255, 255 )
if CLIENT then

	killicon.Add(  "test_rifle",		"vgui/hud/test_rifle", icol  )
	--			weapon name			location of weapon's kill icon, I just used the hud icon

end

--these are some variables we need to keep for stuff to work
--that means don't delete them
if SERVER then

	if GetConVar("M9KWeaponStrip") == nil then
		CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	end

	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
	end

	if GetConVar("M9KDisablePenetration") == nil then
		CreateConVar("M9KDisablePenetration", "1", { FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	end

end

--I always leave a note reminding me which weapon these sounds are for
--weapon name
sound.Add({
    name = "Weapon_CM4.Single",
    channel = CHAN_WEAPON,
    volume = 0.8,
    pitch = {95, 105},
    sound = ")weapons/cod4_m4/fire.wav"
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

