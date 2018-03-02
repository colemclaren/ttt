util.GMIsAftermath = string.lower(GetConVarString("sv_gamemode")) == "aftermath"

function string.Count(str,substr)
	local num = 0
	local f = string.find(str,substr)
	while(f) do
		num = num +1
		f = string.find(str,substr,f +1)
	end
	return num
end

if(!timer) then require("timer") end
function timer.RemoveSafely(tm)	-- Removing a non-simple timer within the same timer can break the whole timer module. Doing this instead prevents that.
	timer.Stop(tm)
	timer.Simple(0,function() timer.Remove(tm) end)
end

function util.RemoveHookSafe(event,name)
	local tbl = hook.GetTable()
	if !tbl[event] || !tbl[event][name] then return end
	hook.Remove(event,name)
end

function MsgPrint(...)
	for _,msg in ipairs({...}) do
		Msg(tostring(msg) .. "\t")
	end
	Msg("\n")
end

function util.CalcArcVelocity(ent,vecSpot1,vecSpot2,flSpeed,flTolerance,bIgnoreObstacles)
	flTolerance = flTolerance || 0
	flSpeed = math.max(flSpeed,1)
	local flGravity = GetConVarNumber("sv_gravity")
	local vecVel = (vecSpot2 -vecSpot1)
	local time = vecVel:Length() /flSpeed
	vecVel = vecVel *(1 /time)
	vecVel.z = vecVel.z +flGravity *time *0.5
	
	local vecApex = vecSpot1 +(vecSpot2 -vecSpot1) *0.5
	vecApex.z = vecApex.z +0.5 *flGravity *(time *0.5) *(time *0.5)
	
	if(!bIgnoreObstacles) then
		local filter = {ent,ent:GetOwner()}
		local tr = util.TraceLine({
			start = vecSpot1,
			endpos = vecApex,
			mask = MASK_SOLID,
			filter = filter
		})
		if(tr.Fraction <= 0.9) then return vector_origin end
		local tr = util.TraceLine({
			start = vecApex,
			endpos = vecSpot2,
			mask = MASK_SOLID_BRUSHONLY,
			filter = filter
		})
		if(tr.Fraction <= 0.8) then
			local bFail = true
			if(flTolerance > 0) then
				local flNearness = (tr.endpos -vecSpot2):LengthSqr()
				if(flNearness < flTolerance ^2) then
					bFail = false
				end
			end
			if(bFail) then return vector_origin end
		end
	end
	return vecVel
end

function util.GetConstrictedDirection(pos,posTgt,ang,angLimit)
	local dir = (posTgt -pos):GetNormal()
	local angDir = dir:Angle()
	ang:Unify(-180)
	angDir:Unify(-180)
	local angDiff = angDir:Difference(ang)
	local angDiffAbs = Angle(math.abs(angDiff.p),math.abs(angDiff.y),math.abs(angDiff.r))
	ang.p = ang.p +(angDiffAbs.p > angLimit.p && angLimit.p *(angDiff.p /angDiffAbs.p) || angDiff.p)
	ang.y = ang.y +(angDiffAbs.y > angLimit.y && angLimit.y *(angDiff.y /angDiffAbs.y) || angDiff.y)
	ang.r = ang.r +(angDiffAbs.r > angLimit.r && angLimit.r *(angDiff.r /angDiffAbs.r) || angDiff.r)
	return ang:Forward()
end

function util.FindEntitiesInSphere(pos,r)	-- For some reason ents.FindInSphere doesn't find certain entities
	r = r ^2
	local tbEnts = {}
	for _, ent in ipairs(ents.GetAll()) do
		if(ent:IsValid() && (ent:NearestPoint(pos) -pos):LengthSqr() <= r) then
			table.insert(tbEnts,ent)
		end
	end
	return tbEnts
end

function math.SplitByPowerOfTwo(value)
	local tbl = {}
	while value > 0 do
		local i = 1
		while value >= i *2 do i = i *2 end
		table.insert(tbl, i)
		value = value -i
	end
	return tbl
end

function math.RoundForPos(num, pos, bKeepZeros)
	local inc = 10 ^pos
	local numRound = math.Round(num *inc) /inc
	if !bKeepZeros || pos <= 0 then return numRound end
	local decStart = string.find(numRound, "[.]")
	if !decStart then return numRound .. "." .. string.rep("0", pos) end
	return numRound .. string.rep("0", pos -(string.len(num) -(decStart)))
end

function ents.GetNPCs()
	local tblNPCs = {}
	for k, ent in pairs(ents.GetAll()) do
		if ent:IsNPC() then table.insert(tblNPCs, ent) end
	end
	return tblNPCs
end

function table.IsEmpty(tbl)
	for _, v in pairs(tbl) do return false end
	return true
end

local tblCustomAmmo = {}
function util.RegisterCustomAmmoType(ammo, ammoName)
	tblCustomAmmo[ammo] = ammoName
end

function util.GetCustomAmmoTypes()
	return tblCustomAmmo
end

function util.GetAmmoName(ammo)
	if tblCustomAmmo[ammo] then return tblCustomAmmo[ammo] end
	if ammo == "Buckshot" then return "Shotgun Ammo"
	elseif ammo == "RPG_Round" then return "RPG Round"
	elseif ammo == "XBowBolt" then return "Crossbow Bolts"
	elseif ammo == "SniperRound" || ammo == "SniperPenetratedRound" then return "Sniper Round"
	elseif ammo == "GaussEnergy" then return "Gauss Energy"
	elseif ammo == "Grenade" then return "Grenades"
	elseif ammo == "SMG1_Grenade" then return "SMG Grenades"
	elseif ammo == "AR2AltFire" then return "Combine's Balls"
	elseif ammo == "slam" then return "SLAM Ammo"
	else return ammo .. " Ammo" end
end

local tblAmmoDefault = {
	"ar2", 
	"alyxgun", 
	"pistol", 
	"smg1", 
	"357", 
	"xbowbolt", 
	"buckshot", 
	"rpg_round", 
	"smg1_grenade", 
	"sniperround", 
	"sniperpenetratedround", 
	"grenade", 
	"thumper", 
	"gravity", 
	"battery", 
	"gaussenergy", 
	"combinecannon", 
	"airboatgun", 
	"striderminigun", 
	"helicoptergun", 
	"ar2altfire", 
	"slam"
}
function util.IsDefaultAmmoType(ammo)
	return table.HasValue(tblAmmoDefault, string.lower(ammo))
end

function table.refresh(tbl) -- obsolete; kept for backward-compatibilty
	table.MakeSequential(tbl)
end

function table.MakeSequential(tbl)
	local i = 1
	for ind, _ in pairs(tbl) do
		if ind > i then tbl[i] = tbl[ind]; tbl[ind] = nil end
		i = i +1
	end
end

function util.IsInWater(vecPos)
	return util.TraceLine({start = vecPos +Vector(0,0,32768), endpos = vecPos, mask = MASK_WATER}).Hit
end

function util.HLR_MinMaxVector(vecA, vecB)
	local vecMin, vecMax = Vector(), Vector()
	if vecA.x < vecB.x then vecMin.x = vecA.x; vecMax.x = vecB.x else vecMin.x = vecB.x; vecMax.x = vecA.x end
	if vecA.y < vecB.y then vecMin.y = vecA.y; vecMax.y = vecB.y else vecMin.y = vecB.y; vecMax.y = vecA.y end
	if vecA.z < vecB.z then vecMin.z = vecA.z; vecMax.z = vecB.z else vecMin.z = vecB.z; vecMax.z = vecA.z end
	return vecMin, vecMax
end
