ENT.Type 			= "anim"

ENT.Base 			= "base_anim"





function ENT:Cure(plyr)

	if (plyr != nil && plyr != NULL && plyr != null) then

	

		if (plyr:IsPlayer()) then

			if (timer.Exists("InfectionTimer"..plyr:GetName().."")) then

				timer.Destroy("InfectionTimer"..plyr:GetName().."")

				CustomMsg(plyr, "YOU HAVE BEEN CURED AND FORGET WHO THE TRAITORS ARE!!", Color(0, 255, 0))

			end

			

			if (timer.Exists("ShakeTimer"..plyr:GetName().."")) then

				timer.Destroy("ShakeTimer"..plyr:GetName().."")

			end

			

			if (InfectConfig.PZ && plyr:GetActiveWeapon():IsValid() && plyr:GetActiveWeapon():GetClass() == "weapon_zombie") then

				local pos = plyr:GetPos()

				plyr:SetRole(ROLE_INNOCENT)

				plyr:Spawn()

				plyr:StripAll()

				plyr:Give("weapon_crowbar")

				--plyr:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")

				--plyr:SetModel("models/player/zombie_classic.mdl")

				plyr:SetPos(pos)

				plyr:SelectWeapon("weapon_crowbar")

				plyr:SetHealth(100)

				CustomMsg(plyr, "YOU ARE NOW A HUMAN AND FORGET WHO THE TRAITORS ARE!!", Color(0, 255, 0))

				SendFullStateUpdate()

			end

		end

		

	end

end









