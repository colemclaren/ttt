
ITEM.ID = 50

ITEM.Name = "Ash Ketchum Model"

ITEM.Description = "Gotta catch em all"

ITEM.Model = "models/player/red.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Aqua Palm Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end