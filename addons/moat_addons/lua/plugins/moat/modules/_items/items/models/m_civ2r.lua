
ITEM.ID = 178

ITEM.Name = "Rebel Male 2"

ITEM.Description = "Just your average rebel male citizen"

ITEM.Model = "models/player/Group03/male_02.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end