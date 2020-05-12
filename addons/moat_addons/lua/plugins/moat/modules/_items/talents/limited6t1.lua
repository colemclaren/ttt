if (not TALENT) then
    TALENT = {DoThing=true}
end
TALENT.ID = 34
TALENT.Name = "Wild! - Tier 1"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255,0)
TALENT.Description = "After a kill, you have a %s_^ chance to add a random Tier 1 talent to your gun with its lowest stats possible"
TALENT.Tier = 1
TALENT.LevelRequired = {min = -5, max = -10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 40, max = 70}

TALENT.Melee = false
TALENT.NotUnique = false

if (SERVER) then
	util.AddNetworkString("weapon.UpdateTalents")

	local tier = 1
	local id = TALENT.ID
	function wild_t1(weapon,talent_mods)
		if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
		local talents = table.Copy(MOAT_TALENTS)

		local active = weapon.Talents[tier].l <= weapon.level
		if (not active) then return end


		for k,v in pairs(talents) do 
			if v.Tier ~= tier or v.ID == id or (v.ID == 154) or (v.ID == 31) or ((v.Collection or "") == "Omega Collection") or v.ID == 98 then 
				talents[k] = nil 
			end 
		end

		local talent, tk = table.Random(talents)

		local t = {
			e = talent.ID,
			l = weapon.Talents[tier].l,
			m = {}
		}

		for k,v in pairs(talent.Modifications) do
			t.m[k] = 0
		end
		-- weapon.Weapon.Talents[tier] = t
		-- weapon.Weapon.ItemStats.t[tier] = t
		-- weapon.Weapon.ItemStats.Talents[tier] = talent


		local function dotalent()
			print(weapon)
			table.insert(weapon.Weapon.Talents,t)
			table.insert(weapon.Weapon.ItemStats.t,t)
			table.insert(weapon.Weapon.ItemStats.item.Talents,talent)

			if loadout_weapon_indexes[weapon.Weapon:EntIndex()] then
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,t)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = t
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t,t)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.t[tier] = t
				table.insert(loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents,talent)
				-- loadout_weapon_indexes[weapon.Weapon:EntIndex()].info.Talents[tier] = talent
			end

			if talent.OnWeaponSwitch then
				talent:OnWeaponSwitch(weapon:GetOwner(), weapon, true, t.m)
			end
			m_ApplyTalentsToWeapon(weapon.Weapon,t)
		end

		if talent.ID == 69 then
			timer.Simple(5, dotalent)
		else
			dotalent()
		end

		for k,v in pairs(talent) do
			if isfunction(v) then talent[k] = nil end
		end

		net.Start("weapon.UpdateTalents")
		net.WriteBool(true)
		net.WriteEntity(weapon.Weapon)
		net.WriteInt(tier,8)
		net.WriteTable(talent)
		net.WriteTable(t)
		net.Broadcast()

	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) and GetRoundState() ~= ROUND_PREP then
    	wild_t1(att:GetActiveWeapon(),talent_mods)
    end
end
if (TALENT.DoThing) then
    MOAT_TALENTS[TALENT.ID] = TALENT
    TALENT.DoThing = nil
    TALENT = nil
end