-- autorun/server/sv_vapeswep.lua
-- Defines serverside globals for Vape SWEP

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

util.AddNetworkString("Vape")
util.AddNetworkString("VapeArm")
util.AddNetworkString("VapeTalking")

local hours = 0.5
mega_vape_cache = {}
local function _megasql()
	local db = MINVENTORY_MYSQL
	local q = db:query("CREATE TABLE IF NOT EXISTS `moat_megavape` ( `itemid` varchar(100) NOT NULL, `time` INT NOT NULL, PRIMARY KEY (itemid) )")
    q:start()

	function mega_vape_use(itemid,fun)
		local q = db:query("SELECT *, UNIX_TIMESTAMP() AS curtime FROM moat_megavape WHERE itemid = '" .. db:escape(itemid) .. "';")
		function q:onSuccess(d)
			if d[1] then 
				mega_vape_cache[itemid] = d
				if d[1].curtime > d[1].time then
					local b = db:query("UPDATE moat_megavape SET time = UNIX_TIMESTAMP() + (60 * 60 * " .. hours .. ") WHERE itemid = '" .. db:escape(itemid) .. "';")
					function b:onSuccess(c)
						fun(d,true)
					end
					b:start()
				else
					fun(d,false)
				end
			else
				local b = db:query("INSERT INTO moat_megavape (itemid, time) VALUES ( '" .. db:escape(itemid) .. "', UNIX_TIMESTAMP() + (60 * 60 * " .. hours .. "));")
				function b:onSuccess(c)
					fun(c or {},true)
				end
				b:start()
			end
		end
		function q:onError()
			fun({},false)
		end
		q:start()
	end

	function mega_vape_gettime(itemid,fun)
		if mega_vape_cache[itemid] then fun(mega_vape_cache[itemid]) return end
		local q = db:query("SELECT *, UNIX_TIMESTAMP() AS curtime FROM moat_megavape WHERE itemid = '" .. db:escape(itemid) .. "';")
		function q:onSuccess(d)
			if d[1] then 
				mega_vape_cache[itemid] = d
				fun(d) 
			else 
				fun() 
			end
		end
		q:start()
	end

end

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        _megasql()
    end
end

hook.Add("InitPostEntity","_megasql",function()
    if not c() then 
        timer.Create("Check_megasql",1,0,function()
            if c() then
                _megasql()
                timer.Destroy("Check_megasql")
            end
        end)
    else
        _megasql()
    end

end)

function VapeUpdate(ply, vapeID)
	if not ply.vapeCount then ply.vapeCount = 0 end
	if not ply.cantStartVape then ply.cantStartVape=false end
	if ply.vapeCount == 0 and ply.cantStartVape then return end

	if ply.vapeCount > 3 then
		if vapeID == 3 then --medicinal vape healing
			if ply.medVapeTimer then ply:SetHealth(math.min(ply:Health() + 0.2, ply:GetMaxHealth())) end
			ply.medVapeTimer = !ply.medVapeTimer
		end

		if vapeID == 5 then --hallucinogenic vape
			ply:SendLua("vapeHallucinogen=(vapeHallucinogen or 0)+3")
		end
	end
	ply.vapeID = vapeID
	ply.vapeCount = ply.vapeCount + 1
	if ply.vapeCount == 1 then
		ply.vapeArm = true
		net.Start("VapeArm")
		net.WriteEntity(ply)
		net.WriteBool(true)
		net.SendPVS(ply:EyePos())
	end
	if ply.vapeCount >= 50 then
		ply.cantStartVape = true
		ReleaseVape(ply)
	end
end

hook.Add("KeyRelease","DoVapeHook",function(ply, key)
	if key == IN_ATTACK and ply:Team() ~= TEAM_SPEC then
		ReleaseVape(ply)
		ply.cantStartVape=false
	end
end)
local mega_vape_used = false
hook.Add("TTTEndRound","Reset mega vape use",function() mega_vape_used = false end)
hook.Add("PlayerSwitchWeapon","Mega Vape Message",function(ply,_,new)
	if new:GetClass() ~= "weapon_vape_mega" then return end
	if not new.c then return end
	mega_vape_gettime(new.c,function(d)
		if not IsValid(ply) then return end
		if d then
			if d[1].time < os.time() then
				ply:MoatChat("Your Mega Vape has BIG smoke available!")
			else
				ply:MoatChat("Your Mega Vape's BIG smoke will be available in " .. string.NiceTime((d[1].time or 0) - os.time() ) .. "!")
			end
		else
			ply:MoatChat("Your Mega Vape has BIG smoke available!")
		end
	end)

end)
function ReleaseVape(ply)
	if not ply.vapeCount then ply.vapeCount = 0 end
	if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass():sub(1,11) == "weapon_vape" then
		if ply:GetActiveWeapon().VapeID == 2 and ply:GetActiveWeapon():GetTable().c and (not mega_vape_used) and (ply.vapeCount >= 5) then
			if not mega_vape_cache[ply:GetActiveWeapon():GetTable().c] then
				mega_vape_use(ply:GetActiveWeapon():GetTable().c,function(_,d)
					local v = (d and 2 or 1)
					if v == 2 then 
						mega_vape_used = true
						ply:MoatChat("You've used the BIG smoke! It will be available in " .. hours .. " hours!")
					else
						ply:MoatChat("Your Mega Vape's BIG smoke will be available in " .. string.NiceTime((_[1].time or 0) - os.time() ) .. "!")
					end
					net.Start("Vape")
					net.WriteEntity(ply)
					net.WriteInt(math.min(25,ply.vapeCount), 8)
					net.WriteInt(v, 8)
					net.Broadcast()
					ply.vapeCount=0 
				end)
			else
				local d = mega_vape_cache[ply:GetActiveWeapon():GetTable().c][1]
				if d.time > os.time() then
					ply:MoatChat("Your Mega Vape's BIG smoke will be available in " .. string.NiceTime((d.time or 0) - os.time() ) .. "!")
					net.Start("Vape")
					net.WriteEntity(ply)
					net.WriteInt(math.min(25,ply.vapeCount), 8)
					net.WriteInt(1, 8)
					net.SendPVS(ply:EyePos())
					ply.vapeCount=0
				else
					mega_vape_use(ply:GetActiveWeapon():GetTable().c,function(dd)
						local v = (dd[1].time < os.time() and 2 or 1)
						if v == 2 then 
							mega_vape_used = true 
							ply:MoatChat("You've used the BIG smoke! It will be available in " .. hours .. " hours!")
						else
							ply:MoatChat("Your Mega Vape's BIG smoke will be available in " .. string.NiceTime((dd[1].time or 0) - os.time() ) .. "!")
						end
						net.Start("Vape")
						net.WriteEntity(ply)
						net.WriteInt(math.min(25,ply.vapeCount), 8)
						net.WriteInt(v, 8)
						net.Broadcast()
						ply.vapeCount=0 
					end)
				end
			end
		elseif ply:GetActiveWeapon().VapeID == 2 and (ply.vapeCount >= 5) and (mega_vape_used) then
			net.Start("Vape")
			net.WriteEntity(ply)
			net.WriteInt(ply.vapeCount, 8)
			net.WriteInt(1, 8)
			net.SendPVS(ply:EyePos())
			ply:MoatChat("Someone already used their mega vape this round!")
			ply.vapeCount=0 
		elseif (ply.vapeCount >= 5) then
			net.Start("Vape")
			net.WriteEntity(ply)
			net.WriteInt(ply.vapeCount, 8)
			net.WriteInt(ply.vapeID + (ply:GetActiveWeapon().juiceID or 0), 8)
			net.SendPVS(ply:EyePos())
			ply.vapeCount=0 
		end
	else
		ply.vapeCount=0 
	end
	if ply.vapeArm then
		ply.vapeArm = false
		net.Start("VapeArm")
		net.WriteEntity(ply)
		net.WriteBool(false)
		net.Broadcast() --Always send the vape arm going down so it doesn't get stuck
	end
end

function SetVapeHelium(ply, helium)
	if ply.vapeHelium ~= helium then
		local grav = Lerp(helium/100, 1, -0.15)
		if grav < 0 and ply:OnGround() then
			ply:SetPos(ply:GetPos()+Vector(0,0,1))
		end
		ply:SetGravity(grav)
		ply.vapeHelium = helium
		ply:SendLua("vapeHelium="..tostring(helium))

		if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_vape_helium" then
			ply:GetActiveWeapon().SoundPitchMod=helium
			ply:SendLua("Entity("..tostring(ply:GetActiveWeapon():EntIndex())..").SoundPitchMod="..tostring(helium))
		end
	end
end

util.AddNetworkString("DragonVapeIgnite")

function m_DropVapeItem(ply, amt)
	if (amt == 1) then
		ply:m_DropInventoryItem("American Vape")
	else
		ply:m_DropInventoryItem("Juicy Vape")
	end
end