
TALENT.ID = 9030
TALENT.Name = "Copycat"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(255, 0, 0)
TALENT.Description = "Every kill with this weapon has a %s_^ chance to copy itself into the weapon of your dead enemy"
TALENT.Tier = 1
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.LevelRequired = {min = 5, max = 10}
-- TALENT.LevelRequired = {min = -5, max = -10}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 25, max = 50} // Percent damage is increased by

util.AddNetworkString("Switch_wep_primary")
function _switch_wep_talent(att,vic)
	local orig_wep = att:GetActiveWeapon()
	local new_wep = vic:GetActiveWeapon()
	new_wep.Primary.Ammo = orig_wep.Primary.Ammo
	-- new_wep.Primary.Damage = orig_wep.Primary.Damage
	orig_wep.Primary = table.Copy(new_wep.Primary)
	for k,v in pairs(orig_wep.Talents) do
		if v.e ~= 9030 then
			orig_wep.Talents[k] = nil
		else
			v.l = -1
			orig_wep.Talents[k] = v
		end
	end
	if istable(new_wep.Talents) then
		orig_wep.level = new_wep.level
		for k,v in pairs(new_wep.Talents) do
			table.insert(orig_wep.Talents,v)
		end
	end
	net.Start("Switch_wep_primary")
	net.WriteEntity(orig_wep)
	net.WriteTable(orig_wep.Primary)
	net.WriteEntity(new_wep)
	net.Broadcast()
	-- local orig_primary = table.Copy(orig_wep.Primary)
	-- local orig_lvl = orig_wep.level
	-- local orig_talents = table.Copy(orig_wep.Talents)
	-- orig_wep:Remove() -- have to do this + 0.1 timer if they are in the same slot.
	-- timer.Simple(0.1,function()
	-- 	local new_wep = att:Give(new_wep_class)
	-- 	new_wep.Primary = orig_primary
	-- 	new_wep.Talents = orig_talents
	-- 	new_wep.level = orig_lvl
	-- 	net.Start("Switch_wep_primary")
	-- 	net.WriteEntity(new_wep)
	-- 	net.WriteTable(new_wep.Primary)
	-- 	net.Broadcast()
	-- 	timer.Simple(0.3,function()
	-- 		att:SelectWeapon(new_wep_class)		
	-- 	end)
	-- end)
end


function TALENT:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
	if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS or MOAT_MINIGAME_OCCURING) then return end

    local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local randomNum = math.Rand(1, 100)
    local applyMod = chanceNum > randomNum

    if (applyMod) then
		if victim:Health() - dmginfo:GetDamage() < 1 then
			-- print(8)
			if (not IsValid(victim:GetActiveWeapon())) then return end
			-- print(9)
			if (not victim:GetActiveWeapon().Primary) then return end
			-- print(10)
			if (victim:GetActiveWeapon().Kind == WEAPON_MELEE) or (victim:GetActiveWeapon().Kind == WEAPON_UNARMED) then return end
			_switch_wep_talent(attacker,victim)
		end
	end
end

