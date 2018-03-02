
ITEM.ID = 542

ITEM.Name = "Isaac Clarke Model"

ITEM.Description = "You may not be in Space, but you're sure as Hell Dead"

ITEM.Model = "models/player/security_suit.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end