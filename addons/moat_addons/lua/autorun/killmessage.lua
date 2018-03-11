if (CLIENT) then

	local GetRTranslation = CLIENT and LANG.GetRawTranslation or util.passthrough

	net.Receive( "ClientDeathNotify", function()
		local bg_colors = {
			background_main = Color(0, 0, 10, 200),

			noround = Color(100,100,100,200),
			[ROLE_TRAITOR]  = Color(200, 25, 25, 200),
			[ROLE_INNOCENT] = Color(25, 200, 25, 200),
			[ROLE_DETECTIVE] = Color(25, 25, 200, 200),

			[ROLE_JESTER or -2]    = Color(253, 158, 255, 200),
			[ROLE_KILLER or -2]    = Color(255, 145, 0, 200),
			[ROLE_DOCTOR or -2]    = Color(0, 200, 255, 200),
			[ROLE_BEACON or -2]    = Color(255, 200, 0, 200),
			[ROLE_SURVIVOR or -2]  = Color(128, 142, 0, 200),
			[ROLE_HITMAN or -2]    = Color(40, 42, 47, 200),
			[ROLE_BODYGUARD or -2] = Color(0, 153, 153, 200),
			[ROLE_VETERAN or -2]   = Color(179, 0, 255, 200),
			[ROLE_XENOMORPH or -2] = Color(0, 249, 199, 200)
		};
		local NameColor = Color(236,240,241)

		local White = Color(236,240,241)

		local name = net.ReadString()
		local role =  tonumber(net.ReadString())
		local reason = net.ReadString()

		local col = bg_colors[role]
		role = GetRTranslation(GetRoleStringRaw(role))

		if reason == "suicide" then
			chat.AddText( NameColor, "You ", White, "killed ", NameColor, "Yourself!")
		elseif reason == "burned" then
			chat.AddText( NameColor, "You", White," burned to death!")
		elseif reason == "prop" then
			chat.AddText( NameColor, "You", White, " were killed by a prop!")
		elseif reason == "ply" then
			chat.AddText( NameColor, "You", White," were killed by ",col,name,White,", he was a ",col,role,White,"!")
		elseif reason == "fell" then
			chat.AddText( NameColor, "You", White," fell to your death!")
		elseif reason == "water" then
			chat.AddText( NameColor, "You", White," drowned!")
		else
			chat.AddText( White, "It was ", NameColor, "unknown ", White, "how you were killed!")
		end
	end) 
end

if (SERVER) then
	util.AddNetworkString( "ClientDeathNotify" )

	hook.Add("PlayerDeath", "Kill_Reveal_Notify", function( victim, entity, killer )
		if gmod.GetGamemode().Name == "Trouble in Terrorist Town" then
			local reason = "nil"
			local killerz = "nil"
			local role = "nil"

			if (not entity:IsValid()) then
				reason = "prop"
				killerz = "nil"
				role = "nil"

			elseif entity:GetClass() == "entityflame" and killer:GetClass() == "entityflame" then
				reason = "burned"
				killerz = "nil"
				role = "nil"

			elseif victim.DiedByWater then
				reason = "water"
				killerz = "nil"
				role = "nil"

			elseif entity:GetClass() == "worldspawn" and killer:GetClass() == "worldspawn" then
				reason = "fell"
				killerz = "nil"
				role = "nil"

			elseif victim:IsPlayer() and entity:GetClass() == 'prop_physics' or entity:GetClass() == "prop_dynamic" or entity:GetClass() == 'prop_physics' then -- If the killer is also a prop
					reason = "prop"
					killerz = "nil"
					role = "nil"

			elseif (killer == victim) then
				reason = "suicide"
				killerz = "nil"
				role = "nil"

			elseif killer:IsPlayer() and victim ~= killer then
				reason = "ply"
				killerz = killer:Nick() 
				role = killer:GetRole()

			else
				reason = "nil"
				killerz = "nil"
				role = "nil"
			end

			net.Start("ClientDeathNotify")
				net.WriteString(killerz)
				net.WriteString(role)
				net.WriteString(reason)
			net.Send(victim)
		end
	end )
end