
ITEM.ID = 547

ITEM.Name = "Master Chief Model"

ITEM.Description = "Master Chief is not a Master Chef"

ITEM.Model = "models/player/lordvipes/haloce/spartan_classic.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end