
ITEM.ID = 540

ITEM.Name = "Hunter Model"

ITEM.Description = "You are probably expecting a Zombie joke here about how you were Left 4 Dead. But I guess you're now only a Half-Life"

ITEM.Model = "models/player/hunter.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end