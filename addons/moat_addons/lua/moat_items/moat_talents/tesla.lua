
TALENT.ID = 9

TALENT.Name = "Tesla"

TALENT.NameColor = Color( 0, 255, 255 )

TALENT.NameEffect = "electric"

TALENT.Description = "Each hit has a %s_^ chance to zap the target %s^ times for %s^ damage every %s^ seconds"

TALENT.Tier = 3

TALENT.LevelRequired = { min = 25, max = 30 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 } // Chance to tesla
TALENT.Modifications[2] = { min = 5, max = 10 } // tesla reps
TALENT.Modifications[3] = { min = 3, max = 5 } // tesla damage
TALENT.Modifications[4] = { min = 3, max = 6 } // tesla delay

TALENT.Melee = true

TALENT.NotUnique = true

function TALENT:OnPlayerHit( victim, attacker, dmginfo, talent_mods )

	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end

	local chance = self.Modifications[1].min + ( ( self.Modifications[1].max - self.Modifications[1].min ) * talent_mods[1] )

	local random_num = math.Rand( 1, 100 )

	local apply_mod = chance > random_num

	if ( apply_mod ) then

		local tesla_reps = self.Modifications[2].min + ( ( self.Modifications[2].max - self.Modifications[2].min ) * talent_mods[2] )
		local tesla_dmg = self.Modifications[3].min + ( ( self.Modifications[3].max - self.Modifications[3].min ) * talent_mods[3] )
		local tesla_delay = self.Modifications[4].min + ( ( self.Modifications[4].max - self.Modifications[4].min ) * talent_mods[4] )

		victim:ApplyDOT( "tesla", tesla_dmg, attacker, tesla_delay, tesla_reps, function(vic, att)

			local effectdata = EffectData()
			effectdata:SetEntity(vic)
			effectdata:SetRadius(10)
			effectdata:SetMagnitude(10)
			effectdata:SetScale(3)
			util.Effect("TeslaHitBoxes", effectdata)
			local n = math.random(11)
			vic:EmitSound("ambient/energy/newspark"..(n<10 and "0" or "")..n..".wav")

			vic:SendLua("util.ScreenShake(Vector(0, 0, 0), 50, 100, 0.5, 100)")

		end, function(vic, att)
			vic:SendLua([[chat.AddText(Material("icon16/lightning.png"),Color(255,0,0),"The spark has touched you! Prepare for its wrath!")]])

			net.Start("moat.dot.init")
			net.WriteString("Electrified")
			net.WriteUInt(tesla_delay * tesla_reps, 16)
			net.WriteString("icon16/lightning.png")
			net.WriteColor(Color(0, 255, 255))
			net.WriteString(tostring("tesla" .. vic:EntIndex() .. att:EntIndex()))
			net.Send(vic)
		end, function(vic, att)
			vic:SendLua([[chat.AddText(Material("icon16/lightning.png"),Color(255,255,0),"You feel better now.")]])
		end)

	end

end