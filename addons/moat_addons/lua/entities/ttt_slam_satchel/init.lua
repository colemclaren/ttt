AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:DecreaseSatchel()
	local weapon = self:GetPlacedBy()
	if (IsValid(weapon)) then
		weapon:ChangeActiveSatchel(-1)
	end
end

function ENT:Disarm(ply)
	local owner = self:GetPlacer()
	SCORE:HandleC4Disarm(ply, owner, true)

	if (IsValid(owner)) then
		if (IsValid(owner)) then
			LANG.Msg(owner, "slam_disarmed")
		end
	end

	self:DecreaseSatchel()

	self:SetBodygroup(0, 0)
	self:SetDefusable(false)
	self:SendWarn(false)
end

function ENT:OnRemove()
	if (self:IsActive()) then
		self:DecreaseSatchel()
	end
	self:SendWarn(false)
end
