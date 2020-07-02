-- Variables that are used on both client and server
SWEP.Gun = ("ttt_m9k_harpoon") -- must be the name of your swep but NO CAPITALS!
SWEP.Category = "TTT M9K Specialties"
SWEP.Author = "edited for TTT by RustyPrime"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.MuzzleAttachment = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName = "Harpoon" -- Weapon name (Shown on HUD)
SWEP.Slot = 4 -- Slot in the weapon selection menu
SWEP.SlotPos = 1 -- Position in the slot
SWEP.DrawAmmo = false -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair = false -- set false if you want no crosshair
SWEP.Weight = 1 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType = "melee"
-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.FiresUnderwater = false
SWEP.ShowWorldModel = false

SWEP.EquipMenuData = {
    type = "Weapon",
    desc = "Throwable Harpoon."
}

SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = false
SWEP.AllowDrop = true
SWEP.IsSilent = true
SWEP.NoSights = false
SWEP.AutoSpawnable = false
SWEP.Primary.Sound = Sound("") -- Script that calls the primary fire sound
SWEP.Primary.RPM = 60 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize = 1 -- Size of a clip
SWEP.Primary.DefaultClip = 1 -- Bullets you start with
SWEP.Primary.KickUp = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo = "Harpoon"
SWEP.Icon = "vgui/ttt/tttharpoonicon.png"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug
SWEP.Primary.Round = "m9k_thrown_harpoon" --NAME OF ENTITY GOES HERE
SWEP.Secondary.IronFOV = 60 -- How much you 'zoom' in. Less is more!
SWEP.Primary.NumShots = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage = 0 -- Base damage per bullet
SWEP.Primary.Spread = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns

/*if file.Exists("models/weapons/v_knife_t.mdl", "GAME") then
    SWEP.ViewModel = "models/weapons/v_knife_t.mdl" -- Weapon view model

    SWEP.VElements = {
        ["harpoon"] = {
            type = "Model",
            model = "models/props_junk/harpoon002a.mdl",
            bone = "v_weapon.Right_Pinky01",
            rel = "",
            pos = Vector(0.518, 0.518, 10.909),
            angle = Angle(90, -12.858, -5.844),
            size = Vector(0.56, 0.56, 0.56),
            color = Color(255, 255, 255, 255),
            surpresslightning = false,
            material = "",
            skin = 0,
            bodygroup = {}
        }
    }

    SWEP.ViewModelBoneMods = {
        ["v_weapon.Right_Hand"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(0, 0.925, 0),
            angle = Angle(-1.111, 14.444, -14.445)
        },
        ["v_weapon.Left_Arm"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(-2.779, -2.408, -3.889),
            angle = Angle(0, 0, 0)
        },
        ["v_weapon.Right_Arm"] = {
            scale = Vector(0.794, 0.794, 0.794),
            pos = Vector(-2.037, -3.52, -3.52),
            angle = Angle(72.222, 32.222, -1.111)
        },
        ["v_weapon.knife_Parent"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(-30, -30, -30),
            angle = Angle(0, 0, 0)
        }
    }
else*/
    SWEP.ViewModel = "models/weapons/v_invisib.mdl" -- Weapon view model

    SWEP.VElements = {
        ["harpoon"] = {
            type = "Model",
            model = "models/props_junk/harpoon002a.mdl",
            bone = "Da Machete",
            rel = "",
            pos = Vector(-9.362, 2.611, 12.76),
            angle = Angle(60.882, 128.927, 105.971),
            size = Vector(0.5, 0.5, 0.5),
            color = Color(255, 255, 255, 255),
            surpresslightning = false,
            material = "",
            skin = 0,
            bodygroup = {}
        }
    }

    --["harpoon"] = { type = "Model", model = "models/weapons/w_harpooner.mdl", bone = "Da Machete", rel = "", pos = Vector(-9.362, 2.611, 12.76), angle = Angle(60.882, 128.927, 105.971), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    SWEP.ViewModelBoneMods = {
        ["l-upperarm"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(-7.286, 1.628, 7.461),
            angle = Angle(7.182, 0, 0)
        },
        ["r-upperarm-movement"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(-30, -30, -30),
            angle = Angle(0, 0, 0)
        },
        ["l-upperarm-movement"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(3.615, 0.547, 4.635),
            angle = Angle(-45.929, -39.949, -76.849)
        },
        ["l-forearm"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(0, 0, 0),
            angle = Angle(-3.932, -42.389, 171.466)
        },
        ["r-upperarm"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(0, 0, 0),
            angle = Angle(7.336, 0, 0)
        },
        ["lwrist"] = {
            scale = Vector(1, 1, 1),
            pos = Vector(0, 0, 0),
            angle = Angle(-47.502, -5.645, 0.551)
        },
		["Da Machete"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)}
    }
--end

SWEP.ViewModelFOV = 70.733668341709
SWEP.WorldModel = "models/props_junk/harpoon002a.mdl"

SWEP.WElements = {
    ["WHarpoon"] = {
        type = "Model",
        model = "models/props_junk/harpoon002a.mdl",
        bone = "ValveBiped.Bip01_R_Hand",
        rel = "",
        pos = Vector(1.248, -0.759, -4.676),
        angle = Angle(50.259, -52.598, -85.325),
        size = Vector(0.5, 0.5, 0.5),
        color = Color(255, 255, 255, 255),
        surpresslightning = false,
        material = "",
        skin = 0,
        bodygroup = {}
    }
}

SWEP.ShowViewModel = false

function SWEP:Initialize()
    -- other initialize code goes here
    if CLIENT then
        -- Create a new table for every weapon instance
        self.VElements = table.FullCopy(self.VElements)
        self.WElements = table.FullCopy(self.WElements)
        self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
        self:CreateModels(self.VElements) -- create viewmodels
        self:CreateModels(self.WElements) -- create worldmodels

        -- init view model bone build function
        if IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()

            if IsValid(vm) then
                self:ResetBonePositions(vm)
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
        if not IsValid(vm) then return end
        if (not self.VElements) then return end
        self:UpdateBonePositions(vm)

        if (not self.vRenderOrder) then
            -- we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}

            for k, v in pairs(self.VElements) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
        end

        for k, name in ipairs(self.vRenderOrder) do
            local v = self.VElements[name]

            if (not v) then
                self.vRenderOrder = nil
                break
            end

            if (v.hide) then continue end
            local model = v.modelEnt
            local sprite = v.spriteMaterial
            if (not v.bone) then continue end
            local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
            if (not pos) then continue end

            if (v.type == "Model" and IsValid(model)) then
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                model:SetAngles(ang)
                --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix("RenderMultiply", matrix)

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial(v.material)
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs(v.bodygroup) do
                        if (model:GetBodygroup(k) ~= v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
                render.SetBlend(v.color.a / 255)
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
                v.draw_func(self)
                cam.End3D2D()
            end
        end
    end

    SWEP.wRenderOrder = nil

    function SWEP:DrawWorldModel()
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end

        if (not self.WElements) then return end

        if (not self.wRenderOrder) then
            self.wRenderOrder = {}

            for k, v in pairs(self.WElements) do
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
            -- when the weapon is dropped
            bone_ent = self
        end

        for k, name in pairs(self.wRenderOrder) do
            local v = self.WElements[name]

            if (not v) then
                self.wRenderOrder = nil
                break
            end

            if (v.hide) then continue end
            local pos, ang

            if (v.bone) then
                pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
            else
                pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
            end

            if (not pos) then continue end
            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (v.type == "Model" and IsValid(model)) then
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                model:SetAngles(ang)
                --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix("RenderMultiply", matrix)

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial(v.material)
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs(v.bodygroup) do
                        if (model:GetBodygroup(k) ~= v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
                render.SetBlend(v.color.a / 255)
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
                v.draw_func(self)
                cam.End3D2D()
            end
        end
    end

    function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
        local bone, pos, ang

        if (tab.rel and tab.rel ~= "") then
            local v = basetab[tab.rel]
            if (not v) then return end
            -- Technically, if there exists an element with the same name as a bone
            -- you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation(basetab, v, ent)
            if (not pos) then return end
            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
        else
            bone = ent:LookupBone(bone_override or tab.bone)
            if (not bone) then return end
            pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
            local m = ent:GetBoneMatrix(bone)

            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end

            if (IsValid(self.Owner) and self.Owner:IsPlayer() and ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r -- Fixes mirrored models
            end
        end

        return pos, ang
    end

    function SWEP:CreateModels(tab)
        if (not tab) then return end

        -- Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs(tab) do
            if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME")) then
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
            elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME")) then
                local name = v.sprite .. "-"

                local params = {
                    ["$basetexture"] = v.sprite
                }

                -- make sure we create a unique name based on the selected options
                local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

                for i, j in pairs(tocheck) do
                    if (v[j]) then
                        params["$" .. j] = 1
                        name = name .. "1"
                    else
                        name = name .. "0"
                    end
                end

                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
            end
        end
    end

    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions(vm)
        if self.ViewModelBoneMods then
            if (not vm:GetBoneCount()) then return end
            -- !! WORKAROUND !! //
            -- We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods

            if (not hasGarryFixedBoneScalingYet) then
                allbones = {}

                for i = 0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName(i)

                    if (self.ViewModelBoneMods[bonename]) then
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = {
                            scale = Vector(1, 1, 1),
                            pos = Vector(0, 0, 0),
                            angle = Angle(0, 0, 0)
                        }
                    end
                end

                loopthrough = allbones
            end

            -- !! ----------- !! //
            for k, v in pairs(loopthrough) do
                local bone = vm:LookupBone(k)
                if (not bone) then continue end
                -- !! WORKAROUND !! //
                local s = Vector(v.scale.x, v.scale.y, v.scale.z)
                local p = Vector(v.pos.x, v.pos.y, v.pos.z)
                local ms = Vector(1, 1, 1)

                if (not hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent(bone)

                    while (cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName(cur)].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent(cur)
                    end
                end

                s = s * ms

                -- !! ----------- !! //
                if vm:GetManipulateBoneScale(bone) ~= s then
                    vm:ManipulateBoneScale(bone, s)
                end

                if vm:GetManipulateBoneAngles(bone) ~= v.angle then
                    vm:ManipulateBoneAngles(bone, v.angle)
                end

                if vm:GetManipulateBonePosition(bone) ~= p then
                    vm:ManipulateBonePosition(bone, p)
                end
            end
        else
            self:ResetBonePositions(vm)
        end
    end

    function SWEP:ResetBonePositions(vm)
        if (not vm:GetBoneCount()) then return end

        for i = 0, vm:GetBoneCount() do
            vm:ManipulateBoneScale(i, Vector(1, 1, 1))
            vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
            vm:ManipulateBonePosition(i, Vector(0, 0, 0))
        end
    end

    function table.FullCopy(tab)
        if (not tab) then return nil end
        local res = {}

        for k, v in pairs(tab) do
            if (type(v) == "table") then
                res[k] = table.FullCopy(v) -- recursion ho!
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

function SWEP:PrimaryAttack()
    self:FireRocket()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Weapon:SetNextPrimaryFire(CurTime() + 1 / (self.Primary.RPM / 60))
    self.Weapon:EmitSound(Sound("Weapon_Knife.Slash"))
    self.Weapon:TakePrimaryAmmo(1)
    self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    pos = self.Owner:GetShootPos()

    if SERVER then
        local rocket = ents.Create(self.Primary.Round)
        if not rocket:IsValid() then return false end
        rocket:SetAngles(self.Owner:GetAimVector():Angle())
        print"a"
        rocket:SetPos(pos - self.Owner:GetAimVector() * 50)
        rocket:SetOwner(self.Owner)
        rocket:Spawn()
        rocket.Owner = self.Owner
        rocket:Activate()
        eyes = self.Owner:EyeAngles()
        local phys = rocket:GetPhysicsObject()
        phys:SetVelocity(self.Owner:GetAimVector() * 2000)
    end

    if SERVER and not self.Owner:IsNPC() then
        local anglo = Angle(-10, -5, 0)
        self.Owner:ViewPunch(anglo)
    end
end

function SWEP:CheckWeaponsAndAmmo()
    if SERVER and self.Weapon ~= nil then
        if self.Weapon:Clip1() == 0 and self.Owner:GetAmmoCount(self.Weapon:GetPrimaryAmmoType()) == 0 then
            timer.Simple(.1, function()
                if SERVER then
                    if not IsValid(self) then return end
                    if self.Owner == nil then return end
                    self.Owner:StripWeapon(self.Gun)
                end
            end)
        else
            self:Reload()
        end
    end
end

function SWEP:Reload()
    if not IsValid(self) then return end
    if not IsValid(self.Owner) then return end

    if self.Owner:IsNPC() then
        self.Weapon:DefaultReload(ACT_VM_RELOAD)

        return
    end

    if self.Owner:KeyDown(IN_USE) then return end
    self.Weapon:DefaultReload(ACT_VM_DRAW)

    if not self.Owner:IsNPC() then
        if self.Owner:GetViewModel() == nil then
            self.ResetSights = CurTime() + 3
        else
            self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration()
        end
    end
end

function SWEP:SecondaryAttack()
    return false
end

function SWEP:Think()
end
