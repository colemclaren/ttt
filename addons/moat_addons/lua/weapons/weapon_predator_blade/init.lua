AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function SWEP:Think()
	if (self:Clip1() < self.Primary.ClipSize and self.NextJumpStack < CurTime()) then
		self:SetClip1(self:Clip1() + 1)
		self.NextJumpStack = CurTime() + 5
	end

	local owner = self.Owner
	if (IsValid(owner) and owner:GetNW2Int("PredatorStacks") > self.MinimumPredatorStacks and self.NextSpeedDecrease < CurTime()) then
		self:ChangePredatorStacks(-1)
	end

	if (IsValid(owner)) then
		local increase = 1 + owner:GetNW2Int("PredatorStacks") * 0.1
		owner:SetWalkSpeed(200 * increase)
		owner:SetRunSpeed(400 * increase)
	end

	local idletime = self:GetNW2Float("NextIdle")
	if (idletime > 0 and CurTime() > idletime) then
		local vm = owner:GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
		self:UpdateNextIdle()
	end
end
