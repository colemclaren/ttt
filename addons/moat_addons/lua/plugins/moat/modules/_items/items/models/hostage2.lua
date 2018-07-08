
ITEM.ID = 192

ITEM.Name = "Working Man"

ITEM.Description = "Just your average male worker"

ITEM.Model = "models/player/hostage/hostage_02.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end