
ITEM.ID = 198

ITEM.Name = "Mossman Model"

ITEM.Description = "Not as slutty as Alyx, but gettin' there"

ITEM.Model = "models/player/mossman.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end