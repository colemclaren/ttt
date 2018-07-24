-- and god said
-- let there be light \o/
if (moat) then return end
moat = moat or {}

include "assets/print.lua"
include "assets/loaders.lua"

moat.includesh "system/constants/_servers.lua"
moat.includesh "autorun/dev_env/init.lua"

moat.cfg = moat.cfg or {}
moat.includesv "system/config/server.lua"
moat.includecl "system/config/client.lua"
moat.includesh "system/config/shared.lua"

moat.includesv "autorun/dev_env/realms/server.lua"
moat.includecl "autorun/dev_env/realms/client.lua"
moat.includesh "autorun/dev_env/realms/shared.lua"

moat.includepath "system/constants/"
moat.includepath "system/libs/"
moat.includepath "system/core/"

moat.includepath "plugins"

if (SERVER and SERVER_ISDEV) then
	util.AddNetworkString "moat.init.dev"

	function moat.initdevcl(pl)
		net.Start "moat.init.dev"
			net.WriteUInt(moat.devfiles.count, 32)
			for i = 1, moat.devfiles.count do
				net.WriteString(moat.devfiles[i])
			end
		net.Send(pl)
	end

	net.Receive("moat.init.dev", function(_, pl)
		if (not SERVER_ISDEV) then return end
		moat.initdevcl(pl)
	end)

	hook.Add("PlayerAuthed", "moat.init.dev", function(pl)
		moat.initdevcl(pl)
	end)
else
	net.Receive("moat.init.dev", function()
		SERVER_ISDEV = true

		for i = 1, net.ReadUInt(32) do
			moat.includecl(net.ReadString())
		end
	end)
end