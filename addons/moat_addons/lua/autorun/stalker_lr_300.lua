//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then

	killicon.Add(  "test_rifle",		"vgui/hud/test_rifle", icol  )
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
