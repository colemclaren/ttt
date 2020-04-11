
TALENT.ID = 19
TALENT.Name = "Assassin"
TALENT.NameColor = Color(50, 50, 255)
TALENT.Description = "Each kill has a %s_^ chance to dissolve the body of the person you killed"
TALENT.Tier = 2
TALENT.LevelRequired = {min = 15, max = 20}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 10, max = 25}

TALENT.Melee = false
TALENT.NotUnique = true


if (SERVER) then
	util.AddNetworkString("Ass_talent")
	function _ass_talent(vic,att)
		local dissolver = ents.Create("env_entity_dissolver")
		local uid = vic:UniqueID()
		timer.Simple(0.2,function()
			for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
				if (v.uqid and v.uqid == uid and IsValid(v)) then
					v.IsSafeToRemove = true
					if IsValid(vic) then
						vic:SetNW2Bool("body_found", false)
						net.Start("Ass_talent")
						net.WriteString(vic:Nick())
						net.Send(att)
					end

					v:SetName("diss_" .. v:EntIndex())
					dissolver:Spawn()
					dissolver:Activate()
					dissolver:SetKeyValue("dissolvetype", 1)
					dissolver:SetKeyValue("magnitude", 1)
					dissolver:SetPos(v:GetPos())
					dissolver:Fire("Dissolve", v:GetName(), 0)
					dissolver:Fire("Kill", "", 0.1)

					timer.Simple(0.1,function()
						dissolver:Remove()
					end)
				end
			end
		end)
	end
end

function TALENT:OnPlayerDeath(vic, inf, att, talent_mods)
    local chance = self.Modifications[1].min + ((self.Modifications[1].max - self.Modifications[1].min) * math.min(1, talent_mods[1]))
    if (chance > math.random() * 100) then
        _ass_talent(vic,att)
    end
end