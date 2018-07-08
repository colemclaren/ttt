local pl = FindMetaTable("Player")

function pl:SelectHolster()
	for k, v in pairs(self:GetWeapons()) do
		if (v.Kind == WEAPON_UNARMED) then
			self:SelectWeapon(v:GetClass())

			break
		end
	end
end