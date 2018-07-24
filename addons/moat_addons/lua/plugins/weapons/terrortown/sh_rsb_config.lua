RSB = {}

-- Config --This is just for the tracker
CreateConVar("RSB_ChargeTimer", "15", FCVAR_SERVER_CAN_EXECUTE, "This is the charge timer for the RSB(number, def: 15)")
CreateConVar("RSB_EnableDefuser", "true", FCVAR_SERVER_CAN_EXECUTE, "Do you want to enable the defuser for the RSB? (true/false, def: true)")
CreateConVar("RSB_BlastRadius", "500", FCVAR_SERVER_CAN_EXECUTE, "This is the blast radius for the RSB detonation(number, def: 500)")
CreateConVar("RSB_BlastDamage", "200", FCVAR_SERVER_CAN_EXECUTE, "Damage dealt to players close to the explosion centre the RSB detonation(number, def: 200)")
CreateConVar("RSB_EnableCam", "true", FCVAR_SERVER_CAN_EXECUTE, "Enable the display of your targets camera when fully charged (true/false, def: true)")