
ITEM.ID = 184

ITEM.Name = "Rebel Male 8"

ITEM.Description = "Just your average rebel male citizen"

ITEM.Model = "models/player/Group03/male_08.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end