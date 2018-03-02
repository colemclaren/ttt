
ITEM.ID = 66

ITEM.Name = "Skeleton Model"

ITEM.Description = "An exclusive item given to Shiny Mega Gallade, first donator of $100"

ITEM.Model = "models/player/skeleton.mdl"

ITEM.Rarity = 8

ITEM.Collection = "Sugar Daddy Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end