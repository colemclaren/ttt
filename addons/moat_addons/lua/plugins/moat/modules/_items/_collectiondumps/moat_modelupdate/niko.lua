
ITEM.ID = 548

ITEM.Name = "Niko Model"

ITEM.Description = "Brother. Let's go Traitor Hunting"

ITEM.Model = "models/player/niko.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end