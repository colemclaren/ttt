-- autorun/client/cl_vapeswep.lua
-- Defines shared globals for Vape SWEP

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

CreateConVar("vape_block_sounds", "0", FCVAR_REPLICATED, "Set to 1 to disable Vape SWEP speech sounds")

--override Entity:SetMaterial to make sure vape shows for ponies
/*
meta = FindMetaTable("Entity")
if meta.VapeOrigSetMaterial == nil then
	meta.VapeOrigSetMaterial = meta.SetMaterial
	meta.SetMaterial = function(self, materialName, forceMaterial)
		if self:GetClass():sub(1,11)=="weapon_vape" and materialName=="Models/effects/vol_light001" then return end
		self:VapeOrigSetMaterial(materialName, forceMaterial)
	end
end
*/