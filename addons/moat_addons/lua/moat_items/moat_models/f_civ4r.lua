
ITEM.ID = 188

ITEM.Name = "Rebel Female 4"

ITEM.Description = "Just your average rebel female citizen"

ITEM.Model = "models/player/Group03/female_04.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end