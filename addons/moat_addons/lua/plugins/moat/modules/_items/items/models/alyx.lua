
ITEM.ID = 63

ITEM.Name = "Alyx Model"

ITEM.Description = "slut"

ITEM.Model = "models/player/alyx.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Alpha Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end