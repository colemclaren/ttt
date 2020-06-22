util.AddNetworkString("RandomRound")
util.AddNetworkString("moat.hide.cosmetics")
util.AddNetworkString "randomround.late"

moat_random = {
    rounds = {}
}
function moat_random.register(name,desc,hooks,after)
    moat_random.rounds[name] = {hooks,desc,after}
end
wacky_round = math.random(2, 7)
cur_random_round = false
function moat_random.start_round(name)
    cur_random_round = name
    for k,v in pairs(moat_random.rounds[name][1]) do
        if k == "NOW" then
            v()
            continue
        end
        hook.Add(k,"Randomround" .. name,function(...)
            if not cur_random_round then print("Removed randomround hook: " .. name,k )hook.Remove(k,"Randomround" .. name) return end
            return v(...)
        end)
    end
end

-- so late players who weren't existant during preparing can be networked the wacky round
net.Receive("randomround.late", function(_, pl)
    if (not cur_random_round) then return end

    net.Start "RandomRound"
    net.WriteString(cur_random_round)
    net.WriteString(moat_random.rounds[cur_random_round][2])
    net.Send(pl)
end)

concommand.Add("moat_start_wacky",function(a,b,c,d)
    if not moat.isdev(a) then return end
    if moat_random.rounds[d] then
        moat_random.start_round(d)

		net.Start("RandomRound")
			net.WriteString(d)
    		net.WriteString(moat_random.rounds[d][2])
		net.Broadcast()
    end
end)
hook.Add("TTTEndRound","RandomRound",function()
    timer.Simple(1, function()
        if moat_random.rounds[cur_random_round] then
            if isfunction(moat_random.rounds[cur_random_round][3]) then
                moat_random.rounds[cur_random_round][3]()
                net.Start("RandomRound")
                net.WriteString("nono")
                net.Broadcast()
            end
        end
        cur_random_round = false
    end)
end)

local chance = 15 -- 1 in how many
hook.Add("TTTPrepareRound","RandomRound",function()
    if moat_random.rounds[cur_random_round] then
        net.Start("RandomRound")
        net.WriteString("nono")
        net.Broadcast()
        if isfunction(moat_random.rounds[cur_random_round][3]) then
            moat_random.rounds[cur_random_round][3]()
        end
        cur_random_round = false
    end
    if wacky_round == GetGlobal("ttt_rounds_left") then
        if math.random() > 0.3 then
            local b,c = table.Random(moat_random.rounds)
            moat_random.start_round(c)

			net.Start("RandomRound")
				net.WriteString(c)
    			net.WriteString(moat_random.rounds[c][2])
			net.Broadcast()
        end
    end
end)
--[[
    config for rounds, pretty self explanitory.
]]
moat_random.register("Blink","Everyone spawns with blink!",{
    ["NOW"] = function()
        for k, v in ipairs(player.GetAll()) do
			if (v:Team() == TEAM_SPEC) then continue end

			v:Give("weapon_vadim_blink")
			v:SelectWeapon("weapon_vadim_blink")
        end
    end,
    ["TTTBeginRound"] = function()
        for k, v in ipairs(player.GetAll()) do
			if (v:Team() == TEAM_SPEC) then continue end
			local spn = v.JustSpawned

			timer.Simple(spn and 2 or 0, function()
				if (not IsValid(v) or v:Team() == TEAM_SPEC) then return end
				if (v:HasWeapon("weapon_vadim_blink") and not spn) then return end

				v:Give("weapon_vadim_blink")
				v:SelectWeapon("weapon_vadim_blink")
			end)
        end
    end
})

local DontBounce1 = {
    "func_door", "func_door_rotating", "prop_door_rotating", "func_breakable"
}
local DontBounce = {}

for _, v in pairs(DontBounce1) do
    DontBounce[v] = true
end

-- moat_random.register("Bouncy","Everything bounces!",{
--     ["NOW"] = function()
--         local function PhysicsCollide(self, e)
--             local phys = self:GetPhysicsObject()
--             if (IsValid(phys)) then
--                 phys:ApplyForceCenter(vector_up * phys:GetMass() * 100)
--             end
--         end
--         for k, v in pairs(ents.GetAll()) do
--             if (v:IsPlayer()) then
--                 continue
--             end
--             local class = v:GetClass()
--             local phys = v:GetPhysicsObject()
--             if (DontBounce[class] or not IsValid(phys)) then
--                 continue
--             end

--             phys:ApplyForceCenter(vector_up * phys:GetMass() * 100)
--             v.CallbackID_Bouncy = v:AddCallback("PhysicsCollide", PhysicsCollide)

--             v.PhysicsCollide = PhysicsCollide

--         end
--     end
-- }, function()
--     for k,v in pairs(ents.GetAll()) do
--         if (v.CallbackID_Bouncy) then
--             v:RemoveCallback("PhysicsCollide", v.CallbackID_Bouncy)
--             v.CallbackID_Bouncy = nil
--         end
--     end
-- end)

--[[
moat_random.register("Slippery","Everyone slides around with low friction!",{
    ["NOW"] = function()
        game.ConsoleCommand("sv_friction 1\n")
    end
},function()
    game.ConsoleCommand("sv_friction 8\n")
end)]]

--[[
moat_random.register("Head","Your head can be bigger or smaller",{
    ["NOW"] = function()
        for k,v in ipairs(player.GetAll()) do
            local a = v:LookupBone("ValveBiped.Bip01_Head1")
            if not (a) then continue end
            local s = math.random() * 2.5
            v:ManipulateBoneScale(a, Vector(s,s,s) )
        end
    end
},function()
    for k,v in ipairs(player.GetAll()) do
        local a = v:LookupBone("ValveBiped.Bip01_Head1")
        if not (a) then continue end
        v:ManipulateBoneScale(a, Vector(1,1,1) )
    end
end)]]

moat_random.register("Fast","Players move at race car speed this round!",{
    ["NOW"] = function()
        cur_random_round = "Fast"
    end
})

moat_random.register("Secondary only","You can only use your secondary weapons!",{
    ["NOW"] = function()
        for k,v in pairs(ents.GetAll()) do
            if v.Kind then
                if v.Kind == WEAPON_HEAVY then
                    SafeRemoveEntity(v)
                end
            end
        end
    end,
    ["TTTBeginRound"] = function()
        for k,v in pairs(ents.GetAll()) do
            if v.Kind then
                if v.Kind == WEAPON_HEAVY then
                    SafeRemoveEntity(v)
                end
            end
        end
    end,
    ["PlayerSwitchWeapon"] = function(ply,old,new)
        if new.Kind == WEAPON_HEAVY then return true end
    end
})

moat_random.register("Headshot","You can only deal damage through headshots!",{
    ["ScalePlayerDamage"] = function(ply,hit,dmg)
        if hit ~= HITGROUP_HEAD then dmg:SetDamage(0) return true end
    end,
    ["TTTBeginRound"] = function()
        for k,v in pairs(player.GetAll()) do
            if v:GetModel():match("sparrow") or v:GetModel():match("bigsmoke") then
                v:SetModel("models/player/Group03/female_01.mdl")
            end
        end
    end
})

--weapon_ttt_golden_deagle

--[[local DeafultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true,
	["weapon_ttt_golden_deagle"] = true
}

moat_random.register("Golden Deagle","You can only use the golden deagle!",{
    ["NOW"] = function()
        for k, v in pairs(ents.GetAll()) do
			if (not IsValid(v) or not v:GetClass():StartWith("weapon_")) then continue end
			if (DeafultLoadout[v:GetClass()] or v.Kind == WEAPON_UNARMED) then continue end

			v:Remove()
        end

        for k, v in ipairs(player.GetAll()) do
			if (v:Team() == TEAM_SPEC) then continue end
            v:StripWeapons()

			v:Give("weapon_ttt_golden_deagle")
            v:GiveAmmo(9999, "AlyxGun", true)
			v:SelectWeapon("weapon_ttt_golden_deagle")
        end
    end,
    ["MoatInventoryShouldGiveLoadout"] = function()
        return true
    end,
    ["TTTBeginRound"] = function()
        for k, v in ipairs(ents.GetAll()) do
			if (not IsValid(v) or not v:GetClass():StartWith("weapon_")) then continue end
			if (DeafultLoadout[v:GetClass()] or v.Kind == WEAPON_UNARMED) then continue end

			v:Remove()
        end

        for k, v in ipairs(player.GetAll()) do
			if (v:Team() == TEAM_SPEC) then continue end
			local spn = v.JustSpawned

			timer.Simple(spn and 2 or 0, function()
				if (not IsValid(v) or v:Team() == TEAM_SPEC) then return end
				if (v:HasWeapon("weapon_ttt_golden_deagle") and not spn) then return end
				v:StripWeapons()

				v:Give("weapon_ttt_golden_deagle")
                v:GiveAmmo(9999,"AlyxGun", true)
				v:SelectWeapon("weapon_ttt_golden_deagle")
			end)
        end

		-- just in case
		timer.Simple(3, function()
			for k, v in ipairs(ents.GetAll()) do
				if (not IsValid(v) or not v:GetClass():StartWith("weapon_")) then continue end
				if (DeafultLoadout[v:GetClass()] or v.Kind == WEAPON_UNARMED) then continue end

				v:Remove()
        	end
		end)
    end
})]]

--[[
moat_random.register("Inverted","Your movement is inverted!",{
    ["Move"] = function(ply,mv)
        if ply:Team() == TEAM_SPEC then return end
        if (GetRoundState() == ROUND_ACTIVE and ply:IsTraitor()) then return end

        mv:SetForwardSpeed(mv:GetForwardSpeed() * -1)
        mv:SetSideSpeed(mv:GetSideSpeed() * -1)
    end
})]]

-- moat_random.register("Invisible Traitors","The traitors are invisible! And everyone else is a detective!",{
--     ["TTTBeginRound"] = function()
--         for k,v in pairs(player.GetAll()) do
--             if (not v:IsValid()) then continue end
            
--             if v:IsTraitor() then
--                 v:SetRenderMode(RENDERMODE_TRANSALPHA)
--                 v:SetColor(Color(0, 0, 0, 0))
--                 v:DrawShadow(false)
                
--                 timer.Simple(1, function()
--                     net.Start("MOAT_PLAYER_CLOAKED")
--                     net.WriteEntity(v)
--                     net.WriteBool(true)
--                     net.Broadcast()
--                 end)
--             else
--                 v:SetRole(ROLE_DETECTIVE)
--             end
--         end
--     end,
--     ["TTTEndRound"] = function()
--         for k, v in pairs(player.GetAll()) do
--             if (not v:IsValid()) then continue end
            
--             v:SetColor(255, 255, 255, 255)
--             v:SetRenderMode(RENDERMODE_NORMAL)
--         end
--     end
-- })

--[[
moat_random.register("Crab","You can only walk sideways!",{
    ["Move"] = function(ply,mv)
        if ply:Team() == TEAM_SPEC then return end
        if (GetRoundState() == ROUND_ACTIVE and ply:IsTraitor()) then return end

            mv:SetForwardSpeed(0)
    end
})]]

--[[
moat_random.register("Inverted Map", "The map is inverted for every player this round!",{
    ["NOW"] = function()
        cur_random_round = "Inverted Map"
    end
})]]

moat_random.register("Third Person", "Every player must play in third person this round!",{
    ["NOW"] = function()
        cur_random_round = "Third Person"
    end
})


--[[
moat_random.register("Loadout Swap", "Loadouts are randomized between players at the start of the round!",{
    ["TTTBeginRound"] = function()
        timer.Simple(1, function()
            local pls = player.GetAll()

            for i = 1, #pls do
                if (pls[i]:Team() == TEAM_SPEC) then continue end
                
                timer.Create("moat_CheckLoadoutSpawn" .. pls[i]:EntIndex(), 1, 0, function()
                    local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(pls[math.random(#pls)])

                    if (pri_wep and sec_wep and melee_wep and powerup and tactical) then
                    m_GivePlayerLoadout(pls[i], pri_wep, sec_wep, melee_wep, powerup, tactical)
                    timer.Remove("moat_CheckLoadoutSpawn" .. pls[i]:EntIndex())
                    end
                end)
            end
        end)
    end
})
]]

-- TODO(meep): REMOVE
moat_random.register("High FOV", "Every player must play with high FOV this round!", {
    ["NOW"] = function()
        cur_random_round = "High FOV"

        for k, v in pairs(player.GetAll()) do
            v:SetFOV(130, 0.5)
        end
    end,
    ["TTTBeginRound"] = function()
        for k, v in pairs(player.GetAll()) do
            v:SetFOV(130, 0.5)
        end
    end
})

--[[
moat_random.register("Jarate", "Every innocent player must play with the Jarate effect this round!", {
    ["NOW"] = function()
        cur_random_round = "Jarate"
    end
})]]

--[[
moat_random.register("Cartoon", "Every player must play with a cartoon effect this round!", {
    ["NOW"] = function()
        cur_random_round = "Cartoon"
    end
})]]

--[[
moat_random.register("Old Timey", "Every player must play with an old timey effect this round!", {
    ["NOW"] = function()
        cur_random_round = "Old Timey"
    end
})]]

local plm = FindMetaTable("Player")

if (not plm.MOAT_FOV) then
    plm.MOAT_FOV = plm.SetFOV
end

function plm:SetFOV(fov, time)
    if (cur_random_round == "High FOV") then fov = 130 end

    self:MOAT_FOV(fov, time)
end

moat_random.register("High HP", "Base health is 500 HP for this round!", {
    ["NOW"] = function()
		for k, v in pairs(player.GetAll()) do
			if ((v.MaxHealth and v.MaxHealth > 500) or v:GetMaxHealth() > 500 or v:Health() > 500) then
				continue
			end

            v:SetMaxHealth(500)
			v.MaxHealth = 500
			v:SetHealth(500)
        end

		net.Start("RandomRound")
    		net.WriteString("High HP")
    		net.WriteString("Base health is 500 HP for this round!")
    	net.Broadcast()
    end,
    ["TTTBeginRound"] = function()
        for k, v in pairs(player.GetAll()) do
			if ((v.MaxHealth and v.MaxHealth > 500) or v:GetMaxHealth() > 500 or v:Health() > 500) then
				continue
			end

            v:SetMaxHealth(500)
			v.MaxHealth = 500
			v:SetHealth(500)
        end

		net.Start("RandomRound")
    		net.WriteString("High HP")
    		net.WriteString("Base health is 500 HP for this round!")
    	net.Broadcast()
    end
})

 -- lua_run moat_random.start_round("Crab")