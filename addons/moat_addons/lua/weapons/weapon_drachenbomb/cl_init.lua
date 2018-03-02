include("shared.lua")



function SWEP:GetViewModelPosition( pos, ang )
	pos = pos + ang:Right() * 7 + ang:Forward() * 17 + ang:Up() * -4.5
	return pos, ang
end

function SWEP:DrawWorldModel()
	p = self:GetPos()
	a = self:GetAngles()
	p = p + a:Right() * 7 + a:Forward() * 25 + a:Up() * 17
	self:SetPos(p)
	self:DrawModel()
end

