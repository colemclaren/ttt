
ITEM.ID = 21

ITEM.Name = "Kliener Model"

ITEM.Description = "The smartest of them all"

ITEM.Model = "models/player/kleiner.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end