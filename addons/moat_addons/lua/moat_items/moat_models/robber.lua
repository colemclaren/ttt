
ITEM.ID = 550

ITEM.Name = "Robber Model"

ITEM.Description = "Maybe when he's not looking you could rob some of Moat's Cosmics"

ITEM.Model = "models/player/robber.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end