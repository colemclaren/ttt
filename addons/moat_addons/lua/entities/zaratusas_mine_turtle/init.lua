AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local validDoors = {"func_door", "func_door_rotating", "prop_door_rotating"}

function ENT:Think()
	if (IsValid(self) and self:IsActive()) then
		if (!self.HelloPlayed) then
			for _, ent in ipairs(ents.FindInSphere(self:GetPos(), self.ScanRadius)) do
				if (IsValid(ent) and ent:IsPlayer()) then
					-- check if the target is visible
					local spos = self:GetPos() + Vector(0, 0, 5) -- let it work a bit better on steps, but then it doesn't work so good at ceilings
					local epos = ent:GetPos() + Vector(0, 0, 5) -- let it work a bit better on steps, but then it doesn't work so good at ceilings

					local tr = util.TraceLine({start=spos, endpos=epos, filter=self, mask=MASK_SOLID})
					if (!tr.HitWorld and IsValid(tr.Entity) and !table.HasValue(validDoors, tr.Entity:GetClass()) and ent:Alive()) then
						self:EmitSound(self.ClickSound)
						timer.Simple(0.15, function() if (IsValid(self)) then sound.Play(self.HelloSound, self:GetPos(), 100, math.random(95, 105), 1) end end)
						self.HelloPlayed = true

						timer.Simple(0.85, function() if (IsValid(self)) then self:StartExplode(true) end end)
						break
					end
				end
			end
		end

		self:NextThink(CurTime() + 0.05)
		return true
	end
end

function ENT:Disarm(ply)
	if (IsValid(owner)) then
		LANG.Msg(owner, "mine_turtle_disarmed")
	end

	self:SetDefusable(false)
end
