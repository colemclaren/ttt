
ITEM.ID = 551

ITEM.Name = "Roman Model"

ITEM.Description = '"Can you stop it with the Fat Jokes already!?", No'

ITEM.Model = "models/player/romanbellic.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end