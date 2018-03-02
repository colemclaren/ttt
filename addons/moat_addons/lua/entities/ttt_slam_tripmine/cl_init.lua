include('shared.lua')

ENT.LaserMaterial = Material("trails/laser")
local Laser = {}
local BeamSettings = {
	{ size = 1.0, color = Color( 55, 0, 0, 255) },
	{ size = 2.0, color = Color(105, 0, 0, 255) },
	{ size = 3.0, color = Color(155, 0, 0, 255) },
	{ size = 4.0, color = Color(205, 0, 0, 255) },
	{ size = 5.0, color = Color(255, 0, 0, 255) }
}

hook.Add("TTTPrepareRound", "SLAMLaserClean", function()
	for _, slam in pairs(Laser) do
		hook.Remove("PostDrawTranslucentRenderables", "SLAMBeam" .. slam)
	end
	Laser = {}
end)

local bSetting = GetConVar("ttt_slam_beamsize")
function ENT:ActivateSLAM()
	if (IsValid(self)) then
		self.LaserPos = self:GetAttachment(self:LookupAttachment("beam_attach")).Pos

		local ignore = ents.GetAll()
		local tr = util.QuickTrace(self.LaserPos, self:GetUp() * 10000, ignore)
		self.LaserLength = tr.Fraction
		self.LaserEndPos = tr.HitPos

		self:SetDefusable(true)

		local index = self:EntIndex()
		hook.Add("PostDrawTranslucentRenderables", "SLAMBeam" .. index, function()
			if (IsValid(self) and self:IsActive()) then
				render.SetMaterial(self.LaserMaterial)
				if (LocalPlayer():IsTraitor() or LocalPlayer():HasWeapon("weapon_ttt_defuser")) then
					render.DrawBeam(self.LaserPos, self.LaserEndPos, BeamSettings[5].size, 1, 1, BeamSettings[5].color)
				else
					render.DrawBeam(self.LaserPos, self.LaserEndPos, BeamSettings[bSetting:GetInt()].size, 1, 1, BeamSettings[bSetting:GetInt()].color)
				end
			end
		end)
		table.insert(Laser, index)
	end
end
