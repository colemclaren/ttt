
ITEM.ID = 53

ITEM.Name = "Stormtrooper Model"

ITEM.Description = "Victory is written in the stars"

ITEM.Model = "models/player/stormtrooper.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Aqua Palm Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end