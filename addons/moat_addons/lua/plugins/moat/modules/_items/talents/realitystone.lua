TALENT.ID = 101
TALENT.Name = "Reality Stone"
TALENT.NameColor = Color(255, 50, 50)
TALENT.Description = "You have a %s_^ chance to go transparent for %s seconds after killing someone with this weapon"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}
TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 20}
TALENT.Modifications[2] = {min = 5, max = 20}
TALENT.Melee = true
TALENT.NotUnique = false

function _reality_stone(sec,att)
    att:SetRenderMode(RENDERMODE_TRANSALPHA)
    att:SetColor(Color(255,255,255,50))
    att.RealityStone = CurTime() - 0.5
	D3A.Chat.SendToPlayer2(att, Color(0, 255, 0), "You are now transparent for ", Color(255, 0, 0), sec or "0", Color(0, 255, 0), " seconds!")
    timer.Simple(sec,function()
        if not IsValid(att) then return end
        if CurTime() - (att.RealityStone or 0) > sec then
            att:SetRenderMode(RENDERMODE_NORMAL)
            att:SetColor(Color(255,255,255,255))
            att:SendLua([[chat.AddText(Color(255,0,0),"You are no longer transparent!")]])
        end
    end)
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    if (GetRoundState() ~= ROUND_ACTIVE or MOAT_ACTIVE_BOSS or MOAT_MINIGAME_OCCURING) then return end

    local chanceNum = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1])
    local randomNum = math.random() * 100
    local applyMod = chanceNum > randomNum

    if (applyMod) then
        local sec = self.Modifications[2].min + ((self.Modifications[2].max - self.Modifications[2].min) * talent_mods[2])
        _reality_stone(sec,att)
    end
end