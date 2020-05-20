ENT.Type 			= "anim"

ENT.Base 			= "base_anim"





function ENT:Infect(plyr)

	if (plyr != nil && plyr != NULL && plyr != null && SERVER) then

		if (plyr:IsPlayer() && plyr:IsValid() and plyr:GetRole() ~= ROLE_JESTER) then

				if (!timer.Exists("InfectionTimer"..plyr:GetName().."")) then

					timer.Create("InfectionTimer"..plyr:GetName().."", math.random(InfectConfig.InfectTimeMin, InfectConfig.InfectTimeMax), 1, 

					function()

						if (plyr:Alive()) then

							if (InfectConfig.PZ) then

								local pos = plyr:GetPos()

								plyr:SetRole(ROLE_TRAITOR)

								--plyr:Spawn()

								plyr:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")

								plyr:SetModel("models/player/zombie_classic.mdl")

								--plyr:SetPos(pos)

								timer.Create("GiveWepTimer"..math.random(1,999), 0, 2, 

									function() 

										if (plyr:IsValid()) then 

											plyr:StripWeapons()

											plyr:Give("weapon_zombie")

											plyr:SelectWeapon("weapon_zombie")

										end

									end)

								plyr:SetHealth(InfectConfig.Health)

								CustomMsg(plyr, "YOU ARE NOW A ZOMBIE!!", Color(255, 0, 0))

								SendFullStateUpdate()

								plyr:SetModel("models/player/zombie_classic.mdl")

							else

								local ent = ents.Create("npc_infectiouszombie")

								ent:SetPos(plyr:GetPos())

								ent:Spawn()

								ent:Activate()

								plyr:SetPos(plyr:GetPos()+ Vector(0,0,15))

								plyr:Kill()

							end

						end

						--player:takeDamage(

					end)

					

				if (InfectConfig.InfectMessage) then CustomMsg(plyr, "YOU HAVE BEEN INFECTED!!", Color(255, 0, 0))  end

			end

			if (InfectConfig.ScreenTick) then

				if (!timer.Exists("ShakeTimer"..plyr:GetName().."")) then

					timer.Create("ShakeTimer"..plyr:GetName().."", InfectConfig.ScreenTickFreq, 0,

					function()

						plyr:ViewPunch(Angle(math.random(-1,1),math.random(-1,1),math.random(-1,1)))

					end)

				end

			end

		end

	end

end











function StopTimers(player)

	if (timer.Exists("InfectionTimer"..player:GetName().."")) then

		timer.Destroy("InfectionTimer"..player:GetName().."")

	end

	

	if (timer.Exists("ShakeTimer"..player:GetName().."")) then

		timer.Destroy("ShakeTimer"..player:GetName().."")

	end

end

hook.Add("PlayerSpawn", "Stop Timers", StopTimers)



















