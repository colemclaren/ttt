
ITEM.ID = 560

ITEM.Name = "TF2 Spy Model"

ITEM.Description = "Everyone's favourite Back Stabbing, Invisible, Rage Inducing Frenchman"

ITEM.Model = "models/player/drpyspy/spy.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end