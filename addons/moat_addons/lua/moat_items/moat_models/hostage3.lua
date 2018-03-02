
ITEM.ID = 193

ITEM.Name = "Working Older Man"

ITEM.Description = "Just your average male worker"

ITEM.Model = "models/player/hostage/hostage_03.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end