
EFFECT.Models = {}
EFFECT.Models[1] = Model("models/shells/ahell_9mm.mdl")
EFFECT.Models[2] = Model("models/shells/ahell_57.mdl")
EFFECT.Models[3] = Model("models/shells/ahell_556.mdl")
EFFECT.Models[4] = Model("models/shells/ahell_762nato.mdl")
EFFECT.Models[5] = Model("models/shells/ahell_12gauge.mdl")
EFFECT.Models[6] = Model("models/shells/ahell_338mag.mdl")
EFFECT.Models[7] = Model("models/weapons/rifleshell.mdl")
EFFECT.Models[8] = Model("models/shells/garand_clip.mdl")

EFFECT.Sounds = {}
EFFECT.Sounds[1] = {Pitch = 100, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[2] = {Pitch = 100, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[3] = {Pitch = 90, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[4] = {Pitch = 90, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[5] = {Pitch = 110, Wavs = {"weapons/fx/tink/shotgun_shell1.wav", "weapons/fx/tink/shotgun_shell2.wav", "weapons/fx/tink/shotgun_shell3.wav"}}
EFFECT.Sounds[6] = {Pitch = 80, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[7] = {Pitch = 70, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
EFFECT.Sounds[8] = {Pitch = 100, Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}

function EFFECT:Init(data)
	
	if not ValidEntity(data:GetEntity()) then 
		self.Entity:SetModel("models/shells/ahell_9mm.mdl")
		self.RemoveMe = true
		return 
	end
	
	local bullettype = math.Clamp((data:GetScale() or 1), 1, 8)
	local angle, pos = self.Entity:GetBulletEjectPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	
	local direction = angle:Forward()
	local ang = LocalPlayer():GetAimVector():Angle()

	self.Entity:SetPos(pos)
	self.Entity:SetModel(self.Models[ bullettype ] or "models/shells/shell_9mm.mdl")
	
	self.Entity:PhysicsInitBox(Vector(-1,-1,-1), Vector(1,1,1))
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetCollisionBounds(Vector(-128 -128, -128), Vector(128, 128, 128))
	
	local phys = self.Entity:GetPhysicsObject()
	
	if ValidEntity(phys) then
		phys:Wake()
		phys:SetDamping(0, 15)
		phys:SetVelocity(direction * math.random(675, 750))
		phys:AddAngleVelocity((VectorRand() * 500))
		phys:SetMaterial("gmod_silent")
	end
	
	self.Entity:SetAngles(ang)
	
	self.HitSound = table.Random(self.Sounds[ bullettype ].Wavs)
	self.HitPitch = self.Sounds[ bullettype ].Pitch + math.random(-10,10)
	
	self.SoundTime = CurTime() + math.Rand(0.5, 0.75)
	self.LifeTime = CurTime() + 60
	self.Alpha = 255
end

function EFFECT:GetBulletEjectPos(Position, Ent, Attachment)

	if (!Ent:IsValid()) then return Angle(), Position end
	if (!Ent:IsWeapon()) then return Angle(), Position end

	// Shoot from the viewmodel
	if (Ent:IsCarriedByLocalPlayer() && GetViewEntity() == LocalPlayer()) then
	
		local ViewModel = LocalPlayer():GetViewModel()
		
		if (ViewModel:IsValid()) then
			
			local att = ViewModel:GetAttachment(Attachment)
			if (att) then
				return att.Ang, att.Pos
			end
			
		end
	// Shoot from the world model
	else
		local att = Ent:GetAttachment(Attachment)
		if (att) then
			return att.Ang, att.Pos
		end
	end

	return Angle(), Position
end


function EFFECT:Think()

	if self.RemoveMe then return false end

	if self.SoundTime and self.SoundTime < CurTime() then
		self.SoundTime = nil
		WorldSound(self.HitSound, self.Entity:GetPos(), 75, self.HitPitch) 
	end
	
	if self.LifeTime < CurTime() then
		self.Alpha = (self.Alpha or 255) - 2
		self.Entity:SetColor(255, 255, 255, self.Alpha)
	end

	return self.Alpha > 2
end

function EFFECT:Render()

	self.Entity:DrawModel()
end


