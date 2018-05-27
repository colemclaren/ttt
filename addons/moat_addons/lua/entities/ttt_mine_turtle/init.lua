AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
util.AddNetworkString("TTT_MineTurtleWarning")

local validDoors = {"func_door", "func_door_rotating", "prop_door_rotating"}
/*
hook.Add("TTTPrepareRound", "MineTurtleClean", function()
	for _, slam in pairs(ents.FindByClass("ttt_mine_turtle")) do
		slam:Remove()
	end
end)
*/
local specDM = file.Exists("sh_spectator_deathmatch.lua", "LUA")
function ENT:Think()
	if (IsValid(self) and self:IsActive()) then
		if (!self.HelloPlayed) then
			local isValid
			for _, ent in ipairs(ents.FindInSphere(self:GetPos(), self.ScanRadius)) do
				-- Spectator Deathmatch support
				isValid = IsValid(ent) and ent:IsPlayer() and !ent:IsSpec() and not ent:IsTraitor()
				if (isValid and specDM) then
					isValid = !ent:IsGhost()
				end

				if (isValid) then
					-- check if the target is visible
					local spos = self:GetPos() + Vector(0, 0, 10) -- let it work a bit better on steps, but then it doesn't work so good at ceilings
					local epos = ent:GetPos() + Vector(0, 0, 10) -- let it work a bit better on steps, but then it doesn't work so good at ceilings

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

function ENT:SendWarn(armed)
	local owner = self:GetPlacer()
	if (!armed or (IsValid(owner) and owner:IsTraitor())) then
		net.Start("TTT_MineTurtleWarning")
			net.WriteUInt(self:EntIndex(), 16)
			net.WriteBool(armed)
			net.WriteVector(self:GetPos())
		net.Send(GetTraitorFilter(true))
	end
end

function ENT:Disarm(ply)
	local owner = self:GetPlacer()
	SCORE:HandleC4Disarm(ply, owner, true)

	if (IsValid(owner)) then
		LANG.Msg(owner, "mine_turtle_disarmed")
	end

	self:SetDefusable(false)
	self:SendWarn(false)
end

function ENT:OnRemove()
	self:SendWarn(false)
end
