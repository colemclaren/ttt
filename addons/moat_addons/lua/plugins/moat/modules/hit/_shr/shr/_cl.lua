local c, b = CreateClientConVar("shr_enabled", tostring(SHR.Config.ClientDefault), true, true), 0
local function a(e, t)
	local att = t.Attacker
	if (not IsValid(att) or att ~= LocalPlayer() or not c:GetBool() or not IsFirstTimePredicted()) then return end

	math.randomseed(e:GetCurrentCommand():CommandNumber())
	local k = e:EntIndex() .. "shr" .. math.random()
	t.Callback = function(a, tr, d)
		if (not d or not tr.HitGroup or not IsValid(tr.Entity)) then return end

		timer.Simple(0, function()
			net.Start "shr"
				net.WriteDouble(b)
				net.WriteString(k)
				net.WriteEntity(tr.Entity)

				net.WriteVector(tr.StartPos)
				net.WriteVector(tr.HitPos)
				net.WriteVector(d:GetDamageForce())

				net.WriteUInt(tr.HitGroup, 4)
			net.SendToServer()
		end)
	end

	return true
end
hook.Add("EntityFireBullets", "‍a", a)
net.Receive("shr", function() b = net.ReadDouble() end)