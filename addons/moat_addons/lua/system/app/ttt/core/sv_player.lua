local DeathSounds = {
	Sound "player/death1.wav",
	Sound "player/death2.wav",
	Sound "player/death3.wav",
	Sound "player/death4.wav",
	Sound "player/death5.wav",
	Sound "player/death6.wav",
	Sound "vo/npc/male01/pain07.wav",
	Sound "vo/npc/male01/pain08.wav",
	Sound "vo/npc/male01/pain09.wav",
	Sound "vo/npc/male01/pain04.wav",
	Sound "vo/npc/Barney/ba_pain06.wav",
	Sound "vo/npc/Barney/ba_pain07.wav",
	Sound "vo/npc/Barney/ba_pain09.wav",
	Sound "vo/npc/Barney/ba_ohshit03.wav",
	Sound "vo/npc/Barney/ba_no01.wav",
	Sound "vo/npc/male01/no02.wav",
	Sound "hostage/hpain/hpain1.wav",
	Sound "hostage/hpain/hpain2.wav",
	Sound "hostage/hpain/hpain3.wav",
	Sound "hostage/hpain/hpain4.wav",
	Sound "hostage/hpain/hpain5.wav",
	Sound "hostage/hpain/hpain6.wav"
}

DeathSounds.Count = #DeathSounds
function ttt.PlayDeathSound(victim)
    if (not IsValid(victim)) then
		return
	end

    sound.Play(DeathSounds[math.random(1, DeathSounds.Count)], victim:GetShootPos(), 90, 100)
end