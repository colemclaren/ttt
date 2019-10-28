COMMAND.Name = "VoiceBattery"
COMMAND.Flag = "m"

local vbatenabled = false

COMMAND.Run = function(pl, args, supp)
	vbatenabled = not vbatenabled
	RunConsoleCommand("ttt_voice_drain_normal", 0.35)
	RunConsoleCommand("ttt_voice_drain_admin", 0.05)
	RunConsoleCommand("ttt_voice_drain_recharge", 0.05)


	RunConsoleCommand("ttt_voice_drain", (vbatenabled and 1) or 0)

	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has ", moat_green, ((vbatenabled and "enabled") or "disabled"), moat_white, " the ", moat_green, "voice battery", moat_white, ". Changes will take effect next round.")
	

	D3A.Commands.Discord((vbatenabled and "voicebattery") or "novoicebattery", D3A.Commands.NameID(pl))
end