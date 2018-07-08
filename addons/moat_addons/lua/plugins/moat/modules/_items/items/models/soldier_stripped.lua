
ITEM.ID = 557

ITEM.Name = "Stripped Soldier Model"

ITEM.Description = "Be careful in the Cold Weather with those Nips out. You might get Banned for possession of two extra weapons"

ITEM.Model = "models/player/soldier_stripped.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end