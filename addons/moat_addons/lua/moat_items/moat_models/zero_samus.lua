
ITEM.ID = 563

ITEM.Name = "Osama Model"

ITEM.Description = "The dead leader of the terrorists"

ITEM.Model = "models/code_gs/osama/osamaplayer.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end