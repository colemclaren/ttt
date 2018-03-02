include('shared.lua')
ENT.Tension = 200
function ENT:Initialize()
	if(self.SetSoundtrack) then self:SetSoundtrack("music/bosstracks/theme_dragon.mp3") end

	local dalerp = 0

	hook.Add("CalcView", "md.calcview", function(ply, pos, ang, fov)
		if (self:IsValid() and IsValid(self) and self.GetController and self:GetController() and self:GetController():IsValid() and IsValid(self:GetController()) and self:GetController() == ply) then

			if (ply:KeyDown(IN_FORWARD)) then
				dalerp = Lerp(FrameTime() * 10, dalerp, 1)
			else
				dalerp = Lerp(FrameTime() * 10, dalerp, 0)
			end

			local view = {}
			view.origin = self:GetPos() - (ang:Forward() * (550 * dalerp)) + Vector(0, 0, 200)
			view.angles = ang
			view.fov = fov
			view.drawviewer = true

			return view
		else
			hook.Remove("CalcView", "md.calcview")
		end
	end)
end