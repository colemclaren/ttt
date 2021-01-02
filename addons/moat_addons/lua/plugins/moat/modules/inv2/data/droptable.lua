ITEM = {}
ITEM.ID = 203
ITEM.Name = "Baseball Bat"
ITEM.WeaponClass = "weapon_ttt_baseballbat"
ITEM.NameColor = Color(255, 204, 153)
ITEM.Rarity = 2
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -10},
	Damage = {min = 4, max = 13},
	Firerate = {min = 8, max = 12},
	Pushrate = {min = -20, max = -30},
	Force = {min = 40, max = 60}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 207
ITEM.Name = "A Baton"
ITEM.Image = "https://static.moat.gg/f/ff9f07c2181f584aefc6f8312a27e417.png" 
ITEM.WeaponClass = "weapon_ttt_baton"
ITEM.NameColor = Color(0, 76, 153, 255)
ITEM.Rarity = 4
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -15, max = -25},
	Damage = {min = 5, max = 10},
	Firerate = {min = 30, max = 60},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 20}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 2007
ITEM.Name = "American Baton"
ITEM.Image = "https://static.moat.gg/f/ff9f07c2181f584aefc6f8312a27e417.png" 
ITEM.WeaponClass = "weapon_ttt_baton"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -15, max = -25},
	Damage = {min = 5, max = 20},
	Firerate = {min = 30, max = 60},
	Pushrate = {min = 50, max = 100},
	Force = {min = 13, max = 20}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 7004
ITEM.Name = "A Candy Cane"
ITEM.WeaponClass = "weapon_ttt_candycane"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -15, max = -30},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 205
ITEM.Name = "Cardboard Knife"
ITEM.WeaponClass = "weapon_ttt_cardboardknife"
ITEM.NameColor = Color(50, 50, 200)
ITEM.Rarity = 5
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -10, max = -20},
	Damage = {min = 5, max = 10},
	Firerate = {min = 30, max = 60},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 20}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 208
ITEM.Name = "A Chair"
ITEM.Image = "https://static.moat.gg/f/ec565c8080853a8074da82047026fdbb.png" 
ITEM.WeaponClass = "weapon_ttt_chair"
ITEM.NameColor = Color(255, 255, 0)
ITEM.Rarity = 2
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -10},
	Damage = {min = 30, max = 50},
	Firerate = {min = -20, max = -50},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 17699
ITEM.Name = "Deep Frying Ban"
ITEM.WeaponClass = "weapon_ttt_fryingpan"
ITEM.Rarity = 4
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Stats = {
	Weight = {min = -30, max = 30},
	Damage = {min = -95, max = -95},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.Talents = {"Deep Fried XL", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.NotDroppable = true
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 728
ITEM.Name = "A Diamond Pickaxe"
ITEM.WeaponClass = "weapon_diamond_pick"
ITEM.NameColor = Color(0, 255, 255)
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -15, max = -30},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 729
ITEM.Name = "A Fish"
ITEM.WeaponClass = "weapon_fish"
ITEM.NameColor = Color(255,160,122)
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 730
ITEM.Name = "Fists"
ITEM.WeaponClass = "weapon_ttt_fists"
ITEM.Rarity = 3
ITEM.Image = "https://static.moat.gg/f/96f183e138d991a720cdebb89f1fd137.png"
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -10, max = -20},
	Damage = {min = 10, max = 25},
	Firerate = {min = 20, max = 50},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 209
ITEM.Name = "Frying Pan"
ITEM.WeaponClass = "weapon_ttt_fryingpan"
ITEM.NameColor = Color(160, 160, 160)
ITEM.Rarity = 1
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -10},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 731
ITEM.Name = "A Katana"
ITEM.WeaponClass = "weapon_katana"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -20, max = -30},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 210
ITEM.Name = "A Keyboard"
ITEM.WeaponClass = "weapon_ttt_keyboard"
ITEM.NameColor = Color(127, 0, 255)
ITEM.Rarity = 2
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 10, max = 25},
	Firerate = {min = 20, max = 40},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 20}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 732
ITEM.Name = "A Lightsaber"
ITEM.WeaponClass = "weapon_light_saber"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	
	Weight = {min = -20, max = -35},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 733
ITEM.Name = "A Diamond Sword"
ITEM.WeaponClass = "weapon_diamond_sword"
ITEM.NameColor = Color(0, 255, 255)
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -20, max = -30},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 206
ITEM.Name = "Meat Cleaver"
ITEM.WeaponClass = "weapon_ttt_meatcleaver"
ITEM.NameColor = Color(51, 0, 0)
ITEM.Rarity = 3
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 10, max = 20},
	Firerate = {min = 20, max = 40},
	Pushrate = {min = 5, max = 10},
	Force = {min = 5, max = 10}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 160
ITEM.Name = "Pipe Wrench"
ITEM.WeaponClass = "weapon_ttt_pipewrench"
ITEM.NameColor = Color(153, 0, 0)
ITEM.Rarity = 3
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 5, max = 10},
	Firerate = {min = 15, max = 25},
	Pushrate = {min = 5, max = 10},
	Force = {min = 15, max = 40}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 204
ITEM.Name = "A Pot"
ITEM.WeaponClass = "weapon_ttt_rollingpin"
ITEM.NameColor = Color(255, 128, 0)
ITEM.Rarity = 2
ITEM.Collection = "Melee Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -10},
	Damage = {min = 5, max = 10},
	Firerate = {min = 15, max = 25},
	Pushrate = {min = 5, max = 10},
	Force = {min = 15, max = 40}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 802
ITEM.Name = "A Smart Pen"
ITEM.WeaponClass = "weapon_smartpen"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -20, max = -30},
	Damage = {min = 15, max = 35},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 801
ITEM.Name = "A Sword"
ITEM.WeaponClass = "weapon_pvpsword"
ITEM.NameColor = Color(70,130,180)
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -20},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 734
ITEM.Name = "A Tomahawk"
ITEM.WeaponClass = "weapon_tomahawk"
ITEM.NameColor = Color	(47,79,79)
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 735
ITEM.Name = "A Toy Hammer"
ITEM.WeaponClass = "weapon_toy_hammer"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 5
ITEM.MinStats = 5
ITEM.Stats = {
	Weight = {min = -5, max = -15},
	Damage = {min = 10, max = 25},
	Firerate = {min = 10, max = 30},
	Pushrate = {min = 5, max = 10},
	Force = {min = 13, max = 35}
}
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')
ITEM.Collection = 'Melee Collection'
ITEM.ID = ITEM.ID + 10000
ITEM.MinTalents = 0
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Melee')

ITEM = {}
ITEM.ID = 23
ITEM.Name = "Ammo Hoarder"
ITEM.NameColor = Color(255, 102, 0)
ITEM.Description = "Begin the round with +%s_ more ammo in your reserves"
ITEM.Image = "https://static.moat.gg/f/62a7db51574ae4a341e61c4174866816.png" 
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Stats = {
	{ min = 45, max = 125}
}
function ITEM:OnBeginRound(ply, powerup_mods)
	timer.Simple(3, function()
		if (not IsValid(ply)) then return end
		for k, v in ipairs(ply:GetWeapons()) do
			local ammo_type, max_clip = v:GetPrimaryAmmoType(), v:GetMaxClip1()
			local ammo_to_give = math.Clamp(((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100) * (max_clip * 2), 0, max_clip * 2)
			ply:GiveAmmo(ammo_to_give, ammo_type)
		end
	end)
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 24
ITEM.Name = "Cat Sense"
ITEM.NameColor = Color(139, 0, 166)
ITEM.Description = "Fall damage is reduced by %s_ when using this power-up"
ITEM.Image = "https://static.moat.gg/f/e62954919e052ed558d6b2e451badd24.png" 
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Stats = {
	{ min = -35, max = -75}
}
function ITEM:OnDamageTaken(ply, dmginfo, powerup_mods)
	if (dmginfo:IsFallDamage()) then
		local damage_scale = 1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100)
		dmginfo:ScaleDamage(damage_scale)
	end
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 600
ITEM.Name = "Credit Hoarder"
ITEM.NameColor = Color(255, 255, 0)
ITEM.Description = "Start with %s extra credits as a detective/traitor when using this power-up"
ITEM.Image = "https://static.moat.gg/f/78738ccf67e834f86317059b2dd06caf.png"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Stats = {
	{ min = 1, max = 5}
}
function ITEM:OnBeginRound(ply, powerup_mods)
	timer.Simple(2, function()
		if (not IsValid(ply)) then return end
		if (ply:GetRole() and ply:GetRole() == ROLE_TRAITOR or ply:GetRole() == ROLE_DETECTIVE) then
			local new_credits = GetConVarNumber("ttt_credits_starting") + math.Round(self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1])))
			ply:SetCredits(new_credits)
		end
	end)
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 601
ITEM.Name = "Flame Retardant"
ITEM.NameColor = Color(255, 60, 0)
ITEM.Description = "Fire and explosion damage is reduced by %s_ when using this power-up"
ITEM.Image = "https://static.moat.gg/f/7d05b151a4f6536508979e4edc065afd.png" 
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.Stats = {
	{min = -35, max = -75}
}
local dmg_prot = {
	[DMG_BURN] = true,
	[DMG_BLAST] = true
}
function ITEM:OnDamageTaken(ply, dmginfo, powerup_mods)
	if (dmg_prot[dmginfo:GetDamageType()]) then
		local damage_scale = 1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100)
		dmginfo:ScaleDamage(damage_scale)
	end
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 11
ITEM.Name = "Froghopper"
ITEM.NameEffect = "bounce"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Description = "Froghoppers can jump 70 times their body height. Too bad this only allows you to jump +%s_ higher"
ITEM.Image = "https://static.moat.gg/f/efbb38256abb921e7cc3425819f80949.png" 
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Stats = {
	{ min = 1, max = 10}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	local new_jump_power = ply.JumpHeight * (1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100))
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
	ply:SetJumpPower(new_jump_power)
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 602
ITEM.Name = "Hard Hat"
ITEM.NameColor = Color(0, 255, 255)
ITEM.Description = "Headshot damage is reduced by %s_ when using this power-up"
ITEM.Image = "https://static.moat.gg/f/ddaebffd6d2f4cdf354479e029426159.png" 
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.Stats = {
	{min = -15, max = -38}
}
function ITEM:ScalePlayerDamage(ply, hitgroup, dmginfo, powerup_mods)
	if (hitgroup == HITGROUP_HEAD) then
		local decrease = 1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100)
		dmginfo:ScaleDamage(decrease)
	end
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 25
ITEM.Name = "Health Bloom"
ITEM.NameColor = Color(0, 204, 0)
ITEM.Description = "Health is increased by +%s when using this power-up"
ITEM.Image = "https://moat.gg/assets/img/smithhealicon.png" 
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Stats = {
	{ min = 5, max = 25}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	local new_health = ply.MaxHealth + self.Stats[1].min + (self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1])
	ply:SetMaxHealth(new_health)
	ply:SetHealth(new_health)
	ply.MaxHealth = new_health
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 26
ITEM.Name = "Marathon Runner"
ITEM.NameColor = Color(85, 85, 255)
ITEM.Description = "Movement speed is increased by +%s_ when using this power-up"
ITEM.Image = "https://static.moat.gg/f/3860e90ff93a1fb663421ddf92fbbffa.png" 
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.Stats = {
	{ min = 5, max = 15}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	/*local new_speed = ply.MaxSpeed * (1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100))
	ply:SetMaxSpeed(new_speed)
	ply:SetWalkSpeed(new_speed)
	ply:SetRunSpeed(new_speed)
	ply.MaxSpeed = new_speed*/
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 604
ITEM.Name = "Experience Lover"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Description = "Gain %s_ more weapon XP after a rightfull kill when using this power-up"
ITEM.Image = "https://static.moat.gg/f/1114672223ae94d7d0ea360abf9924e0.png" 
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Stats = {
	{ min = 25, max = 75}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	local xp_multi = 1 + ((self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100)
	ply.ExtraXP = xp_multi
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 22
ITEM.Name = "Alpha Crate"
ITEM.Description = "This crate contains an item from the Alpha Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/b49edbc96b010036c2bfbb15fa186987.png"
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 250
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 365
ITEM.Name = "Beta Crate"
ITEM.Description = "This crate contains an item from the Beta Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/4110e1152fb08b79d71114627012391a.png" 
ITEM.Rarity = 2
ITEM.Collection = "Beta Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 400
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 3999
ITEM.Name = "Box of Chocolates"
ITEM.Description = "This box contains an item from the Valentine Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/boxofchocolates.png"
ITEM.Rarity = 3
ITEM.NameColor = Color(255, 0, 255)
ITEM.Collection = "Valentine Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 444
ITEM.ChosenRarity = 8
ITEM.LimitedShop = 1584169200
ITEM.Rewardable = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 157
ITEM.Name = "Cosmetic Crate"
ITEM.Description = "This crate contains an item from the Cosmetic Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/ccec866eabde09c133a3f6301d558179.png"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 300
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 7332
ITEM.Name = "Paper Tiqers Crate"
ITEM.Description = "This crate contains a skin from the Paper Tiqers Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/ttt/uwu/pluto/icon_crate.png"
ITEM.Rarity = 4
ITEM.Collection = "Paper Tiqers Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 2000
ITEM.NewItem = 1577779200
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 700
ITEM.Name = "Crimson Crate"
ITEM.Description = "This crate contains an item from the Crimson Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/5ce300e78199481c28d09aebae2e0701.png"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 350
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 8999
ITEM.Name = "Easter Basket"
ITEM.Description = "This basket contains a rare item from the Easter Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/easter_basket64.png"
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Easter Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 350
ITEM.ChosenRarity = 8
ITEM.IgnoreDiscord = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 8998
ITEM.Name = "Easter 2019 Basket"
ITEM.Description = "This basket contains a rare item from the Easter Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/easter_basket64.png"
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Easter Collection"
ITEM.Contains = {"Egg Hunt Collection", "Easter Collection"}
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 350
ITEM.WeaponForcePercent = 0
ITEM.ChosenRarity = 8
ITEM.Rarities = {
    [3] = 0.24,
    [4] = 0.12,
    [5] = 0.05,
    [6] = 0.0125,
    [7] = 0.0017,
    [9] = 0.0001,
}
ITEM.IgnoreDiscord = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 8997
ITEM.Name = "Golden Easter Basket"
ITEM.Description = "This basket contains a rare item from the Easter Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/easter_basket64.png"
ITEM.Rarity = 8
ITEM.Collection = "Golden Easter Collection"
ITEM.Contains = {"Easter Collection"}
ITEM.Active = false
ITEM.Stackable = true
ITEM.NotDroppable = true
ITEM.IgnoreDiscord = true
ITEM.Price = 350
ITEM.WeaponForcePercent = 0
ITEM.ChosenRarity = 3
local rarity = 1 / 3
ITEM.Rarities = {
    [5] = rarity,
    [6] = rarity,
    [7] = rarity
}
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 3995
ITEM.Name = "Easter 2020 Basket"
ITEM.Description = "This basket contains a rare item from the Easter Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/easter_basket64.png"
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Easter Collection"
ITEM.Contains = {"Egg Hunt Collection", "Easter Collection"}
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 350
ITEM.WeaponForcePercent = 0
ITEM.ChosenRarity = 8
ITEM.Rarities = {
    [3] = 0.24,
    [4] = 0.12,
    [5] = 0.05,
    [6] = 0.0125,
    [7] = 0.0017,
    [9] = 0.0001,
}
ITEM.IgnoreDiscord = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 851
ITEM.Name = "Easter Egg"
ITEM.Description = "This egg contains a rare item from the Egg Hunt Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/easter_egg64.png" 
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Egg Hunt Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 350
ITEM.IgnoreDiscord = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 275
ITEM.Name = "Effect Crate"
ITEM.Description = "This crate contains an item from the Effect Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/effect_crate64.png" 
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 3950
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 159
ITEM.Name = "50/50 Crate"
ITEM.Description = "This crate has a 50/50 chance of returning a terrible item, or a great item! Right click to open"
ITEM.Image = "https://static.moat.gg/f/fiftyfifty_crate64.png" 
ITEM.Rarity = 4
ITEM.Collection = "50/50 Collection"
ITEM.CrateShopOverride = "50/50"
ITEM.NameEffect = "enchanted"
ITEM.NameEffectMods = { Color(0, 0, 255)}
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 2000
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 2002
ITEM.Name = "Holiday Crate"
ITEM.Description = "This crate contains an item from the Holiday Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/holiday_crate64.png" 
ITEM.Rarity = 4
ITEM.Endangered = true
ITEM.Collection = "Holiday Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 2250
ITEM.NewItem = 1577779200
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 8151
ITEM.Name = "Hype Crate"
ITEM.Description = "This crate contains an item from the Hype Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/bfdaa65ad7342e8fe539f0b2305e3d62.png"
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Hype Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 625
ITEM.NewItem = 1541818391
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 1991
ITEM.Name = "Independence Crate"
ITEM.NameEffect = "enchanted"
ITEM.NameColor = Color(0, 255, 255)
ITEM.NameEffectMods = {Color(255, 0, 0)}
ITEM.Description = "This crate contains an item from the Independence Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/usa_crate64.png"
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Independence Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 28450
ITEM.LimitedShop = 1594882800
ITEM.Rewardable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 158
ITEM.Name = "Melee Crate"
ITEM.Description = "This crate contains an item from the Melee Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/melee_crate64.png" 
ITEM.Rarity = 2
ITEM.Collection = "Melee Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 350
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 9990
ITEM.Name = "Omega Crate"
ITEM.Description = "This crate contains an item from the Omega Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/ttt/crate_icon_omega128.png"
ITEM.Rarity = 4
ITEM.Endangered = true
ITEM.Collection = "Omega Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 1420
ITEM.NewItem = 1555398000
ITEM.WeaponForcePercent = 0.33
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 211
ITEM.Name = "Model Crate"
ITEM.Description = "This crate contains an item from the Model Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/model_crate64.png" 
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 450
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 6000
ITEM.Name = "Paint Crate"
ITEM.Description = "This crate contains an item from the Paint Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/ttt/paint_crate.png"
ITEM.Rarity = 3
ITEM.Collection = "Paint Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 1400
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 2001
ITEM.Name = "Pumpkin Crate"
ITEM.Description = "This crate contains an item from the Pumpkin Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/pumpkin64.png" 
ITEM.Rarity = 8
ITEM.Endangered = true
ITEM.Collection = "Pumpkin Collection"
ITEM.Active = false
ITEM.Stackable = true
ITEM.Price = 50000
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 810
ITEM.Name = "Spring Crate"
ITEM.Description = "This crate contains an item from the Spring Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/spring_crate64.png" 
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 400
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 1051
ITEM.Name = "Titan Crate"
ITEM.Description = "This crate contains an item from the Titan Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/titan_crate64.png"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 2000
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 524
ITEM.Name = "Urban Style Crate"
ITEM.Description = "This crate contains an item from the Urban Style Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/f/urban_crate64.png" 
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 300
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 3394
ITEM.Name = "Cinco De Mayo"
ITEM.Description = "This box contains an item from the Cinco De Mayo Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/ttt/icon_crate_cincodemayo.png"
ITEM.Rarity = 3
ITEM.NameEffect = "enchanted"
ITEM.NameColor = Color(255, 45, 45)
ITEM.NameEffectMods = {Color(45, 255, 45)}
ITEM.Endangered = true
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 5550
-- ITEM.ChosenRarity = 8
ITEM.LimitedShop = 1589958000
ITEM.Rewardable = true
ITEM.NotDroppable = true
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 67
ITEM.Name = "Aqua Palm Crate"
ITEM.Description = "This crate contains an item from the Aqua Palm Collection! Right click to open"
ITEM.Image = "https://static.moat.gg/ttt/aqua_palm_crate_icon.png" 
ITEM.Rarity = 2
ITEM.Endangered = true
ITEM.Collection = "Aqua Palm Collection"
ITEM.Active = true
ITEM.Stackable = true
ITEM.Price = 550
m_AddDroppableItem(ITEM, 'Crate')

ITEM = {}
ITEM.ID = 9994
ITEM.Name = "30 Speed"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 30},
	Accuracy = {min = 0, max = 23},
	Kick = {min = 0, max = -23},
	Firerate = {min = 0, max = 23},
	Magazine = {min = 0, max = 28},
	Range = {min = 0, max = 28},
	Weight = {min = 0, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Lightweight", "Lightweight"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 912
ITEM.Name = "Insomnious"
ITEM.NameEffect = "glow"
ITEM.Rarity = 9
ITEM.Collection = "24 Hour Marathon Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3424
ITEM.Name = "HANDS OFF MY"
ITEM.NameEffect = "glow"
ITEM.Rarity = 8
ITEM.Collection = "Developer Collection"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.NotDroppable = true
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   },
    Reloadrate = {
        min = 80,
        max = 120
   },
    Deployrate = {
        min = -60,
        max = -40
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 747
ITEM.Name = "Airy"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(0,191,255)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3252
ITEM.Name = "Amateur"
ITEM.Rarity = 2
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2550
ITEM.Name = "Patriotic"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2551
ITEM.Name = "Military-Grade"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2551
ITEM.Name = "Military-Grade"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2561
ITEM.Name = "AMERICAN"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "Brutal", "Explosive", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2561
ITEM.Name = "AMERICAN"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "Brutal", "Explosive", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2550
ITEM.Name = "Patriotic"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2552
ITEM.Name = "Independent"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2552
ITEM.Name = "Independent"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2553
ITEM.Name = "Redneck"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2553
ITEM.Name = "Redneck"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2554
ITEM.Name = "Bombing"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2554
ITEM.Name = "Bombing"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2555
ITEM.Name = "Freedom"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2555
ITEM.Name = "Freedom"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2556
ITEM.Name = "Country"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2556
ITEM.Name = "Country"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2557
ITEM.Name = "Western"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2557
ITEM.Name = "Western"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2558
ITEM.Name = "Trumping"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2558
ITEM.Name = "Trumping"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2559
ITEM.Name = "Explosive"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "Explosive", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2559
ITEM.Name = "Explosive"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "Explosive", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 39
ITEM.Name = "Ammofull"
ITEM.NameColor = Color(255, 128, 0)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 13},
	Accuracy = {min = -13, max = -17},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 20, max = 50},
	Range = {min = 13, max = 20},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 52
ITEM.Name = "Angelic"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 7
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3253
ITEM.Name = "Apprentice"
ITEM.Rarity = 3
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 850
ITEM.Name = "Jokesters"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 8
ITEM.Collection = "April Fools Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 353
ITEM.Name = "Astral"
ITEM.NameColor = Color(255, 255, 0)
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 754
ITEM.Name = "Blissful"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(200,200,0)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 751
ITEM.Name = "Blooming"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(220,20,60)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 89
ITEM.Name = "Boston" -- Boston Bashing was too long PepeHands
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 20},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"Boston Basher", "random"}
ITEM.Price = 79999
ITEM.LimitedShop = 1551725434
ITEM.ShopDesc = "Deal extra damage unless you miss!\nWhich makes you hit yourself with it instead.\n(Purchasing will give you a random weapon with the Boston Basher talent)"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 746
ITEM.Name = "Bright"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(199,21,133)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 606
ITEM.Name = "Busted"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(255, 229, 204)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9
ITEM.Name = "Celestial"
ITEM.NameColor = Color(0, 255, 128)
ITEM.Rarity = 7
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 6
ITEM.Name = "Chaotic"
ITEM.NameColor = Color(255, 255, 0)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 622
ITEM.Name = "Charismatic"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(199,21,133)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9993
ITEM.Name = "*Click*"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 30},
	Accuracy = {min = 0, max = 23},
	Kick = {min = 0, max = -23},
	Firerate = {min = 0, max = 23},
	Range = {min = 0, max = 28},
	Weight = {min = 0, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "*click*", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 761
ITEM.Name = "Cloudless"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(0,191,255)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7095
ITEM.Name = "Coal"
ITEM.Rarity = 9
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1574
ITEM.Name = "Soulbound"
ITEM.Rarity = 8
ITEM.Collection = "Community Collection"
ITEM.NameColor = Color(112, 176, 74)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NotDroppable = true
ITEM.NotTradeable = true
ITEM.Stats = {
    Damage = {
        min = 0,
        max = 5
   },
    Accuracy = {
        min = 0,
        max = 5
   },
    Kick = {
        min = 0,
        max = -5
   },
    Firerate = {
        min = 0,
        max = 5
   },
    Magazine = {
        min = 0,
        max = 5
   },
    Range = {
        min = 0,
        max = 5
   },
    Weight = {
        min = -0,
        max = -5
   }
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7023
ITEM.Name = "Cozy"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 740
ITEM.Name = "Crisp"
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(123,104,238)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7024
ITEM.Name = "Dashin"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 31
ITEM.Name = "Dashing"
ITEM.NameColor = Color(255, 153, 153)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7025
ITEM.Name = "Decorated"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 338
ITEM.Name = "Deranged"
ITEM.NameColor = Color(255, 102, 102)
ITEM.Rarity = 4
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 619
ITEM.Name = "Devoted"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(220,20,60)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 621
ITEM.Name = "Divine"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(0,250,154)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 13372
ITEM.Name = "Dual"
ITEM.NameColor = Color(0, 255, 128)
ITEM.Rarity = 8
ITEM.Collection = "Dual Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = { "Twins", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 336
ITEM.Name = "Dynamic"
ITEM.NameColor = Color(153, 153, 255)
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 347
ITEM.Name = "Eccentric"
ITEM.NameColor = Color(255, 102, 178)
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 867
ITEM.Name = "Egg-Cellent"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 868
ITEM.Name = "Egg-Citing"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 869
ITEM.Name = "Egg-Sposed"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 870
ITEM.Name = "Egg-Straodinary"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 865
ITEM.Name = "Egg-Stravaganza"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 871
ITEM.Name = "Egg-Streme"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 753
ITEM.Name = "Energized"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(65,105,225)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 341
ITEM.Name = "Erratic"
ITEM.NameColor = Color(153, 255, 153)
ITEM.Rarity = 4
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 348
ITEM.Name = "Eternal"
ITEM.NameColor = Color(153, 51, 255)
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 349
ITEM.Name = "Evergreen"
ITEM.NameColor = Color(0, 204, 0)
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3256
ITEM.Name = "Expert"
ITEM.Rarity = 5
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 739
ITEM.Name = "Fair"
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(135,206,250)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 607
ITEM.Name = "Faulty"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(188,143,143)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 36
ITEM.Name = "Fearful"
ITEM.NameColor = Color(92, 50, 176)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 609
ITEM.Name = "Feeble"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(135,206,235)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7026
ITEM.Name = "Festive"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 749
ITEM.Name = "Floral"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(144,238,144)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 757
ITEM.Name = "Flourishing"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,20,147)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 748
ITEM.Name = "Fluffy"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(238,130,238)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
--
ITEM = {}
--
ITEM = {}
ITEM.ID = 741
ITEM.Name = "Fresh"
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(102,205,170)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7027
ITEM.Name = "Friendly"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 30
ITEM.Name = "Frisky"
ITEM.NameColor = Color(204, 255, 153)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7028
ITEM.Name = "Gift-Wrapped"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7029
ITEM.Name = "Giving"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 40
ITEM.Name = "Global"
ITEM.NameColor = Color(0, 153, 0)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3258
ITEM.Name = "God"
ITEM.Rarity = 9
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5136
ITEM.Name = "Scary"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5137
ITEM.Name = "Creepy"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5138
ITEM.Name = "Haunting"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5139
ITEM.Name = "Mystical"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5140
ITEM.Name = "Moonlit"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5141
ITEM.Name = "Startling"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5142
ITEM.Name = "Bloody"
ITEM.NameColor = Color(255, 0, 0)
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5143
ITEM.Name = "Ghostly"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(255, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5144
ITEM.Name = "Spooky"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(255, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5145
ITEM.Name = "Undead"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(255, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5146
ITEM.Name = "Ghoulish"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(255, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5147
ITEM.Name = "Spooktacular"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(0, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5148
ITEM.Name = "Supernatural"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.NameColor = Color(0, 255, 0)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5149
ITEM.Name = "Boo-tiful"
ITEM.Rarity = 8
ITEM.NameColor = Color(0, 255, 255)
ITEM.Collection = "Pumpkin Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NameEffect = "glow"
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 32
ITEM.Name = "Harmful"
ITEM.NameColor = Color(255, 86, 44)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 20, max = 35},
	Accuracy = {min = -10, max = -25},
	Kick = {min = 5, max = 10},
	Firerate = {min = -10, max = -20},
	Magazine = {min = 10, max = 15},
	Weight = {min = 10, max = 15}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 340
ITEM.Name = "Haywire"
ITEM.NameColor = Color(255, 178, 102)
ITEM.Rarity = 4
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 755
ITEM.Name = "Heavenly"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,215,0)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 48
ITEM.Name = "Heroic"
ITEM.NameColor = Color(51, 51, 255)
ITEM.Rarity = 6
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 863
ITEM.Name = "Hippity"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7030
ITEM.Name = "Holiday"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 864
ITEM.Name = "Hoppity"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 51
ITEM.Name = "Immortal"
ITEM.NameColor = Color(0, 255, 255)
ITEM.Rarity = 7
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 759
ITEM.Name = "Incredible"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,0,0)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 612
ITEM.Name = "Infringed"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(128,128,0)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 37
ITEM.Name = "Intimidating"
ITEM.NameColor = Color(162, 0, 0)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7031
ITEM.Name = "Jolly"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 750
ITEM.Name = "Joyful"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(147,112,219)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 27
ITEM.Name = "Junky"
ITEM.Rarity = 1
ITEM.Collection = "Alpha Collection"
ITEM.NameColor = Color(149, 129, 115)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 616
ITEM.Name = "Kosher"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(186,85,211)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3257
ITEM.Name = "Legend"
ITEM.Rarity = 6
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 8
ITEM.Name = "Legendary"
ITEM.NameColor = Color(255, 255, 51)
ITEM.Rarity = 6
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 41
ITEM.Name = "Lightweight"
ITEM.NameColor = Color(152, 255, 255)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 12},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Weight = {min = -9, max = -17},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2	
ITEM.Name = "Copycat"
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 20},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"Copycat", "random", "random"}
ITEM.Price = 49999
ITEM.LimitedShop = 1589353200
ITEM.ShopDesc = "Copy the weapons of your dead enemies!\n(Purchasing will give you a random weapon with the Copycat talent)"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3
ITEM.Name = "Assassin"
ITEM.NameColor = Color(0, 0, 255)
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "Assassin"}
ITEM.Price = 22999
ITEM.LimitedShop = 1532971845
ITEM.ShopDesc = "Destroy the bodies of the people you kill with this limited time talent!\n(Purchasing will give you a random weapon with the Assassin talent)"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 14
ITEM.Name = "Wildcard"
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 20},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "Wildcard: Tier 1", "Wildcard: Tier 2", "Wildcard: Tier 3"}
ITEM.Price = 49999
ITEM.LimitedShop = 1535009156 -- wrong commit messsage just making this comment so i can update it lol
ITEM.ShopDesc = "Get random talents every round!\n(Purchasing will give you a random Wildcard tier weapon)"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 15
ITEM.Name = "Silenced"
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 20},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"Silenced", "random", "random"}
ITEM.Price = 49999
ITEM.LimitedShop = 1537758231
ITEM.ShopDesc = "Limited time weapon that comes with the Silenced talent!\nThe Silenced talent is also available normally, so buying this is not necessary.\nEspecially with such a high price, this item is meant for collectors!\nBuying will give you a random weapon!"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 35
ITEM.Name = "Wild!"
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 20},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "Wild! - Tier 1", "Wild! - Tier 2", "Wild! - Tier 3"}
ITEM.Price = 59999
ITEM.LimitedShop = 1555443868 
ITEM.ShopDesc = "Add a random talent to your weapon after you get a kill!\n(Purchasing will give you a random \"Wild\" tier weapon)"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 620
ITEM.Name = "Lovely"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(255,0,255)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 745
ITEM.Name = "Lush"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(154,205,50)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7032
ITEM.Name = "Magical"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 342
ITEM.Name = "Marvelous"
ITEM.NameColor = Color(215, 121, 255)
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3255
ITEM.Name = "Master"
ITEM.Rarity = 5
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 334
ITEM.Name = "Mediocre"
ITEM.Rarity = 2
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 10101
ITEM.Name = "Moat's"
ITEM.Rarity = 8
ITEM.Collection = "Testing Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NameEffect = "fire"
ITEM.NotTradeable = true
ITEM.NameColor = Color(255, 255, 0)
ITEM.Stats = {
	Damage = {min = 20, max = 30},
	Accuracy = {min = 15, max = 25},
	Kick = {min = -15, max = -30},
	Firerate = {min = 15, max = 30},
	Magazine = {min = 30, max = 50},
	Range = {min = 40, max = 50},
	Weight = {min = -5, max = -13}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = { "random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9999
ITEM.Name = "Dedotated"
ITEM.Rarity = 2
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -10, max = 15},
	Accuracy = {min = -10, max = 15},
	Kick = {min = 10, max = -10},
	Firerate = {min = -15, max = 10},
	Magazine = {min = -20, max = 30},
	Range = {min = -20, max = 20},
	Weight = {min = 15, max = -10}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9195
ITEM.Name = "Brother, May I Have Some"
ITEM.Rarity = 7
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = -40, max = 40},
	Accuracy = {min = -55, max = 55},
	Kick = {min = 45, max = -45},
	Firerate = {min = -45, max = 45},
	Magazine = {min = -70, max = 70},
	Range = {min = -65, max = 65},
	Weight = {min = 50, max = -50}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9194
ITEM.Name = "Donald Trump's"
ITEM.Rarity = 7
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = -40, max = 40},
	Accuracy = {min = -55, max = 55},
	Kick = {min = 45, max = -45},
	Firerate = {min = -45, max = 45},
	Magazine = {min = -70, max = 70},
	Range = {min = -65, max = 65},
	Weight = {min = 50, max = -50}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9193
ITEM.Name = "Change My"
ITEM.Rarity = 2
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -10, max = 15},
	Accuracy = {min = -10, max = 15},
	Kick = {min = 10, max = -10},
	Firerate = {min = -15, max = 10},
	Magazine = {min = -20, max = 30},
	Range = {min = -20, max = 20},
	Weight = {min = 15, max = -10}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9192
ITEM.Name = "Bird Box"
ITEM.Rarity = 3
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -20, max = 25},
	Accuracy = {min = -20, max = 25},
	Kick = {min = 20, max = -20},
	Firerate = {min = -20, max = 20},
	Magazine = {min = -40, max = 40},
	Range = {min = -30, max = 30},
	Weight = {min = 20, max = -20}
}
--[[
	
	Damage = {min = 5, max = 10},
	Accuracy = {min = 10, max = 20},
    Firerate = {min = 30, max = 60},
	Kick = {min = -11, max = -19},
	Magazine = {min = 5, max = 10},
]]
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9191
ITEM.Name = "Thank u, next"
ITEM.Rarity = 5
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -25, max = 25},
	Accuracy = {min = -35, max = 35},
	Kick = {min = 30, max = -30},
	Firerate = {min = -30, max = 30},
	Magazine = {min = -50, max = 50},
	Range = {min = -45, max = 45},
	Weight = {min = 30, max = -30}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2658
ITEM.Name = "Alexa play"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -25, max = 25},
	Accuracy = {min = -35, max = 35},
	Kick = {min = 30, max = -30},
	Firerate = {min = -30, max = 30},
	Magazine = {min = -50, max = 50},
	Range = {min = -45, max = 45},
	Weight = {min = 30, max = -30}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2659
ITEM.Name = "Despacito"
ITEM.Rarity = 5
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -25, max = 25},
	Accuracy = {min = -35, max = 35},
	Kick = {min = 30, max = -30},
	Firerate = {min = -30, max = 30},
	Magazine = {min = -50, max = 50},
	Range = {min = -45, max = 45},
	Weight = {min = 30, max = -30}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2632
ITEM.Name = "AirPods Compatible"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.NameColor = Color(135, 0, 153)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = -30, max = 30},
	Accuracy = {min = -45, max = 45},
	Kick = {min = 35, max = -35},
	Firerate = {min = -40, max = 40},
	Magazine = {min = -60, max = 60},
	Range = {min = -55, max = 55},
	Weight = {min = 40, max = -40}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3612
ITEM.Name = "World Record"
ITEM.Rarity = 7
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = -40, max = 40},
	Accuracy = {min = -55, max = 55},
	Kick = {min = 45, max = -45},
	Firerate = {min = -45, max = 45},
	Magazine = {min = -70, max = 70},
	Range = {min = -65, max = 65},
	Weight = {min = 50, max = -50}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 2670
ITEM.Name = "End Game"
ITEM.Rarity = 9
ITEM.Collection = "Omega Collection2"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.NotDroppable = true
ITEM.Stats = {
	Damage = {min = -40, max = 40},
	Accuracy = {min = -55, max = 55},
	Kick = {min = 45, max = -45},
	Firerate = {min = -45, max = 45},
	Magazine = {min = -70, max = 70},
	Range = {min = -65, max = 65},
	Weight = {min = 50, max = -50},
    Reloadrate = {
        min = -90,
        max = 90
   },
    Deployrate = {
        min = -90,
        max = 90
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9998
ITEM.Name = "Slaps Roof of"
ITEM.Rarity = 3
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -20, max = 25},
	Accuracy = {min = -20, max = 25},
	Kick = {min = 20, max = -20},
	Firerate = {min = -20, max = 20},
	Magazine = {min = -40, max = 40},
	Range = {min = -30, max = 30},
	Weight = {min = 20, max = -20}
}
--[[
	
	Damage = {min = 5, max = 10},
	Accuracy = {min = 10, max = 20},
    Firerate = {min = 30, max = 60},
	Kick = {min = -11, max = -19},
	Magazine = {min = 5, max = 10},
]]
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9997
ITEM.Name = "Boneless"
ITEM.Rarity = 5
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -25, max = 25},
	Accuracy = {min = -35, max = 35},
	Kick = {min = 30, max = -30},
	Firerate = {min = -30, max = 30},
	Magazine = {min = -50, max = 50},
	Range = {min = -45, max = 45},
	Weight = {min = 30, max = -30}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9996
ITEM.Name = "Delet This"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.NameColor = Color(135, 0, 153)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = -30, max = 30},
	Accuracy = {min = -45, max = 45},
	Kick = {min = 35, max = -35},
	Firerate = {min = -40, max = 40},
	Magazine = {min = -60, max = 60},
	Range = {min = -55, max = 55},
	Weight = {min = 40, max = -40}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9995
ITEM.Name = "That's a Lotta"
ITEM.Rarity = 7
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = -40, max = 40},
	Accuracy = {min = -55, max = 55},
	Kick = {min = 45, max = -45},
	Firerate = {min = -45, max = 45},
	Magazine = {min = -70, max = 70},
	Range = {min = -65, max = 65},
	Weight = {min = 50, max = -50}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9199
ITEM.Name = "Don't Say"
ITEM.Rarity = 2
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -10, max = 15},
	Accuracy = {min = -10, max = 15},
	Kick = {min = 10, max = -10},
	Firerate = {min = -15, max = 10},
	Magazine = {min = -20, max = 30},
	Range = {min = -20, max = 20},
	Weight = {min = 15, max = -10}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9198
ITEM.Name = "Is This Your"
ITEM.Rarity = 3
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -20, max = 25},
	Accuracy = {min = -20, max = 25},
	Kick = {min = 20, max = -20},
	Firerate = {min = -20, max = 20},
	Magazine = {min = -40, max = 40},
	Range = {min = -30, max = 30},
	Weight = {min = 20, max = -20}
}
--[[
	
	Damage = {min = 5, max = 10},
	Accuracy = {min = 10, max = 20},
    Firerate = {min = 30, max = 60},
	Kick = {min = -11, max = -19},
	Magazine = {min = 5, max = 10},
]]
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9197
ITEM.Name = "Netflix n'"
ITEM.Rarity = 5
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -25, max = 25},
	Accuracy = {min = -35, max = 35},
	Kick = {min = 30, max = -30},
	Firerate = {min = -30, max = 30},
	Magazine = {min = -50, max = 50},
	Range = {min = -45, max = 45},
	Weight = {min = 30, max = -30}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9196
ITEM.Name = "Wooaah"
ITEM.Rarity = 6
ITEM.Collection = "Omega Collection"
ITEM.NameColor = Color(135, 0, 153)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = -30, max = 30},
	Accuracy = {min = -45, max = 45},
	Kick = {min = 35, max = -35},
	Firerate = {min = -40, max = 40},
	Magazine = {min = -60, max = 60},
	Range = {min = -55, max = 55},
	Weight = {min = 40, max = -40}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7033
ITEM.Name = "Merry"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 4
ITEM.Name = "Moderate"
ITEM.NameColor = Color(153, 255, 255)
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 47
ITEM.Name = "Mythical"
ITEM.NameColor = Color(178, 102, 255)
ITEM.Rarity = 6
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 6666
ITEM.Name = "Celebratory"
ITEM.NameEffect = "glow"
ITEM.Rarity = 9
ITEM.Endangered = true
ITEM.Collection = "New Years Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3251
ITEM.Name = "Novice"
ITEM.Rarity = 1
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 5
ITEM.Name = "Odd"
ITEM.NameColor = Color(153, 255, 153)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 29
ITEM.Name = "Ordinary"
ITEM.NameColor = Color(204, 229, 255)
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 351
ITEM.Name = "Partisan"
ITEM.NameColor = Color(189, 255, 145)
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 614
ITEM.Name = "Unpassable"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(60,179,113)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 333
ITEM.Name = "Passable"
ITEM.NameColor = Color(153, 255, 204)
ITEM.Rarity = 2
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 337
ITEM.Name = "Peppy"
ITEM.NameColor = Color(255, 151, 210)
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 737
ITEM.Name = "Petty"
ITEM.Rarity = 1
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,182,193)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 617
ITEM.Name = "Pleasant"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(218,112,214)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 33
ITEM.Name = "Precise"
ITEM.NameColor = Color(153, 204, 255)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 30, max = 60},
	Kick = {min = 5, max = 10},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 15, max = 20},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3423
ITEM.Name = "Priceless"
ITEM.NameEffect = "glow"
ITEM.Rarity = 9
ITEM.Collection = "Never Dropping Again Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NotDroppable = true
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3254
ITEM.Name = "Professional"
ITEM.Rarity = 4
ITEM.Collection = "Summer Event Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 742
ITEM.Name = "Pure"
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(64,224,208)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 346
ITEM.Name = "Quaint"
ITEM.NameColor = Color(59, 132, 172)
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 38
ITEM.Name = "Rapid"
ITEM.NameColor = Color(255, 178, 102)
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = -5, max = 5},
	Accuracy = {min = -15, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 25, max = 45},
	Magazine = {min = 13, max = 20},
	Range = {min = -13, max = -20},
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1
ITEM.Name = "Recycled"
ITEM.Rarity = 1
ITEM.Collection = "Alpha Collection"
ITEM.NameColor = Color(181, 128, 117)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 43
ITEM.Name = "Remarkable"
ITEM.NameColor = Color(255, 102, 178)
ITEM.Rarity = 5
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 610
ITEM.Name = "Retracted"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(176,224,230)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 625
ITEM.Name = "Righteous"
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(255,255,0)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 608
ITEM.Name = "Rough"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(255,160,122)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 623
ITEM.Name = "Sacred"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(100,149,237)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 626
ITEM.Name = "Saintlike"
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(255,69,0)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7034
ITEM.Name = "Santa's own"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 350
ITEM.Name = "Satanic"
ITEM.NameColor = Color(102, 0, 0)
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1575
ITEM.Name = "Self-Made"
ITEM.Rarity = 8
ITEM.Collection = "Community Collection"
ITEM.NameColor = Color(112, 176, 74)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NotDroppable = true
ITEM.NotTradeable = true
ITEM.Stats = {
    Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 331
ITEM.Name = "Shabby"
ITEM.Rarity = 1
ITEM.Collection = "Beta Collection"
ITEM.NameColor = Color(215, 255, 224)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 352
ITEM.Name = "Shiny"
ITEM.NameColor = Color(0, 255, 200)
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7035
ITEM.Name = "Snowy"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 738
ITEM.Name = "Soft"
ITEM.Rarity = 1
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(175,238,238)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 756
ITEM.Name = "Spectacular"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(0,255,127)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 28
ITEM.Name = "Stable"
ITEM.NameColor = Color(255, 255, 255)
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 34
ITEM.Name = "Steady"
ITEM.NameColor = Color(153, 255, 153)
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -20, max = -50},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Weight = {min = 3, max = 5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 0
ITEM.Name = "Stock"
ITEM.Rarity = 0
ITEM.Collection = "Beginners Collection"
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 44
ITEM.Name = "Strange"
ITEM.NameColor = Color(255, 0, 102)
ITEM.Rarity = 5
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 760
ITEM.Name = "Stunning"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(148,0,211)
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9601
ITEM.Name = "Splashing"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7},
	Reloadrate = {min = 16, max = 24},
	Deployrate = {min = 16, max = 24}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9610
ITEM.Name = "Refreshing"
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 8
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5},
	Reloadrate = {min = 13, max = 20},
	Deployrate = {min = 13, max = 20}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9611
ITEM.Name = "Delightful"
ITEM.Rarity = 3
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 10, max = 15},
	Deployrate = {min = 10, max = 15}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9612
ITEM.Name = "Scorching"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Reloadrate = {min = 19, max = 28},
	Deployrate = {min = 19, max = 28}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9613
ITEM.Name = "Soaking"
ITEM.Rarity = 7
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
	Reloadrate = {min = 23, max = 33},
	Deployrate = {min = 23, max = 33}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9614
ITEM.Name = "Juicy"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7},
	Reloadrate = {min = 16, max = 24},
	Deployrate = {min = 16, max = 24}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9615
ITEM.Name = "Sunburnt"
ITEM.Rarity = 1
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
	Weight = {min = -2, max = 3},
	Reloadrate = {min = -6, max = 7},
	Deployrate = {min = -4, max = 5},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9616
ITEM.Name = "Aquaholic"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 8
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Reloadrate = {min = 19, max = 28},
	Deployrate = {min = 19, max = 28}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9617
ITEM.Name = "Paradise"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Reloadrate = {min = 19, max = 28},
	Deployrate = {min = 19, max = 28}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9618
ITEM.Name = "Backyard"
ITEM.Rarity = 1
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
	Weight = {min = -2, max = 3},
	Reloadrate = {min = -6, max = 7},
	Deployrate = {min = -4, max = 5},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9619
ITEM.Name = "Tropical"
ITEM.Rarity = 7
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
	Reloadrate = {min = 23, max = 33},
	Deployrate = {min = 23, max = 33}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9602
ITEM.Name = "Slip-N-Slide"
ITEM.Rarity = 9
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
	Reloadrate = {min = 23, max = 33},
	Deployrate = {min = 23, max = 33}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9620
ITEM.Name = "Foreign"
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 8
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5},
	Reloadrate = {min = 13, max = 20},
	Deployrate = {min = 13, max = 20}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9621
ITEM.Name = "Humid"
ITEM.Rarity = 2
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 5, max = 10},
	Deployrate = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9603
ITEM.Name = "Squirt"
ITEM.Rarity = 1
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
	Weight = {min = -2, max = 3},
	Reloadrate = {min = -6, max = 7},
	Deployrate = {min = -4, max = 5},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9604
ITEM.Name = "Beachy"
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5},
	Reloadrate = {min = 13, max = 20},
	Deployrate = {min = 13, max = 20}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9605
ITEM.Name = "Umbrella"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 9
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7},
	Reloadrate = {min = 16, max = 24},
	Deployrate = {min = 16, max = 24}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9606
ITEM.Name = "Sizzling"
ITEM.Rarity = 2
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 5, max = 10},
	Deployrate = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9607
ITEM.Name = "Breezy"
ITEM.Rarity = 3
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 10, max = 15},
	Deployrate = {min = 10, max = 15}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9608
ITEM.Name = "Fragrant"
ITEM.Rarity = 2
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 5, max = 10},
	Deployrate = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 9609
ITEM.Name = "Poolside"
ITEM.Rarity = 3
ITEM.Collection = "Aqua Palm Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3},
	Reloadrate = {min = 10, max = 15},
	Deployrate = {min = 10, max = 15}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 758
ITEM.Name = "Sunny"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,255,0)
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 611
ITEM.Name = "Sustainable"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(152,251,152)
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 743
ITEM.Name = "Sweet"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(221,160,221)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 12
ITEM.Name = "TalentTest"
ITEM.Rarity = 8
ITEM.Collection = "Testing Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 20, max = 30},
	Accuracy = {min = 15, max = 25},
	Kick = {min = -15, max = -30},
	Firerate = {min = 15, max = 30},
	Magazine = {min = 30, max = 50},
	Range = {min = 40, max = 50},
	Weight = {min = -5, max = -13}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "Accurate", "Mute", "Inferno"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 330
ITEM.Name = "Tattered"
ITEM.Rarity = 1
ITEM.Collection = "Beta Collection"
ITEM.NameColor = Color(69, 87, 71)
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1146
ITEM.Name = "Titan T0"
ITEM.Rarity = 9
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NameEffect = "electric"
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1147
ITEM.Name = "Titan T1"
ITEM.Rarity = 7
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NameEffect = "electric"
ITEM.Stats = {
    Damage = {min = 17, max = 28},
    Accuracy = {min = 17, max = 28},
    Kick = {min = -17, max = -28},
    Firerate = {min = 17, max = 28},
    Magazine = {min = 23, max = 33},
    Range = {min = 23, max = 33},
    Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1148
ITEM.Name = "Titan T2"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.NameEffect = "electric"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {min = 14, max = 23},
    Accuracy = {min = 14, max = 23},
    Kick = {min = -14, max = -23},
    Firerate = {min = 14, max = 23},
    Magazine = {min = 19, max = 28},
    Range = {min = 19, max = 28},
    Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1149
ITEM.Name = "Titan T3"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.NameEffect = "electric"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {min = 11, max = 19},
    Accuracy = {min = 11, max = 19},
    Kick = {min = -11, max = -19},
    Firerate = {min = 11, max = 19},
    Magazine = {min = 16, max = 24},
    Range = {min = 16, max = 24},
    Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 1150
ITEM.Name = "Titan T4"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.NameEffect = "electric"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
    Damage = {min = 8, max = 15},
    Accuracy = {min = 8, max = 15},
    Kick = {min = -8, max = -15},
    Firerate = {min = 8, max = 15},
    Magazine = {min = 13, max = 20},
    Range = {min = 13, max = 20},
    Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 613
ITEM.Name = "Tolerable"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(221,160,221)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 615
ITEM.Name = "Touted"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(34,139,34)
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 332
ITEM.Name = "Trifling"
ITEM.NameColor = Color(56, 64, 92)
ITEM.Rarity = 2
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 339
ITEM.Name = "Turbid"
ITEM.NameColor = Color(228, 232, 107)
ITEM.Rarity = 4
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 345
ITEM.Name = "Uncanny"
ITEM.NameColor = Color(157, 120, 158)
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 7
ITEM.Name = "Unusual"
ITEM.NameColor = Color(178, 205, 255)
ITEM.Rarity = 5
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3136
ITEM.Name = "Cover-Girl"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 2
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3137
ITEM.Name = "Splendid"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 2
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3138
ITEM.Name = "Amazing"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 2
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3139
ITEM.Name = "Prettier"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 3
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3137
ITEM.Name = "Gentle"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 3
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3140
ITEM.Name = "Cutie"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 3
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3141
ITEM.Name = "Scrumptious"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 4
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3142
ITEM.Name = "Ravishing"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 4
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3142
ITEM.Name = "Purty"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 4
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3137
ITEM.Name = "Dainty"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Rarity = 4
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3143
ITEM.Name = "Handsome"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3144
ITEM.Name = "Nice"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3145
ITEM.Name = "Enchanting"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3146
ITEM.Name = "Charming"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3145
ITEM.Name = "Dreamy"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3145
ITEM.Name = "Yummy"
ITEM.Rarity = 5
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3147
ITEM.Name = "Fabulous"
ITEM.Rarity = 6
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3148
ITEM.Name = "Gorgeous"
ITEM.Rarity = 6
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3148
ITEM.Name = "Beautiful"
ITEM.Rarity = 6
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3148
ITEM.Name = "Adorable"
ITEM.Rarity = 6
ITEM.Collection = "Valentine Collection"
ITEM.NameColor = Color(255, 0, 255)
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3149
ITEM.Name = "Lovable"
ITEM.Rarity = 7
ITEM.NameColor = Color(255, 0, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.NameEffect = "glow"
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 752
ITEM.Name = "Vibrant"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(255,105,180)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 354
ITEM.Name = "Virtuous"
ITEM.NameColor = Color(213, 0, 255)
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 744
ITEM.Name = "Warm"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.NameColor = Color(173,255,47)
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 736
ITEM.Name = "Weak"
ITEM.Rarity = 1
ITEM.Collection = "Spring Collection"
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 618
ITEM.Name = "Crimson"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.NameColor = Color(178,34,34)
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 335
ITEM.Name = "Zesty"
ITEM.NameColor = Color(92, 169, 76)
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3345
ITEM.Name = "Authentic"
ITEM.Rarity = 5
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.NameEffect = "glow"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3347
ITEM.Name = "Community"
ITEM.Rarity = 6
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3348
ITEM.Name = "Kinship"
ITEM.Rarity = 7
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.NameEffect = "glow"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
    Damage = {
        min = 17,
        max = 28
   },
    Accuracy = {
        min = 17,
        max = 28
   },
    Kick = {
        min = -17,
        max = -28
   },
    Firerate = {
        min = 17,
        max = 28
   },
    Magazine = {
        min = 23,
        max = 33
   },
    Range = {
        min = 23,
        max = 33
   },
    Weight = {
        min = -5,
        max = -7
   }
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3337
ITEM.Name = "Young"
ITEM.Rarity = 2
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.ID = 3339
ITEM.Name = "Mexican"
ITEM.Rarity = 3
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'tier')

ITEM = {}
ITEM.Name = "Red Backpack"
ITEM.ID = 584
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/backpack_1.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Black Backpack"
ITEM.ID = 585
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/backpack_1.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Gray Backpack"
ITEM.ID = 569
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/backpack_1.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -3) + (ang:Up() * 0) + (ang:Forward() * 0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "BlueCABackpack"
ITEM.ID = 570
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/backpack_2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "GreenCABackpack"
ITEM.ID = 571
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/backpack_2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "RedCABackpack"
ITEM.ID = 572
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/backpack_2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 1)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Black Tactical Backpack"
ITEM.ID = 573
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/backpack_3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 0.9)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Grey Tactical Backpack"
ITEM.ID = 574
ITEM.Description = "I wonder what you're carrying inside? Perhaps a secret charm for increased luck.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/backpack_3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Right() * -2.3) + (ang:Up() * 0) + (ang:Forward() * 0.9)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.ID = 3397
ITEM.Name = "Balloonicorno"
ITEM.Description = "Hey look, you finally have a friend now"
ITEM.Model = "models/gmod_tower/balloonicorn_nojiggle.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.Attachment = "eyes" // left trapezius
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -20) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.ID = 2097
ITEM.Name = "Balloonicorn"
ITEM.Description = "Hey look, you finally have a friend now"
ITEM.Model = "models/gmod_tower/balloonicorn_nojiggle.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Attachment = "eyes" // left trapezius
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -20) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Face Bandana"
ITEM.ID = 575
ITEM.Description = "True terrorists will always have a spare one of these on them"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/bandana.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Right() * 0.1) + (ang:Up() * -4.5) + (ang:Forward() * -4.1)
	ang:RotateAroundAxis(ang:Up(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.ID = 2067
ITEM.Name = "Duck Tube"
ITEM.Description = "The king of the pool party"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/duck_tube.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Bone = "ValveBiped.Bip01_Spine1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.65, 0)
	pos = pos + (ang:Forward() * 0) + (ang:Right() * -0) +  (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 90)
	pos = pos + Vector(-5,3,0)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "White Scarf"
ITEM.ID = 576
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Gray Scarf"
ITEM.ID = 577
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Black Scarf"
ITEM.ID = 578
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Midnight Scarf"
ITEM.ID = 579
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Red Scarf"
ITEM.ID = 580
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Green Scarf"
ITEM.ID = 581
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.Name = "Pink Scarf"
ITEM.ID = 582
ITEM.Description = "It's getting chilly outside"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/sal/acc/fix/scarf01.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	pos = pos + (ang:Forward() * -17.746000) + (ang:Right() * -8.509000) +  (ang:Up() * 1.143)
	ang:RotateAroundAxis(ang:Right(), -2.400)
	ang:RotateAroundAxis(ang:Up(), 74.100)
	ang:RotateAroundAxis(ang:Forward(), 90.300)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Body')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Body') end

ITEM = {}
ITEM.ID = 785
ITEM.Name = "Akimbonators"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_akimbo"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 776
ITEM.Name = "Akimbonitos"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_akimbo"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 773
ITEM.Name = "Alien Poo90"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_rcp120"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 642
ITEM.Name = "Autocatis"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_cz75"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 639
ITEM.Name = "Breach-N-Clear"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
ITEM.WeaponClass = "weapon_ttt_mp5k"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 55
ITEM.Name = "Bond's First Friend"
ITEM.NameColor = Color(255,215,0)
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.WeaponClass = "weapon_zm_revolver"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
    Damage = {min = 17, max = 28},
    Accuracy = {min = 55, max = 80},
    Kick = {min = -17, max = -30},
    Firerate = {min = 20, max = 38},
    Magazine = {min = 6, max = 10},
    Range = {min = 25, max = 55},
    Weight = {min = -5, max = -7},
    Deployrate = {min = 30, max = 40},
    Reloadrate = {min = 30, max = 40}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 64
ITEM.Name = "Monte Carlo"
ITEM.NameColor = Color(231, 55, 55)
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.WeaponClass = "weapon_ttt_mp5"
ITEM.MinStats = 6
ITEM.MaxStats = 8 
ITEM.Stats = {
    Damage = {min = 17, max = 22},
    Accuracy = {min = 17, max = 28},
    Kick = {min = -17, max = -28},
    Firerate = {min = 10, max = 24},
    Magazine = {min = 25, max = 35},
    Range = {min = 23, max = 32},
    Weight = {min = -7, max = -10},
    Deployrate = {min = 30, max = 40},
    Reloadrate = {min = 30, max = 40}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 65
ITEM.Name = "Traitor Killa"
ITEM.NameColor = Color(255, 153, 10)
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.Collection = "Beta Collection"
ITEM.WeaponClass = "weapon_zm_sledge"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
  	Damage = {min = 17, max = 28},
    Accuracy = {min = 17, max = 28},
    Kick = {min = -17, max = -28},
    Firerate = {min = 17, max = 28},
    Magazine = {min = 23, max = 33},
    Range = {min = 23, max = 33},
    Weight = {min = -5, max = -7},
    Deployrate = {min = 30, max = 40},
    Reloadrate = {min = 30, max = 40},
}

ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = { "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 782
ITEM.Name = "Bond's Double Friend"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_virussil"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 774
ITEM.Name = "Bond's Worst Friend"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_golden_revolver"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 872
ITEM.Name = "Bunny-N-Clyde"
ITEM.NameEffect = "glow"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_thompson"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7052
ITEM.Name = "Dasher"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 20},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_te_g36c"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7053
ITEM.Name = "Rudolph"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 8
ITEM.Stats = {
	Damage = {min = 14, max = 40},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Chargerate = {min = 28, max = 46}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_mor_daedric"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7054
ITEM.Name = "Dancer"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 2, max = 15},
	Kick = {min = 14, max = 23},
	Firerate = {min = 5, max = 30},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_m16"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7055
ITEM.Name = "Prancer"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 28},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_p228"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7056
ITEM.Name = "Vixen"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 6, max = 12},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 20, max = 40},
	Magazine = {min = 30, max = 60},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_p228"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7057
ITEM.Name = "Comet"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 30},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -20, max = -34},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 14, max = 22},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_sg552"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7058
ITEM.Name = "Cupid"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 12, max = 20},
	Accuracy = {min = 4, max = 40},
	Kick = {min = -14, max = -23},
	Firerate = {min = 2, max = 12},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_p90"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7059
ITEM.Name = "Dunder"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 20, max = 35},
	Accuracy = {min = 14, max = 30},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 4, max = 8},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_m03a3"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7063
ITEM.Name = "Blixem"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 23, max = 35},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -5, max = -10},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 5, max = 12},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "Snowball", "random"}
ITEM.WeaponClass = "weapon_ttt_cz75"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 643
ITEM.Name = "Collectinator"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255,165,0)
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_m03a3"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 804
ITEM.Name = "Compactachi"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_xm8b"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 789
ITEM.Name = "DBMonster"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_doubleb"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 644
ITEM.Name = "Deadshot"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(0,206,209)
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_sg550"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 648
ITEM.Name = "Bond's Best Friend"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255,215,0)
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_golden_deagle"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 316
ITEM.Name = "Doomladen"
ITEM.NameColor = Color(231, 213, 11)
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.WeaponClass = "weapon_ttt_m16"
ITEM.MinStats = 9
ITEM.MaxStats = 9
ITEM.Stats = {
    Damage = {min = 20, max = 32},
    Accuracy = {min = 15, max = 30},
    Kick = {min = 15, max = 32},
    Firerate = {min = 16, max = 28},
    Magazine = {min = 6, max = 18},
    Range = {min = 10, max = 25},
    Weight = {min = 6, max = 18},
    Deployrate = {min = -12, max = -25},
    Reloadrate = {min = 15, max = 30},
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = { "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6930
ITEM.Name = "Deagle Lovers"
ITEM.Rarity = 7
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -15, max = -35}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_deagle"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13375
ITEM.Name = "Dual Glocks"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 5, max = 13},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = -28, max = -19},
	Weight = {min = 7, max = 4}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_glock"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6825
ITEM.Name = "Glock Lovers"
ITEM.Rarity = 5
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 5, max = 13},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = -28, max = -19},
	Weight = {min = 7, max = 4}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_glock"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13377
ITEM.Name = "Dual H.U.G.E-249s"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 20, max = 10}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_huge"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6824
ITEM.Name = "H.U.G.E Lovers"
ITEM.Rarity = 3
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 20, max = 10}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_huge"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6923
ITEM.Name = "M16 Lovers"
ITEM.Rarity = 6
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 14, max = 8}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_m16"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13374
ITEM.Name = "Dual MAC10s"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 14, max = 8}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_mac10"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6823
ITEM.Name = "MAC10 Lovers"
ITEM.Rarity = 6
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 14, max = 8}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_mac10"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6831
ITEM.Name = "Pistol Lovers"
ITEM.Rarity = 4
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 7, max = 4}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_pistols"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6929
ITEM.Name = "Rifle Lovers"
ITEM.Rarity = 6
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 35, max = 15}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_rifle"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13378
ITEM.Name = "Dual SG550s"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 16, max = 8}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_sg550"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6822
ITEM.Name = "SG550 Lovers"
ITEM.Rarity = 5
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 16, max = 8}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_sg550"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6924
ITEM.Name = "Shotgun Lovers"
ITEM.Rarity = 7
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 35, max = 15}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_shotgun"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13373
ITEM.Name = "Dual TMPs"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 4, max = -4}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_tmp"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6821
ITEM.Name = "TMP Lovers"
ITEM.Rarity = 6
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 4, max = -4}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_tmp"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 13376
ITEM.Name = "Dual UMPs"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 0, max = -4}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_ump"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 6820
ITEM.Name = "UMP Lovers"
ITEM.Rarity = 7
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(255, 153, 255)
ITEM.Collection = "Valentine Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = 0, max = -4}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_dual_ump"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 873
ITEM.Name = "Easter90"
ITEM.NameEffect = "glow"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_rcp120"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 874
ITEM.Name = "Easternator"
ITEM.NameEffect = "glow"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_virus9mm"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 638
ITEM.Name = "Ecopati"
ITEM.NameColor = Color	(0,139,139)
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
ITEM.WeaponClass = "weapon_ttt_m1911"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10107
ITEM.Name = "Energizing AK47"
ITEM.Rarity = 7
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_ak47"
ITEM.MinStats = 6
ITEM.MaxStats = 8
ITEM.NameEffect = "electric"
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
    Deployrate = {min = 30, max = 40},
	Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 4
ITEM.NotDroppable = true
ITEM.Talents = {"Energizing", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10120
ITEM.Name = "Energizing MAC10"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_zm_mac10"
ITEM.MinStats = 6
ITEM.MaxStats = 8
ITEM.NameEffect = "electric"
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Kick = {min = -17, max = -28},
    Deployrate = {min = 30, max = 40},
	Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 4
ITEM.NotDroppable = true
ITEM.Talents = {"Energizing", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10108
ITEM.Name = "Jewel Noelle"
ITEM.Rarity = 8
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_mp40"
ITEM.MinStats = 8
ITEM.MaxStats = 9
ITEM.NameEffect = "electric"
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
    Deployrate = {min = 30, max = 40},
	Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 4
ITEM.NotDroppable = true
ITEM.Talents = {"Energizing", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10106
ITEM.Name = "Energizing Deadshot"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_sg550"
ITEM.MinStats = 6
ITEM.MaxStats = 8
ITEM.NameEffect = "electric"
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 22, max = 33},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
    Deployrate = {min = 30, max = 40},
    Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 4
ITEM.NotDroppable = true
ITEM.Talents = {"Energizing", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10112
ITEM.Name = "Zapper Capper"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_zapperpvp"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.NameEffect = "electric"
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 22, max = 33},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -10, max = -15},
	Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 2 
ITEM.MaxTalents = 3
ITEM.NotDroppable = true
ITEM.Talents = {"Energizing", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 779
ITEM.Name = "Executioner"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_flakgun"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 7973
ITEM.Name = "FaZe Pro Player"
ITEM.Rarity = 7
ITEM.Collection = "Omega Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 73, max = 92},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.WeaponClass = "weapon_zm_rifle"
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"Accurate", "*click*"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 769
ITEM.Name = "The Gauntlet"
ITEM.Rarity = 6
ITEM.Collection = "Space Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 15, max = 25},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = -10, max = -1},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Space Stone", "Reality Stone", "Power Stone"}
ITEM.WeaponClass = "weapon_ttt_te_deagle"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 637
ITEM.Name = "Goongsta"
ITEM.NameColor = Color(139,0,0)
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
ITEM.WeaponClass = "weapon_ttt_mac11"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 800
ITEM.Name = "Goongsto"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_thompson"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 317
ITEM.Name = "Hawkeyo"
ITEM.NameColor = Color(255, 0, 0)
ITEM.NameEffect = "glow"
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 1, max = 10},
    Accuracy = {min = 10, max = 50},
    Range = {min = 1, max = 10},
    Firerate = {min = 1, max = 10},
	Magazine = {min = 5, max = 10},
}
ITEM.WeaponClass = "weapon_zm_sledge"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 784
ITEM.Name = "Hedge Shooter"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_spas12pvp"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 875
ITEM.Name = "Hippity Hoppity"
ITEM.NameEffect = "glow"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_m1911"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 318
ITEM.Name = "Holukis"
ITEM.NameColor = Color(133, 213, 239)
ITEM.NameEffect = "glow"
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -50, max = -70},
    Firerate = {min = 80, max = 100},
	Magazine = {min = 10, max = 30},
}
ITEM.WeaponClass = "weapon_zm_shotgun"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 792
ITEM.Name = "Intruder Killer"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_doubleb"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 8752
ITEM.Name = "Jelly Parade"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.Collection = "Easter Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 15, max = 20},
	Accuracy = {min = 23, max = 30},
	Kick = {min = -5, max = -30},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 34, max = 58},
	Range = {min = 25, max = 32},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_te_mac"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 319
ITEM.Name = "Headcrusher"
ITEM.NameColor = Color(29, 201, 150)
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 25, max = 50},
    Accuracy = {min = 10, max = 30},
	Magazine = {min = -40, max = -80},
	Firerate = {min = -50, max = -95},
    Range = {min = 1, max = 20},
}
ITEM.WeaponClass = "weapon_zm_revolver"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "Brutal"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 636
ITEM.Name = "Kahtinga"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_aug"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 320
ITEM.Name = "Kik-Back"
ITEM.NameColor = Color(171, 1, 37)
ITEM.NameEffect = "glow"
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = 15, max = 30},
	Accuracy = {min = 10, max = 20},
	Kick = {min = 60, max = 70},
}
ITEM.WeaponClass = "weapon_ttt_ak47"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 321
ITEM.Name = "Karitichu"
ITEM.NameColor = Color(255, 233, 109)
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 10, max = 20},
    Firerate = {min = 30, max = 60},
	Kick = {min = -11, max = -19},
	Magazine = {min = 5, max = 10},
}
ITEM.WeaponClass = "weapon_zm_rifle"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 2562
ITEM.Name = "The Nationalist"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.WeaponClass = "weapon_ttt_te_g36c"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 641
ITEM.Name = "M4ALover"
ITEM.NameColor = Color(220,20,60)
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
ITEM.WeaponClass = "weapon_ttt_m4a1"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 4641
ITEM.Name = "M4AFan"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 28},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_m4a1"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 4642
ITEM.Name = "M4APartner"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_m4a1"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 322
ITEM.Name = "Miscordia"
ITEM.NameColor = Color(0, 189, 71)
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.WeaponClass = "weapon_ttt_glock"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "Sustained"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 646
ITEM.Name = "Mohtuanica"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(220,20,60)
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_mp5k"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 783
ITEM.Name = "Nintendo Switchpa"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_zapperpvp"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 632
ITEM.Name = "Old Comrade"
ITEM.NameColor = Color(210,180,140)
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_glock"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 323
ITEM.Name = "Headbanger"
ITEM.NameColor = Color(23, 116, 89)
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 25, max = 50},
    Accuracy = {min = 10, max = 30},
	Magazine = {min = -40, max = -80},
	Firerate = {min = -50, max = -95},
    Range = {min = 1, max = 20},
}
ITEM.WeaponClass = "weapon_zm_pistol"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "Brutal"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10110
ITEM.Name = "Smear Cavalier"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_famas"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
    Deployrate = {min = 20, max = 40},
    Reloadrate = {min = 20, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Paintball", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10111
ITEM.Name = "Varnish Star"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_galil"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
    Deployrate = {min = 20, max = 40},
    Reloadrate = {min = 20, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Paintball", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10109
ITEM.Name = "La Vaux Gloss"
ITEM.Rarity = 7
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_sp"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
    Deployrate = {min = 20, max = 40},
    Reloadrate = {min = 20, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Paintball", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10105
ITEM.Name = "Brane Splain"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_ttt_mp40"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 3, max = 13},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 5, max = 16},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
    Deployrate = {min = 30, max = 40},
    Reloadrate = {min = 30, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Paintball", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 10104
ITEM.Name = "Spanish Splatter"
ITEM.Rarity = 7
ITEM.Collection = "Aqua Palm Collection"
ITEM.WeaponClass = "weapon_sp"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
    Deployrate = {min = 20, max = 40},
    Reloadrate = {min = 20, max = 40},
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"Paintball", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 771
ITEM.Name = "The Patriot"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_patriot"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 2562
ITEM.Name = "The Nationalist"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.WeaponClass = "weapon_patriot"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 635
ITEM.Name = "Pocketier"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 3
ITEM.MaxStats = 5
ITEM.Stats = {
	Damage = {min = 5, max = 10},
	Accuracy = {min = 5, max = 10},
	Kick = {min = -5, max = -10},
	Firerate = {min = 5, max = 10},
	Magazine = {min = 10, max = 15},
	Range = {min = 10, max = 15},
	Weight = {min = -1, max = -3}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_p228"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 772
ITEM.Name = "Raginator"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ragingbull"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 647
ITEM.Name = "Ratisaci"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(0,255,0)
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_msbs"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 631
ITEM.Name = "Ruscelenas"
ITEM.NameColor = Color(245,222,179)
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 1
ITEM.MaxStats = 3
ITEM.Stats = {
	Damage = {min = -2, max = 3},
	Accuracy = {min = -2, max = 2},
	Kick = {min = -2, max = 2},
	Firerate = {min = -3, max = 3},
	Magazine = {min = -7, max = 7},
	Range = {min = -7, max = 8},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_dual_elites"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 778
ITEM.Name = "Semi-Glock-17"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_semiauto"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 634
ITEM.Name = "Shoopan"
ITEM.NameColor = Color(176,196,222)
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_shotgun"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 324
ITEM.Name = "SGLento"
ITEM.NameColor = Color(0, 97, 179)
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 10, max = 25},
	Accuracy = {min = 10, max = 20},
	Kick = {min = 0, max = 10},
    Firerate = {min = -20, max = -30},
	Magazine = {min = 20, max = 30},
	Range = {min = 5, max = 10},
	Weight = {min = 0, max = -20}
}
ITEM.WeaponClass = "weapon_ttt_sg552"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 325
ITEM.Name = "Slowihux"
ITEM.NameColor = Color(212, 44, 151)
ITEM.NameEffect = "glow"
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 10, max = 30},
    Range = {min = 1, max = 10},
    Firerate = {min = -40, max = -50},
	Magazine = {min = 5, max = 10},
}
ITEM.WeaponClass = "weapon_ttt_shotgun"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 780
ITEM.Name = "Space90"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_rcp120"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 12},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 790
ITEM.Name = "Spasinator"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_spas12pvp"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 326
ITEM.Name = "Spray-N-Pray"
ITEM.NameColor = Color(27, 126, 7)
ITEM.NameEffect = "glow"
ITEM.Rarity = 3
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 4
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = -10, max = -30},
    Firerate = {min = 30, max = 60},
	Magazine = {min = 5, max = 10},
    Kick = {min = -1, max = -19}
}
ITEM.WeaponClass = "weapon_ttt_galil"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 793
ITEM.Name = "Stealthano"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_sp"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 633
ITEM.Name = "Taluhoo"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
ITEM.WeaponClass = "weapon_ttt_famas"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1102
ITEM.Name = "The Apprentice"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_mor_bonemold"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Weight = {min = -3, max = -7},
	Chargerate = {min = 22, max = 38}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1100
ITEM.Name = "The Hand"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_mor_daedric"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 8
ITEM.MaxStats = 8
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Weight = {min = -5, max = -7},
	Chargerate = {min = 34, max = 56}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1101
ITEM.Name = "The Master"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_mor_auriel"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Weight = {min = -4, max = -7},
	Chargerate = {min = 28, max = 46}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 640
ITEM.Name = "The Deliverer"
ITEM.NameColor = Color(0,128,0)
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
ITEM.WeaponClass = "weapon_ttt_deliverer"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 775
ITEM.Name = "Trenchinator"
ITEM.Rarity = 2
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_m590"
ITEM.MinStats = 2
ITEM.MaxStats = 4
ITEM.Stats = {
	Damage = {min = 0, max = 5},
	Accuracy = {min = 0, max = 5},
	Kick = {min = -1, max = -5},
	Firerate = {min = 0, max = 5},
	Magazine = {min = 5, max = 10},
	Range = {min = 5, max = 10}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = {"random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 770
ITEM.Name = "Trusty Steed"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_supershotty"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 4, max = 8},
	Accuracy = {min = 5, max = 12},
	Kick = {min = -8, max = -15},
	Firerate = {min = 10, max = 30},
	Magazine = {min = 8, max = 15},
	Range = {min = 30, max = 60},
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1121
ITEM.Name = "Berattapo"
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_m9"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1122
ITEM.Name = "Counterpart"
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_mp5"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1123
ITEM.Name = "Camoldaci"
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_m14"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1124
ITEM.Name = "Frenchi"
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_famas"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1125
ITEM.Name = "Heavina"
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_sg550"
ITEM.MinStats = 4
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 8, max = 15},
	Accuracy = {min = 8, max = 15},
	Kick = {min = -8, max = -15},
	Firerate = {min = 8, max = 15},
	Magazine = {min = 13, max = 20},
	Range = {min = 13, max = 20},
	Weight = {min = -2, max = -5}
}
ITEM.MinTalents = 1
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1126
ITEM.Name = "Ectopati"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_1911"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1127
ITEM.Name = "Slypinu"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_m9s"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1128
ITEM.Name = "Obicanobi"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_g36c"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1129
ITEM.Name = "Big Deal"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_deagle"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1130
ITEM.Name = "Blastinati"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_benelli"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1131
ITEM.Name = "Goonstar"
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_mac"
ITEM.MinStats = 5
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 2
ITEM.Talents = {"random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1132
ITEM.Name = "Jungle Tap"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_fal"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1133
ITEM.Name = "Cheng Feng"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_cf05"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1134
ITEM.Name = "Annihilator"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_g36c"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1135
ITEM.Name = "Sharpisto"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_ots33"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1136
ITEM.Name = "Deadeye"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_m24"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1137
ITEM.Name = "Policia"
ITEM.NameEffect = "glow"
ITEM.Rarity = 6
ITEM.Collection = "Titan Collection"
ITEM.WeaponClass = "weapon_ttt_te_glock"
ITEM.MinStats = 6
ITEM.MaxStats = 6
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1138
ITEM.Name = "Bond's Best Peep"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_deagle"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 28, max = 45},
	Accuracy = {min = 40, max = 75},
	Kick = {min = -17, max = -28},
	Firerate = {min = 20, max = 38},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1139
ITEM.Name = "MachitoP5"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_vollmer"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1140
ITEM.Name = "Akaline Killer"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_ak47"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1141
ITEM.Name = "Beastmode"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_m4a1"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1142
ITEM.Name = "Trepaci"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_sterlings"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1143
ITEM.Name = "Trepaco"
ITEM.NameEffect = "glow"
ITEM.Rarity = 7
ITEM.WeaponClass = "weapon_ttt_te_sterling"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 3
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1144
ITEM.Name = "Warriochi"
ITEM.NameEffect = "glow"
ITEM.Rarity = 9
ITEM.WeaponClass = "weapon_ttt_te_sako"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 1145
ITEM.Name = "Astronado"
ITEM.NameEffect = "glow"
ITEM.Rarity = 9
ITEM.WeaponClass = "weapon_ttt_te_sr25"
ITEM.Collection = "Titan Collection"
ITEM.MinStats = 7
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 17, max = 28},
	Accuracy = {min = 17, max = 28},
	Kick = {min = -17, max = -28},
	Firerate = {min = 17, max = 28},
	Magazine = {min = 23, max = 33},
	Range = {min = 23, max = 33},
	Weight = {min = -5, max = -7}
}
ITEM.MinTalents = 4
ITEM.MaxTalents = 4
ITEM.Talents = {"random", "random", "random", "random"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 16
ITEM.Name = "Volcanica"
ITEM.NameColor = Color(255, 0, 0)
ITEM.NameEffect = "glow"
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.WeaponClass = "weapon_ttt_ak47"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "Inferno"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 645
ITEM.Name = "Westernaci"
ITEM.NameEffect = "glow"
ITEM.NameColor = Color(218,165,32)
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.MinStats = 6
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 14, max = 23},
	Accuracy = {min = 14, max = 23},
	Kick = {min = -14, max = -23},
	Firerate = {min = 14, max = 23},
	Magazine = {min = 19, max = 28},
	Range = {min = 19, max = 28},
	Weight = {min = -4, max = -7}
}
ITEM.MinTalents = 2
ITEM.MaxTalents = 3
ITEM.Talents = {"random", "random", "random"}
ITEM.WeaponClass = "weapon_ttt_mr96"
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.ID = 300
ITEM.Name = "Zeusitae"
ITEM.NameColor = Color(255, 255, 0)
ITEM.NameEffect = "glow"
ITEM.Rarity = 5
ITEM.Collection = "Beta Collection"
ITEM.MinStats = 5
ITEM.MaxStats = 7
ITEM.Stats = {
	Damage = {min = 11, max = 19},
	Accuracy = {min = 11, max = 19},
	Kick = {min = -11, max = -19},
	Firerate = {min = 11, max = 19},
	Magazine = {min = 16, max = 24},
	Range = {min = 16, max = 24},
	Weight = {min = -3, max = -7}
}
ITEM.WeaponClass = "weapon_zm_revolver"
ITEM.MinTalents = 1
ITEM.MaxTalents = 1
ITEM.Talents = { "Tesla"}
m_AddDroppableItem(ITEM, 'Unique')

ITEM = {}
ITEM.Name = "Ascended Stat Mutator"
ITEM.ID = 4006
ITEM.Description = "Using this item allows you to re-roll the stats of any Ascended item"
ITEM.Rarity = 6
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 80000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/6ebf091ece6172a692c640204464d839.png"
ITEM.ItemCheck = 7
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Ascended Talent Mutator"
ITEM.ID = 4003
ITEM.Description = "Using this item allows you to re-roll the talents of any Ascended item. This will reset the item's LVL and XP"
ITEM.Rarity = 6
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 80000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/ascended_talent64.png"
ITEM.ItemCheck = 3
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Cosmic Stat Mutator"
ITEM.ID = 4007
ITEM.Description = "Using this item allows you to re-roll the stats of any Cosmic item"
ITEM.Rarity = 7
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 350000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/cosmic_stat64.png"
ITEM.ItemCheck = 6
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Cosmic Talent Mutator"
ITEM.ID = 4002
ITEM.Description = "Using this item allows you to re-roll the talents of any Cosmic item. This will reset the item's LVL and XP"
ITEM.Rarity = 7
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 350000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/cosmic_talent64.png"
ITEM.ItemCheck = 2
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 13
ITEM.Name = "Detective Token"
ITEM.Description = "Use this item during the preparing phase to be guaranteed to be a Detective next round"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.ShopDesc = "Become a Detective on the next round!\n(Purchasing will give you a one-time Detective Token usable)"
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/detective_token.png"
ROLE_TOKEN_PLAYERS = ROLE_TOKEN_PLAYERS or {}
ITEM.ItemUsed = function(pl, slot, item)
	if (not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		ROLE_TOKEN_PLAYERS[pl] = ROLE_DETECTIVE
	end
end
hook.Add("TTTBeginRound", "RoleTokens", function()
    timer.Simple(3,function()
        for k,v in pairs(ROLE_TOKEN_PLAYERS) do
            if not IsValid(k) then continue end
            if (ROLE_TOKEN_PLAYERS[k] == ROLE_DETECTIVE) and k:IsTraitor() then continue end
            k:SetRole(v)
            ROLE_TOKEN_PLAYERS[k] = nil
        end
    end)
end)
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Dog Talent Mutator"
ITEM.ID = 4082
ITEM.Description = "Using this item will add the Dog Lover talent to any weapon. It will replace the tier two talent if one already exists. Only 200 of these mutators can be produced."
ITEM.Rarity = 8
ITEM.Collection = "Limited Collection"
ITEM.Image = "https://static.moat.gg/f/name_mutator64.png"
ITEM.ItemCheck = 4
ITEM.ItemUsed = function(pl, slot, item)
	m_AssignDogLover(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 7821
ITEM.Name = "Gift Package"
ITEM.Description = "I wonder what's inside?"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.Collection = "Gift Collection"
ITEM.Image = "https://static.moat.gg/f/present.png"
ITEM.Preview = false
ITEM.CrateShopOverride = "Gift"
ITEM.ItemUsed = function(pl, slot, item)
	local ply_inv = MOAT_INVS[pl]
	if (not ply_inv) then return end
	local i = ply_inv["slot" .. slot]
	if (not i) then return end
	if (not i.g) then return end
	pl:m_AddInventoryItem(i.g, nil, false, true)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 7820
ITEM.Name = "Empty Gift Package"
ITEM.Description = "Right click to insert an item into the gift package"
ITEM.Rarity = 0
ITEM.Active = true
ITEM.Price = 5000
ITEM.Collection = "Gift Collection"
ITEM.Image = "https://static.moat.gg/f/present-empty.png"
ITEM.ItemCheck = 13
ITEM.Preview = false
ITEM.CrateShopOverride = "Gift"
ITEM.ItemUsed = function(pl, slot, item, cslot, citem)
	return MOAT_GIFTS.UseEmptyGift(pl, slot, item, cslot, citem)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 7101
ITEM.Name = "Santa's Present"
ITEM.Description = "Every player will receive a Holiday Crate when this item is used"
ITEM.ShopDesc = "Every player will receive a Holiday Crate when this item is used!"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.NewItem = 1577779200
ITEM.Price = 50000
ITEM.Collection = "Santa's Collection"
ITEM.Image = "https://static.moat.gg/f/gift_usable64.png"
ITEM.ItemUsed = function(pl, slot, item)
	for k, v in pairs(player.GetAll()) do
		v:m_DropInventoryItem("Holiday Crate")
	end
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "High-End Stat Mutator"
ITEM.ID = 4008
ITEM.Description = "Using this item allows you to re-roll the stats of any High-End item"
ITEM.Rarity = 5
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 10000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/highend_stat64.png"
ITEM.ItemCheck = 8
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "High-End Talent Mutator"
ITEM.ID = 4004
ITEM.Description = "Using this item allows you to re-roll the talents of any High-End item. This will reset the item's LVL and XP"
ITEM.Rarity = 5
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 10000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/highend_talent64.png"
ITEM.ItemCheck = 4
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Apache Token"
ITEM.ID = 4801
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/apache_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Apache Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Stalker Token"
ITEM.ID = 4810
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/stalker_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Stalker Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Team Deathmatch Token"
ITEM.ID = 4811
ITEM.Description = "You have two teams, but only use one loadout. Fair game, first team to reach the winning kill limit wins, with the highest damage player getting the top prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/tdm_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Team Deathmatch", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "TNT Token"
ITEM.ID = 4812
ITEM.Description = "Hot-potato style minigame! Be the last alive to win the best prizes"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/tnt_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "TNT-Tag Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Zombie Token"
ITEM.ID = 4813
ITEM.Description = "Hide and kill the contagion to be the last survivor"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/zombie_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Contagion Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Boss Token"
ITEM.ID = 4802
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/boss_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Deathclaw Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Cock Token"
ITEM.ID = 4803
ITEM.Description = "Expoding chickens will spawn on everybody. Be the last alive to win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/cock_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Apache Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Dragon Token"
ITEM.ID = 4804
ITEM.Description = "Team up with every player to defeat the boss for a prize"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/dragon_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Dragon Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Deathmatch Token"
ITEM.ID = 4805
ITEM.Description = "First player to reach the winning kill count gets the top prize! Everybody must compete in a free-for-all shootout with the same guns"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/ffa_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "FFA Round", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Knife Token"
ITEM.ID = 4806
ITEM.Description = "Each player starts with the same weapon. Kill to advance wepaons"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/knife_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Gun Game", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Lava Token"
ITEM.ID = 4807
ITEM.Description = "The floor is lava! Be the last alive to win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/lava_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "The Floor is Lava", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "One Token"
ITEM.ID = 4808
ITEM.Description = "Everybody has a one bullet gun, gain an extra bullet by taking somebody's life. You have 3 lives and the last man standing wins"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/one_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "One in the Chamber", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Seek Token"
ITEM.ID = 4809
ITEM.Description = "Classic prop hunt! Randomly be a prop or a hunter, only one team can win"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/seek_token.png"
ITEM.SafetyCheck = 15
ITEM.ItemUsed = function(pl, slot, item, str)
	MSE.Events.CanStart(pl, "Prop Hunt", {"self"})
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 8980
ITEM.Name = "Easter Egg Memories"
ITEM.Description = "A usable capable of summoning an easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Egg Hunt Collection"
ITEM.Image = "https://static.moat.gg/f/easter_eggold64.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 8981
ITEM.Name = "Easter Egg of Past"
ITEM.Description = "A usable capable of summoning an easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Egg Hunt Collection"
ITEM.Image = "https://static.moat.gg/f/easter_eggold64.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 8983
ITEM.Name = "Old Timey Easter Egg"
ITEM.Description = "A usable capable of summoning an easter egg"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.Price = 100
ITEM.Collection = "Egg Hunt Collection"
ITEM.Image = "https://static.moat.gg/f/easter_eggold64.png"
ITEM.ItemUsed = function(pl, slot, item)
	pl:m_DropInventoryItem("Easter Egg")
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Name Mutator"
ITEM.ID = 4001
ITEM.Description = "Using this item allows you to change the name of any equippable item in your inventory"
ITEM.Rarity = 8
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 50000
ITEM.Collection = "Gamma Collection"
ITEM.CrateShopOverride = "Name Mutator"
ITEM.Image = "https://static.moat.gg/ttt/2499888427.png"
ITEM.ItemCheck = 1
ITEM.ItemUsed = function(pl, slot, item, str)
	str = sql.SQLStr(str, true)
	str = string.Replace(str,"\n","")
	str = string.Replace(str,"\r","")
	str = string.Replace(str,"\\","")
	str = string.sub(str, 0, 100)
	MOAT_INVS[pl]["slot" .. slot].n = str
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Planetary Stat Mutator"
ITEM.ID = 4009
ITEM.Description = "Using this item allows you to re-roll the stats of any Planetary item"
ITEM.Rarity = 9
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 600000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/planetary_stat64.png"
ITEM.ItemCheck = 9
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetStats(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Planetary Talent Mutator"
ITEM.ID = 4005
ITEM.Description = "Using this item allows you to re-roll the talents of any Planetary item. This will reset the item's LVL and XP"
ITEM.Rarity = 9
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 600000
ITEM.Collection = "Gamma Collection"
ITEM.Image = "https://static.moat.gg/f/planetary_talent64.png"
ITEM.ItemCheck = 5
ITEM.ItemUsed = function(pl, slot, item)
	m_ResetTalents(pl, slot, item)
    m_SendInvItem(pl, slot)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 10
ITEM.Name = "Traitor Token"
ITEM.Description = "Use this item during the preparing phase to be guaranteed to be a Traitor next round"
ITEM.Rarity = 0
ITEM.Active = false
ITEM.NewItem = 1575878400
ITEM.Price = 75000
ITEM.ShopDesc = "Become a Traitor on the next round!"
ITEM.Collection = "Supreme Collection"
ITEM.Image = "https://static.moat.gg/ttt/traitor_token.png"
ROLE_TOKEN_PLAYERS = ROLE_TOKEN_PLAYERS or {}
ITEM.ItemUsed = function(pl, slot, item)
	if (not GetGlobal("MOAT_MINIGAME_ACTIVE")) then
		ROLE_TOKEN_PLAYERS[pl] = ROLE_TRAITOR
	end
end
hook.Add("TTTBeginRound", "RoleTokens", function()
    timer.Simple(3,function()
        for k,v in pairs(ROLE_TOKEN_PLAYERS) do
            if not IsValid(k) then continue end
            if (ROLE_TOKEN_PLAYERS[k] == ROLE_DETECTIVE) and k:IsTraitor() then continue end
            k:SetRole(v)
            ROLE_TOKEN_PLAYERS[k] = nil
        end
    end)
end)
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 17
ITEM.Name = "VIP Token"
ITEM.Description = "Using this will grant VIP rank benefits permanently!"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://static.moat.gg/ttt/vip_token.png"
ITEM.Active = false
-- Will only be able to be bought with SC, not done yet. Just pushing votekick meme
//Buying VIP for your friends or trading it for IC is about to be way easier! People that already own VIP will be able to purchase VIP tokens that are able to be traded!
ITEM.ItemUsed = function(pl, slot, item)
	moat_makevip(pl:SteamID64())
	m_AddCreditsToSteamID(pl:SteamID(), 17000)
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 75
ITEM.Name = "Vape Event Token"
ITEM.Description = "Using this will drop every player on the server a Random Vape Item!"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://static.moat.gg/ttt/vape_event128.png"
ITEM.Active = false
ITEM.ItemUsed = function(pl, slot, item)
	for k, v in ipairs(player.GetAll()) do
		v:m_DropInventoryItem(randomvape(), "hide_chat_obtained", false, false)
	end
	local msg = string(":gift: " .. style.Bold(pl:Nick()) .. style.Dot(style.Code(pl:SteamID())) .. style.Dot(pl:SteamURL()), style.NewLine(":tada: Just dropped everybody a ") .. style.BoldUnderline("Random Vape") .. " on " .. string.Extra(GetServerName(), GetServerURL()))
	discord.Send("Moat TTT Announcement", markdown.WrapBold(string(":satellite_orbital::satellite: ", markdown.Bold"Global TTT Announcement", " :satellite::satellite_orbital:", markdown.LineStart(msg))))
	discord.Send("Events", msg)
	discord.Send("Event", msg)
	net.Start "D3A.Chat2"
		net.WriteBool(false)
		net.WriteTable({Color(0, 255, 0), pl:Nick(), Color(255, 255, 255), " just dropped everybody a ", Color(0, 255, 0), "Random Vape", Color(255, 255, 255), "!"})
	net.Broadcast()
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.ID = 76
ITEM.Name = "Dola Event Token"
ITEM.Description = "Using this will drop every player on the server the Dola Effect Item!"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://static.moat.gg/ttt/dola_drop_event.png"
ITEM.Active = false
ITEM.ItemUsed = function(pl, slot, item)
	for k, v in ipairs(player.GetAll()) do
		v:m_DropInventoryItem("Dola Effect", "hide_chat_obtained", false, false)
	end
	local msg = string(":gift: " .. style.Bold(pl:Nick()) .. style.Dot(style.Code(pl:SteamID())) .. style.Dot(pl:SteamURL()), style.NewLine(":tada: Just dropped everybody a ") .. style.BoldUnderline("Dola Effect") .. " on " .. string.Extra(GetServerName(), GetServerURL()))
	discord.Send("Moat TTT Announcement", markdown.WrapBold(string(":satellite_orbital::satellite: ", markdown.Bold"Global TTT Announcement", " :satellite::satellite_orbital:", markdown.LineStart(msg))))
	discord.Send("Events", msg)
	discord.Send("Event", msg)
	net.Start "D3A.Chat2"
		net.WriteBool(false)
		net.WriteTable({Color(0, 255, 0), pl:Nick(), Color(255, 255, 255), " just dropped everybody a ", Color(0, 255, 0), "Dola Effect", Color(255, 255, 255), "!"})
	net.Broadcast()
end
m_AddDroppableItem(ITEM, 'Usable')

ITEM = {}
ITEM.Name = "Angry Shoe"
ITEM.ID = 805
ITEM.Description = "A shoe you can annoy and distract enimes with"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_angryhobo"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Babynade"
ITEM.ID = 806
ITEM.Description = "A throwable baby that explodes like dynamite"
ITEM.Rarity = 6
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_babynade"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Contagio"
ITEM.ID = 1104
ITEM.Description = "A throwable ball of contagious. Infected targets take %s damage every ^%s seconds ^%s times"
ITEM.Rarity = 5
ITEM.Collection = "Titan Collection"
ITEM.Stats = {
	{min = 3, max = 5},
	{min = 3, max = 6},
	{min = 5, max = 10}
}
ITEM.WeaponClass = "weapon_acidball"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Confusionade"
ITEM.ID = 701
ITEM.Description = "A throwable grenade that discombobulates enimies %s_ more than a regular discombobulator"
ITEM.Rarity = 4
ITEM.Collection = "Spring Collection"
ITEM.Stats = {
	{min = 25, max = 100}
}
ITEM.WeaponClass = "weapon_ttt_confgrenade"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 7036
ITEM.Name = "Frozen Snowball"
ITEM.Description = "A deadly snowball made of hard ice probably"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.WeaponClass = "snowball_harmful"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Glacies"
ITEM.ID = 1105
ITEM.Description = "A throwable ball of frost. Targets are frozen for %s seconds, slowing their speed by ^%s_ percent, and apply 2 damage every ^%s seconds"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
ITEM.Stats = {
	{min = 15, max = 30},
	{min = 25, max = 50},
	{min = 5, max = 8}
}
ITEM.WeaponClass = "weapon_frostball"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Ignis"
ITEM.ID = 1106
ITEM.Description = "A throwable ball of inferno. Targets are ignited for %s seconds, applying 1 damage every 0.2 seconds"
ITEM.Rarity = 7
ITEM.Collection = "Titan Collection"
ITEM.Stats = {
	{min = 4, max = 8}
}
ITEM.WeaponClass = "weapon_fireball"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Molotovian"
ITEM.ID = 726
ITEM.Description = "A molotov grenade that lasts %s_ longer than a regular molotov grenade."
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.Stats = {
	{min = 25, max = 100}
}
ITEM.WeaponClass = "weapon_zm_molotov"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "A Random Vape"
ITEM.ID = 969
ITEM.Description = "Shouldn't be in inventory"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "Shouldn't be in inventory"
ITEM.WeaponClass = "weapon_ttt_unarmed"
ITEM.Price = 64999
ITEM.LimitedShop = 1589785200
ITEM.ShopDesc = "For a limited time, you can purchase a random vape!\nYou also have a chance to get a Mega Vape!"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Smokinator"
ITEM.ID = 725
ITEM.Description = "A smoke grenade that's %s_ more dense than a regular smoke grenade"
ITEM.Rarity = 3
ITEM.Collection = "Spring Collection"
ITEM.Stats = {
	{min = 25, max = 100}
}
ITEM.WeaponClass = "weapon_ttt_smokegrenade"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 7019
ITEM.Name = "Snowball"
ITEM.Description = "I think your snow is too soft or something, cause this thing ain't killing anyone"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
ITEM.WeaponClass = "snowball_harmless"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Stealth Box"
ITEM.ID = 807
ITEM.Description = "A box you can use to hide from enimes. Crouching makes the box completely still"
ITEM.Rarity = 7
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_stealthbox"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Agree Taunt"
ITEM.ID = 710
ITEM.Description = "I concur doctor"
ITEM.Rarity = 2
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_agree"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Call For Taunt"
ITEM.ID = 711
ITEM.Description = "Come over here please"
ITEM.Rarity = 3
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_beacon"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Bow Taunt"
ITEM.ID = 712
ITEM.Description = "Thank you very much, I know I'm awesome"
ITEM.Rarity = 3
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_bow"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Cheer Taunt"
ITEM.ID = 713
ITEM.Description = "WOOOOO"
ITEM.Rarity = 4
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_cheer"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Dab Taunt"
ITEM.ID = 714
ITEM.Description = "Hit em with it"
ITEM.Rarity = 7
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_dab"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Disagree Taunt"
ITEM.ID = 715
ITEM.Description = "I don't think so"
ITEM.Rarity = 2
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_disagree"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Flail Taunt"
ITEM.ID = 716
ITEM.Description = "Asdfghjkl;'"
ITEM.Rarity = 5
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_flail"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Hands Up Taunt"
ITEM.ID = 717
ITEM.Description = "Please don't shoot me"
ITEM.Rarity = 4
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_hands"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Laugh Taunt"
ITEM.ID = 718
ITEM.Description = "haHA"
ITEM.Rarity = 5
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_laugh"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Play Dead Taunt"
ITEM.ID = 719
ITEM.Description = "Too bad you don't get a treat for this one diggity dog"
ITEM.Rarity = 6
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_lay"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Robot Taunt"
ITEM.ID = 720
ITEM.Description = "Beep boop beep bop beep"
ITEM.Rarity = 6
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_robot"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Salute Taunt"
ITEM.ID = 721
ITEM.Description = "Press F to pay respects"
ITEM.Rarity = 3
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_salute"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Sexy Taunt"
ITEM.ID = 722
ITEM.Description = "Work that big booty of yours you sexy thang"
ITEM.Rarity = 7
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_sexy"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Wave Taunt"
ITEM.ID = 723
ITEM.Description = "Hey Guys"
ITEM.Rarity = 4
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_wave"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Zombie Climb Taunt"
ITEM.ID = 724
ITEM.Description = "Best dance move eva"
ITEM.Rarity = 7
ITEM.Image = "https://static.moat.gg/f/16945b3954d42dceea858fb9a7eaf1ca.png"
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_ttt_taunt_climb"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Dynamite"
ITEM.ID = 808
ITEM.Description = "A throwable set of TNT that detonates a few seconds after being thrown"
ITEM.Rarity = 5
ITEM.Collection = "Spring Collection"
ITEM.WeaponClass = "weapon_virustnt"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "American Vape"
ITEM.ID = 900
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 2017 Collection"
ITEM.WeaponClass = "weapon_vape_american"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "USA American Vape"
ITEM.ID = 2580
ITEM.Description = "A patriotic vape made in honor of President Trump"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "Independence Collection"
ITEM.WeaponClass = "weapon_vape_american"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Butterfly Vape"
ITEM.ID = 901
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_butterfly"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Custom Vape"
ITEM.ID = 902
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_custom"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Dragon Vape"
ITEM.ID = 903
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_dragon"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Golden Vape"
ITEM.ID = 904
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_golden"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Hallucinogenic Vape"
ITEM.ID = 905
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_hallucinogenic"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Helium Vape"
ITEM.ID = 906
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_helium"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Juicy Vape"
ITEM.ID = 907
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_juicy"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Medicinal Vape"
ITEM.ID = 908
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape_medicinal"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "Mega Vape"
ITEM.ID = 909
ITEM.Description = "An exclusive collectors item. Causes BIG smoke every 30 minutes, just like a very expensive smoke grenade if you think about it"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "Limited Collection"
ITEM.WeaponClass = "weapon_vape_mega"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.Name = "White Vape"
ITEM.ID = 910
ITEM.Description = "A special item given to people as a remembrance of 4/20"
ITEM.Rarity = 8
ITEM.Image = "https://static.moat.gg/f/18af240dd3af16fb834cf9e1e5372a6d.png"
ITEM.Collection = "4/20 - 2017 Collection"
ITEM.WeaponClass = "weapon_vape"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 7020
ITEM.Name = "Christmas Flash"
ITEM.Description = "Don't blink, you might miss santa claus"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.WeaponClass = "weapon_xmasflash"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 7021
ITEM.Name = "Christmas Frag"
ITEM.Description = "Don't run away, you might miss santa claus"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.WeaponClass = "weapon_xmasfrag"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 7022
ITEM.Name = "Christmas Smoke"
ITEM.Description = "Don't get lost in the smoke, you might miss santa claus"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.WeaponClass = "weapon_xmassmoke"
m_AddDroppableItem(ITEM, 'Special')

ITEM = {}
ITEM.ID = 213
ITEM.Name = "Black Hole Effect"
ITEM.Description = "The center of the universe"
ITEM.Model = "models/effects/vol_light128x128.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/effects/portalrift_sheet")
	local MAngle = Angle(90,0,277.0)
	local MPos = Vector(23.26,-2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = ((CurTime() * 0.5) * 0 *90)
	model.ModelDrawingAngle.y = ((CurTime() * 0.5) * 2.60 *90)
	model.ModelDrawingAngle.r = ((CurTime() * 0.5) * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
	
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Black Ice Effect"
ITEM.ID = 215
ITEM.Description = "Don't drive on this"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_junk/cinderblock01a.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,255,255)
ITEM.EffectSize = 6.9
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.349,0.300,0.129)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_combine/citadel_cable")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(2.609,0,8.22)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.169 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Blue Data Effect"
ITEM.ID = 216
ITEM.Description = "This is what's left from the DDoS attack"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/computer_caseb_p3b.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,119,255)
ITEM.EffectSize = 3.6
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1.299,2,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_combine/combine_interface_disp")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(0,0,-0.0399)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Burger Effect"
ITEM.ID = 217
ITEM.Description = "Welcome to good burger, home of the good burger, can I take your order"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/food/burger.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(241,151,17)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(100.1699,360,280.1700)
	local MPos = Vector(-5.829,-2.609,-7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Robot Effect"
ITEM.ID = 218
ITEM.Description = "Boop beep bop boop"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/perftest/loader.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectHalo = Color(255, 204, 0)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.0299,0.0299,0.0299)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(84.519,0,275.4800)
	local MPos = Vector(5.219,-2.609,-5.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Combine Ball Effect"
ITEM.ID = 219
ITEM.Description = "Stop right there civilian scum"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/combineball.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.3000,0.3000,0.3000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(84.5199,173.7400,97.04000)
	local MPos = Vector(5.2199,-0.6100,-8.2200)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 10 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Confusion Effect"
ITEM.ID = 220
ITEM.Description = "uh ... huh"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/vol_light.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.2000,0.1000,0.0199)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/effects/splodearc_sheet")
	local MAngle = Angle(93.9100,0,266.08999)
	local MPos = Vector(-4.570,-0.219,-0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "WASD Effect"
ITEM.ID = 221
ITEM.Description = "Just use WASD"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_train/bush.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.100,0.100,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props/cs_assault/moneywrap")
	local MAngle = Angle(90.7799,0,264.519)
	local MPos = Vector(-5.780,2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.090 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Developer Effect"
ITEM.ID = 222
ITEM.Description = "Time for the dev to get sxy"
ITEM.Rarity = 8
ITEM.Collection = "Dev Collection"
ITEM.Model = "models/props_c17/tools_wrench01a.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(250,255,0)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.8000, 0.5, 0.5)
	local mat = Matrix()
	local CT = CurTime()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/gibs/metalgibs/metal_gibs")
	local MAngle = Angle(236.35000,277.04002,360)
	local MPos = Vector(10.22000,-1,-8.220)
	pos = pos + ang:Forward() * MPos.x + ang:Up() * MPos.z + ang:Right() * MPos.y
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = CT * 0 * 90
	model.ModelDrawingAngle.y = CT * 1.129 * 90
	model.ModelDrawingAngle.r = CT * 1.039 * 90
	ang:RotateAroundAxis(ang:Forward(), model.ModelDrawingAngle.p)
	ang:RotateAroundAxis(ang:Up(), model.ModelDrawingAngle.y)
	ang:RotateAroundAxis(ang:Right(), model.ModelDrawingAngle.r)
	return model, pos, ang
end



m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Diamond Effect"
ITEM.ID = 223
ITEM.Description = "Shine bright"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/hgibs.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,255,255)
ITEM.EffectSize = 2
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.60000,0.6000,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/wireframe")
	local MAngle = Angle(95.48000,180,65.739)
	local MPos = Vector(2.6099,2.6099,7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0.827 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0.829 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.779 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Donut Effect"
ITEM.ID = 224
ITEM.Description = "This donut reminds me so much of Homer from the Simpsons"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/noesis/donut.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,0,238)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.30000,0.3000,0.3000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(236.350,187.8300,275.4800)
	local MPos = Vector(6.219999,-1,-7.2199)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Dr. Danger Effect"
ITEM.ID = 225
ITEM.Description = "Woooah watch out guys"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_wasteland/prison_toiletchunk01j.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,238,0)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.8000,0.800,0.80000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/stripes")
	local MAngle = Angle(0,101.739,78.2600)
	local MPos = Vector(10.4300,-3.609,0.6101)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Explosion Effect"
ITEM.ID = 226
ITEM.Description = "This is so pretty"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/strider_gib3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,97,0)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/effects/splode_sheet")
	local MAngle = Angle(0,101.7399,78.260)
	local MPos = Vector(10.4300,0.610,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Duhaf Effect"
ITEM.ID = 227
ITEM.Description = "What the duhaf"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/strider_gib3.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,255,63)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/wire/pcb_green")
	local MAngle = Angle(0,101.7399,78.260)
	local MPos = Vector(10.430,0.6100,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "dungo Effect"
ITEM.ID = 228
ITEM.Description = "Stop looking at me"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/gibs/antlion_gib_large_2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(190,255,125)
ITEM.EffectSize = 4.3
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.400,0.400,0.400)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/camera")
	local MAngle = Angle(266.0899,0,272.3500)
	local MPos = Vector(4.219,2,-10.430)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Editor Effect"
ITEM.ID = 229
ITEM.Description = "Use this to help you edit your life"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/editor/axis_helper_thick.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,17,255)
ITEM.EffectSize = 2.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.3000,0.3000,0.3000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(264.5199,180,97.040)
	local MPos = Vector(4.6100,-1.6100,7.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.740 *90)
	model.ModelDrawingAngle.r = (CurTime() * 1.779 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "GMan Effect"
ITEM.ID = 230
ITEM.Description = "Good morning Mr. Freeman"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/perftest/gman.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(124,113,175)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.1500,0.1500,0.1500)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(92.349,0,280.170)
	local MPos = Vector(3.609,-2.609,7.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Koi Effect"
ITEM.ID = 231
ITEM.Description = "Just keep swimming, just keep swimming swimming swimming"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_inferno/goldfish.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(241,17,17)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,350.609,269.220)
	local MPos = Vector(7.8299,-2.6099,-10.430)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Holy Effect"
ITEM.ID = 233
ITEM.Description = ":O WOAH"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/vol_light128x128.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(90,0,277.0400)
	local MPos = Vector(23.260,-2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.609 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Horse Effect"
ITEM.ID = 234
ITEM.Description = "Neighhhh"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_phx/games/chess/white_knight.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,231,159)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.2000,0.2000,0.2000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,0,269.649)
	local MPos = Vector(3.2200,-2.6099,-7.8299)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.2593 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Hotdog Effect"
ITEM.ID = 235
ITEM.Description = "Hotdogs here! Get your hotdogs"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/food/hotdog.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(241,151,17)
ITEM.EffectSize = 6.5
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.699,0.699,0.699)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(100.1699,360,280.170)
	local MPos = Vector(-2.609,-2.609,-7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Huladoll Effect"
ITEM.ID = 236
ITEM.Description = "That's racist to my culture sir"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/huladoll.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(17,241,84)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(100.1699,360,280.1700)
	local MPos = Vector(5.219,-2.6099,-7.8299)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Snowman Effect"
ITEM.ID = 237
ITEM.Description = "Frosty the snowman was jolly good fellow"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/snowman_face.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,255,255)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.4000,0.4000,0.4000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(1.5701,0,264.519)
	local MPos = Vector(7.829,-1,-7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "ILLIN Effect"
ITEM.ID = 238
ITEM.Description = "That's sick"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_phx/gibs/flakgib1.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(146,202,255)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/alyx/emptool_glow")
	local MAngle = Angle(0,0,269.649)
	local MPos = Vector(13.039,0.610,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.259 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Lamar Effect"
ITEM.ID = 239
ITEM.Description = "Wazzup people"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/nova/w_headcrab.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,204,0)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(173.740,286.429,84.51)
	local MPos = Vector(4.61,-1.61,7.21)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "LAPIZ Effect"
ITEM.ID = 240
ITEM.Description = "Oh great, another Minecraft reference"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_wasteland/prison_toiletchunk01j.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(29,0,255)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.80,0.80,0.80)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/blue_steel")
	local MAngle = Angle(0,101.739,78.260)
	local MPos = Vector(10.436,-3.60,0.610)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.870 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "L.F. Effect"
ITEM.ID = 241
ITEM.Description = "This only helps you if you're drowning"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_nuke/lifepreserver.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.5,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(95.480,360,178.429)
	local MPos = Vector(-2.609,0,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0.910 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Potke Effect"
ITEM.ID = 242
ITEM.Description = "You a sexy motherfucka"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/shadertest/vertexlittextureplusenvmappedbumpmap.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(0,246,255)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.150,0.150,0.150)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(86.089,3.130,280.17)
	local MPos = Vector(2.60,-2,6.21)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "lovd Effect"
ITEM.ID = 243
ITEM.Description = "Why can't you lovd me"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/pipesystem03d.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,0,255)
ITEM.EffectSize = 4
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/items/boxsniperrounds")
	local MAngle = Angle(93.910,0,164.350)
	local MPos = Vector(14.039,-1.220,-0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 2.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "M Effect"
ITEM.ID = 244
ITEM.Description = "Not any other letter"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_rooftop/sign_letter_m001.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,85,0)
ITEM.EffectSize = 2
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.303,0.303,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_lab/Tank_Glass001")
	local MAngle = Angle(92.349,180.570,101.349)
	local MPos = Vector(10.430,0,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.869 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Mage Effect"
ITEM.ID = 245
ITEM.Description = "Nice magic"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/noesis/donut.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("debug/env_cubemap_model")
	local MAngle = Angle(0,100,91)
	local MPos = Vector(3,-9.2600,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.129 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Math Effect"
ITEM.ID = 246
ITEM.Description = "I was never good at math, but hey, I made this description"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/bindergreen.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1.01999,4.2199,1.0393)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/wireframe")
	local MAngle = Angle(180,0,269.220)
	local MPos = Vector(-2.390,2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0.959 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Metrocop Effect"
ITEM.ID = 248
ITEM.Description = "Not as cool as Robocop"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/nova/w_headgear.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,255,255)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.5,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(92.3499,270.779,360)
	local MPos = Vector(6.219,-1,-7.2197)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.ID = 212
ITEM.Name = "Dola Effect"
ITEM.Description = "A special item given as a thanks to the sugar daddies of MG"
ITEM.Model = "models/props/cs_assault/money.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Sugar Daddy Collection"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(148,192,72)
ITEM.EffectSize = 10
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,2.849)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(95.480,180,65.739)
	local MPos = Vector(2.609,0,-7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0.610 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Trees Effect"
ITEM.ID = 249
ITEM.Description = "God of trees"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_foliage/tree_springers_card_01_skybox.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.20,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(95.480,180,90)
	local MPos = Vector(-5.219,-2.609,2.609)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Nature Effect"
ITEM.ID = 250
ITEM.Description = "God of nature"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/pi_shrub.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.200,0.200,0.200)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(95.480,180,90)
	local MPos = Vector(14.039,0,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.039 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Pantom Effect"
ITEM.ID = 251
ITEM.Description = "You're a fucking demon"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/miniteleportarc.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/effects/comball_glow1")
	local MAngle = Angle(93.9100,0,266.08999)
	local MPos = Vector(-6.5700,-0.21999,-0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.480 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Paradigm Effect"
ITEM.ID = 252
ITEM.Description = "Be careful not to break the space time continuum"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_c17/playgroundtick-tack-toe_block01a.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(129,189,244)
ITEM.EffectSize = 4.3
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_lab/security_screens2")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(2.609,1,-11.039)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 3.650 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Quartz Effect"
ITEM.ID = 253
ITEM.Description = "George6120: Thats a tricky one - Unless you want to reference Minecraft (^:"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_tides/menu_stand_p05.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(229,90,90)
ITEM.EffectSize = 3.6
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_combine/tprings_globe")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.0399)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.039 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Dead Bush Effect"
ITEM.ID = 254
ITEM.Description = "Don't fuck with this shrub"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_train/bush2.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props_c17/gate_door02a")
	local MAngle = Angle(90.779,0,264.519)
	local MPos = Vector(-6.780,1,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.090 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Scan Effect"
ITEM.ID = 255
ITEM.Description = "Scanning for possible scrub ... SCRUB FOUND"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/generatortube.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.400,0.119)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/weapons/w_smg1/smg_crosshair")
	local MAngle = Angle(90,0,277.040)
	local MPos = Vector(2.609,-3,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.130 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Rocket Effect"
ITEM.ID = 256
ITEM.Description = "5 .. 4 .. 3 .. 2 .. 1 .. LIFT OFF"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/weapons/w_missile_closed.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,97,0)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.800,0.800)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,86.0899,0)
	local MPos = Vector(7.829,-1.220,-7.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 10 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "QT Effect"
ITEM.ID = 257
ITEM.Description = "I hope this helps you"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/editor/cone_helper.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(0,169,255)
ITEM.EffectSize = 8.6
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(264.519,180,97.040)
	local MPos = Vector(4.6100,-1.610,7.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.2599 *90)
	model.ModelDrawingAngle.y = (CurTime() * 1.7799 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Particle Effect"
ITEM.ID = 258
ITEM.Description = "So pretty"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/splodeglass.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,255,255)
ITEM.EffectSize = 3.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.100,0.100,0.0599)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,101.739,78.26000)
	local MPos = Vector(10.430,0.610,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0.8700 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end


m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Lava Effect"
ITEM.ID = 259
ITEM.Description = "Feel the BURN"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/trash_can_p6.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,0,0)
ITEM.EffectSize = 2
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/top")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.03999)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Toxin Effect"
ITEM.ID = 260
ITEM.Description = "You're toxic"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/trash_can_p6.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(161,255,0)
ITEM.EffectSize = 2
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,1,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("phoenix_storms/pack2/interior_sides")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.03999)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Wisp Effect"
ITEM.ID = 261
ITEM.Description = "Woah that's pretty cool"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/effects/vol_light128x128.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.2000,0.2000,0.2000)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/roller/rollermine_glow")
	local MAngle = Angle(90,0,277.04000)
	local MPos = Vector(23.26000,-2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.6099 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Stone Effect"
ITEM.ID = 262
ITEM.Description = "You are the king of stone"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_combine/breenbust_chunk03.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1,0.5,0.5)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(7.8299,0,-0.0399)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 2 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	if (tobool(GetConVar("moat_EnableEffectHalos"):GetInt()) and (ply ~= LocalPlayer())) then
	halo.Add({model},
	Color(255,219,219),
	3.6,
	3.6,
	1)
	end

	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Tesla Effect"
ITEM.CustomEffect = true
ITEM.ID = 920
ITEM.Description = "A special effect given to the very dedicated Moat-Gaming players that reach level 100"
ITEM.Rarity = 8
ITEM.NameColor = Color(0, 191, 255)
ITEM.Collection = "Veteran Collection"
--Hack
ITEM.Model = "models/weapons/w_missile_closed.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.NameEffect = "electric"
ITEM.Image = "https://static.moat.gg/f/d8488f994f9134a830a9624106145219.png"
local particle = "TeslaHitBoxes"
if CLIENT then
    net.Receive("TeslaEffect",function()
		local ent = net.ReadEntity()
        ent.Tesla = true
    end)
    hook.Add("TTTEndRound","ClearTesla",function()
        for k,v in ipairs(player.GetAll()) do
            v.Tesla = false
        end
    end)
    
    timer.Create("Tesla Effect",10,0,function()
        if MOAT_PH then return end
        for _,ply in ipairs(player.GetAll()) do
            if (ply.Tesla and IsValid(LocalPlayer()) and ply ~= LocalPlayer() and ply:Team() ~= TEAM_SPEC and not ply:IsDormant() and ply:Health() >= 1) then
                local pos = ply:GetPos() + Vector(0,0,50)
                local effect = EffectData()
                effect:SetOrigin(pos)
                effect:SetStart(pos)
                effect:SetMagnitude(5)
                effect:SetScale(2)
                effect:SetEntity(ply)
                for i =1,15 do
                    timer.Simple(0.09 * i,function()
                        if (not IsValid(ply) or ply:Team() == TEAM_SPEC) then
							return
						end
                        effect:SetOrigin(pos - Vector((i) * math.random(-1,1),i * math.random(-1,1),i))
                        util.Effect("TeslaHitBoxes",effect)
                    end)
                end
            end
        end
    end)
else
    util.AddNetworkString("TeslaEffect")
    function mg_tesla(ply)
        net.Start("TeslaEffect")
        net.WriteEntity(ply)
        net.Broadcast()
    end
end
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0,0,0)
	local mat = Matrix()
	mat:Scale(Size)
    model:EnableMatrix("RenderMultiply", mat)
	return model, pos, ang
end

/*
function ITEM:OnPlayerSpawn(ply)
    if CLIENT then
        local tid = "EffectTimer" .. ply:UniqueID()
        if ply == LocalPlayer() then return end
        timer.Create(tid,5,0,function()
            if not IsValid(ply) then timer.Remove(tid) return end
            if not ply:Alive() then timer.Remove(tid) return end
            local pos = ply:EyePos()
            local effect = EffectData()
            effect:SetOrigin(pos)
            effect:SetStart(pos)
            effect:SetMagnitude(2)
            effect:SetScale(1)
            effect:SetEntity(ply)
            for i =1,15 do
                timer.Simple(0.05 * i,function()
                    if not IsValid(ply) then return end
                    if not ply:Alive() then return end
                    effect:SetOrigin(pos + Vector(i,i,i))
                    util.Effect("TeslaHitBoxes",effect)
                end)
            end
        end)
    end
end
function ITEM:PlayerDeath(ply)
end
*/
m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Gordon Effect"
ITEM.ID = 264
ITEM.Description = "What small body you have there Mr. Freeman"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/editor/playerstart.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(0,255,0)
ITEM.EffectBlur = 2.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.1500,0.1500,0.1500)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(264.519,180,97.0400)
	local MPos = Vector(4.610,-1.610,7.219)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Tornado Effect"
ITEM.ID = 265
ITEM.Description = "Don't let your house get swept up"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_combine/stasisvortex.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.1500,0.1500,0.0399)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props/cs_office/clouds")
	local MAngle = Angle(270.220,0,280.170)
	local MPos = Vector(11.430,0,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 6.039 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end



m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Turtle Effect"
ITEM.ID = 266
ITEM.Description = "Awww it's a turtle"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/de_tides/vending_turtle.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(122,230,86)
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.600,0.600,0.600)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(0,341.2200,264.519)
	local MPos = Vector(5.2199,-1,-7.829)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Valve Effect"
ITEM.ID = 267
ITEM.Description = "The annoying intro everyone watches because it's cool anyways"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_pipes/valvewheel001.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,0,0)
ITEM.EffectSize = 2
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.300,0.300,0.300)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("")
	local MAngle = Angle(90.7799,181.5700,48.5200)
	local MPos = Vector(5.2199,2.6099,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.869 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "White Snake Effect"
ITEM.ID = 268
ITEM.Description = "You sneaky bastard"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props_lab/teleportring.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"
ITEM.EffectColor = Color(255,255,255)
ITEM.EffectSize = 1.7
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0.3000,0.4000,0.1199)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props/de_nuke/nukconcretewalla")
	local MAngle = Angle(90,0,277.040)
	local MPos = Vector(12.649,-3,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 0 *90)
	model.ModelDrawingAngle.y = (CurTime() * 2.130 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Acid Effect"
ITEM.ID = 269
ITEM.Description = "Get slimed"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/dav0r/hoverball.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1.299,1.299,1.299)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/effects/slimebubble_sheet")
	local MAngle = Angle(177,0,269.220)
	local MPos = Vector(2.609,2,0)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 10 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.Name = "Yellow Data Effect"
ITEM.ID = 270
ITEM.Description = "This is what's left from the yellow DDoS attack"
ITEM.Rarity = 5
ITEM.Collection = "Effect Collection"
ITEM.Model = "models/props/cs_office/computer_caseb_p3b.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
ITEM.EffectColor = Color(255,242,0)
ITEM.EffectSize = 3.6
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(1.299,2,1)
	local mat = Matrix()
	mat:Scale(Size)
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial("models/props/cs_assault/pylon")
	local MAngle = Angle(0,0,0)
	local MPos = Vector(0,0,-0.0399)
	pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)
	ang:RotateAroundAxis(ang:Forward(), MAngle.p)
	ang:RotateAroundAxis(ang:Up(), MAngle.y)
	ang:RotateAroundAxis(ang:Right(), MAngle.r)
	model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)
	model.ModelDrawingAngle.p = (CurTime() * 1.0399 *90)
	model.ModelDrawingAngle.y = (CurTime() * 0 *90)
	model.ModelDrawingAngle.r = (CurTime() * 0 *90)
	ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))
	ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))
	ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Effect')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Effect') end

ITEM = {}
ITEM.ID = 8074
ITEM.Rarity = 5
ITEM.Name = "A Crown"
ITEM.Description = "The eastern-american pronounciation of the word 'crayons', but in hat form."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_crown.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.35)
	p = p + (a:Forward() * -3.575)+ (a:Right() * 0.102)+ (a:Up() * 3.485)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 54
ITEM.Name = "Afro"
ITEM.Description = "Become a jazzy man with this afro"
ITEM.Model = "models/gmod_tower/afro.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Up() * 2.5) + (ang:Forward() * -4.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 74
ITEM.Name = "Wooden Comb Afro"
ITEM.Description = "You're as OG as OG can get my black friend"
ITEM.Model = "models/captainbigbutt/skeyler/hats/afro.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 56
ITEM.Name = "Astronaut Helmet"
ITEM.Description = "Instantly become a space god with this helmet"
ITEM.Model = "models/astronauthelmet/astronauthelmet.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * -5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 98
ITEM.Name = "Baseball Cap"
ITEM.Description = "Never forget the GMod Tower games. May they rest in peace"
ITEM.Model = "models/gmod_tower/baseballcap.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), -20)
	ang:RotateAroundAxis(ang:Up(), 180)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 73
ITEM.Name = "Bear Hat"
ITEM.Description = "Now you will always have your teddy bear with you, in a hat form"
ITEM.Model = "models/captainbigbutt/skeyler/hats/bear_hat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 2673
ITEM.Name = "USA Bear Hat"
ITEM.Description = "Now you will always have your teddy bear with you, in a hat form"
ITEM.Model = "models/captainbigbutt/skeyler/hats/bear_hat.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Piswasser Beer Hat"
ITEM.ID = 498
ITEM.Description = "It's true. German beer is literally Piss Water"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA Piswasser Beer Hat"
ITEM.ID = 2498
ITEM.Description = "It's true. German beer is literally Piss Water"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Super Wet Beer Hat"
ITEM.ID = 499
ITEM.Description = "It was so tempting to put a 'Yo Mama' joke here"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA Super Wet Beer Hat"
ITEM.ID = 2499
ITEM.Description = "It was so tempting to put a 'Yo Mama' joke here"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Patriot Beer Hat"
ITEM.ID = 500
ITEM.Description = "For the True Redneck"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA Patriot Beer Hat"
ITEM.ID = 2500
ITEM.Description = "For the True Redneck"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Benedict Beer Hat"
ITEM.ID = 501
ITEM.Description = "Clench your thirst with this Hat"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA Benedict Beer Hat"
ITEM.ID = 2501
ITEM.Description = "Clench your thirst with this Hat"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Blarneys Beer Hat"
ITEM.ID = 502
ITEM.Description = "Sounds like a knock off Barney the Dinosaur"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA Blarneys Beer Hat"
ITEM.ID = 2502
ITEM.Description = "Sounds like a knock off Barney the Dinosaur"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "J Lager Beer Hat"
ITEM.ID = 503
ITEM.Description = "Jelly Lager? Delicious"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "USA J Lager Beer Hat"
ITEM.ID = 2503
ITEM.Description = "Jelly Lager? Delicious"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/beerhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.029419) + (ang:Right() * 0.031807) +  (ang:Up() * 1.305687)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 131
ITEM.Name = "Billy Hatcher Hat"
ITEM.Description = "Good Morning"
ITEM.Model = "models/lordvipes/billyhatcherhat/billyhatcherhat.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0.6) +  (ang:Up() * -1) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 132
ITEM.Name = "Black Mage Hat"
ITEM.Description = "Do you know what happens to a giant when it gets blasted with a fireball? The same thing that happens to everything else"
ITEM.Model = "models/lordvipes/blackmage/blackmage_hat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -12) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 19
ITEM.Name = "Bucket Helmet"
ITEM.Description = "It's a bucket"
ITEM.Model = "models/props_junk/MetalBucket01a.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.7, 0)
	
	pos = pos + (ang:Forward() * -5) + (ang:Up() * 5)// + m_IsTerroristModel(ply:GetModel())
	
	ang:RotateAroundAxis(ang:Right(), 200)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8012
ITEM.Rarity = 2
ITEM.Name = "Bunny Hood"
ITEM.Description = "You got the Bunny Hood! My, what long ears it has! Will the power of the wild spring forth?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bunnyhood/bunnyhood.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.875)
	p = p + (a:Forward() * -3.479)+ (a:Right() * 0.112)+ (a:Up() * 4.168)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), -0.1)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 95
ITEM.Name = "Bunny Ears"
ITEM.Description = "Hello there Mr Bunny"
ITEM.Model = "models/captainbigbutt/skeyler/hats/bunny_ears.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 58
ITEM.Name = "Cake Hat"
ITEM.Description = "This cake is a lie"
ITEM.Model = "models/cakehat/cakehat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Up() * 1.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8521
ITEM.Rarity = 6
ITEM.Name = "Cat in the Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_catinthehat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.325)
	p = p + (a:Forward() * -2.714)+ (a:Right() * 0)+ (a:Up() * 8.254)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 59
ITEM.Name = "Cat Ears"
ITEM.Description = "You look so cute with these cat ears on, omfg"
ITEM.Model = "models/gmod_tower/catears.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 94
ITEM.Name = "Large Cat Ears"
ITEM.Description = "What big ears you have you majestic beast"
ITEM.Model = "models/captainbigbutt/skeyler/hats/cat_ears.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * -0.2) +  (ang:Up() * -5.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 93
ITEM.Name = "Cat Hat"
ITEM.Description = "This does not give you 9 lives"
ITEM.Model = "models/captainbigbutt/skeyler/hats/cat_hat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8073
ITEM.Rarity = 6
ITEM.Name = "Chicken Hat"
ITEM.Description = "The paramount of stealth."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_chicken.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.2)
	p = p + (a:Forward() * -4.189)+ (a:Right() * 0.065)+ (a:Up() * 2.904)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 92
ITEM.Name = "Cowboy Hat"
ITEM.Description = "It's hiiiigh nooon"
ITEM.Model = "models/captainbigbutt/skeyler/hats/cowboyhat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.7, 0)
	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 3.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 13.2)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8021
ITEM.Rarity = 4
ITEM.Name = "Crocodile Dundee Hat"
ITEM.Description = "That's not a knife. [draws a large Bowie knife] That's a knife."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/dundee/dundee.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.746)+ (a:Right() * 0.874)+ (a:Up() * 0.029)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), -9.6)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 91
ITEM.Name = "Deadmau5"
ITEM.Description = "A musicly talented deceased rodent"
ITEM.Model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 90
ITEM.Name = "Developer Hat"
ITEM.Description = "This is an exclusive hat given to people that have created content for MG"
ITEM.Model = "models/captainbigbutt/skeyler/hats/devhat.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Dev Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8020
ITEM.Rarity = 2
ITEM.Name = "Doctor Fez Cap"
ITEM.Description = "A fez is another name for a condom. Kind of like a fez but for your other head."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/doctorfez/doctorfez.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * -3.492)+ (a:Right() * -0.428)+ (a:Up() * 3.722)
	a:RotateAroundAxis(a:Forward(), -17.1)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8535
ITEM.Rarity = 7
ITEM.Name = "Suess Santa Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_xmasfestive01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.798)+ (a:Right() * -0.191)+ (a:Up() * 2.377)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 60
ITEM.Name = "Drink Cap"
ITEM.Description = "The server drunk"
ITEM.Model = "models/sam/drinkcap.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.1) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 61
ITEM.Name = "Dunce Hat"
ITEM.Description = "You must sit in the corner and think of your terrible actions"
ITEM.Model = "models/duncehat/duncehat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	ang:RotateAroundAxis(ang:Right(), 25)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4538
ITEM.Rarity = 9
ITEM.Name = "The Easter Bunny"
ITEM.Description = "Holy cowww"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/custom_prop/moatgaming/eastbunny/eastbunny.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.732)+ (a:Right() * 0.001)+ (a:Up() * -0.3)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4539
ITEM.Rarity = 7
ITEM.Name = "Easter Icon"
ITEM.Description = "But from this earth, this grave, this dust, my God shall raise me up, I trust"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/moat/mg_hat_easteregg.mdl"
ITEM.Image = "https://static.moat.gg/f/6ad1a835688e7dd265fdda23e405f2c2.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 9.259)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8522
ITEM.Rarity = 6
ITEM.Name = "Elf #2 Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_elf.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.015)+ (a:Right() * 0.001)+ (a:Up() * 4.144)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8533
ITEM.Rarity = 6
ITEM.Name = "Elf #1 Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_elf2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.73)+ (a:Right() * -0.135)+ (a:Up() * 1.204)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8078
ITEM.Rarity = 5
ITEM.Name = "Estilo Muerto"
ITEM.Description = "Help the traitors celebrate Day of the Dead by wearing this hat and then killing them."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_estilomuerto.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.024)+ (a:Right() * 0.038)+ (a:Up() * 3.298)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8022
ITEM.Rarity = 4
ITEM.Name = "Evil Plant Head"
ITEM.Description = "The cutest little horrific flower baby!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/evilplant/evilplant.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -6.648)+ (a:Right() * -0.004)+ (a:Up() * -4.964)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 62
ITEM.Name = "Fedora"
ITEM.Description = "You're the best meme of them all"
ITEM.Model = "models/gmod_tower/fedorahat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 2.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8095
ITEM.Rarity = 1
ITEM.Name = "Floral Giggle"
ITEM.Description = "My goodness! Don't you just love flower tracking on a warm sunny day?!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_sun.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.759)+ (a:Right() * 0.098)+ (a:Up() * 4.55)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8025
ITEM.Rarity = 2
ITEM.Name = "Foolish Topper"
ITEM.Description = "You must have sucked someone to get this... (kirby joke lol)"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/foolish/foolish.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -6.627)+ (a:Right() * 0.328)+ (a:Up() * 2.637)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 88
ITEM.Name = "Frog Hat"
ITEM.Description = "Ribbit ribbit bitch"
ITEM.Model = "models/captainbigbutt/skeyler/hats/frog_hat.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.6, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8026
ITEM.Rarity = 7
ITEM.Name = "Galactus Helmet"
ITEM.Description = "Behold... The Power Cosmic itself!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/galactus/galactus.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.3)
	p = p + (a:Forward() * -5.157)+ (a:Right() * -0.125)+ (a:Up() * -5.757)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 135
ITEM.Name = "General Pepper"
ITEM.Description = "Commander of the great and kind"
ITEM.Model = "models/lordvipes/generalpepperhat/generalpepperhat.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -4.2) + (ang:Right() * 0.4) +  (ang:Up() * 0.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Grey Fedora"
ITEM.ID = 520
ITEM.Description = "Become that kid everybody hates"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Black Fedora"
ITEM.ID = 521
ITEM.Description = "Bring out your inner Hipster"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "White Fedora"
ITEM.ID = 522
ITEM.Description = "Smooth Criminal"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Tan Fedora"
ITEM.ID = 367
ITEM.Description = "Why sunbathe for a tan when you could just wear this Fedora"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Red Fedora"
ITEM.ID = 368
ITEM.Description = "Stained with the Blood of your Victims"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "BR Fedora"
ITEM.ID = 369
ITEM.Description = [[I know what you're thinking. "Oh boy! Another Fedora! Hell yeah!!"]]
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Brown Fedora"
ITEM.ID = 370
ITEM.Description = "Amazing, memingly brown"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Blue Fedora"
ITEM.ID = 371
ITEM.Description = "How many of the eight Fedoras do you own? Collect them"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/modified/hat01_fix.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.555908) + (ang:Right() * 0.028637) +  (ang:Up() * 2.641197)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Waldo Beanie"
ITEM.ID = 372
ITEM.Description = "Where are you"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "BB Beanie"
ITEM.ID = 373
ITEM.Description = "Big Bad Beanie"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Red Beanie"
ITEM.ID = 374
ITEM.Description = "It's Red. It's a Beanie. What else do you need to know"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "White Beanie"
ITEM.ID = 375
ITEM.Description = "A Beanie... That's White"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "GB Beanie"
ITEM.ID = 376
ITEM.Description = "A Giant Beetle Beanie? Oh wait. It's not that cool"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat03.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.285522) + (ang:Right() * 0.027466) +  (ang:Up() * 2.641327)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Black Beanie V2"
ITEM.ID = 377
ITEM.Description = "What happened to Black Beanie V1"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Gray Beanie V2"
ITEM.ID = 378
ITEM.Description = "There isn't even a V1."
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Gray Striped Beanie"
ITEM.ID = 379
ITEM.Description = "Loved the Gray Beanie? Well you'll love this Gray Striped Beanie"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Rasta Beanie"
ITEM.ID = 380
ITEM.Description = "Reggae Reggae"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Blue Beanie V2"
ITEM.ID = 381
ITEM.Description = "Blue Beanie V3s and Blue Beanie V3c Coming Soon"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat04.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -5.724609) + (ang:Right() * -0.245316) +  (ang:Up() * 3.670235)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Gray Musicians Hat"
ITEM.ID = 382
ITEM.Description = "If only Voice Chat became Autotune whilst wearing this"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/modified/hat06.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Franklin Cap"
ITEM.ID = 383
ITEM.Description = "For the Franklin Cap OGs"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Franklin Cap V2"
ITEM.ID = 384
ITEM.Description = "Apparently there was something wrong with the original"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Fist Cap"
ITEM.ID = 385
ITEM.Description = "A smaller cap, best worn on your fist"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 10
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(10)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Gray C Cap"
ITEM.ID = 386
ITEM.Description = "Cannot be used as Fallout Currency"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "White LS Cap"
ITEM.ID = 387
ITEM.Description = "Unfortunately this isn't a White Lego Sausage Cap"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Feud Cap"
ITEM.ID = 388
ITEM.Description = "This Cap is Presented by Steve Harvey"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Magnetics Cap"
ITEM.ID = 389
ITEM.Description = "Keep away from Metal surfaces"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "OG Cap"
ITEM.ID = 390
ITEM.Description = "Straight outta Compton"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Stank Cap"
ITEM.ID = 391
ITEM.Description = "Don't do the Stanky Leg"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Dancer Cap"
ITEM.ID = 392
ITEM.Description = "Disco Boogie"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(8)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Ape Cap"
ITEM.ID = 393
ITEM.Description = "Please refrain from the Harambe memes"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 9
ITEM.Model = "models/modified/hat07.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(9)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298584) + (ang:Right() * 0.209599) +  (ang:Up() * 3.671799)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Orange Trucker Hat"
ITEM.ID = 394
ITEM.Description = "I can't stop thinking about an Orange Fruit wearing a little Trucker Hat"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Blue Trucker Hat"
ITEM.ID = 395
ITEM.Description = "Your typical Trucker Hat"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Nut House Trucker Hat"
ITEM.ID = 396
ITEM.Description = "Sounds a lot like a Gay Bar"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Rusty Trucker Hat"
ITEM.ID = 397
ITEM.Description = "Rust is another name for Iron Oxide, which occurs when Iron or an alloy that contains Iron, like Steel, is exposed to Oxygen and moisture for a long period of time"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Bishop Trucker Hat"
ITEM.ID = 398
ITEM.Description = "For all the Christian Truckers"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin(4)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "24/7 Trucker Hat"
ITEM.ID = 399
ITEM.Description = "I'm open all hours"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin(5)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Fruit Trucker Hat"
ITEM.ID = 400
ITEM.Description = "One of your five a day"
ITEM.Rarity = 3
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/modified/hat08.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	
	model:SetSkin(6)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.298096) + (ang:Right() * 0.203354) +  (ang:Up() * 2.404396)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4532
ITEM.Rarity = 3
ITEM.Name = "Hatching Noob"
ITEM.Description = "I like to hide in my shell some times"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/custom_prop/moatgaming/eastegg/eastegg.mdl"
ITEM.Image = "https://static.moat.gg/f/24e1b504b09d4c6625e51cd2f7140b3b.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.8)+ (a:Right() * -1.007)+ (a:Up() * -9.757)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 106
ITEM.Name = "Headcrab"
ITEM.Description = "You will be eaten alive"
ITEM.Model = "models/gmod_tower/headcrabhat.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.7, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 3.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 107
ITEM.Name = "Headphones"
ITEM.Description = "I can't hear you, I'm listeng to a game"
ITEM.Model = "models/gmod_tower/headphones.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 87
ITEM.Name = "Heartband"
ITEM.Description = "Wear this if you have no friends and want people to love you"
ITEM.Model = "models/captainbigbutt/skeyler/hats/heartband.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 6572
ITEM.Name = "Heartband"
ITEM.NameColor = Color(255, 0, 255)
ITEM.Description = "Wear this if you have no friends and want people to love you"
ITEM.Model = "models/captainbigbutt/skeyler/hats/heartband.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Valentine Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Heart Hat"
ITEM.ID = 659
ITEM.Description = "I'm in love with my head"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/balloons/balloon_classicheart.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.775, 0)
	model:SetColor(Color(255, 0, 0))
	pos = pos + (ang:Forward() * -3) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.Name = "Heart Hat"
ITEM.ID = 6573
ITEM.NameColor = Color(255, 0, 255)
ITEM.Description = "I'm in love with my head"
ITEM.Rarity = 4
ITEM.Collection = "Valentine Collection"
ITEM.Model = "models/balloons/balloon_classicheart.mdl"
ITEM.Bone = "ValveBiped.Bip01_Head1"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.775, 0)
	model:SetColor(Color(255, 0, 0))
	pos = pos + (ang:Forward() * -3) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4529
ITEM.Rarity = 6
ITEM.Name = "Holy Cuteness"
ITEM.Description = "OMFGGG MOM ITS SO CUTE!!!! CAN WE KEEP ITT PELASE PLEASE PELASEEEE .."
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/moat/mg_hat_easterchick.mdl"
ITEM.Image = "https://static.moat.gg/f/bd134f0c72698bc5e8df2bede9015f1f.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -2.04)+ (a:Right() * 0.001)+ (a:Up() * 9.416)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 108
ITEM.Name = "Popcorn Bucket"
ITEM.Description = "Incoming racist joke"
ITEM.Model = "models/gmod_tower/kfcbucket.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.6) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 25.8)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8089
ITEM.Rarity = 5
ITEM.Name = "King Neptune's Crown"
ITEM.Description = "I win!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_neptune.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -3.981)+ (a:Right() * 0.046)+ (a:Up() * 8.859)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 109
ITEM.Name = "King Boo's Crown"
ITEM.Description = "Boo, bitch"
ITEM.Model = "models/gmod_tower/king_boos_crown.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), -19.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 143
ITEM.Name = "Kitty Hat"
ITEM.Description = "Aww so cute"
ITEM.Model = "models/gmod_tower/toetohat.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 137
ITEM.Name = "Klonoa Hat"
ITEM.Description = "Become the ultimate hipster"
ITEM.Model = "models/lordvipes/klonoahat/klonoahat.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.77, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8081
ITEM.Rarity = 5
ITEM.Name = "Krusty Krab Hat"
ITEM.Description = "I'm ready! I'm ready! I'm ready!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_krustykrab.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.5)
	p = p + (a:Forward() * -3.779)+ (a:Right() * 0.091)+ (a:Up() * 9.58)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8082
ITEM.Rarity = 4
ITEM.Name = "Kung Lao's Hat"
ITEM.Description = "I will not be so passive in your demise."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_kunglao.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -4.054)+ (a:Right() * 0.119)+ (a:Up() * 4.079)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 111
ITEM.Name = "Link Hat"
ITEM.Description = "Hyeeeh kyaah hyaaah haa hyet haa haa jum jum haaa"
ITEM.Model = "models/gmod_tower/linkhat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3) +(ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 138
ITEM.Name = "Luigi Hat"
ITEM.Description = "Taller and jumps higher than mario. Still doesn't get to be the main character. (no this does not change jump height)"
ITEM.Model = "models/lordvipes/luigihat/luigihat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8086
ITEM.Rarity = 5
ITEM.Name = "Mad Hatter Hat"
ITEM.Description = "We're all mad here! or Whats the hatter with me! (get it? it's a pun)"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_madhatter.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.969)+ (a:Right() * 0.068)+ (a:Up() * 5.221)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 77
ITEM.Name = "Mario Hat"
ITEM.Description = "Shut up you fat italian"
ITEM.Model = "models/lordvipes/mariohat/mariohat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -1.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 114
ITEM.Name = "Midna Hat"
ITEM.Description = "EPIC"
ITEM.Model = "models/gmod_tower/midnahat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 85
ITEM.Name = "Monocle"
ITEM.Description = "You probably think you're smart now. That's incorrect"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/monocle.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -2.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 22.4)
	ang:RotateAroundAxis(ang:Up(),-9)
	ang:RotateAroundAxis(ang:Forward(), 153.8)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8088
ITEM.Rarity = 4
ITEM.Name = "Naruto's Sleeping Cap"
ITEM.Description = "A Shinobi's life is not measured by how they lived but rather what they managed to accomplish before their death."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_narutosleeping.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.982)+ (a:Right() * 0.045)+ (a:Up() * 3.56)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 104
ITEM.Name = "Nightmare Hat"
ITEM.Description = "Jack is on your head.."
ITEM.Model = "models/gmod_tower/halloween_nightmarehat.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -4.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8041
ITEM.Rarity = 3
ITEM.Name = "Olimar's Helmet"
ITEM.Description = "Though it does no longer work, this helmet was said to track down Traitors in 2001."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/olimar/olimar.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -3.685)+ (a:Right() * 1.373)+ (a:Up() * -6.748)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8090
ITEM.Rarity = 6
ITEM.Name = "Pac-Man Helmet"
ITEM.Description = "Waka Waka Waka Waka..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_packman.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -7.723)+ (a:Right() * 0.064)+ (a:Up() * 0.957)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 116
ITEM.Name = "Party Hat"
ITEM.Description = "Raise the ruff"
ITEM.Model = "models/gmod_tower/partyhat.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3) + (ang:Right() * 1.2) +  (ang:Up() * 2.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8085
ITEM.Rarity = 6
ITEM.Name = "Philosophy Bulb"
ITEM.Description = "Basically gives you a headache with pictures."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_lightb.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -3.602)+ (a:Right() * 0.092)+ (a:Up() * 2.62)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 117
ITEM.Name = "Pilgrim Hat"
ITEM.Description = "What is a Mayflower"
ITEM.Model = "models/gmod_tower/pilgrimhat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * 1.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 16.4)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8069
ITEM.Rarity = 6
ITEM.Name = "Pimp Hat"
ITEM.Description = "25% off. Everything must go. Maybe even you."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_fedora.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -3.92)+ (a:Right() * 0.018)+ (a:Up() * 2.601)
	a:RotateAroundAxis(a:Up(), 180)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8006
ITEM.Rarity = 1
ITEM.Name = "Pipo Helmet"
ITEM.Description = "The Peak Point Helmet, also known as Pipo Helmet, is an experimental device made by the developers. This device controls the wearer and increases its intelligence."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/apeescape/apeescape.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -3.877)+ (a:Right() * -0.867)+ (a:Up() * 2.149)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4530
ITEM.Rarity = 4
ITEM.Name = "Playboy Parti Bunni"
ITEM.Description = "Catch me wearing this around the mansion"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/moat/mg_hat_easterhat.mdl"
ITEM.Image = "https://static.moat.gg/f/8cd435b47a8606ad6f0112eeb870085f.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.8)+ (a:Right() * 0)+ (a:Up() * 4.104)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 4531
ITEM.Rarity = 5
ITEM.Name = "Pot Head"
ITEM.Description = "Don't forget to water your flowers"
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/moat/mg_hat_easterflowers.mdl"
ITEM.Image = "https://static.moat.gg/f/7e81543cab4cc40c0414fe1ff9d17d75.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 5.267)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 3559
ITEM.Rarity = 5
ITEM.Name = "Pot Head"
ITEM.Description = "Don't forget to water your flowers"
ITEM.Collection = "Easter 2020 Collection"
ITEM.Model = "models/moat/mg_hat_easterflowers.mdl"
ITEM.Image = "https://static.moat.gg/f/7e81543cab4cc40c0414fe1ff9d17d75.png"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.801)+ (a:Right() * 0)+ (a:Up() * 5.267)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8044
ITEM.Rarity = 5
ITEM.Name = "Princess Peach's Crown"
ITEM.Description = "I am in another castle!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/princess/princess.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.454)+ (a:Right() * 0.845)+ (a:Up() * 5.339)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 142
ITEM.Name = "Red's Hat"
ITEM.Description = "Pokemon red hat"
ITEM.Model = "models/lordvipes/redshat/redshat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.75, 0)
	pos = pos + (ang:Forward() * -3.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 18)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8092
ITEM.Rarity = 5
ITEM.Name = "Robot Chicken Hat"
ITEM.Description = "Why did the chicken REALLY cross the road? To get hit by a car, stolen by a mad scientist, and transformed into a terrifying cyborg that you can wear on your head. So the next time you hear someone telling you that joke, set that smug joke-teller straight, because you've got the FACTS."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_robotchicken.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.775)
	p = p + (a:Forward() * -4.184)+ (a:Right() * 0.081)+ (a:Up() * 6.122)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8539
ITEM.Rarity = 7
ITEM.Name = "Rudolph Hat"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/models/moat/mg_hat_rudolph.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.825)
	p = p + (a:Forward() * -2.738)+ (a:Right() * -0.167)+ (a:Up() * 2.144)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 83
ITEM.Name = "Santa Hat"
ITEM.Description = "It's Christmas"
ITEM.Model = "models/gmod_tower/santahat.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2) + (ang:Right() * -0.2) +  (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 7001

ITEM.Name = "Santa's Cap"
ITEM.Description = "Ho Ho Ho Merry Christmas"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/santa/santa.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    model:SetModelScale(1.1, 0)
    pos = pos + (ang:Forward() * -5.4) + (ang:Up() * -1)
	return model, pos, ang
end
/*
children:
self:
		Angles	=	-90.000 0.000 180.000
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	3.100000 -2.100000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
children:
self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/sal/gingerbread.mdl
		Position	=	1.500000 -0.600000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254
children:
self:
		Angles	=	0.000 -80.000 268.300
		ClassName	=	model
		Color	=	251.000000 255.000000 255.000000
		Model	=	models/santa/santa.mdl
		Position	=	0.100000 1.300000 0.000000
		Size	=	1.1
		UniqueID	=	3221970254

children:
self:
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
self:
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/santa/santa.mdl
		Position	=	-5.400000 0.000000 -1.000000
		Size	=	1.1
		UniqueID	=	3503520631

*/
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 121
ITEM.Name = "Seuss Hat"
ITEM.Description = "Thing 1 and Thing 2 are not a thing here"
ITEM.Model = "models/gmod_tower/seusshat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8054
ITEM.Rarity = 7
ITEM.Name = "Sharky Hat"
ITEM.Description = "Your friend from the ocean!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shark/shark.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -2.451)+ (a:Right() * -0.109)+ (a:Up() * 6.517)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8056
ITEM.Rarity = 6
ITEM.Name = "Shredder Helmet"
ITEM.Description = "TEENAGE MUTANT NINJA TURTLES"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shredder/shredder.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.59)+ (a:Right() * 0.03)+ (a:Up() * 0.677)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8083
ITEM.Rarity = 3
ITEM.Name = "Smore Chef"
ITEM.Description = "Warning! This cozy comfy smores like hat is not edible while shooting terrorists!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_law.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.035)+ (a:Right() * 0.136)+ (a:Up() * 6.665)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 123
ITEM.Name = "Sombrero"
ITEM.Description = "Arriba"
ITEM.Model = "models/gmod_tower/sombrero.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 12.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 3396
ITEM.Name = "Mexican Sombrero"
ITEM.Description = "A special hat in the annual celebration of Cinco de Mayo."
ITEM.Model = "models/gmod_tower/sombrero.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cinco de Mayo Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 12.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8058
ITEM.Rarity = 7
ITEM.Name = "Sorting Hat"
ITEM.Description = "Hmm, difficult. VERY difficult. Plenty of courage, I see. Not a bad mind, either. There's talent, oh yes. And a thirst to prove yourself. But where to put you?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/sortinghat/sortinghat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.208)+ (a:Right() * -0.965)+ (a:Up() * 1.495)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8094
ITEM.Rarity = 3
ITEM.Name = "Spinny Hat"
ITEM.Description = "You can sexually identify as an attack helicopter with this propeller on your head."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_spinny.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.975)
	p = p + (a:Forward() * -3.765)+ (a:Right() * 0.07)+ (a:Up() * 1.862)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 82
ITEM.Name = "Star Headband"
ITEM.Description = "You are amazing"
ITEM.Model = "models/captainbigbutt/skeyler/hats/starband.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -3.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8099
ITEM.Rarity = 3
ITEM.Name = "Steampunk Tophat"
ITEM.Description = "OMG YOU GUYS it has come to my attention that SOMEONE on the internet is saying that my fictional 19th century zombies are NOT SCIENTIFICALLY SOUND. Naturally, I am crushed. To think, IF ONLY I’d consulted with a zombologist or two before sitting down to write, I could’ve avoided ALL THIS EMBARRASSMENT."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/sterling/mg_hat_punk.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.35)
	p = p + (a:Forward() * -3.161)+ (a:Right() * 0.133)+ (a:Up() * 7.737)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8060
ITEM.Rarity = 5
ITEM.Name = "Straw Hat"
ITEM.Description = "Welcome to the rice fields, mutha fucka."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/strawhat/strawhat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.161)+ (a:Right() * -1.299)+ (a:Up() * 0.491)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 81
ITEM.Name = "Straw Hat"
ITEM.Description = "Old McDonald had a farm"
ITEM.Model = "models/captainbigbutt/skeyler/hats/strawhat.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 2.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 80
ITEM.Name = "Sun Hat"
ITEM.Description = "It has flowers and protects you from the sun"
ITEM.Model = "models/captainbigbutt/skeyler/hats/sunhat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -5) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 125
ITEM.Name = "Team Rocket Hat"
ITEM.Description = "Prepare for trouble, and make it double!"
ITEM.Model = "models/gmod_tower/teamrockethat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.15, 0)
	pos = pos + (ang:Forward() * -4) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 18.2)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8096
ITEM.Rarity = 4
ITEM.Name = "Teemo Hat"
ITEM.Description = "Never underestimate the power of the Scout's code."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_teemo.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.566)+ (a:Right() * 0.143)+ (a:Up() * 4.251)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8079
ITEM.Rarity = 6
ITEM.Name = "The Goofy Goober"
ITEM.Description = "I'm a goofy goober, ROCK! You're a goofy goober, ROCK! We're all goofy goobers, ROCK! Goofy goofy goober goober!, ROCK!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_goofygoober.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -2.733)+ (a:Right() * 0.01)+ (a:Up() * -0.255)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8080
ITEM.Rarity = 9
ITEM.Name = "The IC Warrior"
ITEM.Description = "A haiku for war. To default one's enemies. Honor the IC."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_killerskabuto.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.453)+ (a:Right() * 0.089)+ (a:Up() * 3.924)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8100
ITEM.Rarity = 9
ITEM.Name = "The #1 Hat"
ITEM.Description = "Hey man, that's Smitty Werben Man Jensen's hat, give it back! He was #1!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/sterling/mg_hat_number1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.558)+ (a:Right() * -0.002)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8076
ITEM.Rarity = 6
ITEM.Name = "The Stout Shako"
ITEM.Description = "The grand achievement of Victorian military fashion."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_drummer.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.832)+ (a:Right() * 0.044)+ (a:Up() * 8.242)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8061
ITEM.Rarity = 7
ITEM.Name = "Thor's Helmet"
ITEM.Description = "The god of Thunder. Can drink anyone under the table. Not a deity to fuck with."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/thundergod/thundergod.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -3.531)+ (a:Right() * -2.098)+ (a:Up() * -88.611)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8091
ITEM.Rarity = 6
ITEM.Name = "Top Hat of Bling Bling"
ITEM.Description = "For those times when a plain old top hat made out of solid gold just won't do."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_robloxmoney.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.667)+ (a:Right() * 0.1)+ (a:Up() * 5.519)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 127
ITEM.Name = "Top Hat"
ITEM.Description = "If only you had a suit"
ITEM.Model = "models/gmod_tower/tophat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 0.6) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 10.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8087
ITEM.Rarity = 7
ITEM.Name = "Towering Pillar of Hats"
ITEM.Description = "A-ha-ha! You are as PRESUMPTUOUS as you are POOR and IRISH. Tarnish notte the majesty of my TOWER of HATS."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_multi.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.275)
	p = p + (a:Forward() * -3.901)+ (a:Right() * 0.059)+ (a:Up() * 3.53)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 129
ITEM.Name = "Turkey"
ITEM.Description = "Stick this hot thing on your head"
ITEM.Model = "models/gmod_tower/turkey.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * 1.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 18
ITEM.Name = "Turtle Hat"
ITEM.Description = "This cute little turtle can sit on your head and give you amazing love"
ITEM.Model = "models/props/de_tides/Vending_turtle.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Up(), -90)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8097
ITEM.Rarity = 6
ITEM.Name = "Umbrella Hat"
ITEM.Description = "You can stand under my umbrella, ella, ella, eh, eh, eh..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_unbrella.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.134)+ (a:Right() * 0.177)+ (a:Up() * 5.8)
	a:RotateAroundAxis(a:Right(), 11.1)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 144
ITEM.Name = "Viewtiful Joe Helmet"
ITEM.Description = "Shoot em up"
ITEM.Model = "models/lordvipes/viewtifuljoehelmet/viewtifuljoehelmet.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 130
ITEM.Name = "Witch Hat"
ITEM.Description = "Mwahahaha"
ITEM.Model = "models/gmod_tower/witchhat.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.4) + (ang:Up() * 1.4) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 22.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 8072
ITEM.Rarity = 6
ITEM.Name = "Zeppeli Hat"
ITEM.Description = "What is Courage? Courage is owning your fear!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_checkered_top.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.2)
	p = p + (a:Forward() * -3.877)+ (a:Right() * 0.036)+ (a:Up() * 3.853)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 78
ITEM.Name = "Gangsta Hat"
ITEM.Description = "sup fam"
ITEM.Model = "models/captainbigbutt/skeyler/hats/zhat.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -3.68) + (ang:Right() * -0.013) +  (ang:Up() * 1.693) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Hat')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Hat') end

ITEM = {}
ITEM.ID = 566
ITEM.Name = "Walter White Model"
ITEM.Description = [["Say my name". "I am the one who knocks". "You're Goddamn Right". I could go on all day, but there's only do much room in this box]]
ITEM.Model = "models/agent_47/agent_47.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 526
ITEM.Name = "Altair Model"
ITEM.Description = "Actually gives you the ability to jump 200ft into hay"
ITEM.Model = "models/burd/player/altair.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 63
ITEM.Name = "Alyx Model"
ITEM.Description = "slut"
ITEM.Model = "models/player/alyx.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Alpha Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 200
ITEM.Name = "Barney Model"
ITEM.Description = "I'm not a bad guy"
ITEM.Model = "models/player/barney.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 527
ITEM.Name = "Boba Fett Model"
ITEM.Description = "Unfortunatley your Jetpack is out of fuel on this model"
ITEM.Model = "models/moat/player/bobafett.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 201
ITEM.Name = "Breen Model"
ITEM.Description = "The wise man"
ITEM.Model = "models/player/breen.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 861
ITEM.Name = "Bunny Model"
ITEM.Description = "Eh... What's up doc? Hehe.."
ITEM.Model = "models/player/bugsb/bugsb.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 528
ITEM.Name = "Chewbacca Model"
ITEM.Description = "WUUH HUUGUUGHGHG HUURH UUH UGGGUH"
ITEM.Model = "models/moat/player/chewbacca.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 529
ITEM.Name = "Chris Redfield Model"
ITEM.Description = "Just your typical Hunky, Sexy Military Man. All Homo"
ITEM.Model = "models/player/chris.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 161
ITEM.Name = "Citizen Female 1"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_01.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 162
ITEM.Name = "Citizen Female 2"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_02.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 163
ITEM.Name = "Citizen Female 3"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_03.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 164
ITEM.Name = "Citizen Female 4"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_04.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 165
ITEM.Name = "Citizen Female 5"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_05.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 166
ITEM.Name = "Citizen Female 6"
ITEM.Description = "Just your average female citizen"
ITEM.Model = "models/player/Group01/female_06.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 530
ITEM.Name = "Classy Gentleman Model"
ITEM.Description = "Only for the Most Dapper of Tea-Sipping Gentlemen"
ITEM.Model = "models/player/macdguy.mdl"
ITEM.Rarity = 8
ITEM.Collection = "George Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 531
ITEM.Name = "Inferno Armor Model"
ITEM.Description = "Now you can survive a wild volcano attack"
ITEM.Model = "models/moat/player/inferno_armour.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 532
ITEM.Name = "Deathstroke Model"
ITEM.Description = "The result of Two-Face and Deadpool having a Baby"
ITEM.Model = "models/burd/norpo/arkhamorigins/assassins/deathstroke_valvebiped.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 42
ITEM.Name = "T-Rex Modwl"
ITEM.Description = "Tyrannosaurus is a genus of coelurosaurian theropod dinosaur. The species Tyrannosaurus rex, often called T. rex or colloquially T-Rex, is one of the most well-represented of the large theropods. Tyrannosaurus lived throughout what is now western North America, on what was then an island continent known as Laramidia."
ITEM.Model = "models/moat/player/foohysaurusrex_fixed.mdl"
ITEM.Rarity = 9
ITEM.Collection = "Extinct IRL Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 533
ITEM.Name = "Dishonored Assassin Model"
ITEM.Description = "This model is an Assassin from the game Dishonored. Who would have guessed that? Hmm.."
ITEM.Model = "models/player/dishonored_assassin1.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7010 --models/jaanus/santa.mdl
ITEM.Name = "Cat Woman Model"
ITEM.Description = "I'm a catist, not a feminist"
ITEM.Model = "models/kaesar/moat/catwoman/catwoman.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 534
ITEM.Name = "Dude Model"
ITEM.Description = "Just Piss on everything"
ITEM.Model = "models/player/dude.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 862
ITEM.Name = "Eastertrooper Model"
ITEM.Description = "You sure this is where we're supposed to wait? - Yes"
ITEM.Model = "models/burd/player/eastertrooper/eastertrooper.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7006 --models/gonzo/crimboclonesv2/elf/elf.mdl
ITEM.Name = "Batman Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/batman.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 199
ITEM.Name = "Eli Model"
ITEM.Description = "I bet you can't guess why he lost a leg"
ITEM.Model = "models/player/eli.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 185
ITEM.Name = "Rebel Female 1"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_01.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 186
ITEM.Name = "Rebel Female 2"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_02.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 187
ITEM.Name = "Rebel Female 3"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_03.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 188
ITEM.Name = "Rebel Female 4"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_04.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 189
ITEM.Name = "Rebel Female 5"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_05.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 190
ITEM.Name = "Rebel Female 6"
ITEM.Description = "Just your average rebel female citizen"
ITEM.Model = "models/player/Group03/female_06.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 535
ITEM.Name = "Ninja Model"
ITEM.Description = "Hide in the shadows comrade"
ITEM.Model = "models/moat/player/ninja_player.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 536
ITEM.Name = "Freddy Kruger Model"
ITEM.Description = "Invading people's dreams since 1984"
ITEM.Model = "models/player/freddykruger.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7007 --models/players/gingerfast.mdl
ITEM.Name = "Flash Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/flash.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 202
ITEM.Name = "GMan Model"
ITEM.Description = "Good Morning"
ITEM.Model = "models/player/gman_high.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 537
ITEM.Name = "Gordon Freeman Model"
ITEM.Description = "Before I actually played the game, I thought Morgan Freeman played Gordon Freeman"
ITEM.Model = "models/moat/player/gordon.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 538
ITEM.Name = "Chell Model"
ITEM.Description = "How nice. There are no jiggle boobs"
ITEM.Model = "models/player/p2_chell.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 5134
ITEM.Name = "Halloween King Model"
ITEM.Description = "Truely the king of halloween, so let's party bitches"
ITEM.Model = "models/player/zack/zackhalloween.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 539
ITEM.Name = "Harold Lott Model"
ITEM.Description = "LOADSA MONEY"
ITEM.Model = "models/player/haroldlott.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 191
ITEM.Name = "Working Asian"
ITEM.Description = "Just your average male worker"
ITEM.Model = "models/player/hostage/hostage_01.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 192
ITEM.Name = "Working Man"
ITEM.Description = "Just your average male worker"
ITEM.Model = "models/player/hostage/hostage_02.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 193
ITEM.Name = "Working Older Man"
ITEM.Description = "Just your average male worker"
ITEM.Model = "models/player/hostage/hostage_03.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 194
ITEM.Name = "Working Grandpa"
ITEM.Description = "Just your average male worker"
ITEM.Model = "models/player/hostage/hostage_04.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 540
ITEM.Name = "Hunter Model"
ITEM.Description = "You are probably expecting a Zombie joke here about how you were Left 4 Dead. But I guess you're now only a Half-Life"
ITEM.Model = "models/player/hunter.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 541
ITEM.Name = "Iron Man Model"
ITEM.Description = "He will get your Laundry ironed in mere seconds"
ITEM.Model = "models/avengers/iron man/mark7_player.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 542
ITEM.Name = "Isaac Clarke Model"
ITEM.Description = "You may not be in Space, but you're sure as Hell Dead"
ITEM.Model = "models/player/security_suit.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 543
ITEM.Name = "Spider-Man Model"
ITEM.Description = "My spider senses are starting to tingle!"
ITEM.Model = "models/otv/scarletspider.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 544
ITEM.Name = "Joker Model"
ITEM.Description = "You wanna know how I got these Scars? HAHA"
ITEM.Model = "models/player/joker.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7008 --"models/player/christmas/santa.mdl"
ITEM.Name = "Jolly Santa Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/christmas/santa.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 21
ITEM.Name = "Kliener Model"
ITEM.Description = "The smartest of them all"
ITEM.Model = "models/player/kleiner.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 545
ITEM.Name = "Knight Model"
ITEM.Description = "Fixed"
ITEM.Model = "models/moat/player/knight_fixed.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 167
ITEM.Name = "Citizen Male 1"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_01.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 177
ITEM.Name = "Rebel Male 9"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_09.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 176
ITEM.Name = "Rebel Male 1"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_01.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 168
ITEM.Name = "Citizen Male 2"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_02.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 178
ITEM.Name = "Rebel Male 2"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_02.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 169
ITEM.Name = "Citizen Male 3"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_03.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 179
ITEM.Name = "Rebel Male 3"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_03.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 170
ITEM.Name = "Citizen Male 4"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_04.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 180
ITEM.Name = "Rebel Male 4"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_04.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 171
ITEM.Name = "Citizen Male 5"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_05.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 181
ITEM.Name = "Rebel Male 5"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_05.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 172
ITEM.Name = "Citizen Male 6"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_06.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 182
ITEM.Name = "Rebel Male 6"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_06.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 173
ITEM.Name = "Citizen Male 7"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_07.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 183
ITEM.Name = "Rebel Male 7"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_07.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 174
ITEM.Name = "Citizen Male 8"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_08.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 184
ITEM.Name = "Rebel Male 8"
ITEM.Description = "Just your average rebel male citizen"
ITEM.Model = "models/player/Group03/male_08.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 175
ITEM.Name = "Citizen Male 9"
ITEM.Description = "Just your average male citizen"
ITEM.Model = "models/player/Group01/male_09.mdl"
ITEM.Rarity = 1
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 195
ITEM.Name = "Magnusson Model"
ITEM.Description = "Hello doctor"
ITEM.Model = "models/player/magnusson.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 546
ITEM.Name = "Masked Breen Model"
ITEM.Description = "It's got to be said. There's something very BDSM about this Model"
ITEM.Model = "models/moat/player/sunabouzu.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 567
ITEM.Name = "Black Mask Model"
ITEM.Description = "I can see the darkness inside of you"
ITEM.Model = "models/player/bobert/aoblackmask.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 547
ITEM.Name = "Master Chief Model"
ITEM.Description = "Master Chief is not a Master Chef"
ITEM.Model = "models/player/lordvipes/haloce/spartan_classic.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 196
ITEM.Name = "Bald Monk Model"
ITEM.Description = "Hummmmmm...."
ITEM.Model = "models/player/monk.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 198
ITEM.Name = "Mossman Model"
ITEM.Description = "Not as slutty as Alyx, but gettin' there"
ITEM.Model = "models/player/mossman.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 548
ITEM.Name = "Niko Model"
ITEM.Description = "Brother. Let's go Traitor Hunting"
ITEM.Model = "models/player/niko.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 549
ITEM.Name = "Normal Model"
ITEM.Description = "This isn't a Normal Model. A Normal Model is Gigi Hadid"
ITEM.Model = "models/moat/player/normal.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 197
ITEM.Name = "Odessa Model"
ITEM.Description = "Security guard for hire"
ITEM.Model = "models/player/odessa.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7009 --models/gonzo/crimboclonesv2/reindeer/reindeer.mdl
ITEM.Name = "Green Lantern Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/greenlantern.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 550
ITEM.Name = "Robber Model"
ITEM.Description = "Maybe when he's not looking you could rob some of Moat's Cosmics"
ITEM.Model = "models/player/robber.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 551
ITEM.Name = "Obama Model"
ITEM.Description = "I was better than Trump"
ITEM.Model = "models/moat/player/obama.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 552
ITEM.Name = "Rorschach Model"
ITEM.Description = "Somebody help him! He's spilt ink all over his face"
ITEM.Model = "models/player/rorschach.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7005 --models/gonzo/crimboclonesv2/rudolph/rudolph.mdl
ITEM.Name = "Superman Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/superman.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7011 --models/gonzo/crimboclonesv2/santa/santa.mdl
ITEM.Name = "Jesus Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/jesus/jesus.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 553
ITEM.Name = "Scarecrow Model"
ITEM.Description = "Now you have a Model to match Yourself. Someone who scares off Birds"
ITEM.Model = "models/player/scarecrow.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 554
ITEM.Name = "Scorpion Model"
ITEM.Description = "(From Mortal Kombat) Just incase you thought it was the insect and you had a Giant Stinger"
ITEM.Model = "models/player/scorpion.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 5135
ITEM.Name = "Scream Model"
ITEM.Description = "Please do not scream as loud as you can when wearing this model"
ITEM.Model = "models/player/screamplayermodel/scream/scream.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 555
ITEM.Name = "Shaun Model"
ITEM.Description = "Why are you still here? You should be watching Shaun of the Dead right now"
ITEM.Model = "models/player/shaun.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 66
ITEM.Name = "Skeleton Model"
ITEM.Description = "An exclusive item given to Shiny Mega Gallade, first donator of $100"
ITEM.Model = "models/player/skeleton.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Sugar Daddy Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 556
ITEM.Name = "Agent Smith Model"
ITEM.Description = "This model looks an awful lot like Agent K from Men in Black"
ITEM.Model = "models/player/smith.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 557
ITEM.Name = "Stripped Soldier Model"
ITEM.Description = "Be careful in the Cold Weather with those Nips out. You might get Banned for possession of two extra weapons"
ITEM.Model = "models/player/soldier_stripped.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 558
ITEM.Name = "Solid Snake Model"
ITEM.Description = "Wait. Did that Cardboard Box just move? What.."
ITEM.Model = "models/player/big_boss.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 559
ITEM.Name = "Space Suit Model"
ITEM.Description = "Went to the Moon and back. Killed a bunch of Terrorists. Didn't even take off the Suit"
ITEM.Model = "models/moat/player/spacesuit.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 560
ITEM.Name = "TF2 Spy Model"
ITEM.Description = "Everyone's favourite Back Stabbing, Invisible, Rage Inducing Frenchman"
ITEM.Model = "models/moat/player/spy.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 561
ITEM.Name = "Sub Zero Model"
ITEM.Description = "About -1472.18 to be exact"
ITEM.Model = "models/player/subzero.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 45
ITEM.Name = "Aperture Containment Model"
ITEM.Description = [[The Enrichment Center is committed to the well being of all participants]]
ITEM.Model = "models/player/aphaztech.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 46
ITEM.Name = "Veteran Soldier Model"
ITEM.Description = "He's seen some stuff"
ITEM.Model = "models/player/clopsy.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Aqua Palm Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 49
ITEM.Name = "Zelda Model"
ITEM.Description = "It's dangerous to go alone! Take this... model"
ITEM.Model = "models/player/zelda.mdl"
ITEM.Rarity = 9
ITEM.Collection = "Aqua Palm Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 50
ITEM.Name = "Ash Ketchum Model"
ITEM.Description = "Gotta catch em all"
ITEM.Model = "models/player/red.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Aqua Palm Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 53
ITEM.Name = "Stormtrooper Model"
ITEM.Description = "Victory is written in the stars"
ITEM.Model = "models/player/stormtrooper.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Aqua Palm Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1107
ITEM.Name = "Arctic Model"
ITEM.Description = "Chilli now isn't it.."
ITEM.Model = "models/player/arctic.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1108
ITEM.Name = "Guerilla Model"
ITEM.Description = "Go hide in the jungle"
ITEM.Model = "models/player/guerilla.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1109
ITEM.Name = "Leet Model"
ITEM.Description = "Rush B"
ITEM.Model = "models/player/leet.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1110
ITEM.Name = "Phoenix Model"
ITEM.Description = "Rush A"
ITEM.Model = "models/player/phoenix.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1111
ITEM.Name = "Hobo Model"
ITEM.Description = "Now you can collect IC and beg properly"
ITEM.Model = "models/player/corpse1.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1112
ITEM.Name = "Urban Model"
ITEM.Description = "Choose your team"
ITEM.Model = "models/player/urban.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1113
ITEM.Name = "Riot Model"
ITEM.Description = "I think they're going B guys"
ITEM.Model = "models/player/riot.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1114
ITEM.Name = "SWAT Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/swat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1115
ITEM.Name = "Gasmask Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/gasmask.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1116
ITEM.Name = "Super Soldier Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/combine_super_soldier.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1117
ITEM.Name = "Combine Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/combine_soldier.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1118
ITEM.Name = "Combine Prison Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/combine_soldier_prisonguard.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1119
ITEM.Name = "Police Model"
ITEM.Description = "Wow the police are here"
ITEM.Model = "models/player/police.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 1120
ITEM.Name = "Female Police Model"
ITEM.Description = "Wow the police are here"
ITEM.Model = "models/player/police_fem.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 562
ITEM.Name = "Tesla Power Model"
ITEM.Description = "Temporarily osama model until proper power replacement is found by a conscience scientist" -- "If you aren't using a weapon with the Tesla Talent whilst wearing this skin, you're doing it wrong"
ITEM.Model = "models/code_gs/osama/osamaplayer.mdl" -- "models/player/teslapower.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7012 --models/player/portal/male_02_snow.mdl
ITEM.Name = "Winter Male 1"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_02_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7013 --models/player/portal/male_04_snow.mdl
ITEM.Name = "Winter Male 2"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_04_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7014 --models/player/portal/male_05_snow.mdl
ITEM.Name = "Winter Male 3"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_05_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7015 --models/player/portal/male_07_snow.mdl
ITEM.Name = "Winter Male 4"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_07_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7016 --models/player/portal/male_08_snow.mdl
ITEM.Name = "Winter Male 5"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_08_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 7017 --models/player/portal/male_09_snow.mdl
ITEM.Name = "Winter Male 6"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/portal/male_09_snow.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 563
ITEM.Name = "Osama Model"
ITEM.Description = "The dead leader of the terrorists"
ITEM.Model = "models/code_gs/osama/osamaplayer.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 564
ITEM.Name = "Zoey Model"
ITEM.Description = 'Killing Terrorists is the same as killing Infected "Zombies", right? Hmm...'
ITEM.Model = "models/player/zoey.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Model Collection"
function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end
m_AddDroppableItem(ITEM, 'Model')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Model') end

ITEM = {}
ITEM.ID = 96
ITEM.Name = "3D Glasses"
ITEM.Description = "The most practical way to get your head in the game"
ITEM.Model = "models/gmod_tower/3dglasses.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 2096
ITEM.Name = "USA 3D Glasses"
ITEM.Description = "The most practical way to get your head in the game"
ITEM.Model = "models/gmod_tower/3dglasses.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8002
ITEM.Rarity = 6
ITEM.Name = "Aku Aku Mask"
ITEM.Description = "A floating mask from the Crash Bandicoot game series. He aids Crash & co. in some way."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/aku/aku.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.3)
	p = p + (a:Forward() * -5.52)+ (a:Right() * 0.001)+ (a:Up() * -0.621)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8004
ITEM.Rarity = 4
ITEM.Name = "Alien Head"
ITEM.Description = "The head of a person from outerspace. It was generally peace loving and wise, but it only came to Earth because we've got velcro and it loved that shit. Save velcro!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/alien/alien.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -6.061)+ (a:Right() * 0.031)+ (a:Up() * -3.541)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 77
ITEM.Name = "Andross Mask"
ITEM.Description = "I've been waiting for you, Star Fox. You know that I control the galaxy. It's foolish to come against me. You will die just like your father"
ITEM.Model = "models/gmod_tower/androssmask.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1) + (ang:Up() * -2.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8005
ITEM.Rarity = 2
ITEM.Name = "Anonymous Mask"
ITEM.Description = "KNOWLEDGE IS EXPENSIVE. WE ARE IDENTIFIED. WE ARE FEW. WE DO FORGIVE. WE DO FORGET. DO NOT EXPECT US."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/anonymous/anonymous.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.595)+ (a:Right() * 0.047)+ (a:Up() * -3.804)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8007
ITEM.Rarity = 5
ITEM.Name = "Arkham Knight Helmet "
ITEM.Description = "The damn straight best super hero ever."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/arkham/arkham.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -5.484)+ (a:Right() * 0.001)+ (a:Up() * 0.106)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Arnold Mask"
ITEM.ID = 658
ITEM.Description = "Grrr.. I'm a mean dog"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/arnold_mask/arnold_mask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 57
ITEM.Name = "Aviators"
ITEM.Description = "You look like the terminator with these badass glasses on"
ITEM.Model = "models/gmod_tower/aviators.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2) + (ang:Up() * -0.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 2057
ITEM.Name = "USA Aviators"
ITEM.Description = "You look like the terminator with these badass glasses on"
ITEM.Model = "models/gmod_tower/aviators.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2) + (ang:Up() * -0.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Up-n-Atom Bag"
ITEM.ID = 471
ITEM.Description = "The place to go for the finest of Burgers"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Smiley Bag"
ITEM.ID = 472
ITEM.Description = "Colon Closed Parentheses"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Pig Bag"
ITEM.ID = 473
ITEM.Description = "Unlimited Bacon within"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 10
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(10)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Reptilian Bag"
ITEM.ID = 474
ITEM.Description = "Does not provide Camouflage capabilities"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 11
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(11)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Meanie Bag"
ITEM.ID = 475
ITEM.Description = "Why you gotta be so rude"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 12
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(12)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Queasy Bag"
ITEM.ID = 476
ITEM.Description = "Good thing you have this bag if you need to puke"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 13
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(13)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Skull Bag"
ITEM.ID = 477
ITEM.Description = "Spooky Scary Skeleton"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 14
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(14)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Puppy Bag"
ITEM.ID = 478
ITEM.Description = "I will skin you alive if you do not stop barking"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 15
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(15)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Pink Ghost Bag"
ITEM.ID = 479
ITEM.Description = "Like Pinky from Pacman. But not. For Legal Reasons"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 16
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(16)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Alien Bag"
ITEM.ID = 480
ITEM.Description = "Stolen from the depths of Uranus"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 17
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(17)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Help Me Bag"
ITEM.ID = 481
ITEM.Description = "Help Me... Please"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 18
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(18)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Maze Bag"
ITEM.ID = 482
ITEM.Description = "Why isn't this just called a Spiral Bag"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 19
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(19)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Pretty Cry Bag"
ITEM.ID = 483
ITEM.Description = "Am I still beautiful.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "FU Bag"
ITEM.ID = 484
ITEM.Description = "This bag sums up how you feel after doing 150 of these"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 20
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(20)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Sir Bag"
ITEM.ID = 485
ITEM.Description = "For the most dapper of Gentlemen"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 21
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(21)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Stickers Bag"
ITEM.ID = 486
ITEM.Description = "Release your inner college kid"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 22
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(22)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Sheman Bag"
ITEM.ID = 487
ITEM.Description = "Wanna kiss sweetheart? Hmm.."
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 23
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(23)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Heart Bag"
ITEM.ID = 488
ITEM.Description = "Less than Three"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 24
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(24)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Bag"
ITEM.ID = 489
ITEM.Description = "Otherwise known as the 'Blackout Bag'"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 25
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(25)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Heart Bag"
ITEM.ID = 6488
ITEM.Description = "Less than Three"
ITEM.Rarity = 5
ITEM.NameColor = Color(255, 0, 255)
ITEM.Collection = "Valentine Collection"
ITEM.Skin = 24
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(24)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Shy Bag"
ITEM.ID = 490
ITEM.Description = "Not to be confused with Shy Guy"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Mob Boss Bag"
ITEM.ID = 491
ITEM.Description = "You are the Godfather"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Sharp Teeth Bag"
ITEM.ID = 492
ITEM.Description = "Jaws 5: Trouble in Terrorist Ocean"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Kiddo Bag"
ITEM.ID = 493
ITEM.Description = "Why would you bring Children into this"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Burger Shot Bag"
ITEM.ID = 494
ITEM.Description = "Let's hope Big Shot doesn't want to order from here"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Kill Me Bag"
ITEM.ID = 495
ITEM.Description = "That's pretty messed up"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(8)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Devil Bag"
ITEM.ID = 496
ITEM.Description = "Perfect for when you're setting people on fire"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 9
ITEM.Model = "models/sal/halloween/bag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(9)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.225098) + (ang:Right() * 0.245583) +  (ang:Up() * -0.539162)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8008
ITEM.Rarity = 5
ITEM.Name = "Bane Mask"
ITEM.Description = "ass batman villian that uses a super steroid called 'Venom' to destroy anything with brute strength."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bane/bane.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.861)+ (a:Up() * -1.637)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 99
ITEM.Name = "Batman Mask"
ITEM.Description = "Where the fuck is Rachel"
ITEM.Model = "models/gmod_tower/batmanmask.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.2) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bear Mask"
ITEM.ID = 497
ITEM.Description = "Give me a hug"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/bear.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.391235) + (ang:Right() * -0.229431) +  (ang:Up() * -0.777100)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8009
ITEM.Rarity = 4
ITEM.Name = "Bender Head"
ITEM.Description = "Blackmail is such an ugly word. I prefer extortion. The 'x' makes it sound cool."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bender/bender.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.861)+ (a:Right() * 0.314)+ (a:Up() * -6.522)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8032
ITEM.Rarity = 5
ITEM.Name = "Biblethump Mask"
ITEM.Description = "The face of a crying baby from the indie game The Binding of Isaac. Also a Twitch emote."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/isaac/isaac.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.9)
	p = p + (a:Forward() * -4.675)+ (a:Right() * -0.003)+ (a:Up() * -7.871)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8010
ITEM.Rarity = 3
ITEM.Name = "Billy Mask"
ITEM.Description = "The prettiest boy in all the land."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/billy/billy.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.454)+ (a:Right() * 0.008)+ (a:Up() * -5.909)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Stallion Mask"
ITEM.ID = 666
ITEM.Description = "You are a beautiful horse"
ITEM.Rarity = 7
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/horsie/horsiemask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bloody Bird Mask"
ITEM.ID = 668
ITEM.Description = "A very pale vulture feasts on terrorist souls"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bloody Butterfly Mask"
ITEM.ID = 650
ITEM.Description = "A very pale butterfly feasts on terrorist souls"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 2
ITEM.Model = "models/splicermasks/butterflymask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bloody Cat Mask"
ITEM.ID = 655
ITEM.Description = "Tearing up one face at a time"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/catmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bloody Rabbit Mask"
ITEM.ID = 651
ITEM.Description = "Who knew the easter bunny was hungry enough to eat human flesh"
ITEM.Rarity = 1
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/rabbitmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 100
ITEM.Name = "Bomberman Helmet"
ITEM.Description = "FOR THE GLORY OF ALLAH!!!"
ITEM.Model = "models/gmod_tower/bombermanhelmet.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8011
ITEM.Rarity = 6
ITEM.Name = "Bondrewd's Helmet"
ITEM.Description = "World's best dad"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/bondrewd/bondrewd.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -2.268)+ (a:Right() * -2.339)+ (a:Up() * 0.071)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Horsie Mask"
ITEM.ID = 665
ITEM.Description = "Neihhhh, feed me apples and take me to water"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 0
ITEM.Model = "models/horsie/horsiemask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.2) + (ang:Right() * 0) + (ang:Up() * 0.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8023
ITEM.Rarity = 6
ITEM.Name = "Captain Falcon's Helmet"
ITEM.Description = "FALCOOOOON PUNCH!!!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/falcon/falcon.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.152)+ (a:Right() * -0.002)+ (a:Up() * 0.055)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Cat Mask"
ITEM.ID = 504
ITEM.Description = "Nine Lives not included"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/cat.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.390503) + (ang:Right() * -0.228668) +  (ang:Up() * -0.152496)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Chuck Mask"
ITEM.ID = 662
ITEM.Description = "God Bless the Badass America"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/chuck_mask/chuck_mask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 2) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8068
ITEM.Rarity = 7
ITEM.Name = "Clout Goggles"
ITEM.Description = "A pair of iconic glasses that should be treasured and only worn by the best of people."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_clout_goggles.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -1.075)+ (a:Right() * 0.002)+ (a:Up() * 0.793)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Colorful Bird Mask"
ITEM.ID = 652
ITEM.Description = "You are a colorful human bird"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8093
ITEM.Rarity = 4
ITEM.Name = "Confined Cranium"
ITEM.Description = "Your thoughts will be trapped for eternity."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_skullcage.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.6)
	p = p + (a:Forward() * -4.078)+ (a:Right() * 0.088)+ (a:Up() * 0.208)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8013
ITEM.Rarity = 3
ITEM.Name = "Crusaders Helment"
ITEM.Description = "Join for Glory so all will remember you as a soldier of Moat"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/crusaders/crusaders.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.982)+ (a:Right() * 0.003)+ (a:Up() * -4.512)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 133
ITEM.Name = "Cubone Skull"
ITEM.Description = "I choose you"
ITEM.Model = "models/lordvipes/cuboneskull/cuboneskull.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.3, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Up() * -6.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8014
ITEM.Rarity = 7
ITEM.Name = "Daft Punk Helmet"
ITEM.Description = "She's up all night to the sun, I'm up all night to get some, She's up all night for good fun, I'm up all night to get lucky"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/daft/daft.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.15)
	p = p + (a:Forward() * -4.608)+ (a:Right() * 0.006)+ (a:Up() * -4.951)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8016
ITEM.Rarity = 5
ITEM.Name = "Darth Vader Helmet"
ITEM.Description = "Give yourself to the Dark Side. It is the only way you can save your friends. Yes, your thoughts betray you. Your feelings for them are strong."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/darthvader/darthvader.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -4.859)+ (a:Right() * 0.003)+ (a:Up() * -1.382)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8017
ITEM.Rarity = 4
ITEM.Name = "Demon Shank Mask"
ITEM.Description = "Raised from the depths of hell, to die, again and again"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/demonshank/demonshank.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.125)
	p = p + (a:Forward() * -4.646)+ (a:Right() * 0.009)+ (a:Up() * -3.553)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Doctor Mask"
ITEM.ID = 505
ITEM.Description = "The party wants their mask back"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/doctor.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	
	if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
	else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Gray Doctor Mask"
ITEM.ID = 506
ITEM.Description = "You don't need to hide your face with this"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/doctor.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	
	if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
	else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
	end
		
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Doctor Mask"
ITEM.ID = 507
ITEM.Description = "Black doctors are the best doctors out there"
ITEM.Rarity = 2
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/doctor.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	
	if (moat_TerroristModels[ply:GetModel()]) then
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -1.163300)
	else
		pos = pos + (ang:Forward() * -4.917358) + (ang:Right() * 0.063934) + (ang:Up() * -2.5)
	end
		
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Dolph Mask"
ITEM.ID = 661
ITEM.Description = "My horns will pierce any terrorist that gets in my way"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/dolph_mask/dolph_mask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8001
ITEM.Rarity = 7
ITEM.Name = "Duck Mask"
ITEM.Description = "The name is supposed to be Fuck Mask, but it was auto-corrected to Duck Mask?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/duck/duck.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * -6.317)+ (a:Right() * -0.03)+ (a:Up() * -5.161)
	a:RotateAroundAxis(a:Right(), 0.1)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Alien Egg Mask"
ITEM.ID = 853
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/weapons/v_slam/new light2"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Blue Egg Mask"
ITEM.ID = 854
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/shadertest/shader1_dudv"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Lava Egg Mask"
ITEM.ID = 852
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/props_lab/Tank_Glass001"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Money Egg Mask"
ITEM.ID = 855
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/props/cs_assault/moneytop"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Mysterious Egg Mask"
ITEM.ID = 856
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/props_lab/cornerunit_cloud"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Slime Sheet Egg Mask"
ITEM.ID = 857
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/effects/slimebubble_sheet"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Stained Glass Egg Mask"
ITEM.ID = 858
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/shadertest/shader5"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Wireframe Egg Mask"
ITEM.ID = 859
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/wireframe"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Wooden Egg Mask"
ITEM.ID = 860
ITEM.Description = "Quite the pretty egg head you got there"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"
ITEM.Model = "models/props_phx/misc/egg.mdl"
ITEM.Attachment = "eyes"
ITEM.EggMaterial = "models/props/CS_militia/roofbeams03"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local mat = Matrix()
	mat:Scale(Vector(3, 3, 3))
	model:EnableMatrix("RenderMultiply", mat)
	model:SetMaterial(self.EggMaterial)
	pos = pos + (ang:Forward() * -2.6) + (ang:Right() * 0) + (ang:Up() * -8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Bluesteel Egg Of Genius'
ITEM.ID = 9000
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/bluesteel_egg_of_genius.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Aqueous Egg Of River Riding'
ITEM.ID = 9001
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/aqueous_egg_of_river_riding.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Wikipedian Egg Of Alien Mind Control'
ITEM.ID = 9002
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/wikipedian_egg_of_alien_mind_control.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Vicious Egg Of Singularity'
ITEM.ID = 9003
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/vicious_egg_of_singularity.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Chrome Egg Of Speeding Bullet'
ITEM.ID = 9004
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/chrome_egg_of_speeding_bullet.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Dodge Egg'
ITEM.ID = 9005
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/dodge_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggotrip'
ITEM.ID = 9006
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggotrip.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Unassuming Egg Of Shyness'
ITEM.ID = 9007
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/unassuming_egg_of_shyness.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Dark Crimson Egg Of Nemesis'
ITEM.ID = 9008
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/dark_crimson_egg_of_nemesis.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Duskeye Egg Of The Crossroads'
ITEM.ID = 9009
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/duskeye_egg_of_the_crossroads.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Terrordactyl Egg'
ITEM.ID = 9010
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/terrordactyl_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggsplosive Bomb Egg'
ITEM.ID = 9011
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggsplosive_bomb_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggtus'
ITEM.ID = 9012
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggtus.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Strawbeggy'
ITEM.ID = 9013
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/strawbeggy.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Stooge Egg'
ITEM.ID = 9014
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/stooge_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Blinking Egg Of Relocation'
ITEM.ID = 9015
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/blinking_egg_of_relocation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Starry Egg Of The Wild Ride'
ITEM.ID = 9016
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/starry_egg_of_the_wild_ride.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Self Replicating Egg Of Grey Goo'
ITEM.ID = 9017
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/self_replicating_egg_of_grey_goo.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Rusty Egg Of Magnetism'
ITEM.ID = 9018
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/rusty_egg_of_magnetism.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Ruby Egg'
ITEM.ID = 9019
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/ruby_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Beehive Egg Of Infinite Stings'
ITEM.ID = 9020
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/beehive_egg_of_infinite_stings.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Puzzling Egg Of Enigma'
ITEM.ID = 9021
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/puzzling_egg_of_enigma.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Organic Egg'
ITEM.ID = 9022
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/organic_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Normal Egg'
ITEM.ID = 9023
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/normal_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of All-devouring Darkness'
ITEM.ID = 9024
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_all-devouring_darkness.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Lumineggscence'
ITEM.ID = 9025
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/lumineggscence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Kind Egg Of Sharing'
ITEM.ID = 9026
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/kind_egg_of_sharing.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggvertisement Egg'
ITEM.ID = 9027
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggvertisement_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Flawless Teamwork'
ITEM.ID = 9028
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_flawless_teamwork.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Invisible Egg Of Shadow'
ITEM.ID = 9029
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/invisible_egg_of_shadow.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggsterminator Egg'
ITEM.ID = 9030
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggsterminator_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Impossible Egg Of Genius'
ITEM.ID = 9031
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/impossible_egg_of_genius.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Cataclysmic Egg'
ITEM.ID = 9032
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cataclysmic_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Heat-seeking Egg'
ITEM.ID = 9033
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/heat-seeking_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Four Wonders'
ITEM.ID = 9034
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_four_wonders.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Golden Egg Of Kings'
ITEM.ID = 9035
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/golden_egg_of_kings.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Full Moon Egg'
ITEM.ID = 9036
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/full_moon_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Equinox Day'
ITEM.ID = 9037
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_equinox_day.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Extinct Egg Of Dino On Ice'
ITEM.ID = 9038
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/extinct_egg_of_dino_on_ice.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Fiery Egg Of Egg Testing'
ITEM.ID = 9039
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/fiery_egg_of_egg_testing.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Explosive Egg Of Kaboom'
ITEM.ID = 9040
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/explosive_egg_of_kaboom.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Invisible Egg Of Shadow Notinvisible'
ITEM.ID = 9041
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/invisible_egg_of_shadow_notinvisible.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Insanely Valuable Crystal Egg'
ITEM.ID = 9042
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/insanely_valuable_crystal_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Shield'
ITEM.ID = 9043
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_shield.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Subterranean Egg'
ITEM.ID = 9044
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/subterranean_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Bouncing Egg Of Boing Boing'
ITEM.ID = 9045
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/bouncing_egg_of_boing_boing.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg-bit'
ITEM.ID = 9046
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg-bit.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Verticality'
ITEM.ID = 9047
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_verticality.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Basic Egg'
ITEM.ID = 9048
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/basic_egg_2014.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Colored Dot Egg'
ITEM.ID = 9049
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/colored_dot_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Frostbitten Egg'
ITEM.ID = 9050
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/frostbitten_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Bombastic Egg Of Annihilation'
ITEM.ID = 9051
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/bombastic_egg_of_annihilation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggmageddon'
ITEM.ID = 9052
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggmageddon.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Epic Growth'
ITEM.ID = 9053
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_epic_growth.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Dust Deviled Egg'
ITEM.ID = 9054
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/dust_deviled_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Chocolate Egg'
ITEM.ID = 9055
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/chocolate_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Brighteyes Pink Egg Of Anticipation'
ITEM.ID = 9056
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/brighteyes_pink_egg_of_anticipation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Brighteyes Lavender Egg Of Anticipation'
ITEM.ID = 9057
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/brighteyes_lavender_egg_of_anticipation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Equinox Night'
ITEM.ID = 9058
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_equinox_night.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Destiny'
ITEM.ID = 9059
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_destiny.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Frost'
ITEM.ID = 9060
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_frost.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Arborists Verdant Egg Of Leafyness'
ITEM.ID = 9061
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/arborists_verdant_egg_of_leafyness.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.5049438476563) + (ang:Right() * 0.00201416015625) +  (ang:Up() * 0.56503295898438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Royal Agate Egg Of Beautiful Dreams'
ITEM.ID = 9062
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/royal_agate_egg_of_beautiful_dreams.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Radioactive Egg Of Undead Apocalypse'
ITEM.ID = 9063
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/radioactive_egg_of_undead_apocalypse.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tiger Egg'
ITEM.ID = 9064
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tiger_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tldr Egg'
ITEM.ID = 9065
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tldr_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Violently Pink Egg Of Violent Opinions'
ITEM.ID = 9066
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/violently_pink_egg_of_violent_opinions.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Friendship'
ITEM.ID = 9067
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_friendship.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Futuristic Egg Of Antigravity'
ITEM.ID = 9068
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/futuristic_egg_of_antigravity.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggscrutiatingly Deviled Scripter'
ITEM.ID = 9069
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggscrutiatingly_deviled_scripter.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Scenic Egg Of The Clouds'
ITEM.ID = 9070
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/scenic_egg_of_the_clouds.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Preggstoric Fossil'
ITEM.ID = 9071
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/preggstoric_fossil.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Shiny Gold Egg Of Switcheroo'
ITEM.ID = 9072
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/shiny_gold_egg_of_switcheroo.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Yolks On Us'
ITEM.ID = 9073
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/yolks_on_us.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Mean Eggstructor'
ITEM.ID = 9074
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/mean_eggstructor.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Aqua Pal Of Egglantis'
ITEM.ID = 9075
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/aqua_pal_of_egglantis.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Wanwood Egg Of Zomg'
ITEM.ID = 9077
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/wanwood_egg_of_zomg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Last Egg'
ITEM.ID = 9078
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_last_egg_2013.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Fiery Dreggon'
ITEM.ID = 9079
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/fiery_dreggon.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Elevated Egg Of The Eyrie'
ITEM.ID = 9080
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/elevated_egg_of_the_eyrie.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Cracked Egg Of Pwnage'
ITEM.ID = 9081
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cracked_egg_of_pwnage.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Rabid Egg'
ITEM.ID = 9082
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/rabid_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.4830322265625) + (ang:Right() * 0.535400390625) +  (ang:Up() * 6.05029296875)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Easiest Egg'
ITEM.ID = 9083
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_easiest_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggcellent Pearl'
ITEM.ID = 9084
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggcellent_pearl.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Bird Egg'
ITEM.ID = 9085
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/bird_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of The Phoenix'
ITEM.ID = 9086
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_the_phoenix.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Watermelon'
ITEM.ID = 9087
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/watermelon.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Mad Egg'
ITEM.ID = 9088
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_mad_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -3.113525390625) + (ang:Right() * 1.1524658203125) +  (ang:Up() * -0.19969940185547)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Cooperation'
ITEM.ID = 9089
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_cooperation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Cracked Egg'
ITEM.ID = 9090
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cracked_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Cloud Egg'
ITEM.ID = 9091
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_cloud_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Partnership'
ITEM.ID = 9092
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_partnership.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggsplosion'
ITEM.ID = 9093
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggsplosion.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Last Egg'
ITEM.ID = 9094
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_last_egg_2012.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Thundering Egg Of Lightning Strikes'
ITEM.ID = 9095
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/thundering_egg_of_lightning_strikes.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Eggverse'
ITEM.ID = 9096
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_eggverse.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Obsidian Egg'
ITEM.ID = 9097
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_obsidian_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.7972412109375) + (ang:Right() * 0.00634765625) +  (ang:Up() * 1.4794616699219)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Pow To The Moon Egg'
ITEM.ID = 9098
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/pow_to_the_moon_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggdress Of The Chief'
ITEM.ID = 9099
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggdress_of_the_chief.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'iEgg'
ITEM.ID = 9100
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/iegg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tldr Egg Of Eggstreme Aggravation'
ITEM.ID = 9101
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tldr_egg_of_eggstreme_aggravation.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Timer'
ITEM.ID = 9102
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_timer.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggy Pop'
ITEM.ID = 9103
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggy_pop.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Top Of The World Egg'
ITEM.ID = 9104
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/top_of_the_world_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Luregg'
ITEM.ID = 9105
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/luregg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Scrambled Egg'
ITEM.ID = 9106
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/scrambled_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Vanishing Ninja Egg'
ITEM.ID = 9107
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/vanishing_ninja_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Vampiric Egg Of Twilight'
ITEM.ID = 9108
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/vampiric_egg_of_twilight.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Dicey Egg Of Chance'
ITEM.ID = 9109
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/dicey_egg_of_chance.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Unstable Egg'
ITEM.ID = 9110
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/unstable_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Phantom Of The Egg'
ITEM.ID = 9111
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/phantom_of_the_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Pirate Egg'
ITEM.ID = 9112
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_pirate_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Answer Egg'
ITEM.ID = 9113
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_answer_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Lost In Transit Egg'
ITEM.ID = 9114
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/lost_in_transit_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Plum Nesting Egg'
ITEM.ID = 9115
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/plum_nesting_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Lemon Nesting Egg'
ITEM.ID = 9116
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/lemon_nesting_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Amber Egg'
ITEM.ID = 9117
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_amber_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -3.130859375) + (ang:Right() * 0.0819091796875) +  (ang:Up() * -0.20054626464844)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Fancy Egg Of Fabulous'
ITEM.ID = 9118
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/fancy_egg_of_fabulous.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Last Egg Standing'
ITEM.ID = 9119
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/last_egg_standing.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Mystical Eggchemist'
ITEM.ID = 9120
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/mystical_eggchemist.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Cherry Nesting Egg'
ITEM.ID = 9121
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cherry_nesting_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tesla Egg'
ITEM.ID = 9122
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tesla_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.725)
	pos = pos + (ang:Forward() * -3.4835205078125) + (ang:Right() * -0.01953125) +  (ang:Up() * 5.1614456176758)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tabby Egg'
ITEM.ID = 9123
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tabby_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Super Bomb Egg'
ITEM.ID = 9124
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/super_bomb_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Pompeiian Egg'
ITEM.ID = 9125
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/pompeiian_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Specular Egg Of Red No Blue'
ITEM.ID = 9126
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/specular_egg_of_red_no_blue.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Petrified Egg'
ITEM.ID = 9127
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/petrified_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Hyperactive Egg Of Hyperactivity'
ITEM.ID = 9128
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/hyperactive_egg_of_hyperactivity.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Seal Egg'
ITEM.ID = 9129
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/seal_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggvertisement Egg  Pastel Boogaloo'
ITEM.ID = 9130
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggvertisement_egg_2_pastel_boogaloo.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggcano'
ITEM.ID = 9131
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggcano.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggrachnophobia'
ITEM.ID = 9132
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggrachnophobia.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Zenos Egg Of Paradox'
ITEM.ID = 9133
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/zenos_egg_of_paradox.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Stationary Egg Of Boring'
ITEM.ID = 9134
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/stationary_egg_of_boring.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Sharing Egg Of Gifting'
ITEM.ID = 9135
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/sharing_egg_of_gifting.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Billy The Egg'
ITEM.ID = 9136
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/billy_the_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Pegguin'
ITEM.ID = 9137
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/pegguin.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Ra'
ITEM.ID = 9138
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_ra.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Scramblin Egg Of Teleporting'
ITEM.ID = 9139
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/scramblin_egg_of_teleporting.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Abyssal Egg'
ITEM.ID = 9140
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_abyssal_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Office Professional Egg'
ITEM.ID = 9141
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/office_professional_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg 9000'
ITEM.ID = 9142
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg9000.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Agonizingly Ugly Egg Of Screensplat'
ITEM.ID = 9143
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/agonizingly_ugly_egg_of_screensplat.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Farmer'
ITEM.ID = 9144
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_farmer.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Luck'
ITEM.ID = 9145
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_luck.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Deviled Egg'
ITEM.ID = 9146
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/deviled_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.66796875) + (ang:Right() * -2.6796875) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Flawless Deduction'
ITEM.ID = 9147
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_flawless_deduction.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Humpty Dumpty'
ITEM.ID = 9148
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/humpty_dumpty.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Martian Egghunter'
ITEM.ID = 9149
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/martian_egghunter.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Ebr Egg'
ITEM.ID = 9150
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/ebr_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggressor'
ITEM.ID = 9151
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggressor.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Peep-a-boo Egg'
ITEM.ID = 9152
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/peep-a-boo_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggvalanche!'
ITEM.ID = 9153
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggvalanche!.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Mummy Egg'
ITEM.ID = 9154
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/mummy_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.6668701171875) + (ang:Right() * -0.1138916015625) +  (ang:Up() * 2.0478210449219)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Faster Than Light Egg'
ITEM.ID = 9155
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/faster_than_light_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.8)
	pos = pos + (ang:Forward() * -3.838623046875) + (ang:Right() * 0.036529541015625) +  (ang:Up() * 0.59132385253906)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Admin Egg Of Mischief'
ITEM.ID = 9156
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/admin_egg_of_mischief.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -3.1535034179688) + (ang:Right() * -0.13259887695313) +  (ang:Up() * 3.657112121582)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Pearl'
ITEM.ID = 9157
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_pearl.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.735)
	pos = pos + (ang:Forward() * -3.7059326171875) + (ang:Right() * -0.14248657226563) +  (ang:Up() * 1.8225250244141)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Leftover Egg Of Whatevers Left'
ITEM.ID = 9158
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/leftover_egg_of_whatevers_left.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.8)
	pos = pos + (ang:Forward() * -0.37835693359375) + (ang:Right() * 0.055572509765625) +  (ang:Up() * 0.68265533447266)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Ethereal Ghost Egg'
ITEM.ID = 9159
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/ethereal_ghost_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.675)
	pos = pos + (ang:Forward() * -2.8767700195313) + (ang:Right() * 0.020477294921875) +  (ang:Up() * -0.04473876953125)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggtraterrestrial'
ITEM.ID = 9160
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggtraterrestrial.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -2.8681640625) + (ang:Right() * 0.01214599609375) +  (ang:Up() * 1.1173782348633)
	ang:RotateAroundAxis(ang:Right(), -107.69999694824)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Gge'
ITEM.ID = 9161
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/gge.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.306884765625) + (ang:Right() * 0.04052734375) +  (ang:Up() * 0.5899658203125)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 180)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Basket Of Eggception'
ITEM.ID = 9162
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/basket_of_eggception.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -2.7950134277344) + (ang:Right() * -0) +  (ang:Up() * 4.0573883056641)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Air Balloon Egg'
ITEM.ID = 9163
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/s.s_egg_-_the_mighty_dirigible.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.475)
	pos = pos + (ang:Forward() * -3.213623046875) + (ang:Right() * 0.0863037109375) +  (ang:Up() * -1.3739624023438)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Wizard Of Astral Isles'
ITEM.ID = 9164
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/wizard_of_astral_isles.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.575)
	pos = pos + (ang:Forward() * -3.4381103515625) + (ang:Right() * -0.14047241210938) +  (ang:Up() * 4.5401077270508)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Racin Egg Of Fast Cars'
ITEM.ID = 9165
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/racin_egg_of_fast_cars.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.1922607421875) + (ang:Right() * 0.07916259765625) +  (ang:Up() * 0.7210693359375)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Tiny Egg Of Nonexistence'
ITEM.ID = 9166
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/tiny_egg_of_nonexistence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * -0.1636962890625) +  (ang:Up() * 7.4242324829102)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Treasure Eggland'
ITEM.ID = 9167
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/treasure_eggland.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.85)
	pos = pos + (ang:Forward() * -3.4093017578125) + (ang:Right() * -0.14895629882813) +  (ang:Up() * 4.0108642578125)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Space'
ITEM.ID = 9168
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_space.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.9876098632813) + (ang:Right() * -0.25494384765625) +  (ang:Up() * 0.9698486328125)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -280.20001220703)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Eggcognito Egg'
ITEM.ID = 9169
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/eggcognito_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -2.7053833007813) + (ang:Right() * -0) +  (ang:Up() * 0.72085571289063)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Innocence'
ITEM.ID = 9170
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_innocence.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.35)
	pos = pos + (ang:Forward() * -3.1703491210938) + (ang:Right() * 0.00592041015625) +  (ang:Up() * 1.5388488769531)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Sands Of Time'
ITEM.ID = 9171
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_sands_of_time.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.81)
	pos = pos + (ang:Forward() * -2.5338745117188) + (ang:Right() * 0.51425170898438) +  (ang:Up() * 0.95062255859375)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Eggteen-twelve Overture'
ITEM.ID = 9172
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_eggteen-twelve_overture.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.66)
	pos = pos + (ang:Forward() * -2.2990112304688) + (ang:Right() * -0.16574096679688) +  (ang:Up() * 1.9350891113281)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Cannonical Egg'
ITEM.ID = 9173
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/cannonical_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -4.3116989135742) + (ang:Right() * 0.001953125) +  (ang:Up() * 1.3859100341797)
	ang:RotateAroundAxis(ang:Right(), -36.900001525879)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Alien Arteggfact'
ITEM.ID = 9174
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/alien_arteggfact.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -2.7769999504089) + (ang:Right() * -0) +  (ang:Up() * 1.1000000238419)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Bellegg'
ITEM.ID = 9175
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/bellegg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.75)
	pos = pos + (ang:Forward() * -2.7950134277344) + (ang:Right() * -0) +  (ang:Up() * 4.0573883056641)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Scribbled Egg'
ITEM.ID = 9176
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/scribbled_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.525)
	pos = pos + (ang:Forward() * -3.6149291992188) + (ang:Right() * 0.11465454101563) +  (ang:Up() * 2.0404052734375)
	ang:RotateAroundAxis(ang:Right(), -180)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Malicious Egg'
ITEM.ID = 9177
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/malicious_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.925)
	pos = pos + (ang:Forward() * -3.4658203125) + (ang:Right() * 0.069549560546875) +  (ang:Up() * 0.090347290039063)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Close Eggcounters'
ITEM.ID = 9178
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/close_eggcounters.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -3.3329467773438) + (ang:Right() * 0.014404296875) +  (ang:Up() * 7.0184783935547)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Life'
ITEM.ID = 9179
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_life.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	pos = pos + (ang:Forward() * -3.17578125) + (ang:Right() * 0.01104736328125) +  (ang:Up() * -2.2247161865234)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Sorcus Egg'
ITEM.ID = 9180
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/sorcus_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.61)
	pos = pos + (ang:Forward() * -2.7235717773438) + (ang:Right() * -0.86248779296875) +  (ang:Up() * 1.7162933349609)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Duty'
ITEM.ID = 9181
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_duty.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -3.3696899414063) + (ang:Right() * -0.02252197265625) +  (ang:Up() * 0.21257019042969)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 90)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Sand Shark Egg'
ITEM.ID = 9182
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/sand_shark_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.725)
	pos = pos + (ang:Forward() * -2.2077026367188) + (ang:Right() * 0.097442626953125) +  (ang:Up() * 1.2389678955078)
	ang:RotateAroundAxis(ang:Right(), 102.5)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Golden Achievement'
ITEM.ID = 9183
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_golden_achievement.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.3)
	pos = pos + (ang:Forward() * -3.373779296875) + (ang:Right() * 0.003173828125) +  (ang:Up() * 3.6561584472656)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Egg Of Scales'
ITEM.ID = 9184
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/egg_of_scales.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.575)
	pos = pos + (ang:Forward() * -3.9340209960938) + (ang:Right() * 0.02142333984375) +  (ang:Up() * 2.0720672607422)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 180)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Combo Egg Of Trolllolol'
ITEM.ID = 9185
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/combo_egg_of_trolllolol.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.6)
	pos = pos + (ang:Forward() * -2.29052734375) + (ang:Right() * 0.00537109375) +  (ang:Up() * 1.2985763549805)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Snowspheroid'
ITEM.ID = 9186
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/snowspheroid.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.81)
	pos = pos + (ang:Forward() * -2.9716796875) + (ang:Right() * 0.13156127929688) +  (ang:Up() * 2.1076202392578)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Mercurial Egg'
ITEM.ID = 9187
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/mercurial_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.65)
	pos = pos + (ang:Forward() * -3.898681640625) + (ang:Right() * 0.0714111328125) +  (ang:Up() * 2.8903656005859)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Supersonic Egg'
ITEM.ID = 9188
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/supersonic_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.61)
	pos = pos + (ang:Forward() * -2.2730712890625) + (ang:Right() * -0.17501831054688) +  (ang:Up() * 0.95858764648438)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'The Eggtopus'
ITEM.ID = 9189
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/the_eggtopus.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.735)
	pos = pos + (ang:Forward() * -3.684326171875) + (ang:Right() * -0.15023803710938) +  (ang:Up() * -2.4682464599609)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = 'Gooey Egg'
ITEM.ID = 9190
ITEM.Description = 'A rare cosmetic egg from the Easter holiday event! Right click while in loadout to customize position/size.'
ITEM.Rarity = 8
ITEM.Collection = 'Egg Hunt Collection'
ITEM.Model = 'models/roblox_assets/gooey_egg.mdl'
ITEM.Attachment = 'eyes'
function ITEM:ModifyClientsideModel(pl, mdl, pos, ang)
	mdl:SetModelScale(0.625)
	pos = pos + (ang:Forward() * -3.310546875) + (ang:Right() * 0.044525146484375) +  (ang:Up() * 7.1444625854492)
	
	return mdl, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 72
ITEM.Name = "El Mustache"
ITEM.Description = "You sir are the most handsome and dashing man in all of the server"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/mustache.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -2.4) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 7.6)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Fox Mask"
ITEM.ID = 508
ITEM.Description = "What does the fox say? Yep"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/fox.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.561279) + (ang:Right() * 0.079376) +  (ang:Up() * -0.346680)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8027
ITEM.Rarity = 2
ITEM.Name = "Gas Mask"
ITEM.Description = "This allows whoever is wearing the gas mask to inhale farts without plugging their nose."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/gasmask/gasmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.534)+ (a:Right() * -0.258)+ (a:Up() * -2.983)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 7002
ITEM.Name = "Gingerbread Mask"
ITEM.Description = "Please don't eat my face"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/sal/gingerbread.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.8)
	
	return model, pos, ang
end

/*
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/sal/gingerbread.mdl
		Position	=	-3.800000 0.000000 0.000000
		Size	=	1.1
		UniqueID	=	3503520631
		*/
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Vintage Glasses"
ITEM.ID = 509
ITEM.Description = "Like the Gray Vintage Glasses, but darker"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Silver Vintage Glasses"
ITEM.ID = 510
ITEM.Description = "At least it's better than Bronze"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Green Vintage Glasses"
ITEM.ID = 511
ITEM.Description = "Let's be honest. You look like the green hornet"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Vintage Glasses"
ITEM.ID = 512
ITEM.Description = "Hipster Style: Poop Version"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bronze Vintage Glasses"
ITEM.ID = 513
ITEM.Description = "Bronze. The Shiny Brown"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Gray Vintage Glasses"
ITEM.ID = 514
ITEM.Description = "Vintage - Black and White - Gray. It all adds up"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/modified/glasses01.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.869751) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -4)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Beach Raybands"
ITEM.ID = 515
ITEM.Description = "Perfect for when you strut your stuff in your Bathing Suit"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/glasses02.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Red Raybands"
ITEM.ID = 516
ITEM.Description = "A classic type of glasses which every hipster must have"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/glasses02.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Raybands"
ITEM.ID = 517
ITEM.Description = "Opposite to the Black Raybands"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/glasses02.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Raybands"
ITEM.ID = 518
ITEM.Description = "Opposite to the White Raybands"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/glasses02.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Raybands"
ITEM.ID = 519
ITEM.Description = "Disclaimer: These do not make you any cooler"
ITEM.Rarity = 1
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/modified/glasses02.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	if (moat_TerroristModels[ply:GetModel()]) then
		model:SetModelScale(1.15, 0)
		pos = pos + (ang:Forward() * -4.110229) + (ang:Right() * 0) +  (ang:Up() * 1)
	else
		pos = pos + (ang:Forward() * -3.7)
		ang:RotateAroundAxis(ang:Up(), 0)
	end
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 71
ITEM.Name = "Grandma Glasses"
ITEM.Description = "I hope these are big enough for you"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses04.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -1.4) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 7.6)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8028
ITEM.Rarity = 5
ITEM.Name = "Gray Fox Mask"
ITEM.Description = "Make me feel alive again!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/greyfox/greyfox.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.26)+ (a:Right() * -0.044)+ (a:Up() * -4.198)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5101
ITEM.Name = "Evil Clown Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/evil_clown.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5102
ITEM.Name = "Boar Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_boar.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5103
ITEM.Name = "White Bunny Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_bunny.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5104
ITEM.Name = "Gold Bunny Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_bunny_gold.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5105
ITEM.Name = "Chicken Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_chicken.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5106
ITEM.Name = "Devil Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_devil_plastic.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5107
ITEM.Name = "Blue Doll Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_porcelain_doll_kabuki.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5108
ITEM.Name = "Pumpkin Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_pumpkin.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5109
ITEM.Name = "Samurai Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_samurai.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5110
ITEM.Name = "Bloody Sheep Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_sheep_bloody.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5111
ITEM.Name = "Gold Sheep Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_sheep_gold.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5112
ITEM.Name = "Sheep Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_sheep_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5113
ITEM.Name = "Skull Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_skull.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5114
ITEM.Name = "Gold Skull Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_skull_gold.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5115
ITEM.Name = "Target Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_template.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5116
ITEM.Name = "TF2 Demo Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_demo_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5117
ITEM.Name = "TF2 Engineer Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_engi_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5118
ITEM.Name = "TF2 Heavy Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_heavy_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5119
ITEM.Name = "TF2 Medic Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_medic_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5120
ITEM.Name = "TF2 Pyro Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_pyro_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5121
ITEM.Name = "Chains Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_chains.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5122
ITEM.Name = "Dallas Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_dallas.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5123
ITEM.Name = "TF2 Scout Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_scout_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5124
ITEM.Name = "Hoxton Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_hoxton.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5125
ITEM.Name = "Wolf Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_wolf.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5133
ITEM.Name = "Pumpkin Head"
ITEM.Description = "An exclusive head mask from the Pumpkin Event"
ITEM.Model = "models/gmod_tower/halloween_pumpkinhat.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.875, 0)
	pos = pos + (ang:Forward() * -3.1) + (ang:Up() * -7.5) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5126
ITEM.Name = "TF2 Sniper Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_sniper_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5127
ITEM.Name = "TF2 Soldier Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_soldier_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5128
ITEM.Name = "TF2 Spy Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tf2_spy_model.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5129
ITEM.Name = "Tiki Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_tiki.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5130
ITEM.Name = "Zombie Fortune Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/facemask_zombie_fortune_plastic.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 5131
ITEM.Name = "Doll Facemask"
ITEM.Description = "An exclusive face mask from the Pumpkin Event"
ITEM.Model = "models/player/holiday/facemasks/porcelain_doll.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.225, 0)
	pos = pos + (ang:Forward() * 0.7) + (ang:Up() * 1.9) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8029
ITEM.Rarity = 1
ITEM.Name = "Hannibal Mask"
ITEM.Description = "Clarice..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/hannibal/hannibal.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -3.679)+ (a:Right() * -0.002)+ (a:Up() * -0.31)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8105
ITEM.Rarity = 2
ITEM.Name = "Anxious Hattington"
ITEM.Description = "Oh no! This isn't going to be good. Clench your butt! AHHHHHHHH"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 4
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8106
ITEM.Rarity = 2
ITEM.Name = "Ecstatic Hattington"
ITEM.Description = "Give yourself a round of applause. You're not banned!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 5
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8104
ITEM.Rarity = 2
ITEM.Name = "Impartial Hattington"
ITEM.Description = "I was going tell you how much you suck. Turns out you don't!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 3
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8101
ITEM.Rarity = 1
ITEM.Name = "Liberal Hattington"
ITEM.Description = "Oh what the f... fart."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8102
ITEM.Rarity = 1
ITEM.Name = "Pensive Hattington"
ITEM.Description = "Avert your eyes children! AVERT THEM!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8103
ITEM.Rarity = 1
ITEM.Name = "Cold Hattington"
ITEM.Description = "Good try, but try gooder."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_mask_hattington.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 2
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.45)
	p = p + (a:Forward() * -3.458)+ (a:Up() * 0.848)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Hawk Mask"
ITEM.ID = 401
ITEM.Description = "Show off your true Patriotism"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/hawk_1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "USA White Hawk Mask"
ITEM.ID = 2401
ITEM.Description = "Show off your true Patriotism"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Model = "models/sal/hawk_1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Hawk Mask"
ITEM.ID = 402
ITEM.Description = "Show off your true Patriotism"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/hawk_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "USA Brown Hawk Mask"
ITEM.ID = 2402
ITEM.Description = "Show off your true Patriotism"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Model = "models/sal/hawk_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.406860) + (ang:Right() * 0.094940) +  (ang:Up() * -3.257416)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Crime Scene Wrap"
ITEM.ID = 403
ITEM.Description = "CSI: TTT"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Arrows Wrap"
ITEM.ID = 404
ITEM.Description = "This way up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Caution Wrap"
ITEM.ID = 405
ITEM.Description = "Trust me. It's for the best that you're covered up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Red Arrow Wrap"
ITEM.ID = 406
ITEM.Description = "Like the superhero Green Arrow, but Red"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/headwrap1.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -3.935547) + (ang:Right() * -0.018433) +  (ang:Up() * -0.911530)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Gray Mummy Wrap"
ITEM.ID = 407
ITEM.Description = "50 Shades of Mummy. No, wait"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Mummy Wrap"
ITEM.ID = 408
ITEM.Description = "Not to be confused with Black Ninja Mask"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Mummy Wrap"
ITEM.ID = 409
ITEM.Description = "Tutankhamun, is that you"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Rainbow Mummy Wrap"
ITEM.ID = 410
ITEM.Description = "Some say there is Treasure at the end of the Rainbow"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/headwrap2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.167603) + (ang:Right() * 0.109802) +  (ang:Up() * -1.415833)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Heart Welder Mask"
ITEM.ID = 663
ITEM.Description = "You weld broken hearts back together"
ITEM.Rarity = 5
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/weldingmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Heart Welder Mask"
ITEM.ID = 6634
ITEM.Description = "You weld broken hearts back together"
ITEM.Rarity = 5
ITEM.NameColor = Color(255, 0, 255)
ITEM.Collection = "Valentine Collection"
ITEM.Model = "models/splicermasks/weldingmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.6) + (ang:Right() * 2.6) + (ang:Up() * -7.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8075
ITEM.Rarity = 4
ITEM.Name = "Hei Mask"
ITEM.Description = "Bearing the sins of the children of earth, the moon begins to consume it's light. What's Darker than Black?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_hat_darkerthenblack.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 1.361)+ (a:Up() * 0.001)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8024
ITEM.Rarity = 6
ITEM.Name = "Helmet of Fate"
ITEM.Description = "This is the Helmet of Fate. It is not a 'shiny target'. It holds untold power."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/fate/fate.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -5.006)+ (a:Right() * -0.002)+ (a:Up() * -1.971)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8506
ITEM.Rarity = 3
ITEM.Name = "Holiday Star Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_stars.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.524)+ (a:Right() * -0.035)+ (a:Up() * 1.509)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8031
ITEM.Rarity = 6
ITEM.Name = "Hollow Knight Mask"
ITEM.Description = "Brave the depths of a forgotten kingdom with this mask."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/hollow/hollow.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.369)+ (a:Right() * 0)+ (a:Up() * -5.281)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8098
ITEM.Rarity = 4
ITEM.Name = "Iron Helmet"
ITEM.Description = "+42 Damage resistance against dragons"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/moat/mg_helmet_iron.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -2.956)+ (a:Right() * -0.043)+ (a:Up() * 1.603)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8046
ITEM.Rarity = 4
ITEM.Name = "Jack-o-Lantern Mask"
ITEM.Description = "The pumpkin king comes to freight tonight..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/pumpkin/pumpkin.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -5.234)+ (a:Right() * -0.005)+ (a:Up() * -5.159)
	a:RotateAroundAxis(a:Up(), 93.9)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 103
ITEM.Name = "Jason Mask"
ITEM.Description = "Boo"
ITEM.Model = "models/gmod_tower/halloween_jasonmask.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -6.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8057
ITEM.Rarity = 6
ITEM.Name = "Kawaii Dozer Mask"
ITEM.Description = "SENPAI NOTICED ME"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/skullgirl/skullgirl.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.467)+ (a:Up() * -3.063)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 136
ITEM.Name = "Keaton Mask"
ITEM.Description = "What did the fox say"
ITEM.Model = "models/lordvipes/keatonmask/keatonmask.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.9, 0)
	pos = pos + (ang:Forward() * -5.6) + (ang:Up() * -0.4) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 110
ITEM.Name = "Lego Head"
ITEM.Description = "Everything is awesome"
ITEM.Model = "models/gmod_tower/legohead.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8033
ITEM.Rarity = 6
ITEM.Name = "Level 3 Helmet"
ITEM.Description = "Bite the bullet"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/lvl3/lvl3.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.479)+ (a:Right() * -0.001)+ (a:Up() * -1.422)
	a:RotateAroundAxis(a:Up(), 90)
	a:RotateAroundAxis(a:Forward(), 7.1)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8034
ITEM.Rarity = 5
ITEM.Name = "Magneto's Helmet"
ITEM.Description = "Mankind has always feared what it doesn't understand"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/magneto/magneto.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -4.701)+ (a:Right() * -0.002)+ (a:Up() * -1.711)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 139
ITEM.Name = "Majora's Mask"
ITEM.Description = "It is a colorful mask"
ITEM.Model = "models/lordvipes/majoramask/majoramask.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -9.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8040
ITEM.Rarity = 2
ITEM.Name = "Majora's Moon Mask"
ITEM.Description = "I... I shall consume. Consume... Consume everything.."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/moon/moon.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.979)+ (a:Right() * -0.001)+ (a:Up() * -0.718)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 140
ITEM.Name = "Makar's Mask"
ITEM.Description = "That's a very nice leaf you have there"
ITEM.Model = "models/lordvipes/makarmask/makarmask.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(2.2, 0)
	pos = pos + (ang:Forward() * -4.4) + (ang:Up() * -9.6) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), -16)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8035
ITEM.Rarity = 6
ITEM.Name = "Marshmello's Helmet"
ITEM.Description = "I heard you keeping it 'Mello' Eh Eh no okay..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/marshmello/marshmello.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * -4.226)+ (a:Right() * 0.023)+ (a:Up() * -5.588)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Blue Hockey Mask"
ITEM.ID = 417
ITEM.Description = "It's what a blue Jason would wear"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bulldog Hockey Mask"
ITEM.ID = 418
ITEM.Description = "Woof woof back the fuck up"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Electric Hockey Mask"
ITEM.ID = 419
ITEM.Description = "Zap me into the hockey rink sir"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 10
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(10)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Skull Hockey Mask"
ITEM.ID = 420
ITEM.Description = "Made from the Skull of a previous victim"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 11
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(11)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Patch Hockey Mask"
ITEM.ID = 421
ITEM.Description = "Made from the skin of previous victims"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 12
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(12)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Patch 2 Hockey Mask"
ITEM.ID = 422
ITEM.Description = "The Highly Anticipated Sequel to Patch Hockey Mask"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 13
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(13)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Something Hockey Mask"
ITEM.ID = 423
ITEM.Description = "It could be anything"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 14
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(14)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Wolf Hockey Mask"
ITEM.ID = 424
ITEM.Description = "How is a Wolf meant to hold the Hockey Stick"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bear Hockey Mask"
ITEM.ID = 425
ITEM.Description = "I'd love to actually see Bears playing Hockey"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Dog Hockey Mask"
ITEM.ID = 426
ITEM.Description = "Dog backwards is God"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Crown Hockey Mask"
ITEM.ID = 427
ITEM.Description = "This does not make you the new Queen of England."
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Monster Hockey Mask"
ITEM.ID = 428
ITEM.Description = "Sponsored by Monster Energy Drink"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Monster 2 Hockey Mask"
ITEM.ID = 429
ITEM.Description = "The Highly Anticipated Sequel to Monster Hockey Mask"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Flame Hockey Mask"
ITEM.ID = 430
ITEM.Description = "Keep away from Flamable objects"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(8)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "GFlame Hockey Mask"
ITEM.ID = 431
ITEM.Description = "For when you want your flames a little more Green"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 9
ITEM.Model = "models/sal/acc/fix/mask_2.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(9)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.216187) + (ang:Right() * 0.022186) +  (ang:Up() * -0.913788)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Steel Armor Mask"
ITEM.ID = 432
ITEM.Description = "Become a Knight of the Realm"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Circuit Armor Mask"
ITEM.ID = 433
ITEM.Description = "It's like an unmasked Robot Face"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Lava Armor Mask"
ITEM.ID = 434
ITEM.Description = "Feeling Hot Hot Hot"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Purple Armor Mask"
ITEM.ID = 435
ITEM.Description = "Bright Purple. Why not"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Carbon Armor Mask"
ITEM.ID = 436
ITEM.Description = "Although it's hard to break. This won't save you from Headshots"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Bullseye Armor Mask"
ITEM.ID = 437
ITEM.Description = "Aim for between the eyes"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Stone Armor Mask"
ITEM.ID = 438
ITEM.Description = "The weight of this seems impractical"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Lightning Armor Mask"
ITEM.ID = 439
ITEM.Description = "How long until you hear the thunder? Hmm.."
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Wood Armor Mask"
ITEM.ID = 440
ITEM.Description = "Smells like paper"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/sal/acc/fix/mask_4.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(8)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Please Stop Mask"
ITEM.ID = 441
ITEM.Description = "Ripped straight from a Horror Movie"
ITEM.Rarity = 4
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/modified/mask5.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.338135) + (ang:Right() * 0.040802) +  (ang:Up() * -1.451752)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Skull Cover"
ITEM.ID = 442
ITEM.Description = "2spooky4me"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Gray Skull Cover"
ITEM.ID = 443
ITEM.Description = "It's actually Purple with the Grayscale Filter applied"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Tan Skull Cover"
ITEM.ID = 444
ITEM.Description = "Perfect whilst pulling off the perfect Heist"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Green Skull Cover"
ITEM.ID = 445
ITEM.Description = "We all have Skulls. Why not show it off"
ITEM.Rarity = 7
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/modified/mask6.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	pos = pos + (ang:Forward() * -3.950562) + (ang:Right() * 0.060364) +  (ang:Up() * -2.116272)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8036
ITEM.Rarity = 5
ITEM.Name = "Mega Man Helmet"
ITEM.Description = "Watch out for the spikes blocks."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/megaman/megaman.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -11.287)+ (a:Right() * -0.006)+ (a:Up() * -1.14)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8513
ITEM.Rarity = 7
ITEM.Name = "Merry Xmas Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_xmas.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -1.135)+ (a:Right() * 0.002)+ (a:Up() * 2.996)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 113
ITEM.Name = "Metaknight Mask"
ITEM.Description = "Where the fuck is Kirby"
ITEM.Model = "models/gmod_tower/metaknight_mask.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.2, 0)
	pos = pos + (ang:Forward() * 1.8) + (ang:Up() * -4.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8037
ITEM.Rarity = 3
ITEM.Name = "Metroid Hat"
ITEM.Description = "I first battled the Metroids on planet Zebes. It was there that I foiled the plans of the Space Pirate leader, Mother Brain, to use the creatures to attack galactic civilization."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/metroid/metroid.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -7.034)+ (a:Right() * -0.001)+ (a:Up() * 7.255)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8038
ITEM.Rarity = 5
ITEM.Name = "Miraak's Mask"
ITEM.Description = "That name sounds familiar, but I just can't put my finger on it.."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/miraak/miraak.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.986)+ (a:Right() * -0.002)+ (a:Up() * -3.053)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Monkey Mask"
ITEM.ID = 446
ITEM.Description = "Exactly what it says on the tin"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Monkey Mask"
ITEM.ID = 447
ITEM.Description = "King Kong. Is that you? Hmm.."
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Zombie Monkey Mask"
ITEM.ID = 448
ITEM.Description = "Please refrain from the dead Harambe memes"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Old Monkey Mask"
ITEM.ID = 449
ITEM.Description = "Basically Cranky Kong"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/monkey.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 85
ITEM.Name = "Monocle"
ITEM.Description = "You probably think you're smart now. That's incorrect"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/monocle.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1.2) + (ang:Right() * -2.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 22.4)
	ang:RotateAroundAxis(ang:Up(),-9)
	ang:RotateAroundAxis(ang:Forward(), 153.8)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8039
ITEM.Rarity = 3
ITEM.Name = "Monstro Head"
ITEM.Description = "Biblethump had a baby, and it's pretty weird looking."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/monstro/monstro.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.76)
	p = p + (a:Forward() * -4.334)+ (a:Right() * -0.005)+ (a:Up() * -5.066)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8063
ITEM.Rarity = 6
ITEM.Name = "Night Vision Goggles"
ITEM.Description = "Either this guy is hacking, or he actually managed to turn on the goggles..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trihelmet/trihelmet.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.437)+ (a:Right() * 0.185)+ (a:Up() * 0.442)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Ninja Mask"
ITEM.ID = 450
ITEM.Description = "Disclaimer: Does not make you an actual Ninja"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Ninja Mask"
ITEM.ID = 451
ITEM.Description = "How is this meant to help you stay hidden in the shadows"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Police Ninja Mask"
ITEM.ID = 452
ITEM.Description = "Police Ninja. Sounds like the best movie ever"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 10
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(10)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "USA Police Ninja Mask"
ITEM.ID = 2452
ITEM.Description = "Police Ninja. Sounds like the best movie ever"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Skin = 10
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(10)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Tan Ninja Mask"
ITEM.ID = 453
ITEM.Description = "For when you want your Ninja Mask to look like your own face"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Benders Ninja Mask"
ITEM.ID = 454
ITEM.Description = "This is not related to Futurama. Unfortunately"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Justice Ninja Mask"
ITEM.ID = 455
ITEM.Description = "Become a member of the Justice League"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 4
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(4)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Camo Ninja Mask"
ITEM.ID = 456
ITEM.Description = "Who is that dude without a head"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 5
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(5)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Candy Ninja Mask"
ITEM.ID = 457
ITEM.Description = "The latest franchise in the Candy Crush saga"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 6
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(6)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "LoveFist Ninja Mask"
ITEM.ID = 458
ITEM.Description = "Sounds like a Euphemism"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 7
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(7)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "TPI Ninja Mask"
ITEM.ID = 459
ITEM.Description = "TPI: Turtle People Indeed"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 8
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(8)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Pink Ninja Mask"
ITEM.ID = 460
ITEM.Description = "The latest must-have accessory for Barbie"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 9
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(9)
	model:SetModelScale(1.1)
	pos = pos + (ang:Forward() * -4.500366) + (ang:Right() * -0.229553) +  (ang:Up() * -1.120453)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 20
ITEM.Name = "No Entry Mask"
ITEM.Description = "No man shall enter your face again"
ITEM.Model = "models/props_c17/streetsign004f.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Alpha Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.7, 0)
	pos = pos + (ang:Forward() * 3)
	ang:RotateAroundAxis(ang:Up(), -90)
	
	return model, pos, ang
	
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 115
ITEM.Name = "No Face Mask"
ITEM.Description = "Where did your face go?"
ITEM.Model = "models/gmod_tower/noface.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * 1.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8042
ITEM.Rarity = 7
ITEM.Name = "Ori Mask"
ITEM.Description = "When my child's strength faltered, and the last breath was drawn, my light revived Ori, a new age had dawned."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/ori/ori.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -5.785)+ (a:Right() * 0.154)+ (a:Up() * -4.91)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Owl Mask"
ITEM.ID = 461
ITEM.Description = "Does not improve Night Vision"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/owl.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.365112) + (ang:Right() * 0.059586) +  (ang:Up() * -1.330437)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Peacock Butterfly Mask"
ITEM.ID = 660
ITEM.Description = "Don't put me in a zoo please"
ITEM.Rarity = 4
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/splicermasks/butterflymask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1.6) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8043
ITEM.Rarity = 4
ITEM.Name = "Pennywise Mask"
ITEM.Description = "You'll float too."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/pennywise/pennywise.mdl"
ITEM.Attachment = "eyes"
ITEM.Skin = 1
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.206)+ (a:Right() * -0.004)+ (a:Up() * -2.71)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Pig Mask"
ITEM.ID = 462
ITEM.Description = "Bacon not included"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/pig.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Zombie Pig Mask"
ITEM.ID = 463
ITEM.Description = "Please not another Minecraft Reference"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/pig.mdl"
ITEM.Attachment = "eyes"

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -4.220093) + (ang:Right() * 0.055542) +  (ang:Up() * -1.410973)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Po Mask"
ITEM.ID = 664
ITEM.Description = "The panda is a great animal and will always be named Po"
ITEM.Rarity = 6
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 1
ITEM.Model = "models/jean-claude_mask/jean-claude_mask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * 0)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8045
ITEM.Rarity = 5
ITEM.Name = "Psycho Mask"
ITEM.Description = "Strip the flesh, Salt the wound."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/psycho/psycho.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.987)+ (a:Right() * -0.002)+ (a:Up() * -5.456)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 84
ITEM.Name = "Scary Pumpkin"
ITEM.Description = "Shine bright like a pumpkin"
ITEM.Model = "models/captainbigbutt/skeyler/hats/pumpkin.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -3) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8049
ITEM.Rarity = 2
ITEM.Name = "ReDead Mask"
ITEM.Description = "Reeeeeee!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/redead/redead.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.025)
	p = p + (a:Forward() * 0.942)+ (a:Right() * 0.253)+ (a:Up() * -1.381)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8503
ITEM.Rarity = 4
ITEM.Name = "Reindeer Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_reindeer.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.738)+ (a:Right() * -0.023)+ (a:Up() * 0.752)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8050
ITEM.Rarity = 5
ITEM.Name = "Robocop Helmet"
ITEM.Description = "Dead or Alive, you're coming with me."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/robocop/robocop.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.054)+ (a:Right() * 0.079)+ (a:Up() * 2.747)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Royal Cat Mask"
ITEM.ID = 657
ITEM.Description = "Don't touch me, I'm fabulous"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/catmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0.6) + (ang:Up() * -4.6)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Royal Rabbit Mask"
ITEM.ID = 653
ITEM.Description = "Hop hop hop... here comes the royal easter bunny"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/rabbitmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.8) + (ang:Right() * 0) + (ang:Up() * -2.4)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Royal Spider Mask"
ITEM.ID = 654
ITEM.Description = "The itsy bitsy spider crawled up the royal kingdom"
ITEM.Rarity = 2
ITEM.Collection = "Crimson Collection"
ITEM.Model = "models/splicermasks/spidermask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 1) + (ang:Right() * 0) + (ang:Up() * -1.8)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 118
ITEM.Name = "Rubiks Cube"
ITEM.Description = "You can't solve this one"
ITEM.Model = "models/gmod_tower/rubikscube.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.6, 0)
	pos = pos + (ang:Forward() * -2.8) + (ang:Up() * 1) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8051
ITEM.Rarity = 3
ITEM.Name = "Saiyan Scouter"
ITEM.Description = "Something, something, power level, something, 9000..."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/saiyanvisor/saiyanvisor.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -4.051)+ (a:Right() * 0.689)+ (a:Up() * 0.917)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 119
ITEM.Name = "Samus Helmet"
ITEM.Description = "It's a girl"
ITEM.Model = "models/gmod_tower/samushelmet.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.05, 0)
	pos = pos + (ang:Forward() * -2.05) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8504
ITEM.Rarity = 3
ITEM.Name = "Santa Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_santa.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.741)+ (a:Right() * -0.029)+ (a:Up() * 1.508)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8505
ITEM.Rarity = 3
ITEM.Name = "Santa Hat Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_santahat.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.524)+ (a:Right() * -0.035)+ (a:Up() * 1.509)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8052
ITEM.Rarity = 5
ITEM.Name = "Sauron's Helmet"
ITEM.Description = "Kneel before the witch king!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/sauron/sauron.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.075)
	p = p + (a:Forward() * -3.261)+ (a:Right() * -0.597)+ (a:Up() * -3.087)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8053
ITEM.Rarity = 4
ITEM.Name = "Scream Mask"
ITEM.Description = "You're not going to pee alone any more. If you pee, I pee. Is that clear?"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/scream/scream.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.517)+ (a:Up() * -3.868)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 77
ITEM.Name = "Servbot Head"
ITEM.Description = "Smile"
ITEM.Model = "models/lordvipes/servbothead/servbothead.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.8, 0)
	pos = pos + (ang:Forward() * -2.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8055
ITEM.Rarity = 6
ITEM.Name = "Shovel Knight Helmet"
ITEM.Description = "SHOVEL JUSTICE!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/shovel/shovel.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.488)+ (a:Right() * 0.009)+ (a:Up() * -5.436)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 70
ITEM.Name = "Shutter Glasses"
ITEM.Description = "The party is just getting started"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses03.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 7.6)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 2070
ITEM.Name = "USA Shutter Glasses"
ITEM.Description = "The party is just getting started"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses03.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Independence Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -0.8) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 7.6)
	return model, pos, ang
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Gray Skull Mask"
ITEM.ID = 464
ITEM.Description = "It's actually Purple with the Grayscale Filter applied"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Brown Skull Mask"
ITEM.ID = 465
ITEM.Description = "Perfect whilst pulling off the perfect Heist"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "White Skull Mask"
ITEM.ID = 466
ITEM.Description = "We all have Skulls. Why not show it off"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 2
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Black Skull Mask"
ITEM.ID = 467
ITEM.Description = "2spooky4me"
ITEM.Rarity = 5
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 3
ITEM.Model = "models/sal/halloween/skull.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(3)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.471313) + (ang:Right() * 0.043533) +  (ang:Up() * 0.217781)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 122
ITEM.Name = "Snowboard Goggles"
ITEM.Description = "We don't need snow to wear these"
ITEM.Model = "models/gmod_tower/snowboardgoggles.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3.8) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 7003
ITEM.Name = "Snowman Head"
ITEM.Description = "Frosty the terrorist"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/props/cs_office/snowman_face.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    model:SetModelScale(1.1, 0)
    pos = pos + (ang:Forward() * -2.5) + (ang:Up() * 0.5)
    ang:RotateAroundAxis(ang:Up(), -90)
    
	return model, pos, ang
end
/*
		Angles	=	0.000 -90.000 0.000
		Bone	=	eyes
		ClassName	=	model
		Model	=	models/props/cs_office/Snowman_face.mdl
		Position	=	-2.500000 0.000000 0.500000
		Size	=	1.1
		UniqueID	=	3503520631
		*/
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8059
ITEM.Rarity = 7
ITEM.Name = "Spawn Mask"
ITEM.Description = "You sent me to Hell. I'm here to return the favor."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/spawn/spawn.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -5.296)+ (a:Right() * 2.1)+ (a:Up() * -93.192)
	a:RotateAroundAxis(a:Up(), -90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 124
ITEM.Name = "Star Glasses"
ITEM.Description = "Too good for regular glasses"
ITEM.Model = "models/gmod_tower/starglasses.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1.4) + (ang:Up() * -0.2) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8064
ITEM.Rarity = 7
ITEM.Name = "Stormtrooper Helmet"
ITEM.Description = "You can go about your business."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trooperhelmet/trooperhelmet.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.786)+ (a:Right() * 0.008)+ (a:Up() * -5.99)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 69
ITEM.Name = "Stylish Glasses"
ITEM.Description = "Work those pretty little things gurl"
ITEM.Model = "models/captainbigbutt/skeyler/accessories/glasses02.mdl"
ITEM.Rarity = 2
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -1.2) + (ang:Up() * -1.2) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 7.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 134
ITEM.Name = "Tomas Helmet"
ITEM.Description = "Hit that"
ITEM.Model = "models/lordvipes/daftpunk/thomas.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -3.2) + (ang:Up() * -0.6) + m_IsTerroristModel(ply:GetModel())
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 128
ITEM.Name = "Toro Mask"
ITEM.Description = ":3"
ITEM.Model = "models/gmod_tower/toromask.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Cosmetic Collection"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -4.6) + (ang:Up() * -0.8) + m_IsTerroristModel(ply:GetModel())
	ang:RotateAroundAxis(ang:Right(), 10.6)
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8062
ITEM.Rarity = 3
ITEM.Name = "Trapper's Mask"
ITEM.Description = "Perfect to cover a bald head and an ugly face!"
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/trapper/trapper.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.05)
	p = p + (a:Forward() * 0.378)+ (a:Right() * 0.243)+ (a:Up() * -0.971)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8532
ITEM.Rarity = 3
ITEM.Name = "Santa's Trash"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/custom_prop/moatgaming/trashbag/trashbag.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(0.8)
	p = p + (a:Forward() * -3.711)+ (a:Right() * -0.119)+ (a:Up() * -8.322)
	a:RotateAroundAxis(a:Up(), 180)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Turqoise Bird Mask"
ITEM.ID = 656
ITEM.Description = "I'm feelying quite blue and gray right now"
ITEM.Rarity = 3
ITEM.Collection = "Crimson Collection"
ITEM.Skin = 2
ITEM.Model = "models/splicermasks/birdmask.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(2)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * 0.2) + (ang:Right() * 0) + (ang:Up() * -3)
	ang:RotateAroundAxis(ang:Right(), -0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8065
ITEM.Rarity = 6
ITEM.Name = "Vault Boy Mask"
ITEM.Description = "The real pussy destroyer. I'm a motherfuckin' pimp-ass mask who loves hot babes on the daily."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/vaultboy/vaultboy.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	m:SetModelScale(1.1)
	p = p + (a:Forward() * -4.758)+ (a:Right() * 0.015)+ (a:Up() * 1.482)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Wolf Mask"
ITEM.ID = 468
ITEM.Description = "May cause violent outbursts of howling at a Full Moon"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Model = "models/sal/wolf.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1.05)
	pos = pos + (ang:Forward() * -4.468628) + (ang:Right() * 0.039375) +  (ang:Up() * -2.770370)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8514
ITEM.Rarity = 5
ITEM.Name = "Xmas Tree Glasses"
ITEM.Description = "Special swag item from the 2018 Holiday Event! Right click while in loadout to customize position or size."
ITEM.Collection = "Holiday Collection"
ITEM.Model = "models/moat/mg_glasses_xmastree.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -1.427)+ (a:Right() * 0.001)+ (a:Up() * 2.779)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8067
ITEM.Rarity = 5
ITEM.Name = "Zahkriisos' Mask"
ITEM.Description = "The dragon mask acquired from the remains of Zahkriisos, one of four named Dragon Priests on Solstheim."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/zhariisos/zhariisos.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * 0.111)+ (a:Up() * -3.485)
	a:RotateAroundAxis(a:Up(), 90)

	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 8066
ITEM.Rarity = 6
ITEM.Name = "Zer0's Mask"
ITEM.Description = "Your eyes deceive you, an illusion fools you all."
ITEM.Collection = "Hype Collection"
ITEM.Model = "models/custom_prop/moatgaming/zero/zero.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(pl, m, p, a)
	p = p + (a:Forward() * -3.427)+ (a:Up() * -5.324)
	return m, p, a
end
m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Zombie Mask"
ITEM.ID = 469
ITEM.Description = "Unfortunately you can't eat the corpses while wearing this"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 0
ITEM.Model = "models/sal/halloween/zombie.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(0)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.Name = "Stone Zombie Mask"
ITEM.ID = 470
ITEM.Description = "For those who enjoy Roleplaying a Gargoyle"
ITEM.Rarity = 6
ITEM.Collection = "Urban Style Collection"
ITEM.Skin = 1
ITEM.Model = "models/sal/halloween/zombie.mdl"
ITEM.Attachment = "eyes"
function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetSkin(1)
	model:SetModelScale(1.1, 0)
	pos = pos + (ang:Forward() * -4.030151) + (ang:Right() * 0.035046) +  (ang:Up() * -1.245018)
	
	return model, pos, ang
end

m_AddDroppableItem(ITEM, 'Mask')
if (CLIENT) then m_AddCosmeticItem(ITEM, 'Mask') end

ITEM = {}
ITEM.ID = 68
ITEM.Name = "Credit Goblin"
ITEM.NameColor = Color(0, 255, 128)
ITEM.Description = "%s_ chance to receive 1 credit after a kill when using this power-up"
ITEM.Image = "https://static.moat.gg/ttt/credit_goblin64.png" 
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
ITEM.Stats = {
	{min = 30, max = 60}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	ply.CreditGoblin = self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])
end
m_AddDroppableItem(ITEM, 'Power-Up')

ITEM = {}
ITEM.ID = 79
ITEM.Name = "Silent"
ITEM.NameColor = Color(83, 183, 255)
ITEM.Description = "Your footsteps are muffled and killing someone has a %s_ chance to muffle their screams"
ITEM.Image = "https://static.moat.gg/ttt/silent64.png"
ITEM.Rarity = 4
ITEM.Collection = "Aqua Palm Collection"
ITEM.Stats = {
	{min = 50, max = 90}
}
function ITEM:OnPlayerSpawn(ply, powerup_mods)
	ply.SilentPower = self.Stats[1].min + ((self.Stats[1].max - self.Stats[1].min) * powerup_mods[1])
	ply:SetNW2Bool("SilentPower", true)
end
m_AddDroppableItem(ITEM, 'Power-Up')