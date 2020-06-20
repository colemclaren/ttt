// this file isn't ran
// just unobfuscated version of sh_duckhop.lua

local cv = CreateConVar("duck_hop_enabled", "1", FCVAR_REPLICATED)
if (SERVER) then
	cv:SetBool(true)
	concommand.Add("toggle_duck_hop", function(ply)
		if (not moat.isdev(ply)) then
			return
		end
		ply:ChatPrint "toggling"
		cv:SetBool(not cv:GetBool())
		print(not cv:GetBool())
	end)
end

hook.Add("Move", "duck_hop_limiter", function(ply, mv)
	if (not cv:GetBool()) then
		return
	end

	if (mv:KeyWasDown(IN_DUCK) and not mv:KeyDown(IN_DUCK)) then
		ply:SetNW2Float("PreventCrouch", CurTime())
	end

	if (not mv:KeyWasDown(IN_DUCK) and mv:KeyDown(IN_DUCK)) then
		local vo = ply:GetViewOffset()
		if (math.sqrt(ply:GetCurrentViewOffset():DistToSqr(vo)/ply:GetViewOffsetDucked():DistToSqr(vo)) > 0.05) then
			mv:SetButtons(bit.band(bit.bnot(IN_DUCK), mv:GetButtons()))
		else
			if (CurTime() - ply:GetNW2Float("PreventCrouch", 0) < 0.3) then
				ply:SetNW2Int("SpamCrouch", ply:GetNW2Int("SpamCrouch", 0) + 1)
			else
				ply:SetNW2Int("SpamCrouch", 0)
			end

			local dampen = 0.2 + math.min(ply:GetNW2Int("SpamCrouch", 0) * 0.035, 0.3)
			ply:SetDuckSpeed(dampen)
			ply:SetUnDuckSpeed(dampen)
		end
	end

	if (ply:GetMoveType() ~= MOVETYPE_WALK) then
		return
	end

	local vo = ply:GetViewOffset()
	local dt = math.sqrt(ply:GetCurrentViewOffset():DistToSqr(vo) / ply:GetViewOffsetDucked():DistToSqr(vo))
	local hopping = mv:KeyDown(IN_JUMP) or NULL == ply:GetGroundEntity()

	if (ply:Crouching() and mv:KeyDown(IN_DUCK) and hopping and NULL ~= ply:GetGroundEntity() and dt ~= 1) then
		mv:SetButtons(bit.band(bit.bnot(IN_DUCK), mv:GetButtons()))
		return
	end

	if (not ply:Crouching() and mv:KeyDown(IN_DUCK) and hopping) then
		if (dt <= 0.4 and NULL ~= ply:GetGroundEntity()) then
			mv:SetButtons(bit.band(bit.bnot(IN_DUCK + (dt ~= 0 and IN_JUMP or 0)), mv:GetButtons()))
			return
		end

		local x = mv:GetVelocity()
		local extravel = vector_origin
		local side = mv:GetSideSpeed()
		local ang = mv:GetAngles()
		ang.p = 0

		if (side ~= 0) then
			extravel = extravel + ang:Right() * (side / math.abs(side)) * 5
		end

		local forward = mv:GetForwardSpeed()
		if (forward ~= 0) then
			extravel = extravel + ang:Forward() * (forward / math.abs(forward)) * 5
		end

		x = (x + extravel) * engine.TickInterval() * 2

		local obbmins, obbmaxs = ply:GetHull()
		local tr = util.TraceHull({
			start = mv:GetOrigin(),
			endpos = mv:GetOrigin() + x,
			mins = obbmins,
			maxs = obbmaxs,
			filter = ply,
			mask = MASK_PLAYERSOLID,
			collisiongroup = ply:GetCollisionGroup()
		})

		if (tr.Hit) then
			local mins, maxs = ply:GetHullDuck()
			local extravel = Vector()
			local origin = mv:GetOrigin() + Vector(0, 0, obbmaxs.z - maxs.z)
			tr = util.TraceHull({
				start = origin,
				endpos = origin + x,
				mins = mins,
				maxs = maxs,
				filter = ply,
				mask = MASK_PLAYERSOLID,
				collisiongroup = ply:GetCollisionGroup()
			})

			if (not tr.Hit) then
				return
			end

			local v = tr.HitNormal
			v:Rotate(Angle(0,90))
			x  = x:GetNormalized():Dot(v) * v

			tr = util.TraceHull({
				start = origin,
				endpos = origin + x,
				mins = mins,
				maxs = maxs,
				filter = ply,
				mask = MASK_PLAYERSOLID,
				collisiongroup = ply:GetCollisionGroup()
			})

			if (not tr.Hit) then
				tr = util.TraceHull({
					start = mv:GetOrigin(),
					endpos = mv:GetOrigin() + x,
					mins = mins,
					maxs = maxs,
					filter = ply,
					mask = MASK_PLAYERSOLID,
					collisiongroup = ply:GetCollisionGroup()
				})

				if (tr.Hit) then
					return
				end
			end
		end

		mv:SetButtons(bit.band(bit.bnot(IN_DUCK), mv:GetButtons()))
	end
end)