concommand.Add("_collect_items", function(pl, cmd, args)
	file.CreateDir "mi_collect_output"

	local drops_str = ""
	for k, v in pairs(MOAT_COLLECT) do
		local str = string (
			"------------------------------------\n", 
			"--\n", 
			"-- ", k, "\n",
			"--\n",
			"------------------------------------\n\n")

		if (v.Crate) then
			str = string (str, v.Crate)
		end

		local rars = {}
		for r = 1, 10 do
			--if (r == 910) then continue end

			for i = 1, #v do
				if (v[i].Rarity and v[i].Rarity == r) then
					rars[r] = true
					continue
				end
			end
		end


		for r = 1, 10 do
			if (not rars[r]) then continue end

			str = string (str,
				"\n\n------------------------------------\n", 
				"-- ", mi.Rarity(r).Name .. " Items", "\n",
				"------------------------------------\n\n")

			for i = 1, #v do
				if (v[i].Rarity and v[i].Rarity == r) then
					str = string (str, v[i].String)
				end
			end
		end

		file.Write("mi_collect_output/" .. string.Replace(string.lower(k), " ", "_") .. ".txt", str)
		drops_str = drops_str .. str .. "\n\n\n"
	end

	file.Write("mi_collect_output/drops.txt", drops_str)
end)

concommand.Add("_collect_talents", function(pl, cmd, args)
	file.CreateDir "mi_collect_output"

	local output_str = "--\n--		Built by Lua on " .. os.date("%b %d, %Y at %H:%M:%S PST", os.time()) .. "\n--\n"
	local a, b, c, n = ", ", ", '", "'", "\n"
	for k, v in pairs(MOAT_TALENTS) do
		local str = string (
			"------------------------------------\n", 
			"--\n", 
			"-- ", v.Name, " by ", "???\n",
			"--\n",
			"------------------------------------\n\n")

		str = string (str, "Talent(", v.ID, b, v.Name, c, a, v.Tier, v.NotUnique and ")" or ", false)", n)
		str = string (str, "	:SetColor {", v.NameColor.r, a, v.NameColor.g, a, v.NameColor.b, "}", n)
		str = string (str, "	:CanMelee '", v.NameEffect, c, n)
		str = string (str, "	:SetDesc '", v.Description, c, n)

		if (mi.Talent.Tiers[v.Tier] and (mi.Talent.Tiers[v.Tier][1] ~= v.LevelRequired.min or mi.Talent.Tiers[v.Tier][2] ~= v.LevelRequired.max)) then
			str = string (str, "	:SetLevels {", v.LevelRequired.min, c, v.LevelRequired.max, "}", n)
		end

		for id, mod in ipairs(v.Modifications) do
			str = string (str, "	:Mod {'", id, c, a, mod.min, a, mod.max, '}', n)
		end

		for id, mod in ipairs(v.Modifications) do
			str = string (str, "	:Mod {'", id, c, a, mod.min, a, mod.max, '}', n)
		end

		if (v.Melee) then
			str = string (str, "	:CanMelee (", tostring(v.Melee), ")", n)
		end

		if (v.OnPlayerDeath) then
			str = string (str, "	:Hook {'OnPlayerDeath', function(vic, inf, att, talent_mods)", n, "		", n, "	end}", n)
		end

		if (v.OnPlayerHit) then
			str = string (str, "	:Hook {'OnPlayerHit', function(vic, att, dmginfo, talent_mods)", n, "		", n, "	end}", n)
		end

		if (v.OnWeaponSwitch) then
			str = string (str, "	:Hook {'OnWeaponSwitch', function(pl, wep, isto, talent_mods)", n, "		", n, "	end}", n)
		end

		if (v.ScalePlayerDamage) then
			str = string (str, "	:Hook {'ScalePlayerDamage', function(vic, att, dmginfo, hitgroup, talent_mods)", n, "		", n, "	end}", n)
		end

		if (v.ModifyWeapon) then
			str = string (str, "	:Hook {'ModifyWeapon', function(wep, talent_mods)", n, "		", n, "	end}", n)
		end

		if (v.OnWeaponFired) then
			str = string (str, "	:Hook {'OnWeaponFired', function(att, wep, dmginfo, talent_mods, is_bow, hit_pos)", n, "		", n, "	end}", n)
		end

		if (v.OnBeginRound) then
			str = string (str, "	:Hook {'OnBeginRound', function(pl, talent_mods)", n, "		", n, "	end}", n)
		end

		str = string (str, n, n)
		output_str = string (output_str, str)
	end

	file.Write("mi_collect_output/talents.txt", output_str)
end)