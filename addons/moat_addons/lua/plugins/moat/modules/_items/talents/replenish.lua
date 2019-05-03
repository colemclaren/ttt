TALENT.ID = 99
TALENT.Name = "Replenish"
TALENT.NameEffect = "enchanted"
TALENT.NameColor = Color(0, 255, 122)
TALENT.Description = "Your gun has a %s_^ chance to refill a bullet if you hit someone"
TALENT.Tier = 2
TALENT.Melee = false
TALENT.NotUnique = true
TALENT.LevelRequired = {min = 15, max = 19}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 50, max = 90}

function TALENT:OnWeaponFired(attacker, wep, dmginfo, talent_mods, is_bow, hit_pos)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end

	local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
	if (chance > math.random() * 100) then
		local has_done = false
        local old_callback = dmginfo.Callback

        dmginfo.Callback = function(att, tr, dmginfo)
            if (old_callback) then
                old_callback(att, tr, dmginfo)
            end
            
            if (has_done or tr.AltHitreg) then
                return
			end
			has_done = true
            if (IsValid(tr.Entity) and tr.Entity:IsPlayer()) then
                wep:SetClip1(wep:Clip1() + 1)
            end
        end
    end
end

/*
local function sum(x)
	local s = 0

	for k, v in ipairs(x) do
		s = s + v
	end

	return s
end

local wep_cache = {}
local function weps()
	local weps = {}
	
	wep_cache = wep_cache or weapons.GetList()
	for k, v in ipairs(wep_cache) do
		local wep = weapons.Get(v.ClassName)
		if (not wep) then continue end

		if (v.Base == "weapon_tttbase" and (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable)) then
			table.insert(weps, {Damage = v.Primary.Damage, ClipSize = v.Primary.ClipSize, Cone = v.Primary.Cone})
		end
	end

	return weps
end

local function mean(x)
	return (sum(x) / #x)
end

local function median(x)
	table.sort(x)

	return (#x % 2 == 0) and mean({x[#x / 2], x[(#x / 2) - 1]}) or x[((#x + 1) / 2) - 1]
end

local function mode(x)
	table.sort(x)

	local t = {}
	for k, v in ipairs(x) do
		t[v] = (t[v]) and (t[v] + 1) or 1
	end
	
	local max = x[1] or 0
	for k, v in ipairs(x) do
		max = (v > max) and v or max
	end

	return max
end

concommand.Add("r", function(pl, _, args)
	local replenish = {min = args[1], max = args[2]}
	local meticulous = {min = 10, max = 30}
	local sims = args[3] or 1000
	local wpn = weps()

	print("Running " .. sims .. " simulations...")

	

	local t, x = {}, {[1] = {}, [2] = {}, [3] = {}, [4] = {}}
	for kills = 1, 10 do
		for i = 1, sims do
			local w = wpn[math.random(#wpn)]
			local rand = math.random()

			local m = w.ClipSize
			local d = w.Damage

			local s1, s2, n = 0, 0, m
			while (n > 0) do
				s1 = s1 + 1

				if (((replenish.min + ((replenish.max - replenish.min) * rand)) < math.random() * 100)) then
					n = n - 1
				end
			end

			local shots, deaths = 0, 0

			n = m
			while (n > 0) do
				s2 = s2 + 1
				shots = shots + 1

				if ((meticulous.min + ((meticulous.max - meticulous.min) * rand)) < math.random() * 100) then
					n = n - 1
				elseif (deaths < kills and s2 >= math.floor((kills * 100) / )) then
					deaths = deaths + 1
					shots = 0

					n = m
				end
			end

			t[i] = {
				[1] = s1,
				[2] = s2,
				[3] = m,
				[4] = kills
			}

			table.insert(x[1], s1)
			table.insert(x[2], s2)
			table.insert(x[3], m)
			table.insert(x[4], kills)

			if (tonumber(sims) < 1000 and i % 10 == 0 or i % 100 == 0) then
				print(string(kills, ": ", #t, "/", sims))
			end
		end
	end

	local o = {[1] = {}, [2] = {}, [3] = {}, [4] = {}}
	for c = 1, 4 do
		o[c].AVERAGE = mean(x[c])
		o[c].MEDIAN = median(x[c])
		o[c].MODE = mode(x[c])

		print(string("Calulating .. ", c))
	end

	PrintTable {
		Replenish = o[1],
		Meticulous = o[2],
		Clip = o[3]
	}

end)
*/