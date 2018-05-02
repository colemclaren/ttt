TALENT.ID = 100
TALENT.Name = "Space Stone"
TALENT.NameColor = Color(0, 50, 255)
TALENT.Description = "You have a %s_^ chance to have low gravity for %s seconds after killing someone with this weapon"
TALENT.Tier = 1
TALENT.LevelRequired = {min = 5, max = 10}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}
TALENT.Modifications[2] = {min = 5, max = 20}
TALENT.Melee = false
TALENT.NotUnique = true

function _space_stone(sec,att)
    att.SpaceStone = CurTime() - 0.5
    att:SetGravity(0.25)
    att:SendLua([[chat.AddText(Color(0,255,0),"You have gained low gravity for ",Color(255,0,0),"]] .. sec .. [[",Color(0,255,0)," seconds!")]])
    timer.Simple(sec,function()
        if not IsValid(att) then return end
        if CurTime() - (att.SpaceStone or 0) > sec then
            att:SetGravity(1)
            att:SendLua([[chat.AddText(Color(255,0,0),"You have lost your low gravity!")]])
        end
    end)
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS) then return end

    local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local randomNum = math.Rand(1, 100)
    local applyMod = chanceNum > randomNum

    if (applyMod) then
        local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
        _space_stone(sec,att)
        
    end
end