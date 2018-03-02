
ITEM.ID = 181

ITEM.Name = "Rebel Male 5"

ITEM.Description = "Just your average rebel male citizen"

ITEM.Model = "models/player/Group03/male_05.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end