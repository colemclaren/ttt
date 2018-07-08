
ITEM.ID = 533

ITEM.Name = "Dishonored Assassin Model"

ITEM.Description = "This model is an Assassin from the game Dishonored. Who would have guessed that? Hmm.."

ITEM.Model = "models/player/dishonored_assassin1.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end