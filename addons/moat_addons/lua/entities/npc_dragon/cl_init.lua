include('shared.lua')
ENT.Tension = 200
function ENT:Initialize()
	if(self.SetSoundtrack) then self:SetSoundtrack("music/bosstracks/theme_dragon.mp3") end

	hook.Add("CalcView", "md.calcview", function(ply, pos, ang, fov)
		if (self:IsValid() and IsValid(self) and self:GetController() and self:GetController():IsValid() and IsValid(self:GetController()) and self:GetController() == ply) then

			local view = {}
			view.origin = self:GetPos() - (ang:Forward() * 550) + Vector(0, 0, 100)
			view.angles = ang
			view.fov = fov
			view.drawviewer = true

			return view
		else
			hook.Remove("CalcView", "md.calcview")
		end
	end)
end

net.Receive("dragon_roar",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid()) then return end
	local posLp = LocalPlayer():GetPos()
	local pos = ent:GetPos()
	posLp.z = pos.z
	local dist = ent:NearestPoint(posLp):Distance(posLp)
	local snd
	local sndLevel
	if(dist <= 5000) then
		snd = "dragon_flightroar0" .. math.random(1,8) .. ".mp3"
		sndLevel = 100
	elseif(dist <= 15000) then
		snd = "dragon_flightroar_distant0" .. math.random(1,2) .. ".mp3"
		sndLevel = 160
	elseif(dist <= 30000) then
		snd = "dragon_flightroar_distant_b0" .. math.random(1,8) .. ".mp3"
		sndLevel = 160
	else return end
	ent:EmitSound("npc/dragon/" .. snd,sndLevel)
end)

local tracks,durations = {
	"music/skyrim_combat_theme02.mp3",
	"music/skyrim_combat_theme03.mp3"
},{
	186,
	135
}
function ENT:GetSoundtracks()
	return tracks,durations
end