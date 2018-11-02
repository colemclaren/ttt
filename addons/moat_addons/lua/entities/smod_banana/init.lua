//files

AddCSLuaFile("cl_init.lua");

AddCSLuaFile("shared.lua");

include("shared.lua")



ENT.BananaType = 1;

ENT.Spawner = nil;

MaxBananaCount = 14;

print("Banana Bomb V1.0 loaded");



//when initializing

function ENT:Initialize()



	if self.BananaType == 1 then



		self.Entity:SetModel("models/props/cs_italy/bananna_bunch.mdl");



	else



		self.Entity:SetModel("models/props/cs_italy/bananna.mdl");



	end



	self.Entity:PhysicsInit(SOLID_VPHYSICS);

	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);

	self.Entity:SetSolid(SOLID_VPHYSICS);



	//physics object

	local Physics = self.Entity:GetPhysicsObject();



	//if valid

	if IsValid(Physics) then



		//wake

		Physics:Wake();



	else



		self.Entity:Remove();



	end



end



function ENT:DoBananas()

	if self && IsValid(self.Entity) then

		--PrintMessage(HUD_PRINTTALK,"Test01");

		local T = false;

		for I = 0,MaxBananaCount do

			local B = ents.Create("smod_banana");



			if IsValid(B) then



				B:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				B:SetPos(self.Entity:GetPos() + Vector(0,0,10) + VectorRand() * 5);

				B:SetAngles(Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)));

				B.BananaType = 2;

				B.Spawner = self.Spawner

				B:Spawn();

				B:Activate();

				--PrintMessage(HUD_PRINTTALK,"Test02");

				local Physics = B:GetPhysicsObject();



				if IsValid(Physics) then



					local Dir = VectorRand();



					Physics:ApplyForceCenter(Physics:GetMass() * Dir * math.Rand(4,8)*10);

					

					timer.Simple(0.5,function() Physics:ApplyForceCenter(Vector(0,0,15)*10); end);

					timer.Simple(1.5 ,function()Explode(T,B)end);

					if( I == MaxBananaCount) then

					T = !T;

					end

					--PrintMessage(HUD_PRINTTALK,"Test03");

				else



					B:Remove();



				end



			end



		end

		

		self.Entity:Remove();



	end

		

end



function Explode(T,B)

	self = B;

	if IsValid(B.Spawner) then



		if T then

			//effect data

			local FX = EffectData();

			FX:SetStart(self.Entity:GetPos());

			FX:SetOrigin(self.Entity:GetPos());

			FX:SetScale(1)



			//effect

			util.Effect("Explosion",FX)

		

			//damage

			util.BlastDamage(self.Entity,self.Spawner,self.Entity:GetPos(),230,90)

			

		end

		

	end

		

	//remove us

	self.Entity:Remove();



end 



function ENT:PhysicsCollide( data, phys )

	local randvar = math.random(1,3)

	self:EmitSound(Sound("weapons/bugbait/bugbait_squeeze"..math.random(1,3)..".wav"));--self:EmitSound( Sounds["Squeeze"..math.random(1,3)]);

	

end