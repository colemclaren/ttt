ITEM.Name = "Tesla Effect"
ITEM.CustomEffect = true
ITEM.ID = 920
ITEM.Description = "A special effect given to the very dedicated Moat-Gaming players that reach level 100"
ITEM.Rarity = 8
ITEM.NameColor = Color(0, 191, 255)
ITEM.Collection = "Veteran Collection"
--Hack
ITEM.Model = "models/weapons/w_missile_closed.mdl"
ITEM.Bone = "ValveBiped.Bip01_Spine4"

ITEM.NameEffect = "electric"

ITEM.Image = "https://i.moat.gg/18-04-17-S56.png"
local particle = "TeslaHitBoxes"
if CLIENT then
    net.Receive("TeslaEffect",function()
        net.ReadEntity().Tesla = true
    end)

    hook.Add("TTTEndRound","ClearTesla",function()
        for k,v in ipairs(player.GetAll()) do
            v.Tesla = false
        end
    end)
    
    timer.Create("Tesla Effect",10,0,function()
        if MOAT_PH then return end
        for _,ply in ipairs(player.GetAll()) do
            if ply.Tesla and ply:Alive() and (not ply:IsSpec()) then
                local pos = ply:EyePos()
                local effect = EffectData()
                effect:SetOrigin(pos)
                effect:SetStart(pos)
                effect:SetMagnitude(5)
                effect:SetScale(2)
                effect:SetEntity(ply)
                for i =1,15 do
                    timer.Simple(0.09 * i,function()
                        if not IsValid(ply) then return end
                        if not ply:Alive() then return end
                        if ply:IsSpec() then return end
                        effect:SetOrigin(pos - Vector((i) * math.random(-1,1),i * math.random(-1,1),i))
                        util.Effect("TeslaHitBoxes",effect)
                    end)
                end
            end
        end
    end)
else
    util.AddNetworkString("TeslaEffect")
    function mg_tesla(ply)
        net.Start("TeslaEffect")
        net.WriteEntity(ply)
        net.Broadcast()
    end
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	local Size = Vector(0,0,0)
	local mat = Matrix()
	mat:Scale(Size)
    model:EnableMatrix("RenderMultiply", mat)

	return model, pos, ang
end


/*
function ITEM:OnPlayerSpawn(ply)
    if CLIENT then
        local tid = "EffectTimer" .. ply:UniqueID()
        if ply == LocalPlayer() then return end
        timer.Create(tid,5,0,function()
            if not IsValid(ply) then timer.Remove(tid) return end
            if not ply:Alive() then timer.Remove(tid) return end
            local pos = ply:EyePos()
            local effect = EffectData()
            effect:SetOrigin(pos)
            effect:SetStart(pos)
            effect:SetMagnitude(2)
            effect:SetScale(1)
            effect:SetEntity(ply)
            for i =1,15 do
                timer.Simple(0.05 * i,function()
                    if not IsValid(ply) then return end
                    if not ply:Alive() then return end
                    effect:SetOrigin(pos + Vector(i,i,i))
                    util.Effect("TeslaHitBoxes",effect)
                end)
            end
        end)
    end
end

function ITEM:PlayerDeath(ply)
end
*/