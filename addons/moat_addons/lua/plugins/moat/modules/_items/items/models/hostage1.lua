
ITEM.ID = 191

ITEM.Name = "Working Asian"

ITEM.Description = "Just your average male worker"

ITEM.Model = "models/player/hostage/hostage_01.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end