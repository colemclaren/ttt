ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName		= "DoorBuster"
ENT.Author			= "Kenny"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

if SERVER then return end
 
-- ENT.TimerSeconds=5 //Zeit bis zur Explosion
 
function ENT:Initialize()
    -- self.ExplodeTime=self.TimerSeconds+CurTime() //Zeitpunkt der Explosion
	self:SetMaterial("c4_green/w/c4_green")
end
 
/*function ENT:Draw()
    self:DrawModel()
    local pos,ang=self:GetPos()+self:GetUp()*9+self:GetForward()*4.05+self:GetRight()*4.40,self:GetAngles()
    ang:RotateAroundAxis(ang:Up(),-90)
    cam.Start3D2D(pos,ang,0.15)
        draw.DrawText(string.FormattedTime(self.ExplodeTime-CurTime(),"%02i:%02i"),"C4ModelTimer",0,0,Color(255,0,0,255),TEXT_ALIGN_CENTER)
    cam.End3D2D()
end*/