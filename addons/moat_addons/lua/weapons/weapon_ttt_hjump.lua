AddCSLuaFile()
SWEP.HoldType = "unarmed"
SWEP.PrintName = "High Jump"
if CLIENT then
    SWEP.Slot = 7
    SWEP.ViewModelFOV = 0

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = [[Failing to jump to that roof? 

Just equip me and we can do anything!



Can only be used on hand.



This also purges fall damage.]]
    }

    SWEP.Icon = "vgui/ttt/icon_cust_jumper.png"
    SWEP.IconLetter = "j"
end

SWEP.Base = "weapon_tttbase"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_defuser.mdl"
SWEP.DrawCrosshair = false
SWEP.Primary.Damage = 50
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 1.1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.4
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_DETECTIVE, ROLE_TRAITOR}
SWEP.LimitedStock = false -- only buyable once
SWEP.WeaponID = AMMO_FALL
SWEP.IsSilent = true
-- Pull out faster than standard guns
SWEP.DeploySpeed = 2
SWEP.Done = false

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
    if (IsValid(self.Owner)) then
		self.Owner.HighJump = self.Owner:GetJumpPower() or 160
        self.Owner:SetJumpPower(600)
    end

    return true
end

SWEP.OnRemove = SWEP.Deploy

function SWEP:Holster()
    if (IsValid(self.Owner)) then
        self.Owner:SetJumpPower(self.Owner.HighJump or 160)
		self.Owner.HighJump = nil
    end

    return true
end

function SWEP:PreDrop()
    if (IsValid(self.Owner)) then
        self.Owner:SetJumpPower(self.Owner.HighJump or 160)
		self.Owner.HighJump = nil
    end
end

function SWEP:OnRemove()
    if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
        RunConsoleCommand("lastinv")
    end
end

hook.Add("KeyPress", "Jump", function(ply, key)
    if not IsValid(ply) then return end
    if key ~= IN_JUMP then return end
    if not ply:Alive() then return end
    if not IsValid(ply:GetActiveWeapon()) then return end
    if not ply:OnGround() then return end
    if ply:GetActiveWeapon():GetClass() ~= "weapon_ttt_hjump" then return end
    ply:EmitSound(Sound("ambient/machines/catapult_throw.wav"))
    local pos = ply:GetPos()
    local effect = EffectData()
    effect:SetOrigin(pos)
    effect:SetStart(pos)
    effect:SetScale(600)
    effect:SetMagnitude(600)
    util.Effect("ThumperDust", effect)
end)

if SERVER then
    function GAMEMODE:OnPlayerHitGround(ply, in_water, on_floater, speed)
        if (in_water or speed < 450 or not IsValid(ply)) then return end
        -- Everything over a threshold hurts you, rising exponentially with speed
        local damage = math.pow(0.05 * (speed - 420), 1.75)
		local wep = ply:GetActiveWeapon()
		if (not IsValid(wep)) then return end
		local holding_hjump = wep:GetClass() == "weapon_ttt_hjump"

        if holding_hjump then
            damage = damage / 70
        end

        if damage < 1 then return end

        -- I don't know exactly when on_floater is true, but it's probably when
        -- landing on something that is in water.
        if on_floater then
            damage = damage / 2
        end

        -- if we fell on a dude, that hurts (him)
        local ground = ply:GetGroundEntity()

        if IsValid(ground) and ground:IsPlayer() then
            if math.floor(damage) > 0 then
                local att = ply
                -- if the faller was pushed, that person should get attrib
                local push = ply.was_pushed

                if push then
                    -- TODO: move push time checking stuff into fn?
                    if math.max(push.t or 0, push.hurt or 0) > CurTime() - 4 then
                        att = push.att
                    end
                end

                local dmg = DamageInfo()

                if att == ply then
                    -- hijack physgun damage as a marker of this type of kill
                    dmg:SetDamageType(DMG_CRUSH + DMG_PHYSGUN)
                else
                    -- if attributing to pusher, show more generic crush msg for now
                    dmg:SetDamageType(DMG_CRUSH)
                end

                dmg:SetAttacker(att)
                dmg:SetInflictor(att)
                dmg:SetDamageForce(Vector(0, 0, -1))
                dmg:SetDamage(damage)
                ground:TakeDamageInfo(dmg)
            end

            -- our own falling damage is cushioned
            damage = damage / 3
        end

        if math.floor(damage) > 0 then
            local dmg = DamageInfo()
            dmg:SetDamageType(DMG_FALL)
            dmg:SetAttacker(game.GetWorld())
            dmg:SetInflictor(game.GetWorld())
            dmg:SetDamageForce(Vector(0, 0, 1))
            dmg:SetDamage(damage)
            ply:TakeDamageInfo(dmg)
            local fallsounds = {Sound("player/damage1.wav"), Sound("player/damage2.wav"), Sound("player/damage3.wav")}

            if holding_hjump then
                local pos = ply:GetPos()
                local effect = EffectData()
                effect:SetOrigin(pos)
                effect:SetStart(pos)
                effect:SetScale(800)
                effect:SetMagnitude(800)
                util.Effect("ThumperDust", effect)
                sound.Play(Sound("doors/heavy_metal_stop1.wav"), ply:GetShootPos(), 100 - (damage * 3), 200)

                timer.Simple(0.3, function()
                    sound.Play(Sound("hl1/ambience/steamburst1.wav"), ply:GetShootPos(), 100 - (damage * 3), 200)
                end)
            end

            -- play CS:S fall sound if we got somewhat significant damage
            if damage > 5 and not holding_hjump then
                sound.Play(table.Random(fallsounds), ply:GetShootPos(), 55 + math.Clamp(damage, 0, 50), 100)
            end
        end
    end
end

local function ResetJumpDeath(ply)
    if (IsValid(ply) and ply.HighJump) then
		ply:SetJumpPower(ply.HighJump)
		ply.HighJump = nil
	end
end

hook.Add("DoPlayerDeath", "ResetDeathJumpPower", ResetJumpDeath)

local function ResetJumpEnd()
    for k, ply in ipairs(player.GetAll()) do
		if (IsValid(ply) and ply.HighJump) then
			ply:SetJumpPower(ply.HighJump)
			ply.HighJump = nil
		end
    end
end

hook.Add("TTTEndRound", "ResetEndJumpPower", ResetJumpEnd)