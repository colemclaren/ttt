

AddCSLuaFile()



SWEP.HoldType = "slam"

--resource.AddFile("materials/vgui/ttt/icon_pigeon.vtf");

SWEP.PrintName    = "Pigeon Bomb"

if CLIENT then

   SWEP.Slot         = 6



   SWEP.ViewModelFOV = 0

   SWEP.ViewModelFlip = false



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "A bird that turns into a living timebomb\n if it spots a nearby innocent.\n\nLeft-click to place."

   };



   SWEP.Icon = "vgui/ttt/icon_pigeon"

   SWEP.IconLetter = "j"

end



SWEP.Base               = "weapon_tttbase"



SWEP.UseHands			= true

SWEP.ViewModelFlip		= false 

SWEP.ViewModel  = "models/weapons/v_crowbar.mdl"

SWEP.WorldModel = Model("models/weapons/w_c4.mdl")



SWEP.DrawCrosshair      = false

SWEP.Primary.Damage         = 50

SWEP.Primary.ClipSize       = -1

SWEP.Primary.DefaultClip    = -1

SWEP.Primary.Automatic      = true

SWEP.Primary.Delay = 1.1

SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize     = -1

SWEP.Secondary.DefaultClip  = -1

SWEP.Secondary.Automatic    = true

SWEP.Secondary.Ammo     = "none"

SWEP.Secondary.Delay = 1.4

SWEP.AllowDrop = false;



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy 

SWEP.IsSilent = true



-- Pull out faster than standard guns

SWEP.DeploySpeed = 2



function SWEP:PrimaryAttack()

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 

 

   self.Owner:LagCompensation(false)

    

   if SERVER then

   if (self.planted) then return end

   local ply = self.Owner;

         local ignore = {ply, self}

      local spos = ply:GetShootPos()

      local epos = spos + ply:GetAimVector() * 90

      local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})



      if tr.HitWorld and tr.HitNormal.z > 0 then

	  self.planted = true;

         self.Owner:SetAnimation( PLAYER_ATTACK1 )

		self:PlantBird(tr.HitPos, Angle(0, self.Owner:EyeAngles().yaw,0))

		self:Remove();

	  end

	  end

end

  if SERVER then

  function SWEP:PlantBird(pos, ang)

   

 

 local e = ents.Create("base_ai");

 e:SetPos(pos + Vector(0,0,10)); 

 e:SetModel("models/pigeon.mdl");

 	e:SetHullType( HULL_TINY );

	e:SetHullSizeNormal();

	e:SetOwner(self.Owner);

 

	e:SetSolid( SOLID_BBOX ) 

	e:SetMoveType( MOVETYPE_STEP )

 

	e:CapabilitiesAdd( bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS, CAP_MOVE_JUMP ));

 

	e:SetMaxYawSpeed( 5000 )

	e:SetModelScale(0.7, 0.1);

 

	//don't touch stuff above here

	e:SetHealth(100)

	e.nextc = 0;

	function e:OnTakeDamage(dmginfo)

	self:SetEnemy(dmginfo:GetAttacker());

	self:Detonate()

	end

	

	 local function explode(es)

	 	local ex = ents.Create("env_explosion")

	ex:SetKeyValue("iMagnitude", 90);

	ex:SetKeyValue("iRadius", 50);

	ex:SetOwner(es:GetOwner()); 

	ex:SetPos(es:GetPos());

	ex:Spawn()

	es:Remove();

	ex:Fire("explode")

	ex:Fire("kill","", 0.1);

	end

	function e:Detonate() 

	if (self.detonatingNow) then return end

	self.detonatingNow = true;

	self:SetColor(Color(255,0,0,255));

	self:EmitSound("music/stingers/hl1_stinger_song28.mp3", 30, 95);

 self:EmitSound("ambient/creatures/pigeon_idle" .. math.random(1,4) .. ".wav",500,100);

 local d = self;

 local tag;

 local en = self:GetEnemy()

    if IsValid(self:GetEnemy()) then

	local n = self:GetEnemy():GetName()

	if n == "" then 

	 n = self:GetEnemy():EntIndex() .. "_entity_";

	end   

	self:GetEnemy():SetName(n);

	local tf = ents.Create("npc_pigeon")

	tf:SetPos(self:GetPos())

	tf:CapabilitiesAdd( bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS, CAP_MOVE_JUMP, CAP_MOVE_FLY));

	tf:SetAngles(self:GetAngles())

	tf:SetModelScale(0.7, 0.01);

	tf:SetKeyValue("target", n);

	tf:Spawn()

	tf:SetOwner(self:GetOwner());

	tf:SetColor(Color(255,0,0,255));

	tf:SetHealth(5000);

	tf:SetSolid(SOLID_NONE);

	tf:Activate();

	tf:SetTarget(en)

	tf:Fire("FlyAway", n, 0.4); 

	tf:SetLastPosition(en:GetPos());

	tf:AddEntityRelationship(en, D_HT, 99);

	tf:SetEnemy(en);

	tf.nca = true;

	tf:SetSchedule(SCHED_CHASE_ENEMY);

	tf:SetPos(tf:GetPos() + Vector(0,0,20));

tf:SetVelocity(((en:GetPos() - tf:GetPos()):Angle():Forward() * 500) + Vector(0,0,500));

	d = tf;

	if (SERVER) then self:Remove(); end

	end

   local t = 0;

   

   local aas =  IsValid(en) and math.floor(d:GetPos():Distance(en:GetPos()) / 160) or 0;

   local tt = { 0.5,0.5,  0.45, 0.45,  0.4, 0.35, 0.3, 0.25, 0.2, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15  };

   if (aas > 0) then 

   for i = 1, aas do 

   table.insert(tt, 0, 1);

   end 

   end 

   for k,v in pairs(tt) do

   t = t + v; 

   if k == #tt then

      timer.Simple(t , function() if IsValid(d) then 

 

   explode(d)

   end

   

   end) 

 else

   timer.Simple(t , function() if IsValid(d) then 

   	  if  IsValid(en) then

 d:SetLastPosition(en:GetPos()); 

 d:SetTarget(en);  

 d:SetVelocity((en:GetPos() - d:GetPos()):Angle():Forward() * 200 );

 if (d:IsOnGround() and d.nca) then d:SetPos(d:GetPos() + Vector(0,0,10)) end  

	  end

   d:EmitSound("npc/turret_floor/ping.wav", 60 + (k * 5), 100 + (math.max(0, k - aas)  ));

   end

   

   end) 

   end

   end

	

	end

 

 function e:SelectSchedule()

 local pos = self:GetPos()

 local dist = 800;

 local target = nil;

 

 for k,v in pairs(util.GetAlivePlayers()) do

  if !v:GetTraitor() and  (v:GetPos() - pos):Length() < dist and self:Visible(v) then

  dist = (v:GetPos() - pos):Length()

  target = v;

  end

end

 

 if IsValid(target)  then

  	function self:Think() 

		if CurTime() >= e.nextc then

		e.nextc = CurTime() + 0.1;

		if (IsValid(self:GetEnemy()) and self:GetEnemy():IsPlayer() and self:GetEnemy():GetRole() ~= ROLE_TRAITOR) then

		 

		 local en = self:GetEnemy();

		 if not self.Detonating and (self:GetPos() - en:GetPos()):Length() <= 200  and self:Visible(en) then

		self.Detonating = true

		self:Detonate()

		

		end

		end

		end

	end 

 

 self:SetEnemy(target);

 self:SetLastPosition(target:GetPos())

 self:SetSchedule(SCHED_CHASE_ENEMY);

 	 

		 if not self.Detonating and (self:GetPos() - target:GetPos()):Length() <= 200 then

		self.Detonating = true

		self:Detonate()

		

		end

 else

 self:SetEnemy(nil); 

 self:SetLastPosition(self:GetPos() + Vector(math.random(-150,150),math.random(-150,150),math.random(0,80)));

 self:SetSchedule(SCHED_FORCED_GO);

 if math.random(1,3) == 2 then

 self:EmitSound("ambient/creatures/pigeon_idle" .. math.random(1,4) .. ".wav",60,100);

 end

 end

 end

 

 e:Spawn()

 e:SelectSchedule();

 end

  

  

  end



function SWEP:SecondaryAttack()

    

end



function SWEP:Deploy()

   if SERVER and IsValid(self.Owner) then

      self.Owner:DrawViewModel(false)

   end

   return true

end



function SWEP:Holster()

   return true

end



function SWEP:DrawWorldModel()

end

function SWEP:DrawViewModel()

end



function SWEP:DrawWorldModelTranslucent()

end



function SWEP:Equip()

   self.Weapon:SetNextPrimaryFire( CurTime() + (self.Primary.Delay * 1.5) ) 

end



function SWEP:PreDrop() 

end



function SWEP:OnRemove()

   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then

      RunConsoleCommand("lastinv")

   end

end



if CLIENT then

   function SWEP:DrawHUD()

   local ply = self.Owner;

         local ignore = {ply, self}

      local spos = ply:GetShootPos()

      local epos = spos + ply:GetAimVector() * 90

      local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})

		local reason = "LEFT-CLICK TO PLACE PIGEON BOMB";

		local success = true;

		

		if (tr.HitNormal.z <= 0) then

		reason = "YOU MUST PLACE THE PIGEON BOMB ON A HORIZONTAL SURFACE";

		success = false;

		end

		

      if !tr.HitWorld then

		reason = "YOU CAN'T PLACE IT HERE";

		success = false;

      end 

	  

	  if (tr.HitPos:Distance(self.Owner:GetShootPos()) > 81) then

	  reason = "TOO FAR AWAY TO PLACE";

	  success = false;

	  end

	  



         local x = ScrW() / 2.0

         local y = ScrH() / 2.0



         if (success) then

		 surface.SetDrawColor(0, 255, 0, 255)

		 else

		 surface.SetDrawColor(255, 0, 0, 255)

		 end



         local outer = 20

         local inner = 10

         surface.DrawLine(x - outer, y - outer, x - inner, y - inner)

         surface.DrawLine(x + outer, y + outer, x + inner, y + inner)



         surface.DrawLine(x - outer, y + outer, x - inner, y + inner)

         surface.DrawLine(x + outer, y - outer, x + inner, y - inner)



         draw.SimpleText(reason, "TabLarge", x, y - 30,success and COLOR_GREEN or  COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM) 

      return self.BaseClass.DrawHUD(self)

   end

end





