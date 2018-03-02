if(CLIENT) then

net.Receive( "ClientDeathNotify", function()
			//Colours for customizing
			local TraitorColor = Color(255,0,0)
			local InnoColor = Color(0,255,0)
			local DetectiveColor = Color(0,0,255)
			
			local NameColor = Color(236,240,241)
			local UnknownColor = Color(152,48,196)
			
			local White = Color(236,240,241)
			//Read the variables from the message
			local name = net.ReadString()
			local role =  tonumber(net.ReadString())
			local reason = net.ReadString()
			//Format the number role into a human readable role
			if role == ROLE_INNOCENT then
				col = InnoColor
				role = "Innocent"
			elseif role == ROLE_TRAITOR then
				col = TraitorColor
				role = "Traitor"
			elseif role == ROLE_DETECTIVE then
				col = DetectiveColor
				role = "Detective"
			else
				//He wasn't anything yet e.g pre-round
				col = InnoColor
				role = "Innocent"
			end
			//Format the reason for their death
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
end )  
end

if(SERVER) then
//Precache the net message
util.AddNetworkString( "ClientDeathNotify" )

hook.Add("PlayerDeath", "Kill_Reveal_Notify", function( victim, entity, killer )
		if gmod.GetGamemode().Name == "Trouble in Terrorist Town" then
	local reason = 0
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
		
	elseif( killer == victim ) then 
		reason = "suicide"
		killerz = "nil"
		role = "nil"
		
	elseif killer:IsPlayer() && victim != killer then
		reason = "ply"
		killerz = killer:Nick() 
		role = killer:GetRole()
	
	else
		reason = "nil"
		killerz = "nil"
		role = "nil"
	end
	
	//Send the buffer message with the death information to the victim
	net.Start("ClientDeathNotify")
		net.WriteString(killerz)
		net.WriteString(role)
		net.WriteString(reason)
	net.Send(victim)
			end
		end )
	end