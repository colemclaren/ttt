
TALENT.ID = 35
TALENT.Name = "Backstab"
TALENT.NameColor = Color(255, 128, 0)
TALENT.Description = "Damage is increased by %s_ when attacking someone from behind"
TALENT.Tier = 2
TALENT.LevelRequired = { min = 15, max = 20 }

TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 15, max = 30 } -- Amount headshot is increased

TALENT.Melee = true
TALENT.MeleeOnly = true
TALENT.NotUnique = true

-- Ported from https://gist.github.com/sigsegv-mvm/bda5c53af428878af6889635cd787332
local function IsBehindAndFacingTarget(vic, att)
	if (not IsValid(vic) or not IsValid(att)) then return false end

	local wsc_att_to_vic = vic:WorldSpaceCenter() - att:WorldSpaceCenter()
	wsc_att_to_vic.y = 0
	wsc_att_to_vic:Normalize()

	local eye_att = att:GetAimVector()
	eye_att.y = 0
	eye_att:Normalize()

	local eye_vic = vic:GetAimVector()
	eye_vic.y = 0
	eye_vic:Normalize()

	if (wsc_att_to_vic	:Dot(eye_vic) <=  0.0) then return false end
	if (wsc_att_to_vic	:Dot(eye_att) <=  0.5) then return false end
	if (eye_att			:Dot(eye_vic) <= -0.3) then return false end

	return true
end

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (IsBehindAndFacingTarget(victim, attacker)) then
		local increase = 1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])) / 100)
		dmginfo:ScaleDamage(increase)
	end
end

