
ITEM.ID = 558

ITEM.Name = "Solid Snake Model"

ITEM.Description = "Wait. Did that Cardboard Box just move? What.."

ITEM.Model = "models/player/big_boss.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end