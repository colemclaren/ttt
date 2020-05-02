-- ENT.Type			= "anim"
-- ENT.Base			= "base_entity"
-- ENT.PrintName		= "ent_propshot"
-- ENT.Author			= "Cole McLaren"
-- ENT.Purpose 		= "ent_propshot"

-- ENT.Spawnable			= false
-- ENT.AdminSpawnable		= false 

ENT.Type			= "anim"
ENT.Base			= "base_entity"
ENT.PrintName		= "ent_propshot"
ENT.Author			= "Cole McLaren"
ENT.Purpose 		= "ent_propshot"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.MinSize = 4
ENT.MaxSize = 128
ENT.PropModels = {
	Model('models/foodnhouseholditems/pepper1.mdl'), Model('models/foodnhouseholditems/pepper2.mdl'), Model('models/foodnhouseholditems/pepper3.mdl')
}

function ENT:SetupDataTables()
    self:NetworkVar( "Vector", 0, "TrailColor", { KeyName = "trailcolor", Edit = { type = "Vector", order = 1 } } )

	self:NetworkVarNotify( "TrailColor", self.OnTrailColorChanged )
end

function ENT:Initialize()

    -- We do NOT want to execute anything below in this FUNCTION on CLIENT
    if ( CLIENT ) then return end

    -- Use the helibomb model just for the shadow (because it's about the same size)
    self:SetModel(self.PropModels[math.random(#self.PropModels)])

    -- We will put this here just in case, even though it should be called from OnBallSizeChanged in any case
    self:RebuildPhysics()

    -- Select a random color for the ball
    self:SetTrailColor(Vector(0.8, 1, 0.8))
end

function ENT:RebuildPhysics()
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:Wake()
		phys:EnableGravity(true)
	end
end

function ENT:OnPropModelChanged( varname, oldvalue, newvalue )
    -- Do not rebuild if the size wasn't changed
    if ( oldvalue == newvalue ) then return end

	local mdl = self.PropModels[newvalue][math.random(#self.PropModels[newvalue])]

	self.Entity:SetModel(mdl)
	self:SetModel(mdl)

	self:RebuildPhysics()
end

function ENT:OnTrailColorChanged( varname, oldvalue, newvalue )
    -- Do not rebuild if the size wasn't changed
    if ( oldvalue == newvalue ) then return end

	local color = Color(newvalue.x * 255, newvalue.y * 255, newvalue.z * 255, 255)
	if (SERVER) then
		self.Trail = util.SpriteTrail(self.Entity, 0, color, false, 15, 1, 0.1, 1/(15+1)*0.5, "trails/laser.vmt")
	end
end