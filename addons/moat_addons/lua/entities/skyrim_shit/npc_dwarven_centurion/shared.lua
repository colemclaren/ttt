ENT.Base = "npc_creature_base"
ENT.Type = "ai"

ENT.PrintName = "Dwarven Centurion"
ENT.Category = "Skyrim"
//ENT.NPCID = ""

game.AddParticles("particles/centurion_steam.pcf")
PrecacheParticleSystem("centurion_steam_arm")
PrecacheParticleSystem("centurion_steam_head")
PrecacheParticleSystem("centurion_steam_shout")

if(CLIENT) then
	language.Add("npc_dwarven_centurion","Dwarven Centurion")
end

