function Prometheus.Weapons.Add(Ply, NewWepString)
	local WepString = Ply:GetPData("PrometheusWeapons", "")

	if WepString == "" then
		WepString = NewWepString
	else
		WepString = WepString .. "," .. NewWepString
	end

	local Failed = Ply:SetPData("PrometheusWeapons", WepString)
	if Failed then Prometheus.Error("Failed to add weapons (" .. NewWepString .. ") for player: " .. Ply:Nick() ) end
end


function Prometheus.Weapons.Remove(Ply, RemWepString)
	local WepString = Ply:GetPData("PrometheusWeapons", "")

	local WepTable = string.Split(WepString, ",")
	local RemWepTable = string.Split(RemWepString, ",")

	for n, j in pairs(RemWepTable) do
		for a, b in pairs(WepTable) do
			if j == b then
				table.remove(WepTable, a)
				break
			end
		end
	end

	local NewWepString = table.concat(WepTable, ",")

	local Failed = Ply:SetPData("PrometheusWeapons", NewWepString)
	if Failed then Prometheus.Error("Failed to remove weapons (" .. RemWepString .. ") for player: " .. Ply:Nick() ) end
end


function Prometheus.Weapons.Spawn(Ply)
	local WepString = Ply:GetPData("PrometheusWeapons", "")
	if WepString == "" then return end
	local WepTable = string.Split(WepString, ",")
	if table.Count(WepTable) > 0 then
		for n, j in pairs(WepTable) do
			Ply:Give(j)
		end
	end
end

hook.Add("PlayerLoadout", "PrometheusWeaponsPlayerLoadout", Prometheus.Weapons.Spawn)

function Prometheus.OnWeaponDrop(Ply, Wep)
	if Prometheus.CanDropPermaWeapon != nil && !Prometheus.CanDropPermaWeapon && Wep.PrometheusGiven then
		return false
	end
end

hook.Add("canDropWeapon", "PrometheusWeaponscanDropWeapon", Prometheus.OnWeaponDrop)
