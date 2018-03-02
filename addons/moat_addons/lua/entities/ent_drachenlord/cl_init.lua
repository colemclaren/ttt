include("shared.lua")

local v = {}
function ENT:Initialize()
	local id = self.Entity:EntIndex()

	v[id] = {}
	v[id]["fadeOut"] = false
	v[id]["fadeValue"] = 255
	v[id]["scale"] = 0.01
	timer.Simple(6.5, 
		function()
			v[id]["fadeOut"] = true
		end
	)
	self:DrawShadow(false)
end

local material, white = Material("drachenbomb/drache.png"), Color(255, 255, 255, 255)

function ENT:Draw()
	local id = self.Entity:EntIndex()
	local pos = self.Entity:GetPos()
	alpha = 255
	scale = v[id]["scale"]

	if(scale < 1.0) then
		scale = Lerp(FrameTime()*5, scale, 1.0)
		v[id]["scale"] = scale
	end
	render.SetMaterial(material)
	if(v[id]["fadeOut"]) then
		alpha = Lerp(FrameTime()*5, v[id]["fadeValue"], 0)
		v[id]["fadeValue"] = alpha
		scale = v[id]["scale"] + 100.0*FrameTime()
		v[id]["scale"] = scale
	end
	render.DrawSprite(pos+Vector(0,0,math.Clamp(60*scale,0,60)), 80*scale, 130*scale, Color(255,255,255, alpha))
end

function ENT:Remove()
	v[id] = nil;
end
