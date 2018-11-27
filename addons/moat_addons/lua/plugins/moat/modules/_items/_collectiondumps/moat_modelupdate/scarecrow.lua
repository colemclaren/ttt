
ITEM.ID = 553

ITEM.Name = "Scarecrow Model"

ITEM.Description = "Now you have a Model to match Yourself. Someone who scares off Birds"

ITEM.Model = "models/moat/player/scarecrow.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end