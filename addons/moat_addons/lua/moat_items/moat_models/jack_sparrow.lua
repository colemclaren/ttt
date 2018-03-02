
ITEM.ID = 543

ITEM.Name = "Spiderman Model"

ITEM.Description = "My Spider-Sense is tingling"

ITEM.Model = "models/otv/scarletspider.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end