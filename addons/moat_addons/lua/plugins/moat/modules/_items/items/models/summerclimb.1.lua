
ITEM.ID = 45

ITEM.Name = "Aperture Containment Model"

ITEM.Description = [[The Enrichment Center is committed to the well being of all participants]]

ITEM.Model = "models/player/aphaztech.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Summer Climb Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end