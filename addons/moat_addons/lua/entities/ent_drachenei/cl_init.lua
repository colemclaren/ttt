include("shared.lua")

local v = {};

function ENT:Initialize()
	local id = self.Entity:EntIndex()

	v[id] = {}
	v[id]["scale"] = 1.0;
	v[id]["t_scale"] = 1.0;
	timer.Simple(1.85, function()
		v[id]["t_scale"] = 5.0
	end)

	local vOffset = self.Entity:GetPos() + Vector( 0, 0, 0.2 )
	local vAngle = self.Entity:GetAngles()
end

local material, white = Material("drachenbomb/drache_small.png"), Color(255, 255, 255, 255)

function ENT:Draw()
	local id = self.Entity:EntIndex()
	local pos = self.Entity:GetPos()
	local scale = v[id]["scale"]

	v[id]["scale"] = Lerp(FrameTime()*10.5, v[id]["scale"], v[id]["t_scale"])

	render.SetMaterial(material)
	render.DrawSprite(pos+Vector(0,0,-3), 50*scale, 50*scale, white)
end

function ENT:Remove()
	v[id] = nil
end
