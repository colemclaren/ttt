--resource.AddWorkshop( "938750501" )

local pl = FindMetaTable("Player")

function pl:SelectHolster()
	for k, v in pairs(self:GetWeapons()) do
		if (v.Kind == WEAPON_UNARMED) then
			self:SelectWeapon(v:GetClass())

			break
		end
	end
end

if (not file.Exists("terrorcity.txt", "MOD")) then
hook.Add("TTTBeginRound","Role Save",function()
    timer.Simple(0.5,function()
        if MOAT_MINIGAME_OCCURING then return end
        for k,v in ipairs(player.GetAll()) do
            local role = cookie.GetString("rolesave" .. v:SteamID64(),"none")
            if role == "t" then v:SetRole(ROLE_TRAITOR) v:AddCredits(3) continue end
            if role == "d" then v:SetRole(ROLE_DETECTIVE) v:AddCredits(3) continue end

            if v:IsTraitor() then
                cookie.Set("rolesave" .. v:SteamID64(),"t")
            elseif v:IsDetective() then
                cookie.Set("rolesave" .. v:SteamID64(),"d")
            end
        
        end
    end)
end)

hook.Add("TTTEndRound","Role Save",function()
    for k,v in ipairs(player.GetAll()) do
        cookie.Delete("rolesave" .. v:SteamID64())
    end
end)

hook.Add("PlayerDisconnected","Role Save",function(ply)
    cookie.Delete("rolesave" .. ply:SteamID64())
end)
end
/*
util.AddNetworkString("TTT_Player_Equipment")

function GetDetectives()
   local trs = {}
   for k,v in ipairs(player.GetAll()) do
      if v:GetDetective() then table.insert(trs, v) end
   end

   return trs
end

hook.Add("TTTOrderedEquipment", "Equipment Bought", function(pl, equipment, is_item)
    if (pl:IsDetective()) then
        if (is_item) then
            local name = EquipmentItems[ROLE_DETECTIVE][equipment]
            if (not name) then return end 
            name = name.name
            if (not name) then return end


            net.Start("TTT_Player_Equipment")
            net.WriteString(pl:Nick())
            net.WriteBool(false)
            net.WriteString(name)
            net.WriteBool(true)
            net.Send(GetDetectives())
        else
            net.Start("TTT_Player_Equipment")
            net.WriteString(pl:Nick())
            net.WriteBool(true)
            net.WriteString(equipment)
            net.WriteBool(true)
            net.Send(GetDetectives())
        end
    elseif (pl:IsTraitor()) then
        if (is_item) then
            local name = EquipmentItems[ROLE_DETECTIVE][equipment]
            if (not name) then return end
            name = name.name
            if (not name) then return end


            net.Start("TTT_Player_Equipment")
            net.WriteString(pl:Nick())
            net.WriteBool(false)
            net.WriteString(name)
            net.WriteBool(false)
            net.Send(GetTraitors())
        else
            net.Start("TTT_Player_Equipment")
            net.WriteString(pl:Nick())
            net.WriteBool(true)
            net.WriteString(equipment)
            net.WriteBool(false)
            net.Send(GetTraitors())
        end
    end
end)
*/