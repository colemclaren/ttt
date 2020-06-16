util.AddNetworkString("Dragon.Prep")
util.AddNetworkString("Dragon.Begin")
util.AddNetworkString("Dragon.End")
MOAT_ACTIVE_BOSS = MOAT_ACTIVE_BOSS or false
MOAT_DRAGON_PLY = MOAT_DRAGON_PLY or nil
local MOAT_BOSS_DMG = {}
local MOAT_ROUND_OVER = false
local death_voices = {"https://static.moat.gg/f/u4QUxAtoqhJMNdLKoCDFnfFJOgfj.mp3", "https://static.moat.gg/f/DuUQdR6b6IPLuDBoUffUb3GcO7kF.mp3", "https://static.moat.gg/f/o66GU9avCtjwXkEWnrKZTRpj0A7A.mp3", "https://static.moat.gg/f/es1VgqnzB8rkdFbbvjxrpjpXmAmM.mp3", "https://static.moat.gg/f/HNGJ1QHKrDFgxEKezZwDqDnHCGKu.mp3", "https://static.moat.gg/f/3TjV4QhosYjCyGjhTHuaOBYCEYW3.mp3", "https://static.moat.gg/f/Zy6k5NHOUkbWXWlRqjFZU5ovMkVs.mp3", "https://static.moat.gg/f/vXHWudEuRy7azKDjfN3rP6LUIwZU.mp3", "https://static.moat.gg/f/ABOKrPTwS5ctIr0rcfa9r5FzheSo.mp3", "https://static.moat.gg/f/BnEx3kkGamjarHGak9ZY6TsdMQc4.mp3", "https://static.moat.gg/f/vOdDwekeqfqY7jHpvzHaoeFY4uih.mp3"}
local boss_voices = {"https://static.moat.gg/f/FQ8Ki3DI1iwz7COGvb3lJDGNjvqi.mp3", "https://static.moat.gg/f/d498NmYGCidzOhk5eKIwjCZnLiG1.mp3", "https://static.moat.gg/f/AlbmDVfwYncLe73Cy4NbTBiOdtzQ.mp3", "https://static.moat.gg/f/VLnfWX6R7qms2nXqixIb8MpHKfYz.mp3", "https://static.moat.gg/f/2C8JVERC0wo61c57IUYfesggbNI8.mp3", "https://static.moat.gg/f/WWKrz7PvhSNnMKpl8BZWHhzp6sK9.mp3", "https://static.moat.gg/f/VSh7wIfUcx7tD9Pp7kJJ2uXQolro.mp3", "https://static.moat.gg/f/XUk6mFPFkFr4eL9B3fJ7I9iLY17b.mp3", "https://static.moat.gg/f/vHJAQrx7C07ykA4stEeglMN8SjWN.mp3"}
local MOAT_DEATHCLAW_WPN = nil
MOAT_DRAGON_ENT = MOAT_DRAGON_ENT or NULL
local MOAT_DRAGON_INITIALIZED = false
local MOAT_BOSS_HP_MULTIPLIER = 1000

local DefaultLoadout = {
	["weapon_ttt_unarmed"] = true,
	["weapon_zm_improvised"] = true,
	["weapon_zm_carry"] = true
}

-- for k, v in pairs(ents.FindByClass"moat_dragon") do v:SetModelScale(.2, 0) end

function m_GetActiveBoss()
	return MOAT_BOSS_CUR or MOAT_DRAGON_PLY
end

local function moat_EndRoundBossHooks()
	if (MOAT_MINIGAMES.CantEnd()) then return end
	-- Remove our hooks
	hook.Remove("ttt.BeginRound", "moat_BossBeginRound")
	hook.Remove("EntityTakeDamage", "moat_BossSaveDamage")
	hook.Remove("PostPlayerDeath", "moat_BossDeath")
	hook.Remove("EntityTakeDamage", "moat_BossPreventDamage")
	hook.Remove("PlayerSwitchWeapon", "moat_HolsteredHide")
	hook.Remove("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss")
	hook.Remove("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout")
	hook.Remove("PlayerDisconnected", "moat_BossDisconnect")
	hook.Remove("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents")

	if (IsValid(MOAT_DRAGON_ENT)) then
		MOAT_DRAGON_ENT.Boss = NULL
	end

	if (IsValid(MOAT_DRAGON_PLY)) then
		MOAT_DRAGON_PLY:SpectateEntity(nil)
		MOAT_DRAGON_PLY:Spectate(OBS_MODE_NONE)
		MOAT_DRAGON_PLY:Spawn()
	end

	MOAT_ACTIVE_BOSS = false
	MOAT_DRAGON_PLY = nil
	MOAT_DEATHCLAW_WPN = nil
	MOAT_BOSS_DMG = {}
	MOAT_ROUND_OVER = false
	MOAT_DRAGON_INITIALIZED = false
	MOAT_BOSS_HP_MULTIPLIER = 1000
	SetGlobalStr("MOAT_MINIGAME_ACTIVE", false)
	RunConsoleCommand("ttt_roundrestart")
	hook.Remove("TTTCheckForWin", "moat_BossDelayWin")
end

local function moat_EndRoundHandler()
	moat_EndRoundBossHooks()
end

if (IsValid(MOAT_DRAGON_PLY)) then
	moat_EndRoundBossHooks()
end

function moat_InitializeDragonBoss(ply)
	if (MOAT_DRAGON_INITIALIZED) then return end
	MOAT_DRAGON_INITIALIZED = true
	local boss_hp = 7500 * #player.GetAll()
	ply:SetMaxHealth(boss_hp)
	ply:SetHealth(boss_hp)

	MOAT_DRAGON_ENT = ents.Create "moat_boss_dragon"
	MOAT_DRAGON_ENT:SetOwner(ply)
	MOAT_DRAGON_ENT:SetBoss(ply, boss_hp)
	MOAT_DRAGON_ENT:SetPos(ply:GetPos() + Vector(0, 0, 256))
	MOAT_DRAGON_ENT:SetHealth(boss_hp)
	MOAT_DRAGON_ENT:Spawn()
	MOAT_DRAGON_ENT:Activate()

	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(MOAT_DRAGON_ENT)
	ply:SetNoDraw(true)

	for k, v in pairs(ply:GetWeapons()) do
		if (v:GetClass() ~= "weapon_ttt_unarmed") then
			ply:StripWeapon(v:GetClass())
		end
	end

	ply:SelectWeapon("weapon_ttt_unarmed")

	MOAT_DRAGON_ENT:SetMaxHealth(boss_hp)
	MOAT_DRAGON_ENT:SetHealth(boss_hp)

	net.Start("Dragon.Begin")
	net.WriteEntity(MOAT_DRAGON_ENT)
	net.WriteEntity(ply)
	net.WriteVector(ply:GetPos())
	net.Broadcast()
end

local rarity_to_placing = {
	[1] = 6,
	[2] = 6,
	[3] = 6,
	[4] = 6,
	[5] = 6
}

local function moat_BossPlayerDeath(ply)
	if (not MOAT_ACTIVE_BOSS) then return end
	if (MOAT_ROUND_OVER or GetRoundState() ~= ROUND_ACTIVE) then return end
	local IS_BOSS, ALIVE = false, GetAlivePlayers()

	if (type(ply) == "string" and ply == "boss") then
		IS_BOSS = true
	else
		IS_BOSS = IsValid(MOAT_DRAGON_PLY) and MOAT_DRAGON_PLY == ply
	end

	if (IS_BOSS or ALIVE <= 1) then
		MOAT_ROUND_OVER = true
	end

	if (IsValid(MOAT_DRAGON_PLY)) then
		MOAT_DRAGON_PLY:SetCredits(0)
	end

	if (not MOAT_ROUND_OVER) then
		timer.Simple(1, function()
			if (not IsValid(ply) or not IsValid(ply.server_ragdoll)) then return end
			local pl = player.GetBySteamID(ply.server_ragdoll.sid)
			if (not IsValid(pl)) then return end
			pl:SetCleanRound(false)
			pl:SetNW2Bool("body_found", true)
			CORPSE.SetFound(ply.server_ragdoll, true)
			ply.server_ragdoll:Remove()
		end)

		-- cdn.PlayURL(table.Random(death_voices))

		return
	end

	net.Start("moat.damage.reset")
	net.Broadcast()

	for k, v in pairs(player.GetAll()) do
		if (IsValid(v) and v.BossDamage and v.BossDamage > 1) then
			table.insert(MOAT_BOSS_DMG, {v:Nick(), v.BossDamage, v:EntIndex()})
		end
	end

	net.Start("Dragon.End")
	net.WriteBool(IS_BOSS)
	net.WriteTable(MOAT_BOSS_DMG)
	net.Broadcast()
	timer.Remove("moat_boss_voices")

	if (IsValid(MOAT_DRAGON_ENT)) then
		MOAT_DRAGON_ENT.Boss = NULL
	end

	if (IsValid(MOAT_DRAGON_PLY)) then
		MOAT_DRAGON_PLY:SpectateEntity(nil)
		MOAT_DRAGON_PLY:Spectate(OBS_MODE_NONE)
		MOAT_DRAGON_PLY:Spawn()
	end

	timer.Simple(20, function()
		moat_EndRoundHandler()
	end)

	if (not IS_BOSS) then
		-- cdn.PlayURL("https://static.moat.gg/f/ubbd7fKB9WdDWbk5J1QMC3iM81GG.mp3", 2)

		if (IsValid(MOAT_DRAGON_PLY)) then
			if (math.random(2) == 2) then
				MOAT_DRAGON_PLY:m_DropInventoryItem(7)
			else
				MOAT_DRAGON_PLY:m_DropInventoryItem(6)
			end
		end

		return
	else
		-- cdn.PlayURL("https://static.moat.gg/f/9582v2jF3CQSP5fOM44CuAE3TMVr.mp3", 2)
	end

	local ply_tbl = {}

	for k, v in pairs(player.GetAll()) do
		if (IsValid(v) and v.BossDamage and v.BossDamage > 1) then
			table.insert(ply_tbl, {v, v.BossDamage})
		end
	end

	table.sort(ply_tbl, function(a, b) return a[2] > b[2] end)

	for k, v in ipairs(ply_tbl) do
		if (k <= 3) then
			if (math.random(2) == 2) then
				v[1]:m_DropInventoryItem(7)
			else
				v[1]:m_DropInventoryItem(6)
			end

			continue
		end
		
		if (math.random(20) == 20) then
			v[1]:m_DropInventoryItem(7)
		elseif (math.random(5) == 5) then
			v[1]:m_DropInventoryItem(6)
		else
			v[1]:m_DropInventoryItem(5)
		end
	end
end

local function moat_BeginRoundBossHooks()
	hook.Add("PlayerDisconnected", "moat_BossDisconnect", function(pl)
		hook.Run("PostPlayerDeath", pl)
	end)

	hook.Add("ttt.BeginRound", "moat_BossBeginRound", function()
		local pls = player.GetAll()

		if (not IsValid(MOAT_DRAGON_PLY)) then
			local chosen

			for k, v in RandomPairs(pls) do
				if (v:Team() ~= TEAM_SPEC) then
					chosen = v
					break
				end
			end

			for i = 1, 5 do
				chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU ARE THE BOSS!!!" )]])
			end

			MOAT_DRAGON_PLY = chosen
		end

		if (MOAT_DEATHCLAW_WPN) then
			for k, v in pairs(ents.GetAll()) do
				if (IsValid(v) and v ~= NULL and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
					v:Remove()
				end
			end
		end

		local boss = MOAT_DRAGON_PLY
		-- boss:GodEnable()

		if (boss:GetRole() ~= ROLE_TRAITOR) then
			boss:SetRole(ROLE_TRAITOR)
		end

		boss:SetCredits(0)

		timer.Simple(boss.JustSpawned and 2 or 0, function()
			moat_InitializeDragonBoss(boss)
			-- boss:GodDisable()
		end)

		local healers = {}

		for k, v in RandomPairs(pls) do
			v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			-- v:Freeze(true)
			if (v == boss) then continue end

			if (v:GetRole() ~= ROLE_INNOCENT) then
				v:SetRole(ROLE_INNOCENT)
			end

			local healer = false

			if (#healers < math.ceil(#pls / 4)) then
				healer = true
				table.insert(healers, v)
				D3A.Chat.SendToPlayer2(v, Color(255, 255, 0), v:Nick(), Color(255, 255, 255), " has a ", Color(0, 255, 0), "health station", Color(255, 255, 255), "!")
			end

			local function HandleWeaponsAndAmmo()
				if (not IsValid(v)) then return end

				if (MOAT_DEATHCLAW_WPN) then
					v:Give(MOAT_DEATHCLAW_WPN)
					v:SelectWeapon(MOAT_DEATHCLAW_WPN)
				end

				for k2, v2 in pairs(v:GetWeapons()) do
					if (v2.Primary.Ammo) then
						v:GiveAmmo(9999, v2.Primary.Ammo)
					end
				end

				if (healer) then
					v:Give("weapon_ttt_health_station")
				end
			end

			timer.Simple(0, HandleWeaponsAndAmmo)
			timer.Simple(2, HandleWeaponsAndAmmo)
		end

		timer.Simple(1, function()
			MuteForRestart(true)
			-- cdn.PlayURL(table.Random({"https://static.moat.gg/f/tFU5O424OaHTrU16ayw6NJz3x4Lz.mp3", "https://static.moat.gg/f/q5ZZXsMohK3L3b0lnaKQ88SUPOUZ.mp3"}), 2)
		end)

		timer.Create("moat_boss_voices", 30, 0, function()
			-- cdn.PlayURL(table.Random(boss_voices))
		end)

		timer.Simple(5, function()
			MuteForRestart(false)
		end)

		SetRoundEnd(CurTime() + 99999)

		timer.Simple(5, function()
			for k, v in ipairs(player.GetAll()) do
				-- v:Freeze(false)
				v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end

			if (not IsValid(MOAT_DRAGON_PLY)) then return end
			MOAT_DRAGON_PLY:GiveEquipmentItem(EQUIP_RADAR)
			MOAT_DRAGON_PLY:ConCommand("ttt_radar_scan")
		end)

		local tmr = MOAT_DRAGON_PLY:EntIndex()

		timer.Create("moat_check_boss" .. tmr, 0.1, 0, function()
			if (not IsValid(MOAT_DRAGON_PLY)) then
				moat_BossPlayerDeath("boss")
				timer.Remove("moat_check_boss" .. tmr)

				return
			end
		end)
	end)

	hook.Add("TTTCheckForWin", "moat_BossDelayWin", function() return WIN_NONE end)

	hook.Add("EntityTakeDamage", "moat_BossSaveDamage", function(ply, dmginfo)
		local att = dmginfo:GetAttacker()

		if (IsValid(ply) and IsValid(att) and ply == MOAT_DRAGON_ENT and dmginfo:GetDamage() >= 1 and att:IsPlayer() and GetRoundState() == ROUND_ACTIVE) then
			if (MOAT_DRAGON_PLY and IsValid(MOAT_DRAGON_PLY) and MOAT_DRAGON_PLY == att) then return end

			if (not att.BossDamage) then
				att.BossDamage = 0
			end

			att.BossDamage = att.BossDamage + dmginfo:GetDamage()
			SHR:SendHitEffects(att, dmginfo:GetDamage(), dmginfo:GetDamagePosition())
			net.Start("moat.damage")
			net.WriteUInt(dmginfo:GetDamage(), 16)
			net.Send(att)

			MOAT_DRAGON_ENT:DamageBoss(dmginfo)
		end
	end)

	hook.Add("EntityTakeDamage", "moat_BossPreventDamage", function(ent, dmg)
		if (not IsValid(ent) or not ent:IsPlayer()) then return end
		if (not IsValid(MOAT_DRAGON_PLY) or not IsValid(MOAT_DRAGON_ENT)) then return end
		
		-- if (dmg:IsBulletDamage() or dmg:IsExplosionDamage()) then
			local att = dmg:GetAttacker()
			if (not IsValid(att)) then return end

			if (dmg:IsExplosionDamage() and att:GetClass() ~= "moat_proj_fireball" and att:GetClass() ~= "moat_boss_dragon") then
				dmg:SetDamage(0)

				return true
			end

			att = (not att:IsPlayer() and att:GetOwner() and IsValid(att:GetOwner())) and att:GetOwner() or att

			if (IsValid(att) and att:IsPlayer() and att:GetRole() == ent:GetRole()) then
				dmg:SetDamage(0)

				return true
			end
		-- end
	end)

	hook.Add("TTTKarmaGivePenalty", "moat_BossPreventKarmaLoss", function(ply, penalty, vic) return true end)
	hook.Add("m_ShouldPreventWeaponHitTalent", "moat_BossStopTalents", function(att, vic) return att:GetRole() == vic:GetRole() end)
	hook.Add("PostPlayerDeath", "moat_BossDeath", moat_BossPlayerDeath)
end

concommand.Add("moat_dragon", function(ply, cmd, args)
	if (not moat.isdev(ply) or GetRoundState() ~= ROUND_PREP) then return end

	if (not IsValid(ply) and MSE.Player) then
		ply = MSE.Player
	end

	local chosen = args[1]
	MOAT_DEATHCLAW_WPN = args[2]

	if (MOAT_DEATHCLAW_WPN) then
		MOAT_BOSS_HP_MULTIPLIER = 350

		for k, v in pairs(ents.GetAll()) do
			if (IsValid(v) and v ~= NULL and v:GetClass():StartWith("weapon_") and not DefaultLoadout[v:GetClass()]) then
				v:Remove()
			end
		end

		hook.Add("MoatInventoryShouldGiveLoadout", "moat_BossPreventLoadout", function(ply) return true end)
	end

	if (chosen == "self") then
		chosen = ply
	elseif (chosen == "random") then
		for k, v in RandomPairs(player.GetAll()) do
			if (v:Team() ~= TEAM_SPEC) then
				chosen = v
				break
			end
		end
	elseif (chosen) then
		chosen = player.GetBySteamID(chosen)
	else
		if (IsValid(ply)) then
			ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "No player provided." )]])
		end

		return
	end

	if (type(chosen) == "string" or not IsValid(chosen)) then
		if (IsValid(ply)) then
			ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "Couldn't find a player." )]])
		end

		return
	end

	for i = 1, 5 do
		chosen:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "YOU WILL BE THE BOSS!!!" )]])
	end

	for k, v in pairs(player.GetAll()) do
		if (v == chosen) then continue end
		v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
		v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
		v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
		v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
		v:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "WARNING!!! INCOMING BOSS FIGHT!!!" )]])
	end

	net.Start("Dragon.Prep")
	net.Broadcast()

	MuteForRestart(true)
	ttt.ExtendPrep()
	MOAT_DRAGON_INITIALIZED = false
	MOAT_DRAGON_ENT = NULL
	MOAT_ACTIVE_BOSS = true
	MOAT_DRAGON_PLY = chosen
	MOAT_BOSS_DMG = {}
	MOAT_ROUND_OVER = false
	SetGlobalStr("MOAT_MINIGAME_ACTIVE", "Dragon Boss")

	for k, v in pairs(player.GetAll()) do
		v.BossDamage = 0
	end

	moat_BeginRoundBossHooks()
end)