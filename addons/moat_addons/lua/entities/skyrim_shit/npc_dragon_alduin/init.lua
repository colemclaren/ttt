AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DRAGON,"npc_dragon_alduin")

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAGON","npc_dragon_alduin")
ENT.NPCFaction = NPC_FACTION_DRAGON
ENT.sModel = "models/skyrim/dragonalduin.mdl"
ENT.skName = "alduin"
ENT.m_shouts = bit.bor(1,2,4,8,16,32,64)
ENT.ScaleExp = 12
ENT.ScaleLootChance = 0.01
local tbShouts = {
	["Shout1a"] = "shouts/dragonshout_alduin01_a_fus.mp3",
	["Shout1b"] = "shouts/dragonshout_alduin01_b_rodah.mp3",
	["Shout2a"] = "shouts/dragonshout_alduin02_a_faas.mp3",
	["Shout2b"] = "shouts/dragonshout_alduin02_b_rumaar.mp3",
	["Shout4a"] = "shouts/dragonshout_alduin03_a_iiz.mp3",
	["Shout4b"] = "shouts/dragonshout_alduin03_b_slennus.mp3",
	["Shout8a"] = "shouts/dragonshout_alduin04_a_zun.mp3",
	["Shout8b"] = "shouts/dragonshout_alduin04_b_haalvik.mp3",
	["Shout16a"] = "shouts/dragonshout_alduin05_a_yol.mp3",
	["Shout16b"] = "shouts/dragonshout_alduin05_b_torshul.mp3"
}
function ENT:SelectDeathActivity() return ACT_DIEVIOLENT end
function ENT:SubInit()
	table.Merge(self.m_tbSounds,tbShouts)
end
--function ENT:GetSoundEvents()
--	return self.m_tbSounds
--end