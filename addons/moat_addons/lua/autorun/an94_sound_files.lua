sound.Add({
    name = "BO2_PEACE_FIRE",
    channel = CHAN_WEAPON,
    volume = 1.0,
    pitch = {95, 105},
    sound = ")weapons/peacekeeper/fire.wav"
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