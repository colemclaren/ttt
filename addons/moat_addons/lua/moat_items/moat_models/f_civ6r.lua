
ITEM.ID = 190

ITEM.Name = "Rebel Female 6"

ITEM.Description = "Just your average rebel female citizen"

ITEM.Model = "models/player/Group03/female_06.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end