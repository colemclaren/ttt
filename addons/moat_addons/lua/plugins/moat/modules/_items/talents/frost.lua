TALENT.ID = 10
TALENT.Name = "Frost"
TALENT.NameColor = Color( 100, 100, 255 )
TALENT.NameEffect = "frost"
TALENT.Description = "Each hit has a %s_^ chance to freeze the target for %s seconds, slowing their speed by ^%s_ percent, and applying 2 damage every ^%s seconds"
TALENT.Tier = 3
TALENT.LevelRequired = { min = 25, max = 30 }
TALENT.Modifications = {}
TALENT.Modifications[1] = { min = 5, max = 10 } // Chance to freeze
TALENT.Modifications[2] = { min = 15, max = 30 } // Freeze time
TALENT.Modifications[3] = { min = 25, max = 50 } // Frozen Speed time
TALENT.Modifications[4] = { min = 5, max = 8 } // Frozen Damage Delay
TALENT.Melee = true
TALENT.NotUnique = true

function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or victim:HasGodMode()) then return end
	local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])

	if (chanceNum > math.random() * 100) then
		status.Inflict("Frost", {
			Player = victim,
			Time = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2]),
			Speed = (self.Modifications[3].min + ((self.Modifications[3].max - self.Modifications[3].min) * talent_mods[3])) / 100,
			DamageDelay = self.Modifications[4].min + ((self.Modifications[4].max - self.Modifications[4].min) * talent_mods[4]),
			Weapon = attacker:GetActiveWeapon(),
			Attacker = attacker,
			Percent = 1 + ((self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])) / 100)
		})
	end
end

local STATUS = status.Create "Frost"
function STATUS:Invoke(data)
	self:CreateEffect "Frozen":Invoke(data, data.Time, data.Player)
	self:CreateEffect "Freezing":Invoke(data, data.Time, data.Player)
end

local EFFECT = STATUS:CreateEffect "Frozen"
EFFECT.Message = "Freezing"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/weather_snow.png"
function EFFECT:Init(data)
	local amt = math.floor(data.Time / data.DamageDelay) * data.DamageDelay
	self.Timer = self:CreateTimer(amt, amt / data.DamageDelay, self.Callback, data)
end

function EFFECT:Callback(data)
	local vic = data.Player
	if (not IsValid(vic)) then return end
	if (vic:Team() == TEAM_SPEC) then return end
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local dmg = DamageInfo()
	dmg:SetInflictor(data.Weapon)
	dmg:SetAttacker(data.Attacker)
	dmg:SetDamage(2)
	dmg:SetDamageType(DMG_DIRECT)

	vic:TakeDamageInfo(dmg)
end


local EFFECT = STATUS:CreateEffect "Freezing"
EFFECT.Message = "Frozen"
EFFECT.Color = TALENT.NameColor
EFFECT.Material = "icon16/weather_snow.png"
function EFFECT:Init(data)
	local ply = data.Player

	ply.moatFrozen = true
	ply.moatFrozenSpeed = data.Speed
	ply:SetNWBool("moatFrozen", true)
	self.Timer = self:CreateTimer(data.Time, 1, self.Callback, data)
end

function EFFECT:Callback(data)
	local ply = data.Player
	ply.moatFrozen = false
	ply.moatFrozenSpeed = 1
	ply:SetNWBool("moatFrozen", false)
end