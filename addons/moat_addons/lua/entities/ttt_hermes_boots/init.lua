AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

CreateConVar("ttt_hermesboots_detective_loadout", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "Should Detectives have the Hermes Boots in their loadout?")
CreateConVar("ttt_hermesboots_traitor_loadout", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "Should Traitors have the Hermes Boots in their loadout?")
local speed = CreateConVar("ttt_hermesboots_speed", 1.3, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "The speed multiplier for the Hermes Boots.")

include('shared.lua')