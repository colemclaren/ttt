local ManhackHealth = 500

local ManhackDamage = 10



SWEP.HoldType            = "grenade"



SWEP.PrintName                = "Throwable Manhacks"



if CLIENT then

   

   SWEP.Slot = 6

    

   SWEP.ViewModelFlip = false

   SWEP.ViewModelFOV = 70

   

      SWEP.EquipMenuData = {

      type = "Weapon",

      desc = "Left click to hit to throw a manhack into the air!\n\nHas 3 uses."

    };

   

   SWEP.Icon = "vgui/ttt/icon_manhack.png"



end



SWEP.Base = "weapon_tttbase"



SWEP.ViewModel = "models/weapons/cstrike/c_eq_fraggrenade.mdl"

SWEP.WorldModel  = "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight                = 5

SWEP.AutoSwitchTo        = true

SWEP.AutoSwitchFrom        = true

SWEP.Primary.ClipSize       = 1

SWEP.Primary.ClipMax	    = 3

SWEP.Primary.Delay			= 1.5

SWEP.Primary.DefaultClip    = 0

SWEP.Primary.Automatic      = false

SWEP.Primary.Ammo           = "Xbowbolt"



SWEP.UseHands = true

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {

	["v_weapon.Flashbang_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_R_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, -10, 1.11) },

	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, 0, 0) }

}

SWEP.VElements = {

	["manhack"] = { type = "Model", model = "models/manhack.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 2.596, -0.519), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

SWEP.WElements = {

	["manhack"] = { type = "Model", model = "models/manhack.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 5.714, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}



SWEP.AutoSpawnable = false



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.LimitedStock = true

SWEP.AllowDrop = true

SWEP.IsSilent = false

SWEP.NoSights = false


function SWEP:WasBought(buyer)
   if IsValid(buyer) then -- probably already self.Owner
      buyer:GiveAmmo(3, "XBowBolt")
   end
end

function SWEP:PrimaryAttack()

	if !self:CanPrimaryAttack() then return end

	

	self.Owner.ThrownHax = self.Owner.ThrownHax or {} 

	

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

        

    if self.Owner:WaterLevel() == 3 then return end

	

	self:SendWeaponAnim(ACT_VM_PULLPIN)

	



	timer.Simple(1, function()

		if !IsValid(self.Owner) then return end

		if !IsValid(self) then return end

		

		if SERVER then

			self.Owner:SetAnimation( PLAYER_ATTACK1 )

			self.Owner:EmitSound("weapons/crossbow/fire1.wav")

			self:MakeAManhack()
	   
			if self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) < 1 then
				self.Owner:StripWeapon(self:GetClass())
				return
			end

			

			self:SendWeaponAnim(ACT_VM_DEPLOY)

			

			self:TakePrimaryAmmo(1)

			self:Reload()

		end

	end)



end

if SERVER then
    function SWEP:MakeAManhack()

        local hack = ents.Create("npc_manhack")

        hack:SetOwner(self.Owner)

        hack.Controller = self.Owner

        

        local vVelocity = self.Owner:GetVelocity()

        local vThrowPos = self.Owner:EyePos() + self.Owner:GetRight() * 8

            

        hack.CanPickup = false

        hack:SetPos( self:CheckSpace(vThrowPos) or ( vThrowPos + self.Owner:GetForward() * 30) )

        hack:SetKeyValue("spawnflags","73728")

        hack:SetKeyValue("Squad Name", tostring(self.Owner:UniqueID()) )

        hack:Spawn()

		hack:SetHealth(ManhackHealth)

        constraint.NoCollide( self.Owner, hack, 0, 0 )

        

        local phys = hack:GetPhysicsObject()

        phys:SetVelocity(self.Owner:GetAimVector() * 60 + Vector(0,0,200) )

        hack:SetAngles(hack:GetAngles()+Angle(0,-90,0))



        table.insert(self.Owner.ThrownHax, hack)

		

        hack:AddEntityRelationship(self.Owner,D_LI,99)

		for k, v in pairs(player.GetAll()) do 

			if !v:IsValid() then continue end

			

			if v:IsActiveTraitor() then

				hack:AddEntityRelationship(v,D_LI,99)

			end

		end

				

        if #self.Owner.ThrownHax == 1 then self:CallOnClient("DManhackAnim","4") end

        self.Owner.ThrownHaxNum = (self.Owner.ThrownHaxNum or 0) + 1

    end



    function SWEP:CheckSpace(vThrowPos)



        local ang = self.Owner:GetAimVector()

        local tracedata = {}

        tracedata.start = vThrowPos

        tracedata.endpos = vThrowPos + (ang*24)

        tracedata.filter = self.Owner

        tracedata.mins = Vector(-8, -8, -4)



        tracedata.maxs = Vector(8, 8, 4)





        local tr = util.TraceHull(tracedata)

        

        if tr.Hit then

            return vThrowPos

        else

            return nil

        end
    end

	    hook.Add("EntityTakeDamage","ManhackDamage", function( hack, dmginfo )
	    	local inflictor = dmginfo:GetInflictor()
			if (not IsValid(inflictor)) then return end

        	if inflictor.ManhackExplosion then
        	    if inflictor.ManhackExplosion.Controller and hack.Controller and hack.Controller == inflictor.ManhackExplosion.Controller then
        	        dmginfo:SetDamage(0)
        	    else
        	        dmginfo:SetInflictor(inflictor.ManhackExplosion)
					if (IsValid(inflictor.ManhackExplosion.Controller)) then
        	        	dmginfo:SetAttacker(inflictor.ManhackExplosion.Controller)
					end
        	    end
        	end

        	if inflictor.Controller then
            	if hack.Controller and hack.Controller == inflictor.Controller then
            	    dmginfo:SetDamage(0)
            	else
            	    dmginfo:SetAttacker(inflictor.Controller)
        		end
        	end
    	end)

    	hook.Add("EntityTakeDamage", "ManhackTraitor", function(ent, dmginfo)
    		if !IsValid(dmginfo:GetAttacker()) then return end
			if !IsValid(ent) then return end

    		if dmginfo:GetAttacker():GetClass() == "npc_manhack" then 
        		if ent:IsActiveTraitor() then dmginfo:ScaleDamage(0) return end
        		dmginfo:ScaleDamage(ManhackDamage)
    		end
		end)
end


function SWEP:Initialize()
	self.Owner.ThrownHax = {}

	if CLIENT then

	

		// Create a new table for every weapon instance

		self.VElements = table.FullCopy( self.VElements )

		self.WElements = table.FullCopy( self.WElements )

		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )



		self:CreateModels(self.VElements) // create viewmodels

		self:CreateModels(self.WElements) // create worldmodels

		

		// init view model bone build function

		if IsValid(self.Owner) then

			local vm = self.Owner:GetViewModel()

			if IsValid(vm) then

				self:ResetBonePositions(vm)

				

				// Init viewmodel visibility

				if (self.ShowViewModel == nil or self.ShowViewModel) then

					vm:SetColor(Color(255,255,255,255))

				else

					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called

					vm:SetColor(Color(255,255,255,1))

					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in

					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing

					vm:SetMaterial("Debug/hsv")			

				end

			end

		end

		

	end



end



function SWEP:Holster()

	

	if CLIENT and IsValid(self.Owner) then

		local vm = self.Owner:GetViewModel()

		if IsValid(vm) then

			self:ResetBonePositions(vm)

		end

	end

	

	return true

end



function SWEP:RemoveModels(tab)
    if (!tab) then return end
    for k, v in pairs( tab ) do
        if (IsValid(v.modelEnt)) then
            v.modelEnt:Remove()
            v.modelEnt = nil
        end
    end
end

function SWEP:OnRemove()
	if (CLIENT) then
    	self:RemoveModels(self.VElements)
    	self:RemoveModels(self.WElements)
    end

	self:Holster()
end



if CLIENT then



	SWEP.vRenderOrder = nil

	function SWEP:ViewModelDrawn()

		

		local vm = self.Owner:GetViewModel()

		if !IsValid(vm) then return end

		

		if (!self.VElements) then return end

		

		self:UpdateBonePositions(vm)



		if (!self.vRenderOrder) then

			

			// we build a render order because sprites need to be drawn after models

			self.vRenderOrder = {}



			for k, v in pairs( self.VElements ) do

				if (v.type == "Model") then

					table.insert(self.vRenderOrder, 1, k)

				elseif (v.type == "Sprite" or v.type == "Quad") then

					table.insert(self.vRenderOrder, k)

				end

			end

			

		end



		for k, name in ipairs( self.vRenderOrder ) do

		

			local v = self.VElements[name]

			if (!v) then self.vRenderOrder = nil break end

			if (v.hide) then continue end

			

			local model = v.modelEnt

			local sprite = v.spriteMaterial

			

			if (!v.bone) then continue end

			

			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )

			

			if (!pos) then continue end

			

			if (v.type == "Model" and IsValid(model)) then



				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )

				ang:RotateAroundAxis(ang:Up(), v.angle.y)

				ang:RotateAroundAxis(ang:Right(), v.angle.p)

				ang:RotateAroundAxis(ang:Forward(), v.angle.r)



				model:SetAngles(ang)

				//model:SetModelScale(v.size)

				local matrix = Matrix()

				matrix:Scale(v.size)

				model:EnableMatrix( "RenderMultiply", matrix )

				

				if (v.material == "") then

					model:SetMaterial("")

				elseif (model:GetMaterial() != v.material) then

					model:SetMaterial( v.material )

				end

				

				if (v.skin and v.skin != model:GetSkin()) then

					model:SetSkin(v.skin)

				end

				

				if (v.bodygroup) then

					for k, v in pairs( v.bodygroup ) do

						if (model:GetBodygroup(k) != v) then

							model:SetBodygroup(k, v)

						end

					end

				end

				

				if (v.surpresslightning) then

					render.SuppressEngineLighting(true)

				end

				

				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)

				render.SetBlend(v.color.a/255)

				model:DrawModel()

				render.SetBlend(1)

				render.SetColorModulation(1, 1, 1)

				

				if (v.surpresslightning) then

					render.SuppressEngineLighting(false)

				end

				

			elseif (v.type == "Sprite" and sprite) then

				

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

				render.SetMaterial(sprite)

				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

				

			elseif (v.type == "Quad" and v.draw_func) then

				

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

				ang:RotateAroundAxis(ang:Up(), v.angle.y)

				ang:RotateAroundAxis(ang:Right(), v.angle.p)

				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				

				cam.Start3D2D(drawpos, ang, v.size)

					v.draw_func( self )

				cam.End3D2D()



			end

			

		end

		

	end



	SWEP.wRenderOrder = nil

	function SWEP:DrawWorldModel()

		

		if (self.ShowWorldModel == nil or self.ShowWorldModel) then

			self:DrawModel()

		end

		

		if LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE and LocalPlayer():GetObserverTarget() == self.Owner then return end

		

		if (!self.WElements) then return end

		

		if (!self.wRenderOrder) then



			self.wRenderOrder = {}



			for k, v in pairs( self.WElements ) do

				if (v.type == "Model") then

					table.insert(self.wRenderOrder, 1, k)

				elseif (v.type == "Sprite" or v.type == "Quad") then

					table.insert(self.wRenderOrder, k)

				end

			end



		end

		

		if (IsValid(self.Owner)) then

			bone_ent = self.Owner

		else

			// when the weapon is dropped

			bone_ent = self

		end

		

		for k, name in pairs( self.wRenderOrder ) do

		

			local v = self.WElements[name]

			if (!v) then self.wRenderOrder = nil break end

			if (v.hide) then continue end

			

			local pos, ang

			

			if (v.bone) then

				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )

			else

				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )

			end

			

			if (!pos) then continue end

			

			local model = v.modelEnt

			local sprite = v.spriteMaterial

			

			if (v.type == "Model" and IsValid(model)) then



				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )

				ang:RotateAroundAxis(ang:Up(), v.angle.y)

				ang:RotateAroundAxis(ang:Right(), v.angle.p)

				ang:RotateAroundAxis(ang:Forward(), v.angle.r)



				model:SetAngles(ang)

				//model:SetModelScale(v.size)

				local matrix = Matrix()

				matrix:Scale(v.size)

				model:EnableMatrix( "RenderMultiply", matrix )

				

				if (v.material == "") then

					model:SetMaterial("")

				elseif (model:GetMaterial() != v.material) then

					model:SetMaterial( v.material )

				end

				

				if (v.skin and v.skin != model:GetSkin()) then

					model:SetSkin(v.skin)

				end

				

				if (v.bodygroup) then

					for k, v in pairs( v.bodygroup ) do

						if (model:GetBodygroup(k) != v) then

							model:SetBodygroup(k, v)

						end

					end

				end

				

				if (v.surpresslightning) then

					render.SuppressEngineLighting(true)

				end

				

				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)

				render.SetBlend(v.color.a/255)

				model:DrawModel()

				render.SetBlend(1)

				render.SetColorModulation(1, 1, 1)

				

				if (v.surpresslightning) then

					render.SuppressEngineLighting(false)

				end

				

			elseif (v.type == "Sprite" and sprite) then

				

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

				render.SetMaterial(sprite)

				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

				

			elseif (v.type == "Quad" and v.draw_func) then

				

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

				ang:RotateAroundAxis(ang:Up(), v.angle.y)

				ang:RotateAroundAxis(ang:Right(), v.angle.p)

				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				

				cam.Start3D2D(drawpos, ang, v.size)

					v.draw_func( self )

				cam.End3D2D()



			end

			

		end

		

	end



	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

		

		local bone, pos, ang

		if (tab.rel and tab.rel != "") then

			

			local v = basetab[tab.rel]

			

			if (!v) then return end

			

			// Technically, if there exists an element with the same name as a bone

			// you can get in an infinite loop. Let's just hope nobody's that stupid.

			pos, ang = self:GetBoneOrientation( basetab, v, ent )

			

			if (!pos) then return end

			

			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

			ang:RotateAroundAxis(ang:Up(), v.angle.y)

			ang:RotateAroundAxis(ang:Right(), v.angle.p)

			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				

		else

		

			bone = ent:LookupBone(bone_override or tab.bone)



			if (!bone) then return end

			

			pos, ang = Vector(0,0,0), Angle(0,0,0)

			local m = ent:GetBoneMatrix(bone)

			if (m) then

				pos, ang = m:GetTranslation(), m:GetAngles()

			end

			

			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 

				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then

				ang.r = -ang.r // Fixes mirrored models

			end

		

		end

		

		return pos, ang

	end



	function SWEP:CreateModels( tab )



		if (!tab) then return end



		// Create the clientside models here because Garry says we can't do it in the render hook

		for k, v in pairs( tab ) do

			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 

					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then

				

				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)

				if (IsValid(v.modelEnt)) then

					v.modelEnt:SetPos(self:GetPos())

					v.modelEnt:SetAngles(self:GetAngles())

					v.modelEnt:SetParent(self)

					v.modelEnt:SetNoDraw(true)

					v.createdModel = v.model

				else

					v.modelEnt = nil

				end

				

			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 

				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then

				

				local name = v.sprite.."-"

				local params = { ["$basetexture"] = v.sprite }

				// make sure we create a unique name based on the selected options

				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }

				for i, j in pairs( tocheck ) do

					if (v[j]) then

						params["$"..j] = 1

						name = name.."1"

					else

						name = name.."0"

					end

				end



				v.createdSprite = v.sprite

				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)

				

			end

		end

		

	end

	

	local allbones

	local hasGarryFixedBoneScalingYet = false



	function SWEP:UpdateBonePositions(vm)

		

		if self.ViewModelBoneMods then

			

			if (!vm:GetBoneCount()) then return end

			

			// !! WORKAROUND !! //

			// We need to check all model names :/

			local loopthrough = self.ViewModelBoneMods

			if (!hasGarryFixedBoneScalingYet) then

				allbones = {}

				for i=0, vm:GetBoneCount() do

					local bonename = vm:GetBoneName(i)

					if (self.ViewModelBoneMods[bonename]) then 

						allbones[bonename] = self.ViewModelBoneMods[bonename]

					else

						allbones[bonename] = { 

							scale = Vector(1,1,1),

							pos = Vector(0,0,0),

							angle = Angle(0,0,0)

						}

					end

				end

				

				loopthrough = allbones

			end

			// !! ----------- !! //

			

			for k, v in pairs( loopthrough ) do

				local bone = vm:LookupBone(k)

				if (!bone) then continue end

				

				// !! WORKAROUND !! //

				local s = Vector(v.scale.x,v.scale.y,v.scale.z)

				local p = Vector(v.pos.x,v.pos.y,v.pos.z)

				local ms = Vector(1,1,1)

				if (!hasGarryFixedBoneScalingYet) then

					local cur = vm:GetBoneParent(bone)

					while(cur >= 0) do

						local pscale = loopthrough[vm:GetBoneName(cur)].scale

						ms = ms * pscale

						cur = vm:GetBoneParent(cur)

					end

				end

				

				s = s * ms

				// !! ----------- !! //

				

				if vm:GetManipulateBoneScale(bone) != s then

					vm:ManipulateBoneScale( bone, s )

				end

				if vm:GetManipulateBoneAngles(bone) != v.angle then

					vm:ManipulateBoneAngles( bone, v.angle )

				end

				if vm:GetManipulateBonePosition(bone) != p then

					vm:ManipulateBonePosition( bone, p )

				end

			end

		else

			self:ResetBonePositions(vm)

		end

		   

	end

	 

	function SWEP:ResetBonePositions(vm)

		

		if (!vm:GetBoneCount()) then return end

		for i=0, vm:GetBoneCount() do

			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )

			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )

			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )

		end

		

	end



	/**************************

		Global utility code

	**************************/



	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).

	// Does not copy entities of course, only copies their reference.

	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop

	function table.FullCopy( tab )



		if (!tab) then return nil end

		

		local res = {}

		for k, v in pairs( tab ) do

			if (type(v) == "table") then

				res[k] = table.FullCopy(v) // recursion ho!

			elseif (type(v) == "Vector") then

				res[k] = Vector(v.x, v.y, v.z)

			elseif (type(v) == "Angle") then

				res[k] = Angle(v.p, v.y, v.r)

			else

				res[k] = v

			end

		end

		

		return res

		

	end

	

end

