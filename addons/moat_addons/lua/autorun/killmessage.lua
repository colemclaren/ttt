if (CLIENT) then
	local bg_colors = {
		background_main = Color(0, 0, 10, 200),

		noround = Color(100,100,100,200)
	};

	net.Receive( "ClientDeathNotify", function()
		local NameColor = Color(236,240,241)

		local White = Color(236,240,241)

		local name = net.ReadString()
		local role =  tonumber(net.ReadString())
		local reason = net.ReadString()

		local col = GetRoleColor(role) or bg_colors.noround
		role = LANG.GetRawTranslation(GetRoleStringRaw(role))

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