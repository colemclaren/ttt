
ITEM.ID = 552

ITEM.Name = "Rorschach Model"

ITEM.Description = "Somebody help him! He's spilt ink all over his face"

ITEM.Model = "models/player/rorschach.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end