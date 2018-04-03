SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "normal"
SWEP.PrintName = "Witch Doctor Reviver"
SWEP.Slot = 6
SWEP.Kind = WEAPON_EQUIP1
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "none"
SWEP.InLoadoutFor = { ROLE_WITCHDOCTOR }

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = false

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = false

SWEP.Radius = 100

function SWEP:DoTrace()
    local own = self:GetOwner()
    local tr = util.TraceLine {
        filter = { self, own },
        start = own:GetShootPos(),
        endpos = own:GetShootPos() + own:GetAimVector() * 100,
        mask = MASK_SHOT
    }
    return tr
end

function SWEP:GetTargets()
    local tr = self:DoTrace()
    local rags = {}
    for _, ent in pairs(ents.FindInSphere(tr.HitPos, self.Radius)) do
        if (ent:GetClass() == "prop_ragdoll" and CORPSE.GetFound(ent, false)) then
            local pl = CORPSE.GetPlayer(ent)
            if (IsValid(pl) and not pl:Alive()) then
                table.insert(rags, ent)
            end
        end
    end
    return rags
end

function SWEP:DrawHUD()
    local rags = self:GetTargets()
    for i = 1, #rags do
        rags[i] = CORPSE.GetPlayer(rags[i]):Nick()
    end
    local name = table.concat(rags, ", ")
    surface.SetFont "TargetID" -- better font pls
    local w = surface.GetTextSize "Target: "
    local w2, h = surface.GetTextSize(name)
    local tw = w + w2
    local centerx, centery = ScrW() / 2, ScrH() / 2 + 90
    draw.SimpleTextOutlined("Target: ", "TargetID", centerx - tw / 2, centery, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))
    draw.SimpleTextOutlined(name, "TargetID", centerx - tw / 2 + w, centery, Color(230, 90, 90), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))
end


function SWEP:PrimaryAttack()
    if (SERVER) then
        local targets = self:GetTargets()
        if (#targets >= 3) then
            local target = table.Random(targets)
            CORPSE.GetPlayer(target):SpawnForRound(true)
            for _, rag in pairs(targets) do
                rag:Remove()
            end
        end
    end
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:Deploy()
    if SERVER and IsValid(self.Owner) then
       self.Owner:DrawViewModel(false)
    end
    return true
 end