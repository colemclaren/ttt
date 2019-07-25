ITEM.ID = 42
ITEM.Name = "T-Rex Modwl"
ITEM.Description = "Tyrannosaurus is a genus of coelurosaurian theropod dinosaur. The species Tyrannosaurus rex, often called T. rex or colloquially T-Rex, is one of the most well-represented of the large theropods. Tyrannosaurus lived throughout what is now western North America, on what was then an island continent known as Laramidia."
ITEM.Model = "models/moat/player/foohysaurusrex_fixed.mdl"
ITEM.Rarity = 9
ITEM.Collection = "Extinct IRL Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end