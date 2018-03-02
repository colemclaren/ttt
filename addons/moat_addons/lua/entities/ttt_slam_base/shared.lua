DEFINE_BASECLASS("ttt_mine_base")

ENT.Model = Model("models/weapons/w_slam.mdl")

function ENT:UseOverride(activator)
	if (IsValid(self) and (!self.Exploding) and IsValid(activator) and activator:IsPlayer()) then
		local owner = self:GetPlacer()
		if ((self:IsActive() and owner == activator) or (!self:IsActive())) then
			-- check if the user already has a slam
			if (activator:HasWeapon("weapon_ttt_slam")) then
				local weapon = activator:GetWeapon("weapon_ttt_slam")
				weapon:SetClip1(weapon:Clip1() + 1)
			else
				local weapon = activator:Give("weapon_ttt_slam")
				weapon:SetClip1(1)
			end

			-- remove the entity
			if activator:HasWeapon("weapon_ttt_slam") then
				self:Remove()
			else
				LANG.Msg(activator, "slam_full")
			end
		end
	end
end
