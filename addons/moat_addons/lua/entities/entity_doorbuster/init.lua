AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.entHealth = 50
ENT.Exploded = false

function ENT:Initialize()
  self.Entity:PhysicsInit( SOLID_VPHYSICS )
  self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
  self.Entity:SetSolid( SOLID_VPHYSICS )
  self.Entity:SetModel("models/weapons/w_c4_planted.mdl")
  self.Entity:SetUseType(1)
  self.Owner = self.Entity:GetOwner()
  local phys = self.Entity:GetPhysicsObject()
  if (phys:IsValid()) then
    phys:Wake()
    phys:EnableDrag(true)
    phys:EnableMotion(false)
  end
end

function ENT:Explode()
  if self.Exploded then return end
  self.Exploded = true
  local effectdata = EffectData()
  effectdata:SetAngles(self.Entity:GetAngles())
  effectdata:SetOrigin(self.Entity:GetPos())
  util.Effect("ThumperDust",effectdata)
  local effectdata2 = EffectData()
  effectdata2:SetOrigin(self.Entity:GetPos())
  util.Effect("Explosion",effectdata2)
  self.Entity:EmitSound("ambient/explosions/explode_4.wav",100,100)
  local pos = self.Entity:GetPos()
  self.Entity:Remove()
  util.BlastDamage(self.Entity, self.Owner, pos, 150, 200 )
  local Bombs = ents.FindInSphere(pos,120)
  for k, v in pairs(Bombs) do
    if v:GetClass()=="entity_doorbuster" and v != self.Entity then v:Explode() end
  end
end

function ENT:BlowDoor()
  self:Explode()
  for k, v in pairs(ents.FindInSphere(self.Entity:GetPos(),80)) do
    if v:GetClass()=="prop_door_rotating" and not v.Exploded then
      v:SetColor(0,0,0,0)
      local door = ents.Create("prop_physics")
      door:SetModel(v:GetModel())
      local pos=v:GetPos()
      pos:Add(self.Entity:GetAngles():Up()*-13)
      door:SetPos(pos)
      door:SetAngles(v:GetAngles())
      door:SetSkin(v:GetSkin())
      door:SetMaterial(v:GetMaterial())
      door:Spawn()
      local phys = door:GetPhysicsObject()
      phys:ApplyForceOffset((self.Entity:GetAngles():Up()*-10000)*phys:GetMass(),self.Entity:GetPos())
      v.Collision = v:GetCollisionGroup()
      v:SetCollisionGroup(1)
      v.Exploded = true
      v:Remove()
    end
  end
end

function ENT:OnTakeDamage(dmginfo)
  if dmginfo:IsBulletDamage() then
    self.entHealth = self.entHealth - dmginfo:GetDamage()
    if self.entHealth<= 0 then
      self:BlowDoor()
    end
  end
end
