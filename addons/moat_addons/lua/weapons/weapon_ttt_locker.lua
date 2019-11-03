if SERVER then

    AddCSLuaFile() 

end

 

if CLIENT then

    SWEP.Slot = 7

    SWEP.DrawAmmo = true

    SWEP.DrawCrosshair = true

       

    SWEP.Icon = "vgui/ttt/locker2.png"

 

   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = [[Allows you to lock a door for a short period of time! People can also shoot your doors down!!]]

   };

end

SWEP.PrintName = "Door Locker"

SWEP.Author                              = "Exho"

SWEP.HoldType                    = "normal"

SWEP.Base                                = "weapon_tttbase"

SWEP.Kind                                = WEAPON_EQUIP

SWEP.CanBuy                      = { ROLE_TRAITOR }

SWEP.Spawnable                   = true

SWEP.AdminSpawnable              = true

SWEP.AutoSpawnable               = false

 

SWEP.ViewModel           = "models/weapons/v_pistol.mdl"

SWEP.WorldModel          = "models/weapons/w_pistol.mdl"

SWEP.ViewModelFlip               = false

 

SWEP.Primary.Ammo        = "none"

SWEP.Primary.Delay       = 2

SWEP.Secondary.Delay     = 2

SWEP.Primary.ClipSize    = 5

SWEP.Primary.ClipMax     = 5

SWEP.Primary.DefaultClip = 5

SWEP.Primary.Automatic   = false

 

SWEP.DoorHealth			= 300 -- How much health the doors have

SWEP.LockRange			= 80 -- How close you have to be to the door to lock it 

SWEP.LockTime 			= 30 -- How long it stays locked

SWEP.CooldownTime 		= 10 -- How long the door has to cool down before being locked again

SWEP.DoorLock 			= true -- Do the doors automatically unlock?

SWEP.DoorBreak 			= true -- Do the doors break?

 

function SWEP:PrimaryAttack()

        if not self:CanPrimaryAttack() then return end

        self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)

        self:SetNextSecondaryFire(CurTime()+self.Secondary.Delay)

       

        local pos = self.Owner:GetShootPos()

        local ang = self.Owner:GetAimVector()

        local tracedata = {}

        tracedata.start = pos

        tracedata.endpos = pos+(ang*self.LockRange)

        tracedata.filter = self.Owner

        local trace = util.TraceLine(tracedata)

       

        local door = trace.Entity

        if DCheck( true, door, self.Owner ) then

               

                if SERVER then -- I decided to do this instead of using SWEP delays.

                        if door:GetNW2Bool("DoorCooldown") then

                                local timel = timer.TimeLeft(door:EntIndex() .. "_CoolDown")

                                local timel = math.Round( math.Clamp(timel, 0, self.CooldownTime))

                                CustomMsg(self.Owner, "This door is cooling down for " .. timel .. " more seconds!", Color(200,0,0))

                                return false

                        end

                end

               

                if not door:GetNW2Bool("TTTLocked") then

                        self:TakePrimaryAmmo(1)

                       

                        if SERVER then

                                door:SetNW2Entity("DoorOwner", self.Owner) -- Sets the locker of that specific door

                                door:EmitSound( "doors/door_metal_medium_close1.wav" )

                                door:Fire("lock", "", 0)

                                door:SetNW2Bool("TTTLocked", true)

                               

                                local prehealth = self.DoorHealth -- Why not use health? Cause it breaks a lot...

                                door:SetNW2Int(door:EntIndex() .. "_health", prehealth)

                               

                                DamageLog(self.Owner:Nick() .. " locked a door")

                                CustomMsg(self.Owner, "Door locked!", Color(0,255,0))

                               

                                if self.DoorLock then

                                        timer.Create(door:EntIndex() .. "DoorLockedTime", self.LockTime, 1, function()

                                                door:Fire( "unlock", "", 0 )

                                                door:EmitSound( "doors/door1_move.wav" )

                                                door:SetNW2Bool("TTTLocked", false)

                                                door:SetNW2Entity("DoorOwner", nil)

                                                CustomMsg(door:GetNW2Entity("DoorOwner"), "One of your doors has unlocked due to time!", Color(255,255,0))

                                                timer.Destroy(door:EntIndex() .. "DoorLockedTime")

                                        end)

                                end

                                door:SetNW2Float("LockedUntil", CurTime() + self.LockTime) -- Used for the DrawHUD timer

                        end

                elseif door:GetNW2Bool("TTTLocked") then

                        if SERVER then

                                CustomMsg(self.Owner, "This door is already locked!", Color(255,255,0))

                        end

                end

        end

end

 

function SWEP:SecondaryAttack()

        -- Allows the player to unlock their door

        if not self:CanSecondaryAttack() then return end

        self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)

       

        local pos = self.Owner:GetShootPos()

        local ang = self.Owner:GetAimVector()

        local tracedata = {}

        tracedata.start = pos

        tracedata.endpos = pos+(ang* (self.LockRange * 1.5))

        tracedata.filter = self.Owner

        local trace = util.TraceLine(tracedata)

       

        local door = trace.Entity

       

        if (door:GetNW2Bool("TTTLocked") == true and DCheck( true, door, self.Owner ) ) then

                local locker = door:GetNW2Entity("DoorOwner")

                local wannabe = self.Owner

               

                if SERVER then

                        if ( locker == wannabe and IsValid(locker) ) then

                                CustomMsg(locker, "Door Unlocked!", Color(0,255,0))

                                door:SetNW2Bool("TTTLocked", false)

                                door:EmitSound( "buttons/latchunlocked2.wav" )

                                door:Fire( "unlock", "", 0 )

                                timer.Destroy(door:EntIndex() .. "DoorLockedTime")

                                DamageLog(locker:Nick() .. " unlocked their door")

                               

                                door:SetNW2Bool("DoorCooldown", true)

                                timer.Create(door:EntIndex() .. "_CoolDown", self.CooldownTime, 1, function()

                                        door:SetNW2Bool("DoorCooldown", false)

                                        -- You lock then unlock a door and it will have to cool down for a short time before being used again.

                                        -- This is to prevent exploting of health with it

                                end)

                        elseif (locker ~= wannabe and IsValid(locker) ) then

                                CustomMsg(wannabe, "This is not your door to unlock!", Color(200,0,0))

                                CustomMsg(locker, Format("%s has tried to unlock your door!", wannabe:Nick() ), Color(200,0,0))

                        end

                end

        end

end

 

function SWEP:DrawHUD()

        local tr = self.Owner:GetEyeTrace() -- Simplified trace because I dont care about distance

        local door = tr.Entity

        if door:GetNW2Bool("TTTLocked") then

                        local timeleft = math.Clamp(  door:GetNW2Float("LockedUntil", 0)-CurTime(), 0, self.LockTime  )

                        local timeleft = math.Round(timeleft,1)

                        local owner = door:GetNW2Entity("DoorOwner")

                        local dhealth = door:GetNW2Int(door:EntIndex() .. "_health")

                        local dhealth = math.Clamp(dhealth, 0, self.DoorHealth)

                        self.DrawCrosshair = false -- Hides the crosshair to make things look neater

               

                        local w = ScrW()

                        local h = ScrH()

                        local x_axis, y_axis, width, height = w/2-w/14, h/2.8, w/7, h/20

                        draw.RoundedBox(2, x_axis, y_axis, width , height, Color(10,10,10,200)) -- Onscreen stuff

                        draw.SimpleText("Door locked by " ..owner:Nick(), "Trebuchet24", w/2, h/2.8 + height/2, Color(255, 40, 40,255), 1, 1)

                        draw.RoundedBox(2, x_axis, y_axis * 1.3, width, height * 2, Color(10,10,10,200))

                        draw.SimpleText("Health: "..dhealth, "Trebuchet24", w/2, h/2.8 + height*2.6, Color(255, 255, 255), 1, 1)

                        if self.DoorLock then

                                draw.SimpleText("Unlocks in: "..timeleft, "Trebuchet24", w/2, h/2.8 + height*3.5, Color(255, 255, 255), 1, 1)

                        end

        else

                self.DrawCrosshair = true -- Shows the crosshair again

        end

end

 

-- Runs the entity through a series of checks to make sure its the right type of door

function DCheck( da_msg, prop, ply )

        if not IsValid( prop ) then print("[Debug]: " .. tostring(prop) .. " is not valid" ) return false end

        -- Do NOT check if the player is valid, it causes issues with the Entity Damage function

       

         -- These types will not work because they cannot recieve a health value no matter what I try

        local b_list = { "func_door", "func_door_rotating" }

        local object = prop:GetClass()

       

        for h, i in pairs(b_list) do

                if (object == "prop_door_rotating" and IsValid(prop) and object ~= i) then

                        return true

                elseif object == i then

                        if SERVER and da_msg then

                                CustomMsg(ply, "Incompatible door!", Color(200,0,0))

                                ply:ChatPrint("This door is incompatible with the Locker!")

                                print("[Debug]: Player tried to use blacklisted door " .. tostring(i) )

                                print("[Debug]: Send these to Exho if you have questions")

                        end

                        return false

                end

        end

end

 

if SERVER then

        local function Sparkify( ent )

                -- Who doesnt like a little pyrotechnics eh?

                ent:EmitSound( "physics/wood/wood_crate_break3.wav" )

                local effectdata = EffectData()

                effectdata:SetOrigin( ent:GetPos() + ent:OBBCenter() )

                effectdata:SetMagnitude( 5 )

                effectdata:SetScale( 2 )

                effectdata:SetRadius( 5 )

                util.Effect( "Sparks", effectdata )

        end

        -- This could probably go in autorun too; it checks if the door needs to be destroyed.

        function DoorTakeDamage( prop, dmginfo )

                if ( DCheck( false, prop ) and prop:GetNW2Bool("TTTLocked") ) then

                        local dmgtaken = dmginfo:GetDamage()

                        local doorhealth = prop:GetNW2Int(prop:EntIndex() .. "_health")

                       

                        if IsPlayer(dmginfo:GetAttacker()) then

                                DamageLog(dmginfo:GetAttacker():Nick() .. " damaged a locked door for " .. dmgtaken .. "dmg")

                        else return end

                       

                        prop:SetNW2Int(prop:EntIndex() .. "_health", doorhealth - dmgtaken)

                       

                        if prop:GetNW2Int(prop:EntIndex() .. "_health") <= 1 then

                                local d_own = prop:GetNW2Entity("DoorOwner")

                                if not IsPlayer(dmginfo:GetAttacker()) then -- Damage log stuff

                                        CustomMsg(d_own, "One of your doors has been destroyed!", Color(255,0,0))

                                        DamageLog(d_own:Nick() .. "'s door has been destroyed")

                                else

                                        DamageLog(dmginfo:GetAttacker():Nick() .. " destroyed the locked door of " .. d_own:Nick()) -- Use format

                                        CustomMsg(d_own, "One of your doors has been destroyed!", Color(255,0,0))

                                end

                               

                                prop:Fire( "unlock", "", 0 )

                                timer.Destroy(prop:EntIndex() .. "DoorLockedTime")

                                timer.Destroy(prop:EntIndex() .. "ClientLockTime")

                                prop:SetNW2Bool("TTTLocked", false)

                               

                                if self.DoorBreak == false then

                                        prop:Fire( "unlock", "", 0 )

                                        prop:Fire( "open", "", 0 )

                                        Sparkify(prop)

                                else

                                        -- Now we create a prop version of the door to be knocked down for looks

                                        local dprop = ents.Create( "prop_physics" )

                                        dprop:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- This

                                        dprop:SetMoveType(MOVETYPE_VPHYSICS) -- This

                                        dprop:SetSolid(SOLID_BBOX) -- And this, prevent against the prop from clipping horribly into the wall

                                        dprop:SetPos( prop:GetPos() + Vector(0, 0, 2))

                                        dprop:SetAngles( prop:GetAngles() )

                                        dprop:SetModel( prop:GetModel() )

                                        dprop:SetSkin( prop:GetSkin() ) -- This makes sure the doors are identical

                                        -- Removes the actual door and spawns the prop, might have to switch them around

                                        prop:Remove()

                                        dprop:Spawn()

                                       

                                        Sparkify(dprop)

                                end

                        end

                end

        end

        hook.Add("EntityTakeDamage","BreachAndClear",DoorTakeDamage)

end

 
/*
hook.Add("TTTPrepareRound", "FixAllYallDoors",function()

        for e,f in pairs( ents.GetAll() ) do

                if f == "prop_door_rotating" then

                        print("[Debug]: All doors reset" )

                        f:SetNW2Bool("TTTLocked", false)

                        f:SetNW2Entity("DoorOwner", nil)

                        f:SetNW2Float("LockedUntil", nil)

                        timer.Destroy(f:EntIndex() .. "DoorLockedTime")

                end

        end

end)
*/