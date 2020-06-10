
ITEM.ID = 46

ITEM.Name = "Veteran Soldier Model"

ITEM.Description = "He's seen some stuff"

ITEM.Model = "models/player/clopsy.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Summer Climb Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end