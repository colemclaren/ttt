local meta = FindMetaTable("NPC")
function meta:GetWeapon(class)
	for k, v in pairs(ents.FindByClass(class)) do
		if v.Owner == self then
			return v
		end
	end
	return NULL
end
